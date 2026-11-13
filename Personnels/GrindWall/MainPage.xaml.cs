using GrindWall.ViewModels;
using GrindWall.Services;

namespace GrindWall;

public partial class MainPage : ContentPage
{
	private readonly IAppBlocker? _appBlocker;

	public MainPage(MainPageViewModel viewModel, IAppBlocker appBlocker)
	{
		InitializeComponent();
		BindingContext = viewModel;
		_appBlocker = appBlocker;
        System.Diagnostics.Debug.WriteLine($"[MainPage] Constructor: AppBlocker is {(_appBlocker != null ? "NOT null" : "null")}");
	}

	protected override void OnAppearing()
	{
		base.OnAppearing();
        System.Diagnostics.Debug.WriteLine("[MainPage] OnAppearing triggered");

#if ANDROID
        MainThread.BeginInvokeOnMainThread(async () => 
        {
            // Small delay to ensure the window is ready for a dialog
            await Task.Delay(1000);
            
            bool hasPermission = _appBlocker?.HasPermission() ?? true;
            System.Diagnostics.Debug.WriteLine($"[MainPage] Async Check - HasPermission: {hasPermission}");

            if (_appBlocker != null && !hasPermission)
            {
                System.Diagnostics.Debug.WriteLine("[MainPage] Showing Permission Alert...");
                bool result = await DisplayAlert("Permission Required", "Please allow Usage Access to enable blocking.", "OK", "Cancel");
                if (result)
                {
                    System.Diagnostics.Debug.WriteLine("[MainPage] User accepted, requesting permission...");
                    _appBlocker.RequestPermission(); 
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("[MainPage] User cancelled permission request");
                }
            }
        });
#endif
	}
}
