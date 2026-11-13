using GrindWall.Services;
using System.ComponentModel;
using System.Net.Sockets;
using System.Runtime.CompilerServices;
using System.Text;
using System.Windows.Input;
using System.Globalization;
using Microsoft.Maui.Controls.Shapes;
using Microsoft.Maui.Graphics;
using System.Collections.ObjectModel;

namespace GrindWall.ViewModels;

/// <summary>
/// ViewModel for the main page that coordinates squat detection and process blocking.
/// </summary>
public class MainPageViewModel : INotifyPropertyChanged
{
    private readonly SquatCounterService _squatCounter;
    private readonly ISquatDetector? _squatDetector;
    private readonly IAppBlocker? _appBlocker;
    private readonly NetworkSyncService _networkSync;

    private string _statusMessage = "Ready to start!";
    private string _currentPage = "Home";
    private bool _isMenuOpen;
    private bool _isMonitoring;
    private Geometry? _progressArcData;
    private string _remoteIpAddress = "192.168.2.30"; // Default PC IP for mobile, mobile IP for PC
    private List<Models.InstalledApp> _allApps = new();
    private ObservableCollection<Models.InstalledApp> _displayedApps = new();
    private string _searchText = "";
    private string _selectedPlatform = "All";
    private string _selectedSort = "Name (A-Z)";
    private bool _isGridView = false;
    private string _selectedCategory = "All";
    private string _resultCountText = "0 Apps";
    private ObservableCollection<FilterChip> _activeFilters = new();

    public event PropertyChangedEventHandler? PropertyChanged;

    public MainPageViewModel(
        SquatCounterService squatCounter,
        NetworkSyncService networkSync,
        ISquatDetector? squatDetector = null,
        IAppBlocker? appBlocker = null)
    {
        _squatCounter = squatCounter;
        _networkSync = networkSync;
        _squatDetector = squatDetector;
        _appBlocker = appBlocker;

        // Subscribe to property changes from the counter service
        _squatCounter.PropertyChanged += OnSquatCounterPropertyChanged;

        // Subscribe to network sync events
        _networkSync.SquatCountReceived += OnNetworkSquatCountReceived;
        _networkSync.CommandReceived += OnCommandReceived;
        
        // Start listening for incoming updates
        _ = Task.Run(async () => await _networkSync.StartListeningAsync());

#if WINDOWS
        // On PC, update remote IP to mobile's IP
        _remoteIpAddress = "192.168.2.78";
#endif

        // Subscribe to squat detection events
        if (_squatDetector != null)
        {
            _squatDetector.SquatDetected += OnSquatDetected;
        }

        // Initialize commands
        StartMonitoringCommand = new Command(async () => await StartMonitoringAsync(), () => !IsMonitoring);
        StopMonitoringCommand = new Command(async () => await StopMonitoringAsync(), () => IsMonitoring);
        UnlockCommand = new Command(async () => await UnlockGamesAsync(), () => _squatCounter.CanUnlock);
        ResetCommand = new Command(ResetCounter);
        TestSquatCommand = new Command(AddTestSquat);
        
        // Navigation commands
        ToggleMenuCommand = new Command(ToggleMenu);
        NavigateHomeCommand = new Command(() => NavigateTo("Home"));
        NavigateSettingsCommand = new Command(() => NavigateTo("Settings"));
        NavigateProfileCommand = new Command(() => NavigateTo("Profile"));
        NavigateGamesCommand = new Command(() => NavigateTo("Games"));
        NavigateQuestsCommand = new Command(() => NavigateTo("Quests"));
        NavigateHistoryCommand = new Command(() => NavigateTo("History"));
        LoadAppsCommand = new Command(async () => await LoadInstalledAppsAsync());
        
        ToggleLayoutCommand = new Command<string>(ToggleLayout);
        SelectCategoryCommand = new Command<string>(SelectCategory);
        RemoveFilterCommand = new Command<FilterChip>(RemoveFilter);
        ResetFiltersCommand = new Command(ResetFilters);

        // Initialize arc
        CalculateProgressArc();
    }

    #region Properties

    public int SquatCount => _squatCounter.SquatCount;

    public string ProgressText => _squatCounter.ProgressText;

    public Geometry? ProgressArcData
    {
        get => _progressArcData;
        set
        {
            if (_progressArcData != value)
            {
                _progressArcData = value;
                OnPropertyChanged();
            }
        }
    }

    public bool CanUnlock => _squatCounter.CanUnlock;

    public bool IsUnlocked => _squatCounter.IsUnlocked;

    public string StatusMessage
    {
        get => _statusMessage;
        set
        {
            if (_statusMessage != value)
            {
                _statusMessage = value;
                OnPropertyChanged();
            }
        }
    }

    public bool IsMonitoring
    {
        get => _isMonitoring;
        set
        {
            if (_isMonitoring != value)
            {
                _isMonitoring = value;
                OnPropertyChanged();
                ((Command)StartMonitoringCommand).ChangeCanExecute();
                ((Command)StopMonitoringCommand).ChangeCanExecute();
            }
        }
    }

    public string PlatformInfo
    {
        get
        {
            var platform = DeviceInfo.Platform.ToString();
            var hasSquatDetector = _squatDetector != null;
            var hasAppBlocker = _appBlocker != null;

            var role = "";
            if (platform == "Android")
                role = "Role: Squat Counter -> Syncs to PC";
            else if (platform == "WinUI")
                role = "Role: Blocks Games + Syncs with Phone";

            return $"Platform: {platform}\n" +
                   $"Squat Detection: {(hasSquatDetector ? "✓" : "✗")}\n" +
                   $"App Blocking: {(hasAppBlocker ? "✓" : "✗")}\n" +
                   $"Network Sync: ✓\n" +
                   role;
        }
    }

    public ObservableCollection<Models.InstalledApp> DisplayedApps
    {
        get => _displayedApps;
        set
        {
            if (_displayedApps != value)
            {
                _displayedApps = value;
                OnPropertyChanged();
            }
        }
    }

    public string SearchText
    {
        get => _searchText;
        set
        {
            if (_searchText != value)
            {
                _searchText = value;
                OnPropertyChanged();
                FilterAndSortApps();
            }
        }
    }

    public string SelectedPlatform
    {
        get => _selectedPlatform;
        set
        {
            if (_selectedPlatform != value)
            {
                _selectedPlatform = value;
                OnPropertyChanged();
                FilterAndSortApps();
            }
        }
    }

    public string SelectedSort
    {
        get => _selectedSort;
        set
        {
            if (_selectedSort != value)
            {
                _selectedSort = value;
                OnPropertyChanged();
                FilterAndSortApps();
            }
        }
    }

    public List<string> FilterPlatforms { get; } = new() { "All", "Android", "Windows" };
    public List<string> SortOptions { get; } = new() { "Name (A-Z)", "Name (Z-A)", "Most Used", "Least Used" };
    public List<string> FilterCategories { get; } = new() { "All", "Social", "Games", "Streaming", "Productivity" };

    public bool IsGridView
    {
        get => _isGridView;
        set
        {
            if (_isGridView != value)
            {
                _isGridView = value;
                OnPropertyChanged();
            }
        }
    }

    public string SelectedCategory
    {
        get => _selectedCategory;
        set
        {
            if (_selectedCategory != value)
            {
                _selectedCategory = value;
                OnPropertyChanged();
                FilterAndSortApps();
            }
        }
    }

    public string ResultCountText
    {
        get => _resultCountText;
        set
        {
            if (_resultCountText != value)
            {
                _resultCountText = value;
                OnPropertyChanged();
            }
        }
    }

    public ObservableCollection<FilterChip> ActiveFilters
    {
        get => _activeFilters;
        set
        {
            if (_activeFilters != value)
            {
                _activeFilters = value;
                OnPropertyChanged();
            }
        }
    }

    #endregion

    #region Commands

    public ICommand StartMonitoringCommand { get; }
    public ICommand StopMonitoringCommand { get; }
    public ICommand UnlockCommand { get; }
    public ICommand ResetCommand { get; }
    public ICommand TestSquatCommand { get; }
    public ICommand ToggleMenuCommand { get; }
    public ICommand NavigateHomeCommand { get; }
    public ICommand NavigateSettingsCommand { get; }
    public ICommand NavigateProfileCommand { get; }
    public ICommand NavigateGamesCommand { get; }
    public ICommand NavigateQuestsCommand { get; }
    public ICommand NavigateHistoryCommand { get; }
    public ICommand LoadAppsCommand { get; }
    public ICommand ToggleLayoutCommand { get; }
    public ICommand SelectCategoryCommand { get; }
    public ICommand RemoveFilterCommand { get; }
    public ICommand ResetFiltersCommand { get; }

    #endregion

    #region Menu State

    public string CurrentPage
    {
        get => _currentPage;
        set
        {
            if (_currentPage != value)
            {
                _currentPage = value;
                OnPropertyChanged();
            }
        }
    }

    public bool IsMenuOpen
    {
        get => _isMenuOpen;
        set
        {
            if (_isMenuOpen != value)
            {
                _isMenuOpen = value;
                OnPropertyChanged();
            }
        }
    }

    #endregion

    #region Methods

    private async Task StartMonitoringAsync()
    {
        try
        {
            StatusMessage = "Starting monitoring...";

            // Start squat detection on Android
            if (_squatDetector != null)
            {
                await _squatDetector.StartMonitoringAsync();
                StatusMessage = "Squat detection active! Sending START to PC...";
                
                // Send START_BLOCKING command to Windows PC
                await SendStartBlockingToPC();
            }

            // Start app blocking (Android or Windows)
            if (_appBlocker != null)
            {
                _appBlocker.IsBlocking = true;
                _appBlocker.StartBlocking();
                StatusMessage = "Distractions are blocked. Do squats to unlock!";
            }

            if (_squatDetector == null && _appBlocker == null)
            {
                StatusMessage = "⚠️ No platform services available.";
            }

            IsMonitoring = true;
        }
        catch (Exception ex)
        {
            StatusMessage = $"Error: {ex.Message}";
        }
    }

    private async Task StopMonitoringAsync()
    {
        try
        {
            StatusMessage = "Stopping monitoring...";

            if (_squatDetector != null)
            {
                await _squatDetector.StopMonitoringAsync();
            }

            if (_appBlocker != null)
            {
                _appBlocker.StopBlocking();
            }

            IsMonitoring = false;
            StatusMessage = "Monitoring stopped.";
        }
        catch (Exception ex)
        {
            StatusMessage = $"Error: {ex.Message}";
        }
    }

    private async Task UnlockGamesAsync()
{
    if (_squatCounter.TryUnlock())
    {
        StatusMessage = "Games unlocked! Sending signal to PC...";

        // --- NEW LOGIC: DETECT PLATFORM ---
#if ANDROID
        // If we are on the PHONE, send the signal to the PC
        await SendUnlockSignalToPC();
#elif WINDOWS
        // If we are testing on WINDOWS, just stop the local blocker
        if (_appBlocker != null)
        {
            _appBlocker.IsBlocking = false;
        }
#endif
        
        // Also stop blocking on current device if it exists (Android or PC)
        if (_appBlocker != null)
        {
            _appBlocker.IsBlocking = false;
        }
        // ----------------------------------
    }
    else
    {
        StatusMessage = $"Not enough squats! Need {_squatCounter.RequiredSquats - _squatCounter.SquatCount} more.";
    }

    await Task.Delay(100);
}

// --- HELPER METHOD TO SEND THE SIGNAL ---
private async Task SendUnlockSignalToPC()
{
    try
    {
        // 1. Connect to your PC (Use the IP you found: 192.168.2.30)
        // Note: Ensure your PC firewall allows connections on Port 5000
        using TcpClient client = new TcpClient();
        
        // Timeout check (don't freeze the app if PC is off)
        var connectTask = client.ConnectAsync("192.168.2.30", 5000);
        if (await Task.WhenAny(connectTask, Task.Delay(3000)) != connectTask)
        {
            StatusMessage = "❌ Error: PC not found (Timeout).";
            return;
        }

        // 2. Send the "UNLOCK" command
        using NetworkStream stream = client.GetStream();
        byte[] data = Encoding.UTF8.GetBytes("UNLOCK");
        await stream.WriteAsync(data, 0, data.Length);

        StatusMessage = "Signal Sent! PC should be unlocked.";
    }
    catch (Exception ex)
    {
        StatusMessage = $"Connection Failed: {ex.Message}";
    }
}

// --- HELPER METHOD TO SEND START_BLOCKING ---
private async Task SendStartBlockingToPC()
{
    try
    {
        using TcpClient client = new TcpClient();
        
        // Timeout check
        var connectTask = client.ConnectAsync("192.168.2.30", 5000);
        if (await Task.WhenAny(connectTask, Task.Delay(3000)) != connectTask)
        {
            StatusMessage = "Error: PC not found. Start local mode.";
            return;
        }

        // Send the "START_BLOCKING" command
        using NetworkStream stream = client.GetStream();
        byte[] data = Encoding.UTF8.GetBytes("START_BLOCKING");
        await stream.WriteAsync(data, 0, data.Length);

        StatusMessage = "PC blocking activated!";
    }
    catch (Exception ex)
    {
        StatusMessage = $"PC not reachable: {ex.Message}";
    }
}

// --- HELPER METHOD TO SEND SQUAT COUNT UPDATE ---
private async Task SendSquatUpdateToPC(int count)
{
    try
    {
        using TcpClient client = new TcpClient();
        
        // Quick timeout - this is fire-and-forget
        var connectTask = client.ConnectAsync("192.168.2.30", 5000);
        if (await Task.WhenAny(connectTask, Task.Delay(1000)) != connectTask)
        {
            return; // Silently fail - don't disrupt user experience
        }

        // Send the squat count update (format: "SQUAT_UPDATE:5")
        using NetworkStream stream = client.GetStream();
        byte[] data = Encoding.UTF8.GetBytes($"SQUAT_UPDATE:{count}");
        await stream.WriteAsync(data, 0, data.Length);
    }
    catch
    {
        // Silently ignore - don't want to interrupt squat flow
    }
}

// --- HELPER METHOD TO SEND RESET COMMAND ---
private async Task SendResetToPC()
{
    try
    {
        System.Diagnostics.Debug.WriteLine("📤 Sending RESET_COUNTER to PC...");
        
        using TcpClient client = new TcpClient();
        
        // Quick timeout
        var connectTask = client.ConnectAsync("192.168.2.30", 5000);
        if (await Task.WhenAny(connectTask, Task.Delay(1000)) != connectTask)
        {
            System.Diagnostics.Debug.WriteLine("❌ Timeout connecting to PC");
            return; // Silently fail
        }

        // Send the reset command
        using NetworkStream stream = client.GetStream();
        byte[] data = Encoding.UTF8.GetBytes("RESET_COUNTER");
        await stream.WriteAsync(data, 0, data.Length);
        
        System.Diagnostics.Debug.WriteLine("✅ RESET_COUNTER sent successfully");
    }
    catch (Exception ex)
    {
        System.Diagnostics.Debug.WriteLine($"❌ Error sending reset: {ex.Message}");
    }
}

    private void AddTestSquat()
    {
        _squatCounter.AddSquat();
        StatusMessage = $"Test squat added! Total: {_squatCounter.SquatCount}";
        ((Command)UnlockCommand).ChangeCanExecute();
        
        // Send count update to the other device (bidirectional)
        _ = _networkSync.SendSquatUpdateAsync(_remoteIpAddress, _squatCounter.SquatCount);
        
        // Auto-unlock when goal is reached
        if (_squatCounter.CanUnlock && !_squatCounter.IsUnlocked)
        {
            StatusMessage = "🎉 Goal reached! Auto-unlocking...";
            _ = Task.Run(async () => await UnlockGamesAsync());
        }
    }

    private void OnNetworkSquatCountReceived(object? sender, int count)
    {
        // Update counter to match received count
        MainThread.BeginInvokeOnMainThread(() =>
        {
            while (_squatCounter.SquatCount < count)
            {
                _squatCounter.AddSquat();
            }
            StatusMessage = $"Synced from remote device! Total: {count}";
            ((Command)UnlockCommand).ChangeCanExecute();
            
            // Auto-unlock when goal is reached
            if (_squatCounter.CanUnlock && !_squatCounter.IsUnlocked)
            {
                StatusMessage = "🎉 Goal reached! Auto-unlocking...";
                _ = Task.Run(async () => await UnlockGamesAsync());
            }
        });
    }

    private void ResetCounter()
    {
        _squatCounter.Reset();
        
        if (_squatDetector != null)
        {
            _squatDetector.ResetCount();
        }

        if (_appBlocker != null)
        {
            _appBlocker.IsBlocking = true;
        }

        StatusMessage = "Counter reset. Games are locked again!";
        ((Command)UnlockCommand).ChangeCanExecute();
        
        // Send reset command to the other device (bidirectional)
        _ = _networkSync.SendResetAsync(_remoteIpAddress);
    }

    private void OnCommandReceived(object? sender, string command)
    {
        MainThread.BeginInvokeOnMainThread(() =>
        {
            if (command == "RESET_COUNTER")
            {
                _squatCounter.Reset();
                
                if (_squatDetector != null)
                {
                    _squatDetector.ResetCount();
                }

                if (_appBlocker != null)
                {
                    _appBlocker.IsBlocking = true;
                }

                StatusMessage = "Counter reset by remote device!";
                ((Command)UnlockCommand).ChangeCanExecute();
            }
            else if (command == "START_BLOCKING" || command == "UNLOCK")
            {
                // Handle other commands if needed
                StatusMessage = $"Command received: {command}";
            }
        });
    }

    private void OnSquatDetected(object? sender, int count)
    {
        _squatCounter.AddSquat();
        StatusMessage = $"Squat detected! Total: {count}";
        ((Command)UnlockCommand).ChangeCanExecute();
        
        // Send count update to PC (fire and forget)
        _ = SendSquatUpdateToPC(count);
        
        // Auto-unlock when goal is reached
        if (_squatCounter.CanUnlock && !_squatCounter.IsUnlocked)
        {
            StatusMessage = "🎉 Goal reached! Auto-unlocking...";
            _ = Task.Run(async () => await UnlockGamesAsync());
        }
    }

    private void OnSquatCounterPropertyChanged(object? sender, PropertyChangedEventArgs e)
    {
        // Forward property change notifications
        if (e.PropertyName == nameof(SquatCounterService.SquatCount))
        {
            OnPropertyChanged(nameof(SquatCount));
            OnPropertyChanged(nameof(ProgressText));
            CalculateProgressArc();
        }
        else if (e.PropertyName == nameof(SquatCounterService.CanUnlock))
        {
            OnPropertyChanged(nameof(CanUnlock));
            ((Command)UnlockCommand).ChangeCanExecute();
        }
        else if (e.PropertyName == nameof(SquatCounterService.IsUnlocked))
        {
            OnPropertyChanged(nameof(IsUnlocked));
        }
        else if (e.PropertyName == nameof(SquatCounterService.RequiredSquats))
        {
            CalculateProgressArc();
        }
    }
    
    private void CalculateProgressArc()
    {
        double centerX = 80;
        double centerY = 80;
        double radius = 70;
        int current = SquatCount;
        int max = _squatCounter.RequiredSquats;
        if (max <= 0) max = 1;

        double percentage = (double)current / max;
        if (percentage < 0) percentage = 0;
        if (percentage > 1) percentage = 1;

        if (percentage <= 0.0001) 
        {
            ProgressArcData = null;
            return;
        }

        double startX = 80;
        double startY = 10;

        var geometry = new PathGeometry();
        var figure = new PathFigure { StartPoint = new Point(startX, startY), IsClosed = false, IsFilled = false };

        if (percentage > 0.9999) 
        {
            // Full circle using two arcs
            figure.Segments.Add(new ArcSegment { Point = new Point(80, 150), Size = new Size(radius, radius), SweepDirection = SweepDirection.Clockwise, IsLargeArc = true });
            figure.Segments.Add(new ArcSegment { Point = new Point(startX, startY), Size = new Size(radius, radius), SweepDirection = SweepDirection.Clockwise, IsLargeArc = true });
        }
        else
        {
            double startAngle = -Math.PI / 2;
            double totalSweep = 2 * Math.PI * percentage;
            double endAngle = startAngle + totalSweep;
            double endX = centerX + radius * Math.Cos(endAngle);
            double endY = centerY + radius * Math.Sin(endAngle);

            figure.Segments.Add(new ArcSegment 
            { 
                Point = new Point(endX, endY), 
                Size = new Size(radius, radius), 
                SweepDirection = SweepDirection.Clockwise, 
                IsLargeArc = totalSweep > Math.PI 
            });
        }

        geometry.Figures.Add(figure);
        ProgressArcData = geometry;
        
        System.Diagnostics.Debug.WriteLine($"[ViewModel] Progress Arc Geometry Updated: {current}/{max}");
    }


    #endregion

    #region Navigation Methods

    private void ToggleMenu()
    {
        IsMenuOpen = !IsMenuOpen;
    }

    private void NavigateTo(string page)
    {
        CurrentPage = page;
        IsMenuOpen = false; // Close menu after navigation
        StatusMessage = $"📍 Navigating to {page}...";
        
        StatusMessage = $"📍 Navigating to {page}...";
        
        if (page == "Games" && _allApps.Count == 0)
        {
            Task.Run(LoadInstalledAppsAsync);
        }
    }

    private async Task LoadInstalledAppsAsync()
    {
        if (_appBlocker == null) return;
        
        try
        {
            var apps = await _appBlocker.GetInstalledAppsAsync();
            MainThread.BeginInvokeOnMainThread(() =>
            {
                _allApps = apps;
                FilterAndSortApps();
                StatusMessage = $"Loaded {apps.Count} apps/games.";
            });
        }
        catch (Exception ex)
        {
            StatusMessage = $"Error loading apps: {ex.Message}";
        }
    }

    private void FilterAndSortApps()
    {
        var result = _allApps.AsEnumerable();

        // 1. Search (Start after 3 letters)
        if (!string.IsNullOrWhiteSpace(SearchText) && SearchText.Length >= 3)
        {
            result = result.Where(a => a.Name.Contains(SearchText, StringComparison.OrdinalIgnoreCase));
        }

        // 2. Filter by Platform
        if (SelectedPlatform != "All")
        {
            result = result.Where(a => a.Platform.Equals(SelectedPlatform, StringComparison.OrdinalIgnoreCase));
        }

        // 3. Filter by Category
        if (SelectedCategory != "All")
        {
            result = result.Where(a => a.Category.Equals(SelectedCategory, StringComparison.OrdinalIgnoreCase));
        }

        // 3. Sort
        switch (SelectedSort)
        {
            case "Name (A-Z)":
                result = result.OrderBy(a => a.Name);
                break;
            case "Name (Z-A)":
                result = result.OrderByDescending(a => a.Name);
                break;
            case "Most Used":
                result = result.OrderByDescending(a => a.UsageTime);
                break;
            case "Least Used":
                result = result.OrderBy(a => a.UsageTime);
                break;
        }

        DisplayedApps = new ObservableCollection<Models.InstalledApp>(result);
        ResultCountText = $"{DisplayedApps.Count} Apps";
        UpdateActiveFilters();
    }

    private void ToggleLayout(string layout)
    {
        IsGridView = layout == "Grid";
    }

    private void SelectCategory(string category)
    {
        SelectedCategory = category;
    }

    private void RemoveFilter(FilterChip filter)
    {
        if (filter.Type == "Category") SelectedCategory = "All";
        else if (filter.Type == "Platform") SelectedPlatform = "All";
        else if (filter.Type == "Search") SearchText = "";
    }

    private void ResetFilters()
    {
        SearchText = "";
        SelectedPlatform = "All";
        SelectedCategory = "All";
        SelectedSort = "Name (A-Z)";
    }

    private void UpdateActiveFilters()
    {
        var filters = new List<FilterChip>();
        if (SearchText.Length >= 3) filters.Add(new FilterChip { Text = $"Search: {SearchText}", Type = "Search" });
        if (SelectedPlatform != "All") filters.Add(new FilterChip { Text = SelectedPlatform, Type = "Platform" });
        if (SelectedCategory != "All") filters.Add(new FilterChip { Text = SelectedCategory, Type = "Category" });
        
        ActiveFilters = new ObservableCollection<FilterChip>(filters);
    }

    #endregion

    protected virtual void OnPropertyChanged([CallerMemberName] string? propertyName = null)
    {
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
    }
}

public class FilterChip
{
    public string Text { get; set; } = "";
    public string Type { get; set; } = "";
}
