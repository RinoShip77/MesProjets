using System.ComponentModel;
using System.Runtime.CompilerServices;

namespace GrindWall.Services;

/// <summary>
/// Cross-platform service that manages squat counting and unlock logic.
/// </summary>
public class SquatCounterService : INotifyPropertyChanged
{
    private int _squatCount;
    private int _requiredSquats = 10; // Default: 10 squats to unlock
    private bool _isUnlocked;

    public event PropertyChangedEventHandler? PropertyChanged;

    /// <summary>
    /// Current total number of squats performed.
    /// </summary>
    public int SquatCount
    {
        get => _squatCount;
        set
        {
            if (_squatCount != value)
            {
                _squatCount = value;
                OnPropertyChanged();
                OnPropertyChanged(nameof(CanUnlock));
                OnPropertyChanged(nameof(ProgressText));
            }
        }
    }

    /// <summary>
    /// Number of squats required to unlock games.
    /// </summary>
    public int RequiredSquats
    {
        get => _requiredSquats;
        set
        {
            if (_requiredSquats != value)
            {
                _requiredSquats = value;
                OnPropertyChanged();
                OnPropertyChanged(nameof(CanUnlock));
                OnPropertyChanged(nameof(ProgressText));
            }
        }
    }

    /// <summary>
    /// Whether games are currently unlocked.
    /// </summary>
    public bool IsUnlocked
    {
        get => _isUnlocked;
        set
        {
            if (_isUnlocked != value)
            {
                _isUnlocked = value;
                OnPropertyChanged();
            }
        }
    }

    /// <summary>
    /// Whether the user has performed enough squats to unlock.
    /// </summary>
    public bool CanUnlock => SquatCount >= RequiredSquats;

    /// <summary>
    /// Progress text for display (e.g., "7/10 squats").
    /// </summary>
    public string ProgressText => $"{SquatCount}/{RequiredSquats} squats";

    /// <summary>
    /// Adds a squat to the counter (caps at RequiredSquats).
    /// </summary>
    public void AddSquat()
    {
        if (SquatCount < RequiredSquats)
        {
            SquatCount++;
        }
    }

    /// <summary>
    /// Resets the squat counter and locked state.
    /// </summary>
    public void Reset()
    {
        SquatCount = 0;
        IsUnlocked = false;
    }

    /// <summary>
    /// Unlocks games if enough squats have been performed.
    /// </summary>
    /// <returns>True if unlock was successful, false if not enough squats</returns>
    public bool TryUnlock()
    {
        if (CanUnlock)
        {
            IsUnlocked = true;
            return true;
        }
        return false;
    }

    protected virtual void OnPropertyChanged([CallerMemberName] string? propertyName = null)
    {
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
    }
}
