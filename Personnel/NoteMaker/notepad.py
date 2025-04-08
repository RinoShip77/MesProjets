from tkinter import *
import customtkinter
from tkinter import filedialog
import speech_recognition
from CTkMenuBar import *

customtkinter.set_appearance_mode("system")
customtkinter.set_default_color_theme("green")

class Menu(customtkinter.CTkFrame):
    def __init__(self, master, **kwargs):
        super().__init__(master, **kwargs)
        self.grid_rowconfigure(0, weight=1)
        self.columnconfigure(2, weight=1)

        # Add buttons to frame
        self.openBtn = customtkinter.CTkButton(self, text="Open File", hover=True, command=OpenFile)
        self.openBtn.grid(row=0, column=0, padx=5, pady=20, sticky="nse")

        self.saveBtn = customtkinter.CTkButton(self, text="Save", hover=True, command=SaveFile)
        self.saveBtn.grid(row=0, column=1, padx=5, pady=20, sticky="nse")

        self.combobox = customtkinter.CTkComboBox(self, values=["system", "dark", "light"], hover=True, command=ChangeMode, justify="right")
        self.combobox.grid(row=0, column=2, padx=10, pady=20, sticky="e")
        self.combobox.set("system")


class App(customtkinter.CTk):
    def __init__(self):
        super().__init__()
        self.title("NoteMaker")
        self.geometry("700x900")
        self.minsize(width=400, height=200)
        self.resizable(True, True)
        self.grid_rowconfigure(1, weight=1)
        self.grid_columnconfigure(0, weight=1)
        self.wm_iconbitmap('logo.ico')
        
        # Add frame to app
        # self.menu = CTkMenuBar(self)
        # self.option1 = self.menu.add_cascade("File")
        # self.option2 = self.menu.add_cascade("Edit")
        # self.option3 = self.menu.add_cascade("Settings")
        # self.option4 = self.menu.add_cascade("About")

        # self.dropdown1 = CustomDropdownMenu(widget=self.option1)
        # self.dropdown1.add_option(option="Open", command=OpenFile)
        # self.dropdown1.add_option(option="Save", command=SaveFile)
        # self.dropdown1.add_separator()
        # self.sub_menu1 = self.dropdown1.add_submenu("Export As")
        # self.sub_menu1.add_option(option=".TXT")
        # self.sub_menu1.add_option(option=".PDF")

        # self.dropdown2 = CustomDropdownMenu(widget=self.option2)
        # self.dropdown2.add_option(option="Cut")
        # self.dropdown2.add_option(option="Copy")
        # self.dropdown2.add_option(option="Paste")

        # self.dropdown3 = CustomDropdownMenu(widget=self.option3)
        # self.sub_menu2 = self.dropdown3.add_submenu("Preferences")
        # self.sub_menu2.add_option(option="System", command=ChangeMode)
        # self.sub_menu2.add_option(option="Dark", command=ChangeMode)
        # self.sub_menu2.add_option(option="Light", command=ChangeMode)

        # self.dropdown4 = CustomDropdownMenu(widget=self.option4)
        # self.dropdown4.add_option(option="Creator", command=lambda: print("Paste about me..."))

        self.optionMenu = Menu(self)
        self.optionMenu.grid(row=0, column=0, padx=20, pady=20, sticky="nsew")

        self.textbox = customtkinter.CTkTextbox(self, corner_radius=5, wrap="word")
        self.textbox.grid(row=1, column=0, padx=10, pady=10, sticky="nsew", rowspan=1)
        # self.textbox.pack(fill=BOTH, expand=1, padx=10, pady=10)

# Add methods to app
def ChangeMode(choice):
    customtkinter.set_appearance_mode(choice)

def OpenFile():
    file = filedialog.askopenfile(mode='r',filetype=[('text files',' *. txt')])
    if file is not None:
        content = file.read()
    app.textbox.insert("0.0", content)
        
def SaveFile():
    openFile = filedialog.asksaveasfile(mode='w',defaultextension='.txt')
    if openFile is None:
        return
    text=app.textbox.get("0.0","end")
    openFile.write(text)
    openFile.close()

def Speech():
    with speech_recognition.Microphone() as source:
        r = speech_recognition.Recognizer()
        # read the audio data from the default microphone
        audio_data = r.record(source, duration=5)
        print("Recognizing...")
        # convert speech to text
        text = r.recognize_google(audio_data)
        print(text)

# Create an window instance
app = App()
# Execute the main program
app.mainloop()