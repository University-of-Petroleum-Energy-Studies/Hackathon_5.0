import tkinter as tk

class PomodoroApp(tk.Tk):
    def __init__(self):
        tk.Tk.__init__(self)
        self.geometry("400x600")

        self.frame = None
        self.switch_frame(StartPage)
    def switch_frame(self, frame_class):
        new_frame = frame_class(self)
        if self.frame is not None:
            self.frame.destroy()
        self.frame = new_frame
        self.frame.pack()
class StartPage(tk.Frame):
    def __init__(self, master):
        tk.Frame.__init__(self, master, bg='red')
        tk.Label(self, text="Welcome", font=('Roboto', 18, "normal")).pack(side="top", fill="x", pady=5)
        tk.Button(self, text="README", font=('MathJax_SansSerif-Bold', 18, "bold"),
                  command=lambda: master.switch_frame(READMEPage)).pack(side='left', fill='x', pady=10)
        tk.Button(self, text="START POMODORO", font=('MathJax_SansSerif-Bold', 18, "bold"),
                  command=lambda: master.switch_frame(PomodoroPage)).pack(side='right', fill='x', pady=10)

app = PomodoroApp()
app.mainloop()


