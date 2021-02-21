import tkinter as tk
from tkinter import ttk
from tkinter import *
import os

# this is the function called when the button is clicked
def Custom():
    os.system('python testing.py')


# this is the function called when the button is clicked
def Ai():
    os.system('python aimode.py')



root = Tk()

# This is the section of code which creates the main window
root.geometry('368x570')
root.configure(background='#FF7F50')
root.title('Pomodoro Timer')


# This is the section of code which creates the a label
Label(root, text='Let\'s get Productive', bg='#FF7F50', font=('arial', 18, 'normal')).place(x=78, y=113)


# This is the section of code which creates a button
Button(root, text='Set Timer', bg='#8B3E2F', font=('arial', 18, 'normal'), command=Custom).place(x=112, y=220)


# This is the section of code which creates a button
Button(root, text='Personalized Timer', bg='#8B3E2F', font=('arial', 18, 'normal'), command=Ai).place(x=63, y=320)
'''Label(root, text='enter url:', bg='#FF7F50', font=('arial', 12, 'normal')).place(x=50, y=400)
urlinput=Entry(root)
urlinput.place(x=115, y=400)
urlinput.insert(END, 'https://www.youtube.com/watch?v=SvWfZGhjwGs')
global URL
URL = urlinput.get()'''
root.mainloop()