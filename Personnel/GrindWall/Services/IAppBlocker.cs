namespace GrindWall.Services;

/// <summary>
/// Cross-platform interface for blocking distracting apps or processes.
/// </summary>
public interface IAppBlocker
{
    /// <summary>
    /// Starts the background monitoring or blocking service.
    /// </summary>
    void StartBlocking();

    /// <summary>
    /// Stops the background monitoring or blocking service.
    /// </summary>
    void StopBlocking();

    /// <summary>
    /// Checks if the necessary system permissions are granted.
    /// </summary>
    bool HasPermission();

    /// <summary>
    /// Requests the necessary system permissions (e.g., opens settings).
    /// </summary>
    void RequestPermission();

    /// <summary>
    /// Gets or sets whether blocking is currently active.
    /// </summary>
    bool IsBlocking { get; set; }

    /// <summary>
    /// Gets or sets whether debug mode is active (uses test apps instead of real distractions).
    /// </summary>
    bool IsDebugMode { get; set; }

    /// <summary>
    /// Retrieves a list of installed applications.
    /// </summary>
    Task<List<Models.InstalledApp>> GetInstalledAppsAsync();
}
