using GrindWall.Services;
using Microsoft.Maui.Devices.Sensors;

namespace GrindWall.Platforms.Android;

/// <summary>
/// Android implementation of squat detection using accelerometer sensor.
/// Detects squats based on vertical acceleration patterns (down-up motion).
/// </summary>
public class SquatDetector : ISquatDetector
{
    private const double SquatThreshold = 12.0; // Acceleration threshold for squat detection
    private const int CooldownMs = 1000; // Minimum time between squat detections

    private int _squatCount;
    private bool _isMonitoring;
    private bool _isInSquat;
    private DateTime _lastSquatTime = DateTime.MinValue;
    private double _previousAcceleration;

    public event EventHandler<int>? SquatDetected;

    public int CurrentCount => _squatCount;

    /// <summary>
    /// Starts monitoring the accelerometer for squat movements.
    /// </summary>
    public Task StartMonitoringAsync()
    {
        if (_isMonitoring)
            return Task.CompletedTask;

        try
        {
            if (!Accelerometer.Default.IsSupported)
            {
                System.Diagnostics.Debug.WriteLine("Accelerometer not supported on this device");
                return Task.CompletedTask;
            }

            // Set accelerometer speed to game (fastest)
            Accelerometer.Default.ReadingChanged += OnAccelerometerReadingChanged;
            Accelerometer.Default.Start(SensorSpeed.Game);

            _isMonitoring = true;
            System.Diagnostics.Debug.WriteLine("Squat detection started");
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine($"Error starting accelerometer: {ex.Message}");
        }

        return Task.CompletedTask;
    }

    /// <summary>
    /// Stops monitoring the accelerometer.
    /// </summary>
    public Task StopMonitoringAsync()
    {
        if (!_isMonitoring)
            return Task.CompletedTask;

        try
        {
            Accelerometer.Default.ReadingChanged -= OnAccelerometerReadingChanged;
            Accelerometer.Default.Stop();
            _isMonitoring = false;
            System.Diagnostics.Debug.WriteLine("Squat detection stopped");
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine($"Error stopping accelerometer: {ex.Message}");
        }

        return Task.CompletedTask;
    }

    /// <summary>
    /// Resets the squat count.
    /// </summary>
    public void ResetCount()
    {
        _squatCount = 0;
    }

    /// <summary>
    /// Handles accelerometer reading changes and detects squat patterns.
    /// </summary>
    private void OnAccelerometerReadingChanged(object? sender, AccelerometerChangedEventArgs e)
    {
        // Calculate total acceleration magnitude
        var reading = e.Reading;
        double totalAcceleration = Math.Sqrt(
            reading.Acceleration.X * reading.Acceleration.X +
            reading.Acceleration.Y * reading.Acceleration.Y +
            reading.Acceleration.Z * reading.Acceleration.Z
        );

        // Detect squat pattern: high acceleration (downward motion) followed by return to normal
        if (totalAcceleration > SquatThreshold && !_isInSquat)
        {
            // User is going down (squat start)
            _isInSquat = true;
            System.Diagnostics.Debug.WriteLine($"Squat started - Acceleration: {totalAcceleration:F2}");
        }
        else if (_isInSquat && totalAcceleration < SquatThreshold * 0.8)
        {
            // User is coming back up (squat complete)
            var timeSinceLastSquat = DateTime.Now - _lastSquatTime;
            
            if (timeSinceLastSquat.TotalMilliseconds > CooldownMs)
            {
                _isInSquat = false;
                _squatCount++;
                _lastSquatTime = DateTime.Now;

                System.Diagnostics.Debug.WriteLine($"Squat detected! Count: {_squatCount}");
                
                // Fire event on main thread
                MainThread.BeginInvokeOnMainThread(() =>
                {
                    SquatDetected?.Invoke(this, _squatCount);
                });
            }
        }

        _previousAcceleration = totalAcceleration;
    }
}
