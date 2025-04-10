from tkinter import *
import customtkinter
from PIL import Image
from tkinter import filedialog
import speech_recognition
import pyttsx3
import language_tool_python

# Set some constants
customtkinter.set_default_color_theme("green")
openIcon = customtkinter.CTkImage(light_image=Image.open('img/open.png'), dark_image=Image.open('img/open.png'), size=(20,20))
saveIcon = customtkinter.CTkImage(light_image=Image.open('img/save.png'), dark_image=Image.open('img/save.png'), size=(20,20))
speakIcon = customtkinter.CTkImage(light_image=Image.open('img/speak.png'), dark_image=Image.open('img/speak.png'), size=(20,20))
readIcon = customtkinter.CTkImage(light_image=Image.open('img/read.png'), dark_image=Image.open('img/read.png'), size=(20,20))
grammarCheckIcon = customtkinter.CTkImage(light_image=Image.open('img/grammarCheck.png'), dark_image=Image.open('img/grammarCheck.png'), size=(20,20))

# UI component as classes
class Submenu(customtkinter.CTkFrame):
    def __init__(self, master, **kwargs):
        super().__init__(master, **kwargs)
        self.grid_rowconfigure(0, weight=1)
        self.grid_columnconfigure((0, 1), weight=1)

        # Add buttons to frame
        self.openBtn = customtkinter.CTkButton(self, text="Open File", image=openIcon, hover=True, command=OpenFile)
        self.openBtn.grid(row=0, column=0, padx=5, pady=15, sticky="nsew")

        self.saveBtn = customtkinter.CTkButton(self, text="Save", image=saveIcon, hover=True, command=SaveFile)
        self.saveBtn.grid(row=0, column=1, padx=5, pady=15, sticky="nsew")
        
        self.speakBtn = customtkinter.CTkButton(self, text="Speak", image=speakIcon, hover=True, command=Speak)
        self.speakBtn.grid(row=0, column=2, padx=5, pady=15, sticky="nsew")
        
        self.readBtn = customtkinter.CTkButton(self, text="Read", image=readIcon, hover=True, command=Read)
        self.readBtn.grid(row=0, column=3, padx=5, pady=15, sticky="nsew")
        
        self.grammarCheckBtn = customtkinter.CTkButton(self, text="Grammar check", image=grammarCheckIcon, hover=True, command=GrammarCheck)
        self.grammarCheckBtn.grid(row=0, column=4, padx=5, pady=15, sticky="nsew")

class Menu(customtkinter.CTkFrame):
    def __init__(self, master, **kwargs):
        super().__init__(master, **kwargs)
        self.grid_rowconfigure(0, weight=1)
        self.columnconfigure(2, weight=1)

        # Add the submenu and the combobox to the frame
        self.submenu = Submenu(self)
        self.submenu.grid(row=0, column=0, padx=5, pady=5, sticky="nsew")

        self.combobox = customtkinter.CTkComboBox(self, values=["system", "dark", "light"], hover=True, command=ChangeMode)
        self.combobox.grid(row=0, column=2, padx=10, pady=20, sticky="e")
        self.combobox.set("system")

class TabView(customtkinter.CTkTabview):
    def __init__(self, master, **kwargs):
        super().__init__(master, **kwargs)
        self.grid_columnconfigure(0, weight=1)

        # Create starting tabs
        self.add("New file")
        self.add("+")

        # Set configurations for the first tab
        self.tab("New file").grid_rowconfigure(0, weight=1)
        self.tab("New file").grid_columnconfigure(0, weight=1)

        # Add a textbox in the first tab
        self.textbox = customtkinter.CTkTextbox(self.tab("New file"), corner_radius=5, wrap="word")
        self.textbox.grid(row=0, column=0, padx=10, pady=10, sticky="nsew")

class App(customtkinter.CTk):
    def __init__(self):
        super().__init__()
        self.title("NoteMaker")
        self.geometry("1500x1000")
        self.minsize(width=1000, height=200)
        self.resizable(True, True)
        self.grid_rowconfigure(1, weight=1)
        self.grid_columnconfigure(0, weight=1)
        self.wm_iconbitmap('img/logo.ico')
        
        # Add the menu and the tab viewer to the main window
        self.menu = Menu(self)
        self.menu.grid(row=0, column=0, padx=20, pady=5, sticky="nsew")

        self.tabView = TabView(self, command=NewTab)
        self.tabView.grid(row=1, column=0, padx=10, pady=10, sticky="nsew")

# Add methods to app
def NewTab(title = None):
    if app.tabView.get() == "+":
        if title is None:
            # Dynamically create a new tab
            title = "New file"
            app.tabView.insert(app.tabView.index("+"), title)
            app.tabView.tab(title).grid_rowconfigure(0, weight=1)
            app.tabView.tab(title).grid_columnconfigure(0, weight=1)
            app.tabView.textbox = customtkinter.CTkTextbox(app.tabView.tab(title), corner_radius=5, wrap="word")
            app.tabView.textbox.grid(row=0, column=0, padx=10, pady=10, sticky="nsew")
            app.tabView.set(title)

def SetTabs(currentTab, title):
    # Dynamically organise the existing tabs
    app.tabView.rename(currentTab, title)
    app.tabView.set(title)

def ChangeMode(choice):
    customtkinter.set_appearance_mode(choice)

def OpenFile():
    file = filedialog.askopenfile(mode='r', title="Open file", filetype=[("*. txt")])
    if file is not None:
        content = file.read()
    SetTabs(app.tabView.get(), file.name.split("/")[len(file.name.split("/")) - 1].split(".")[0])
    app.tabView.textbox.insert("0.0", content)
        
def SaveFile():
    openFile = filedialog.asksaveasfile(mode='w', title="Save file", initialfile=app.tabView.get(), filetype=[('text files', '*.txt')])
    if openFile is None:
        return
    SetTabs("New file", openFile.name.split("/")[len(openFile.name.split("/")) - 1].split(".")[0])
    openFile.write(app.tabView.textbox.get("0.0","end"))
    openFile.close()

def Speak():
    with speech_recognition.Microphone() as source:
        # Convert speech to text from the default microphone
        app.tabView.textbox.insert("end", speech_recognition.Recognizer().recognize_google(speech_recognition.Recognizer().record(source, duration=5)))

def Read():
    engine = pyttsx3.init()
    engine.say(app.tabView.textbox.get("0.0","end"))
    engine.runAndWait()

def GrammarCheck():
    with language_tool_python.LanguageToolPublicAPI('en-US') as checker:
        if checker.check(app.tabView.textbox.get("0.0","end")) is not None:
            text = checker.correct(app.tabView.textbox.get("0.0","end"))
            app.tabView.textbox.delete("0.0","end")
            app.tabView.textbox.insert("0.0", text)

customtkinter.set_appearance_mode("system")
# Create an window instance
app = App()
# Execute the main program
app.mainloop()