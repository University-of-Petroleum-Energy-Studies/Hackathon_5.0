import tkinter as tk
from tkinter import ttk
from tkinter import *
import pandas as pd
import joblib
from tkinter import messagebox


def submit():
    tree = joblib.load('model.pkl')
    age = Age.get()
    gender = Gender.get()
    program = Program.get()
    course = Course.get()
    academic = Academic.get()
    attendance = Attendance.get()
    data = [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]
    df = pd.DataFrame(data,
                      columns=['Age_18-20', 'Age_21-25', 'Age_26-30', 'Age_31-35', 'Age_<18', 'Age_>36', 'Gender_F',
                               'Gender_M', 'Program_FC', 'Program_IYO', 'Program_Language', 'Program_PM',
                               'Course_Art and Design', 'Course_Business', 'Course_Computing',
                               'Course_Law/Legal studies', 'Course_Media and Communications',
                               'Course_Science and engineering', 'Course_Social Sciences and Humanities',
                               'Academic_40%~49%', 'Academic_50%~59%', 'Academic_60%~70%	', 'Academic_<40%',
                               'Academic_>70%', 'Attendance_S0', 'Attendance_S1', 'Attendance_S2', 'Attendance_S3',
                               'Attendance_S4'])
    df.at[0, age] += 1
    df.at[0, gender] += 1
    df.at[0, program] += 1
    df.at[0, course] += 1
    df.at[0, academic] += 1
    df.at[0, attendance] += 1
    y = tree.predict(df)
    y = y.reshape(3, -1)
    if y[2] == 1:
        messagebox.showinfo("needs improvement", "Working Time = 25min,Break Time = 5min and remember to take long "
                                                 "break after 4 cycles")
    elif y[1] == 1:
        messagebox.showinfo("average", "Working Time = 50min,Break Time = 10min and remember to take long "
                                       "break after 2 cycles")

    else:
        messagebox.showinfo("pro", "Working Time = 1hour 15min,Break Time = 15min and remember to take long "
                                   "break after 2 cycles")


root = Tk()

# This is the section of code which creates the main window
root.geometry('700x535')
root.configure(background='#7FFF00')
root.title('Welcome to AI mode')

# This is the section of code which creates the a label
Label(root, text='Enter your age group', bg='#7FFF00', font=('arial', 12, 'normal')).place(x=102, y=63)

# This is the section of code which creates a combo box
Age = ttk.Combobox(root, values=['Age_18-20', 'Age_21-25', 'Age_26-30', 'Age_31-35', 'Age_<18', 'Age_>36'],
                   font=('arial', 12, 'normal'), width=30)
Age.place(x=290, y=62)

# This is the section of code which creates the a label
Label(root, text='Enter your Gender', bg='#7FFF00', font=('arial', 12, 'normal')).place(x=116, y=133)

# This is the section of code which creates a combo box
Gender = ttk.Combobox(root, values=['Gender_F', 'Gender_M'], font=('arial', 12, 'normal'), width=30)
Gender.place(x=290, y=131)

# This is the section of code which creates the a label
Label(root, text='Enter your Program details', bg='#7FFF00', font=('arial', 12, 'normal')).place(x=57, y=200)

# This is the section of code which creates a combo box
Program = ttk.Combobox(root, values=['Program_FC', 'Program_IYO', 'Program_Language', 'Program_PM'],
                       font=('arial', 12, 'normal'), width=30)
Program.place(x=290, y=195)

# This is the section of code which creates the a label
Label(root, text='Enter Course', bg='#7FFF00', font=('arial', 12, 'normal')).place(x=151, y=263)

Course = ttk.Combobox(root, values=['Course_Art and Design', 'Course_Business', 'Course_Computing',
                                    'Course_Law/Legal studies', 'Course_Media and Communications',
                                    'Course_Science and engineering', 'Course_Social Sciences and Humanities'],
                      font=('arial', 12, 'normal'), width=30)
Course.place(x=290, y=263)

Label(root, text='Enter Percentage bracket', bg='#7FFF00', font=('arial', 12, 'normal')).place(x=57, y=320)

Academic = ttk.Combobox(root, values=['Academic_40%~49%', 'Academic_50%~59%', 'Academic_<40%',
                                      'Academic_>70%'], font=('arial', 12, 'normal'), width=30)
Academic.place(x=290, y=320)

Label(root, text='Enter Attendance Category', bg='#7FFF00', font=('arial', 12, 'normal')).place(x=57, y=380)

Attendance = ttk.Combobox(root,
                          values=['Attendance_S0', 'Attendance_S1', 'Attendance_S2', 'Attendance_S3', 'Attendance_S4'],
                          font=('arial', 12, 'normal'), width=30)
Attendance.place(x=290, y=380)

# This is the section of code which creates a button
Button(root, text='Submit', bg='#76EEC6', font=('arial', 12, 'normal'), command=submit).place(x=249, y=440)

root.mainloop()
