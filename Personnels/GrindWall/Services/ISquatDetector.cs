namespace GrindWall.Services;

/// <summary>
/// Platform-specific interface for detecting squats using device sensors.
/// Implemented on Android using accelerometer data.
/// </summary>
public interface ISquatDetector
{
    /// <summary>
    /// Event fired when a squat is successfully detected.
    /// The int parameter represents the total squat count.
    /// </summary>
    event EventHandler<int>? SquatDetected;

    /// <summary>
    /// Starts monitoring for squat movements.
    /// </summary>
    Task StartMonitoringAsync();

    /// <summary>
    /// Stops monitoring for squat movements.
    /// </summary>
    Task StopMonitoringAsync();

    /// <summary>
    /// Gets the current squat count.
    /// </summary>
    int CurrentCount { get; }

    /// <summary>
    /// Resets the squat counter to zero.
    /// </summary>
    void ResetCount();
}
