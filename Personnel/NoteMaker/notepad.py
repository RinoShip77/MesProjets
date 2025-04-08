from tkinter import *
import customtkinter
from CTkMenuBar import *
from PIL import Image
from tkinter import filedialog
import speech_recognition
import pyttsx3

customtkinter.set_appearance_mode("system")
customtkinter.set_default_color_theme("green")

openIcon = customtkinter.CTkImage(light_image=Image.open('img/open.png'), dark_image=Image.open('img/open.png'), size=(20,20))
saveIcon = customtkinter.CTkImage(light_image=Image.open('img/save.png'), dark_image=Image.open('img/save.png'), size=(20,20))
speakIcon = customtkinter.CTkImage(light_image=Image.open('img/speak.png'), dark_image=Image.open('img/speak.png'), size=(20,20))
readIcon = customtkinter.CTkImage(light_image=Image.open('img/read.png'), dark_image=Image.open('img/read.png'), size=(20,20))

class Submenu(customtkinter.CTkFrame):
    def __init__(self, master, **kwargs):
        super().__init__(master, **kwargs)
        self.grid_columnconfigure((0, 1), weight=1)
        self.grid_rowconfigure(0, weight=1)

        # Add buttons to frame
        self.openBtn = customtkinter.CTkButton(self, text="Open File", image=openIcon, hover=True, command=OpenFile)
        self.openBtn.grid(row=0, column=0, padx=5, pady=15, sticky="nsew")

        self.saveBtn = customtkinter.CTkButton(self, text="Save", image=saveIcon, hover=True, command=SaveFile)
        self.saveBtn.grid(row=0, column=1, padx=5, pady=15, sticky="nsew")
        
        self.speakBtn = customtkinter.CTkButton(self, text="Speak", image=speakIcon, hover=True, command=Speak)
        self.speakBtn.grid(row=0, column=2, padx=5, pady=15, sticky="nsew")
        
        self.readBtn = customtkinter.CTkButton(self, text="Read", image=readIcon, hover=True, command=Read)
        self.readBtn.grid(row=0, column=3, padx=5, pady=15, sticky="nsew")

class Menu(customtkinter.CTkFrame):
    def __init__(self, master, **kwargs):
        super().__init__(master, **kwargs)
        self.grid_rowconfigure(0, weight=1)
        self.columnconfigure(2, weight=1)

        # Add the submenu and the combobox to the frame
        self.menu = Submenu(self)
        self.menu.grid(row=0, column=0, padx=5, pady=5, sticky="nsew")

        self.combobox = customtkinter.CTkComboBox(self, values=["system", "dark", "light"], hover=True, command=ChangeMode)
        self.combobox.grid(row=0, column=2, padx=10, pady=20, sticky="e")
        self.combobox.set("system")


class TabView(customtkinter.CTkTabview):
    def __init__(self, master, **kwargs):
        super().__init__(master, **kwargs)
        self.grid_columnconfigure(0, weight=1)

        # Create tabs
        self.add("tab 1")
        self.add("tab 2")
        self.add("+")

        # Add a textbox in the tabs
        self.tab("tab 1").grid_rowconfigure(0, weight=1)
        self.tab("tab 1").grid_columnconfigure(0, weight=1)

        self.textbox = customtkinter.CTkTextbox(self.tab("tab 1"), corner_radius=5, wrap="word")
        self.textbox.grid(row=0, column=0, padx=10, pady=10, sticky="nsew")
        
        self.text = customtkinter.CTkTextbox(self.tab("tab 2"), corner_radius=5, wrap="word")
        self.text.grid(row=0, column=0, padx=10, pady=10, sticky="nsew")
        
        # self.tab("+").configure(command=NewFile)


class App(customtkinter.CTk):
    def __init__(self):
        super().__init__()
        self.title("NoteMaker")
        self.geometry("1500x1000")
        self.minsize(width=700, height=200)
        self.resizable(True, True)
        self.grid_rowconfigure(1, weight=1)
        self.grid_columnconfigure(0, weight=1)
        self.wm_iconbitmap('img/logo.ico')
        
        # Add the menu and the tab viewer to the main window
        self.menu = Menu(self)
        self.menu.grid(row=0, column=0, padx=20, pady=5, sticky="nsew")

        self.tabView = TabView(self)
        self.tabView.grid(row=1, column=0, padx=10, pady=10, sticky="nsew")


# Add methods to app
def ChangeMode(choice):
    customtkinter.set_appearance_mode(choice)

def NewFile():
    print("New file")
    # TODO: Complete the new file function

def OpenFile():
    files = filedialog.askopenfiles(mode='r', filetype=[('*. txt')], multiple=True)
    for file in files:
        print(file.name)
    # file = filedialog.askopenfile(mode='r', filetype=[('text files',' *. txt')], defaultextension='.txt', multiple=True)
    # if file is not None:
    #     content = file.read()
    # app.textbox.insert("0.0", content)
        
def SaveFile():
    openFile = filedialog.asksaveasfile(mode='w', defaultextension='.txt')
    if openFile is None:
        return
    text = app.textbox.get("0.0","end")
    openFile.write(text)
    openFile.close()

def Speak():
    with speech_recognition.Microphone() as source:
        recognizer = speech_recognition.Recognizer()
        # read the audio data from the default microphone
        audio_data = recognizer.record(source, duration=5)
        # convert speech to text
        text = recognizer.recognize_google(audio_data)
        app.textbox.insert("0.0", text)

def Read():
    engine = pyttsx3.init()
    text = app.textbox.get("0.0","end")
    engine.say(text)
    engine.runAndWait()

# Create an window instance
app = App()
# Execute the main program
app.mainloop()