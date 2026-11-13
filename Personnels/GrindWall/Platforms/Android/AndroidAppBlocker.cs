using Android.App;
using Android.App.Usage;
using Android.Content;
using Android.Provider;
using GrindWall.Services;
using System.Diagnostics;
using System.Threading.Tasks;
using System.Threading;
using System.Collections.Generic;

namespace GrindWall.Platforms.Android;

public class AndroidAppBlocker : IAppBlocker
{
    private readonly Context _context;
    private bool _isBlocking;
    private bool _isDebugMode = true;
    private bool _isMonitoring;
    private CancellationTokenSource? _monitoringCts;

    private readonly List<string> _debugBlacklist = new()
    {
        "com.android.chrome",
        "com.google.android.calculator",
        "com.android.calculator2",
        "com.sec.android.app.popupcalculator" // Samsung
    };

    private readonly List<string> _realBlacklist = new()
    {
        "com.zhiliaoapp.musically",
        "com.instagram.android",
        "com.supercell.clashroyale",
        "com.facebook.katana",
        "com.twitter.android"
    };

    public AndroidAppBlocker()
    {
        _context = global::Android.App.Application.Context;
    }

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
        if (_isMonitoring) return;

        _isMonitoring = true;
        _monitoringCts = new CancellationTokenSource();

        Task.Run(async () =>
        {
            Debug.WriteLine("[AndroidAppBlocker] Monitoring loop started");
            while (!_monitoringCts.Token.IsCancellationRequested)
            {
                try
                {
                    if (_isBlocking)
                    {
                        if (CheckPermissionSilent())
                        {
                            var foregroundApp = GetForegroundApp();
                            if (!string.IsNullOrEmpty(foregroundApp) && !foregroundApp.Equals(_context.PackageName, StringComparison.OrdinalIgnoreCase))
                            {
                                // Debug log occasionally so we don't spam too much, but enough to see it's working
                                // Debug.WriteLine($"[AndroidAppBlocker] Current foreground: {foregroundApp}");
                                
                                if (CurrentBlacklist.Contains(foregroundApp))
                                {
                                    Debug.WriteLine($"[AndroidAppBlocker] ⚠️ DISTRACTION DETECTED: {foregroundApp}");
                                    RedirectToGrindWall();
                                }
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    Debug.WriteLine($"[AndroidAppBlocker] Error in monitoring loop: {ex.Message}");
                }
                await Task.Delay(1000);
            }
            Debug.WriteLine("[AndroidAppBlocker] Monitoring loop stopped");
            _isMonitoring = false;
        }, _monitoringCts.Token);
    }

    public void StopBlocking()
    {
        _monitoringCts?.Cancel();
    }

    public bool HasPermission()
    {
        bool hasUsageStats = CheckPermissionSilent();
        bool hasOverlay = Settings.CanDrawOverlays(_context);
        
        Debug.WriteLine($"[AndroidAppBlocker] Permission Check - UsageStats: {hasUsageStats}, Overlay: {hasOverlay}");
        return hasUsageStats && hasOverlay;
    }

    public void RequestPermission()
    {
        if (!CheckPermissionSilent())
        {
            Debug.WriteLine("[AndroidAppBlocker] Requesting Usage Access Permission");
            var intent = new Intent(Settings.ActionUsageAccessSettings);
            intent.SetFlags(ActivityFlags.NewTask);
            _context.StartActivity(intent);
        }
        else if (!Settings.CanDrawOverlays(_context))
        {
            Debug.WriteLine("[AndroidAppBlocker] Requesting Overlay Permission");
            var intent = new Intent(Settings.ActionManageOverlayPermission, global::Android.Net.Uri.Parse("package:" + _context.PackageName));
            intent.SetFlags(ActivityFlags.NewTask);
            _context.StartActivity(intent);
        }
    }

    private bool CheckPermissionSilent()
    {
        try
        {
            var appOps = (global::Android.App.AppOpsManager)_context.GetSystemService(global::Android.Content.Context.AppOpsService);
            var mode = appOps.CheckOpNoThrow(global::Android.App.AppOpsManager.OpstrGetUsageStats, global::Android.OS.Process.MyUid(), _context.PackageName);
            System.Diagnostics.Debug.WriteLine($"[AndroidAppBlocker] CheckPermissionSilent mode: {mode}");
            return mode == global::Android.App.AppOpsManagerMode.Allowed;
        }
        catch (Exception ex)
        {
            Debug.WriteLine($"Error checking permission: {ex.Message}");
            return false;
        }
    }

    private string GetForegroundApp()
    {
        string foregroundApp = "";
        try
        {
            var usageStatsManager = (UsageStatsManager)_context.GetSystemService(Context.UsageStatsService);
            var time = DateTimeOffset.UtcNow.ToUnixTimeMilliseconds();
            
            // Query events for the last 10 seconds
            var events = usageStatsManager.QueryEvents(time - 10000, time);
            UsageEvents.Event usageEvent = new UsageEvents.Event();
            
            while (events.HasNextEvent)
            {
                events.GetNextEvent(usageEvent);
                if (usageEvent.EventType == UsageEventType.MoveToForeground)
                {
                    foregroundApp = usageEvent.PackageName;
                }
            }
        }
        catch (Exception ex)
        {
            Debug.WriteLine($"Error getting foreground app: {ex.Message}");
        }
        return foregroundApp;
    }

    private void RedirectToGrindWall()
    {
        try
        {
            Intent intent = _context.PackageManager.GetLaunchIntentForPackage(_context.PackageName);
            if (intent != null)
            {
                intent.SetAction(Intent.ActionMain);
                intent.AddCategory(Intent.CategoryLauncher);
                intent.AddFlags(ActivityFlags.NewTask | ActivityFlags.ClearTop | ActivityFlags.SingleTop | ActivityFlags.ReorderToFront);
                _context.StartActivity(intent);
            }
        }
        catch (Exception ex)
        {
            Debug.WriteLine($"[AndroidAppBlocker] Failed to redirect: {ex.Message}");
        }
    }

    public Task<List<Models.InstalledApp>> GetInstalledAppsAsync()
    {
        return Task.Run(() => 
        {
            var apps = new List<Models.InstalledApp>();
            try
            {
                var pm = _context.PackageManager;
                var packages = pm.GetInstalledPackages(global::Android.Content.PM.PackageInfoFlags.MetaData);

                foreach (var pkg in packages)
                {
                    // Check if is launchable
                    var intent = pm.GetLaunchIntentForPackage(pkg.PackageName);
                    if (intent != null)
                    {
                         apps.Add(new Models.InstalledApp
                         {
                             Name = pkg.ApplicationInfo.LoadLabel(pm),
                             PackageName = pkg.PackageName,
                             Platform = "Android",
                             IsBlocked = false,
                             Category = GetAppCategory(pkg.PackageName)
                         });
                    }
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"[AndroidAppBlocker] Error fetching apps: {ex.Message}");
                // Fallback to stub
                foreach (var name in _realBlacklist)
                {
                    apps.Add(new Models.InstalledApp { Name = name, PackageName = name, Platform = "Android", IsBlocked = true });
                }
            }
            return apps;
        });
    }

    private string GetAppCategory(string packageName)
    {
        if (packageName.Contains("game", StringComparison.OrdinalIgnoreCase) || _realBlacklist.Contains(packageName) && packageName.Contains("clash"))
            return "Games";
        if (packageName.Contains("instagram") || packageName.Contains("facebook") || packageName.Contains("twitter") || packageName.Contains("musically"))
            return "Social";
        if (packageName.Contains("chrome") || packageName.Contains("calculator"))
            return "Productivity";
        
        return "General";
    }
}
