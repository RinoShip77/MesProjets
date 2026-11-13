using GrindWall.Services;
using System.Diagnostics;

namespace GrindWall.Platforms.Windows;

/// <summary>
/// Windows implementation of app blocking to prevent game execution.
/// Monitors and terminates blocked processes.
/// </summary>
public class WindowsAppBlocker : IAppBlocker
{
    private readonly List<string> _debugBlacklist = new()
    {
        "notepad",
        "calculator"
    };

    private readonly List<string> _realBlacklist = new()
    {
        "steam",
        "marvelrivals",
        "netflix"
    };

    private bool _isBlocking;
    private bool _isDebugMode = true;
    private bool _isMonitoring;
    private CancellationTokenSource? _monitoringCts;
    private Task? _monitoringTask;

    public bool IsBlocking
    {
        get => _isBlocking;
        set => _isBlocking = value;
    }

    public bool IsDebugMode
    {
        get => _isDebugMode;
        set => _isDebugMode = value;
    }

    private List<string> CurrentBlacklist => IsDebugMode ? _debugBlacklist : _realBlacklist;

    public void StartBlocking()
    {
        if (_isMonitoring)
            return;

        _isMonitoring = true;
        _monitoringCts = new CancellationTokenSource();
        
        _monitoringTask = Task.Run(async () =>
        {
            Debug.WriteLine("Windows App Blocking started");
            
            while (!_monitoringCts.Token.IsCancellationRequested)
            {
                try
                {
                    if (_isBlocking)
                    {
                        foreach (var processName in CurrentBlacklist)
                        {
                            var isRunning = await IsProcessRunningAsync(processName);
                            if (isRunning)
                            {
                                Debug.WriteLine($"Detected blocked process: {processName}");
                                await KillProcessAsync(processName);
                            }
                        }
                    }

                    // Check every 2 seconds
                    await Task.Delay(2000, _monitoringCts.Token);
                }
                catch (OperationCanceledException)
                {
                    break;
                }
                catch (Exception ex)
                {
                    Debug.WriteLine($"Error in Windows monitoring loop: {ex.Message}");
                }
            }

            Debug.WriteLine("Windows App Blocking stopped");
        }, _monitoringCts.Token);
    }

    public void StopBlocking()
    {
        if (!_isMonitoring)
            return;

        _isMonitoring = false;
        _monitoringCts?.Cancel();

        // Fire and forget the await or just let it die
        _ = Task.Run(async () => {
            if (_monitoringTask != null)
            {
                try { await _monitoringTask; } catch { }
            }
        });

        _monitoringCts?.Dispose();
        _monitoringCts = null;
        _monitoringTask = null;
    }

    public bool HasPermission()
    {
        // Windows typically doesn't need specific "Usage Access" permissions for Process.GetProcesses
        // but might need admin for Kill. For now, we return true.
        return true;
    }

    public void RequestPermission()
    {
        // No-op on Windows for now
    }

    private Task<bool> IsProcessRunningAsync(string processName)
    {
        try
        {
            var processes = Process.GetProcessesByName(processName);
            return Task.FromResult(processes.Length > 0);
        }
        catch (Exception ex)
        {
            Debug.WriteLine($"Error checking process {processName}: {ex.Message}");
            return Task.FromResult(false);
        }
    }

    private Task<bool> KillProcessAsync(string processName)
    {
        try
        {
            var processes = Process.GetProcessesByName(processName);
            
            if (processes.Length == 0)
                return Task.FromResult(false);

            foreach (var process in processes)
            {
                try
                {
                    process.Kill(entireProcessTree: true);
                    Debug.WriteLine($"Killed process: {processName} (PID: {process.Id})");
                }
                catch (Exception ex)
                {
                    Debug.WriteLine($"Failed to kill process {processName} (PID: {process.Id}): {ex.Message}");
                }
                finally
                {
                    process.Dispose();
                }
            }

            return Task.FromResult(true);
        }
        catch (Exception ex)
        {
            Debug.WriteLine($"Error killing process {processName}: {ex.Message}");
            return Task.FromResult(false);
        }
    }
    public Task<List<Models.InstalledApp>> GetInstalledAppsAsync()
    {
        var apps = new List<Models.InstalledApp>();

        // For Windows, initially populating with our known blacklist for testing
        // In a real implementation, we would scan Registry or Start Menu shortcuts
        
        foreach (var name in _debugBlacklist)
        {
            apps.Add(new Models.InstalledApp 
            { 
                Name = System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(name), 
                PackageName = name, 
                Platform = "Windows",
                IsBlocked = false,
                Category = name == "netflix" ? "Streaming" : (name == "steam" || name == "marvelrivals" ? "Games" : "Productivity")
            });
        }

        foreach (var name in _realBlacklist)
        {
            apps.Add(new Models.InstalledApp 
            { 
                Name = System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(name), 
                PackageName = name, 
                Platform = "Windows",
                IsBlocked = false,
                Category = name == "netflix" ? "Streaming" : (name == "steam" || name == "marvelrivals" ? "Games" : "Productivity")
            });
        }

        return Task.FromResult(apps);
    }
}
