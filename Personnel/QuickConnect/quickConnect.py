import customtkinter
from PIL import Image
import speedtest
import threading
from tkdial import Meter
from numpy import random

class Image:
    latencyIcon = customtkinter.CTkImage(light_image=Image.open('img/latency.png'), dark_image=Image.open('img/latency.png'), size=(30, 30))
    downloadIcon = customtkinter.CTkImage(light_image=Image.open('img/download.png'), dark_image=Image.open('img/download.png'), size=(30, 30))
    uploadIcon = customtkinter.CTkImage(light_image=Image.open('img/upload.png'), dark_image=Image.open('img/upload.png'), size=(30, 30))
    serviceIcon = customtkinter.CTkImage(light_image=Image.open('img/service.png'), dark_image=Image.open('img/service.png'), size=(30, 30))
    serverIcon = customtkinter.CTkImage(light_image=Image.open('img/server.png'), dark_image=Image.open('img/server.png'), size=(30, 30))
    startBtnImg = customtkinter.CTkImage(light_image=Image.open('img/start.png'), dark_image=Image.open('img/start.png'), size=(50, 50))

class DefaultText:
    dataLbl = "__.__"
    serviceLbl = "____"
    serverLbl = "_._._._"

class BottomFrame(customtkinter.CTkFrame):
    def __init__(self, master, **kwargs):
        super().__init__(master, **kwargs)
        self.grid_columnconfigure(0, weight=1)
        # Add widgets onto the frame, for example:
        self.testBtn = customtkinter.CTkButton(self, text="START", font=("arial", 40), image=Image.startBtnImg, fg_color="transparent", hover=True, hover_color="#2b2b2b", command=Check, compound="left")
        self.testBtn.grid(row=0, column=0)

class ServerFrame(customtkinter.CTkFrame):
    def __init__(self, master, **kwargs):
        super().__init__(master, **kwargs)
        self.grid_columnconfigure(0, weight=1)
        self.serverIcon = customtkinter.CTkLabel(self, image=Image.serverIcon, text="")
        self.serverIcon.grid(row=0)
        self.serverTitle = customtkinter.CTkLabel(self, text="Server", font=("arial", 20))
        self.serverTitle.grid(row=1, column=0)
        self.serverLbl = customtkinter.CTkLabel(self, text=DefaultText.serverLbl, text_color="#e9b342")
        self.serverLbl.grid(row=2)

class GaugeFrame(customtkinter.CTkFrame):
    def __init__(self, master, **kwargs):
        super().__init__(master, **kwargs)
        self.grid_columnconfigure(0, weight=1)
        self.gauge = Meter(self, bg="#242424", fg="black", start=0, end=500, start_angle=210, end_angle=-240, radius=300, scale_color="black", border_width=5, needle_color="white", axis_color="white", text_color="black", text_font="DS-Digital 30")
        self.gauge.set_mark(1, 100, "red")
        self.gauge.set_mark(105, 390, "yellow")
        self.gauge.set_mark(395, 495, "green")
        self.gauge.grid(row=0, column=0)
        self.gaugeLbl = customtkinter.CTkLabel(self, text=DefaultText.dataLbl, text_color="#e9b342")
        self.gaugeLbl.grid(row=1, column=0)

class ServiceFrame(customtkinter.CTkFrame):
    def __init__(self, master, **kwargs):
        super().__init__(master, **kwargs)
        self.grid_columnconfigure(0, weight=1)
        self.serviceIcon = customtkinter.CTkLabel(self, image=Image.serviceIcon, text="")
        self.serviceIcon.grid(row=0)
        self.serviceTitle = customtkinter.CTkLabel(self, text="Service", font=("arial", 20))
        self.serviceTitle.grid(row=1, column=0)
        self.serviceLbl = customtkinter.CTkLabel(self, text=DefaultText.serviceLbl, text_color="#e9b342")
        self.serviceLbl.grid(row=2)

class MeterFrame(customtkinter.CTkFrame):
    def __init__(self, master, **kwargs):
        super().__init__(master, **kwargs)
        self.grid_rowconfigure(0, weight=1)
        self.grid_columnconfigure((0, 1), weight=1)
        # Add widgets onto the frame, for example:
        self.serviceFrame = ServiceFrame(self, fg_color="transparent")
        self.serviceFrame.grid(row=0, column=0, pady=(150, 0), sticky="w")
        self.gaugeFrame = GaugeFrame(self, fg_color="transparent")
        self.gaugeFrame.grid(row=0, column=1, sticky="w")
        self.serverFrame = ServerFrame(self, fg_color="transparent")
        self.serverFrame.grid(row=0, column=2, pady=(150, 0), sticky="w")

class UploadFrame(customtkinter.CTkFrame):
    def __init__(self, master, **kwargs):
        super().__init__(master, **kwargs)
        self.grid_columnconfigure(0, weight=1)
        self.uploadIcon = customtkinter.CTkLabel(self, image=Image.uploadIcon, text="")
        self.uploadIcon.grid(row=0, padx=(15, 0))
        self.uploadTitle = customtkinter.CTkLabel(self, text="Upload", font=("arial", 20))
        self.uploadTitle.grid(row=1, column=0, padx=2)
        self.uploadUnit = customtkinter.CTkLabel(self, text="Mbps", font=("arial", 10))
        self.uploadUnit.grid(row=1, column=1, pady=(5, 0))
        self.uploadLbl = customtkinter.CTkLabel(self, text=DefaultText.dataLbl, text_color="#c91e07")
        self.uploadLbl.grid(row=2, padx=(15, 0))

class DownloadFrame(customtkinter.CTkFrame):
    def __init__(self, master, **kwargs):
        super().__init__(master, **kwargs)
        self.grid_columnconfigure(0, weight=1)
        self.downloadIcon = customtkinter.CTkLabel(self, image=Image.downloadIcon, text="")
        self.downloadIcon.grid(row=0, padx=(15, 0))
        self.downloadTitle = customtkinter.CTkLabel(self, text="Download", font=("arial", 20))
        self.downloadTitle.grid(row=1, column=0, padx=2)
        self.downloadUnit = customtkinter.CTkLabel(self, text="Mbps", font=("arial", 10))
        self.downloadUnit.grid(row=1, column=1, pady=(5, 0))
        self.downloadLbl = customtkinter.CTkLabel(self, text=DefaultText.dataLbl, text_color="#717800")
        self.downloadLbl.grid(row=2, padx=(15, 0))

class LatencyFrame(customtkinter.CTkFrame):
    def __init__(self, master, **kwargs):
        super().__init__(master, **kwargs)
        self.grid_columnconfigure(0, weight=1)
        self.latencyIcon = customtkinter.CTkLabel(self, image=Image.latencyIcon, text="")
        self.latencyIcon.grid(row=0, padx=(15, 0))
        self.latencyTitle = customtkinter.CTkLabel(self, text="Latency", font=("arial", 20))
        self.latencyTitle.grid(row=1, column=0, padx=2)
        self.latencyUnit = customtkinter.CTkLabel(self, text="ms", font=("arial", 10))
        self.latencyUnit.grid(row=1, column=1, pady=(5, 0))
        self.latencyLbl = customtkinter.CTkLabel(self, text=DefaultText.dataLbl, text_color="#e9b342")
        self.latencyLbl.grid(row=2, padx=(15, 0))

class DataFrame(customtkinter.CTkFrame):
    def __init__(self, master, **kwargs):
        super().__init__(master, **kwargs)
        self.grid_rowconfigure(0, weight=1)
        self.grid_columnconfigure((0, 1), weight=1)
        # Add widgets onto the frame, for example:
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
        # Add widgets onto the frame, for example:
        self.title = customtkinter.CTkLabel(self, text="QuickConnect", font=("arial", 50), justify="center")
        self.title.grid(row=0)
        self.subtitle = customtkinter.CTkLabel(self, text="by Olivier Bourgault", font=("arial", 12), justify="center")
        self.subtitle.grid(row=1)

class App(customtkinter.CTk):
    def __init__(self):
        super().__init__()
        self.title("QuickConnect")
        self.geometry(CenterWindowToDisplay(self, 450, 750, self._get_window_scaling()))
        self.resizable(False, False)
        self.grid_columnconfigure(0, weight=1)
        self.wm_iconbitmap('img/logo.ico')
        # Add frames to app
        self.topFrame = TopFrame(self, fg_color="transparent")
        self.topFrame.grid(row=0, pady=10, sticky="nsew")
        self.dataFrame = DataFrame(self, fg_color="transparent")
        self.dataFrame.grid(row=1, padx=50, pady=20, sticky="ew")
        self.meterFrame = MeterFrame(self, fg_color="transparent")
        self.meterFrame.grid(row=2, padx=40, pady=(50, 0), sticky="nsew")
        self.bottomFrame = BottomFrame(self, fg_color="transparent")
        self.bottomFrame.grid(row=3, padx=50, pady=50, sticky="nsew")

def CenterWindowToDisplay(Screen: customtkinter.CTk, width: int, height: int, scale_factor: float = 1.0):
    # Centers the window to the main display/monitor
    return f"{width}x{height}+{int(((Screen.winfo_screenwidth()/2) - (width/2)) * scale_factor)}+{int(((Screen.winfo_screenheight()/2) - (height/1.5)) * scale_factor)}"

def Test():
    def run_speed_test():
        # Tell the speed test started
        app.meterFrame.gaugeFrame.gauge.set(random.randint(50, 175))
        app.meterFrame.gaugeFrame.gaugeLbl.configure(text="Loading...")
        test = speedtest.Speedtest()
        servers = []
        test.get_servers(servers)
        data = test.get_config()
        serviceProvider = data["client"]["isp"]
        ipAddress = data["client"]["ip"]
        uploadResult = round(test.upload() / (1024 * 1024), 2)
        downloadResult = round(test.download() / (1024 * 1024), 2)
        # Update the labels with the test results
        app.dataFrame.latencyFrame.latencyLbl.configure(text=test.results.ping)
        app.dataFrame.downloadFrame.downloadLbl.configure(text=downloadResult)
        app.dataFrame.uploadFrame.uploadLbl.configure(text=uploadResult)
        app.meterFrame.serviceFrame.serviceLbl.configure(text=serviceProvider)
        app.meterFrame.gaugeFrame.gaugeLbl.configure(text=downloadResult)
        app.meterFrame.gaugeFrame.gauge.set(downloadResult)
        app.meterFrame.serverFrame.serverLbl.configure(text=ipAddress)
        app.update()
    # Start the speed test in a separate thread
    threading.Thread(target=run_speed_test).start()

def Check():
    if app.meterFrame.gaugeFrame.gaugeLbl.cget("text") != DefaultText.dataLbl:
        app.meterFrame.gaugeFrame.gauge.set(0)
        app.dataFrame.latencyFrame.latencyLbl.configure(text=DefaultText.dataLbl)
        app.dataFrame.downloadFrame.downloadLbl.configure(text=DefaultText.dataLbl)
        app.dataFrame.uploadFrame.uploadLbl.configure(text=DefaultText.dataLbl)
        app.meterFrame.serviceFrame.serviceLbl.configure(text=DefaultText.serviceLbl)
        app.meterFrame.gaugeFrame.gaugeLbl.configure(text=DefaultText.dataLbl)
        app.meterFrame.serverFrame.serverLbl.configure(text=DefaultText.serverLbl)
        threading.Timer(1, Test).start()
    else:
        Test()

app = App()
app.mainloop()