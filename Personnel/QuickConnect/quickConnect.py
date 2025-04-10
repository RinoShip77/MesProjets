import customtkinter
from PIL import Image
import speedtest
import threading

bgImg = customtkinter.CTkImage(light_image=Image.open('img/backgroundd.png'), dark_image=Image.open('img/backgroundd.png'), size=(450, 780))
pingIcon = customtkinter.CTkImage(light_image=Image.open('img/ping.png'), dark_image=Image.open('img/ping.png'), size=(30, 30))
downloadIcon = customtkinter.CTkImage(light_image=Image.open('img/download.png'), dark_image=Image.open('img/download.png'), size=(30, 30))
uploadIcon = customtkinter.CTkImage(light_image=Image.open('img/upload.png'), dark_image=Image.open('img/upload.png'), size=(30, 30))
gaugeImg = customtkinter.CTkImage(light_image=Image.open('img/gauge.png'), dark_image=Image.open('img/gauge.png'), size=(350, 300))
testImg = customtkinter.CTkImage(light_image=Image.open('img/button.png'), dark_image=Image.open('img/button.png'), size=(100, 100))
resetImg = customtkinter.CTkImage(light_image=Image.open('img/reset.png'), dark_image=Image.open('img/reset.png'), size=(100, 100))

class GaugeFrame(customtkinter.CTkFrame):
    def __init__(self, master, **kwargs):
        super().__init__(master, **kwargs)
        self.grid_columnconfigure(0, weight=1)

        # TODO: Add the gauge img
        self.gaugeImg = customtkinter.CTkLabel(self, image=gaugeImg, text="")
        self.gaugeImg.grid(row=0, column=0)

        # self.Test_Button = customtkinter.CTkButton(self, image=testImg, fg_color="#141527", command=Check)
        # self.Test_Button.place(x=125, y=510)

        # self.Reset_Button = customtkinter.CTkButton(self, image=resetImg, fg_color="#141527", command=Reset)
        # self.Reset_Button.place(x=190, y=600)


        # Labels to show values
        # self.Download = customtkinter.CTkLabel(self, font=("arial", 30), fg_color="#141527", text_color="#00FFFF")
        # self.Download.place(x=225, y=430, anchor="center")

        # self.service = customtkinter.CTkLabel(self, text="______", font=("arial", 12), fg_color="#141527", text_color="white")
        # self.service.place(x=55, y=590, anchor="center")

        # self.ip = customtkinter.CTkLabel(self, text="____.____.____.____", font=("arial", 12), fg_color="#141527", text_color="white")
        # self.ip.place(x=380, y=590, anchor="center")

class UploadFrame(customtkinter.CTkFrame):
    def __init__(self, master, **kwargs):
        super().__init__(master, **kwargs)
        self.grid_columnconfigure(0, weight=1)

        self.uploadIcon = customtkinter.CTkLabel(self, image=uploadIcon, text="")
        self.uploadIcon.grid(row=0, padx=(15, 0))
        self.uploadTitle = customtkinter.CTkLabel(self, text="Upload", font=("arial", 20))
        self.uploadTitle.grid(row=1, column=0, padx=2)
        self.uploadUnit = customtkinter.CTkLabel(self, text="Mbps", font=("arial", 10))
        self.uploadUnit.grid(row=1, column=1, pady=(5, 0))
        self.upload = customtkinter.CTkLabel(self, text="__.__", text_color="#e9b342")
        self.upload.grid(row=2, padx=(15, 0))

class DownloadFrame(customtkinter.CTkFrame):
    def __init__(self, master, **kwargs):
        super().__init__(master, **kwargs)
        self.grid_columnconfigure(0, weight=1)

        self.downloadIcon = customtkinter.CTkLabel(self, image=downloadIcon, text="")
        self.downloadIcon.grid(row=0, padx=(15, 0))
        self.downloadTitle = customtkinter.CTkLabel(self, text="Download", font=("arial", 20))
        self.downloadTitle.grid(row=1, column=0, padx=2)
        self.downloadUnit = customtkinter.CTkLabel(self, text="Mbps", font=("arial", 10))
        self.downloadUnit.grid(row=1, column=1, pady=(5, 0))
        self.download = customtkinter.CTkLabel(self, text="__.__", text_color="#e9b342")
        self.download.grid(row=2, padx=(15, 0))

class LatencyFrame(customtkinter.CTkFrame):
    def __init__(self, master, **kwargs):
        super().__init__(master, **kwargs)
        self.grid_columnconfigure(0, weight=1)

        self.pingIcon = customtkinter.CTkLabel(self, image=pingIcon, text="")
        self.pingIcon.grid(row=0, padx=(15, 0))
        self.pingTitle = customtkinter.CTkLabel(self, text="Latency", font=("arial", 20))
        self.pingTitle.grid(row=1, column=0, padx=2)
        self.pingUnit = customtkinter.CTkLabel(self, text="ms", font=("arial", 10))
        self.pingUnit.grid(row=1, column=1, pady=(5, 0))
        self.ping = customtkinter.CTkLabel(self, text="__.__", text_color="#e9b342")
        self.ping.grid(row=2, padx=(15, 0))

class DataFrame(customtkinter.CTkFrame):
    def __init__(self, master, **kwargs):
        super().__init__(master, **kwargs)
        self.grid_rowconfigure(0, weight=1)
        self.grid_columnconfigure((0, 1), weight=1)

        # add widgets onto the frame, for example:
        self.latencyFrame = LatencyFrame(self, fg_color="transparent")
        self.latencyFrame.grid(row=0, column=0, sticky="n")
        
        self.downloadFrame = DownloadFrame(self, fg_color="transparent")
        self.downloadFrame.grid(row=0, column=1, sticky="n")
        
        self.uploadFrame = UploadFrame(self, fg_color="transparent")
        self.uploadFrame.grid(row=0, column=2, padx=10, sticky="n")

class TopFrame(customtkinter.CTkFrame):
    def __init__(self, master, **kwargs):
        super().__init__(master, **kwargs)
        self.grid_columnconfigure(0, weight=1)

        # add widgets onto the frame, for example:
        self.title = customtkinter.CTkLabel(self, text="QuickConnect", font=("arial", 50), justify="center")
        self.title.grid(row=0)
        
        self.subtitle = customtkinter.CTkLabel(self, text="by Olivier Bourgault", font=("arial", 12), justify="center")
        self.subtitle.grid(row=1)

class App(customtkinter.CTk):
    def __init__(self):
        super().__init__()
        self.title("QuickConnect")
        self.geometry(CenterWindowToDisplay(self, 500, 780, self._get_window_scaling()))
        self.resizable(False, False)
        self.grid_columnconfigure(0, weight=1)
        self.wm_iconbitmap('img/logo.ico')

        # Add frames to app
        self.topFrame = TopFrame(self, fg_color="transparent")
        self.topFrame.grid(row=0, column=0, pady=10, sticky="nsew")
        
        self.dataFrame = DataFrame(self, fg_color="transparent")
        self.dataFrame.grid(row=1, column=0, padx=50, pady=20, sticky="ew")
        
        self.gaugeFrame = GaugeFrame(self) #fg_color="transparent"
        self.gaugeFrame.grid(row=2, column=0, pady=50, sticky="nsew")

def CenterWindowToDisplay(Screen: customtkinter.CTk, width: int, height: int, scale_factor: float = 1.0):
    """Centers the window to the main display/monitor"""
    screen_width = Screen.winfo_screenwidth()
    screen_height = Screen.winfo_screenheight()
    x = int(((screen_width/2) - (width/2)) * scale_factor)
    y = int(((screen_height/2) - (height/1.5)) * scale_factor)
    return f"{width}x{height}+{x}+{y}"

def Test():
    def run_speed_test():
        app.Download.configure(text="Loading...")
        
        test = speedtest.Speedtest()
        servernames = []
        test.get_servers(servernames)
        data = test.get_config()

        service_data = data["client"]["isp"]
        ip_data = data["client"]["ip"]

        uploading = round(test.upload() / (1024 * 1024), 2)
        downloading = round(test.download() / (1024 * 1024), 2)

        # Update the labels with the test results
        app.ping.configure(text=test.results.ping)
        app.upload.configure(text=uploading)
        app.download.configure(text=downloading)
        app.Download.configure(text=downloading)
        app.service.configure(text=service_data)
        app.ip.configure(text=ip_data)
        app.update()

    # Start the speed test in a separate thread
    threading.Thread(target=run_speed_test).start()


def Check():
    Test()


# #Set all data to 00
def Reset():
    app.ping.configure(text="--")
    app.upload.configure(text="--")
    app.download.configure(text="--")
    app.Download.configure(text="--")
    app.service.configure(text="- - -")
    app.ip.configure(text="- - - - - - - -")


app = App()
app.mainloop()