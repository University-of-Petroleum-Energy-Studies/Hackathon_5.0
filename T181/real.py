import tkinter as tk
from tkinter import *
import os
import time
from tkinter import messagebox
root = tk.Tk()
root.title("welcome")
root.geometry('200x200')
f1 = Frame(root)
f2 = Frame(root)
def fun():
        os.system('python tk.py')



B = tk.Button(root,text='AI Mode')
B2 = tk.Button(root,text='Custom Mode',command=fun)
root.grid_rowconfigure(0, weight=1)
root.grid_columnconfigure(0, weight=1)
B.grid(row=1, column=1)
B2.grid(row=1,column=0)
root.mainloop()

