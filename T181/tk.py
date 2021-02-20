import time
from tkinter import *
from tkinter import messagebox


root = Tk()


root.geometry("300x250")


root.title("Time Counter")


hour = StringVar()
minute = StringVar()
second = StringVar()

bhour = StringVar()
bminute = StringVar()
bsecond = StringVar()
b2second = StringVar()
b3second = StringVar()
b4second = StringVar()
hour.set("00")
minute.set("00")
second.set("00")

bhour.set("00")
bminute.set("00")
bsecond.set("00")
b2second.set('00')
b3second.set('00')
b4second.set('00')
hourEntry = Entry(root, width=3, font=("Arial", 18, ""),
                  textvariable=hour)
hourEntry.place(x=80, y=100)

minuteEntry = Entry(root, width=3, font=("Arial", 18, ""),
                    textvariable=minute)
minuteEntry.place(x=130, y=100)

secondEntry = Entry(root, width=3, font=("Arial", 18, ""),
                    textvariable=second)
secondEntry.place(x=180, y=100)

bhourEntry = Entry(root, width=3, font=("Arial", 18, ""),
                  textvariable=bhour)
bhourEntry.place(x=80, y=60)

bminuteEntry = Entry(root, width=3, font=("Arial", 18, ""),
                    textvariable=bminute)
bminuteEntry.place(x=130, y=60)

bsecondEntry = Entry(root, width=3, font=("Arial", 18, ""),
                    textvariable=bsecond)
bsecondEntry.place(x=180, y=60)
b2secondEntry = Entry(root, width=3, font=("Arial", 18, ""),
                    textvariable=b2second)
b2secondEntry.place(x=80, y=20)
b3secondEntry = Entry(root, width=3, font=("Arial", 18, ""),
                    textvariable=b3second)
b3secondEntry.place(x=130, y=20)
b4secondEntry = Entry(root, width=3, font=("Arial", 18, ""),
                    textvariable=b4second)
b4secondEntry.place(x=180, y=20)
lsec = bsecond
r = (hour,minute,second)
br = (bhour,bminute,bsecond)

def submit(hour,minute,second):
    try:

        temp = int(hour.get()) * 3600 + int(minute.get()) * 60 + int(second.get())
    except:
        print("Please input the right value")
    while temp > -1:

        # divmod(firstvalue = temp//60, secondvalue = temp%60)
        mins, secs = divmod(temp, 60)

        # Converting the input entered in mins or secs to hours,
        # mins ,secs(input = 110 min --> 120*60 = 6600 => 1hr :
        # 50min: 0sec)
        hours = 0
        if mins > 60:
            # divmod(firstvalue = temp//60, secondvalue
            # = temp%60)
            hours, mins = divmod(mins, 60)

        # using format () method to store the value up to
        # two decimal places
        hour.set("{0:2d}".format(hours))
        minute.set("{0:2d}".format(mins))
        second.set("{0:2d}".format(secs))

        # updating the GUI window after decrementing the
        # temp value every time
        root.update()
        time.sleep(1)

        # when temp value = 0; then a messagebox pop's up
        # with a message:"Time's up"
        if (temp == 0):
            messagebox.showinfo("Time Countdown", "Time's up ")

        # after every one sec the value of temp will be decremented
        # by one
        temp -= 1

def funcall():



    for i in  range(4):
        b2second.set(hour.get())
        b3second.set(minute.get())
        b4second.set(second.get())
        submit(b2second, b3second, b4second)
        b2second.set(br[0].get())
        b3second.set(br[1].get())
        b4second.set(br[2].get())
        submit(b2second,b3second,b4second)





# button widget
btn = Button(root, text='Set Time Countdown', bd='5',
             command=funcall)
btn.place(x=70, y=120)

# infinite loop which is required to
# run tkinter program infinitely
# until an interrupt occurs
root.mainloop()