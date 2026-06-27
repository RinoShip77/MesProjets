using Microsoft.Extensions.Logging;
using GrindWall.Services;
using GrindWall.ViewModels;

namespace GrindWall;

public static class MauiProgram
{
	public static MauiApp CreateMauiApp()
	{
		var builder = MauiApp.CreateBuilder();
		builder
			.UseMauiApp<App>()
			.ConfigureFonts(fonts =>
			{
				fonts.AddFont("OpenSans-Regular.ttf", "OpenSansRegular");
				fonts.AddFont("OpenSans-Semibold.ttf", "OpenSansSemibold");
				fonts.AddFont("fa_solid.otf", "FASolid");
				fonts.AddFont("fa_regular.otf", "FARegular");
				fonts.AddFont("fa_brands.otf", "FABrands");
				fonts.AddFont("fluent_regular.ttf", "FluentRegular");
				fonts.AddFont("fluent_filled.ttf", "FluentFilled");
			});

		// Register cross-platform services
		builder.Services.AddSingleton<SquatCounterService>();
		builder.Services.AddSingleton<NetworkSyncService>();

		// Register platform-specific services using conditional compilation
#if ANDROID
		builder.Services.AddSingleton<ISquatDetector, Platforms.Android.SquatDetector>();
		builder.Services.AddSingleton<IAppBlocker, Platforms.Android.AndroidAppBlocker>();
#endif

#if WINDOWS
		builder.Services.AddSingleton<IAppBlocker, Platforms.Windows.WindowsAppBlocker>();
#endif

		// Register ViewModels
		builder.Services.AddTransient<MainPageViewModel>();

		// Register Pages
		builder.Services.AddTransient<MainPage>();

#if DEBUG
		builder.Logging.AddDebug();
#endif

		return builder.Build();
	}
}
