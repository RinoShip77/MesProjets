using Microsoft.Maui.Graphics;

namespace GrindWall.Models;

public class InstalledApp
{
    public string Name { get; set; } = string.Empty;
    public string PackageName { get; set; } = string.Empty; // Process name on Windows, Package on Android
    public ImageSource? Icon { get; set; }
    public string Platform { get; set; } = "System"; // e.g., Android, Windows, Steam
    public TimeSpan UsageTime { get; set; }
    public bool IsBlocked { get; set; }
    public string Category { get; set; } = "General";
}
