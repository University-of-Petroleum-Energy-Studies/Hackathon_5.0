import tkinter as tk
import winsound
import time
import os
from threading import Thread
import vlc
import pafy
#from Welcome import URL
'''
Pomodoro timer created to require little user interaction
and remove the need to have a browser open
'''

# Initial HMS variables
timeHours, timeMinutes, timeSeconds = 0, 0, 0
# Initial number of displayCounter instances
instances = 0
variable = True


# displayCounter Object
class displayCounter():
    def __init__(self, window):
        self.window = window
        self.notifLabel = tk.Label(text="")
        self.notifLabel.grid(column=2, row=3)
        self.workHours, self.workMinutes, self.workSeconds, self.breakHours, self.breakMinutes, self.breakSeconds = hmsdata
        self.isWorking = True
        self.textNotifData = ('Get to work!', '')
        global timeHours, timeMinutes, timeSeconds
        timeHours, timeMinutes, timeSeconds = self.workHours, self.workMinutes, self.workSeconds
        self.tick()

    # Called once per second
    def tick(self):
        global timeHours, timeMinutes, timeSeconds
        try:
            # if the countdown is running
            if (timeHours >= 0 and timeMinutes >= 0 and timeSeconds >= 0):
                # Set the HMS data to be displayed
                self.timeDisplayData = str(timeHours) + ":" + str(timeMinutes) + ":" + str(timeSeconds)
                # Set and display the data
                notifString = self.textNotifData[0] + " " + str(self.timeDisplayData)
                self.notifLabel.config(text=notifString)
                # If the counter is done
                if (timeHours == 0 and timeMinutes == 0 and timeSeconds == 0):
                    # Get data tuple from time_up() function
                    self.textNotifData = self.time_up()
                    # Play sound asynchronously on windows
                    try:
                        winsound.PlaySound(self.textNotifData[1], winsound.SND_ASYNC)
                    except Exception:
                        # If error, try method for playing sound on linux
                        try:
                            os.system("aplay " + self.textNotifData[1] + ".wav&")
                        except Exception:
                            # If error, try method for playing sound on a Mac
                            try:
                                os.system("afplay " + self.textNotifData[1] + ".wav&")
                            except Exception as e:
                                print(e)
                    self.isWorking = not self.isWorking
                    if (self.isWorking):
                        timeHours, timeMinutes, timeSeconds = self.workHours, self.workMinutes, self.workSeconds
                    else:
                        timeHours, timeMinutes, timeSeconds = self.breakHours, self.breakMinutes, self.breakSeconds
                else:
                    if (timeSeconds > 0):
                        timeSeconds -= 1
                    elif (timeMinutes > 0):
                        timeMinutes -= 1
                        timeSeconds = 59
                    elif (timeHours > 0):
                        timeHours -= 1
                        timeMinutes = 59
                        timeSeconds = 59
        # Print exception if it occurs
        except Exception as e:  # ValueError:
            print(e)
        # Use tkinter's after() function to call tick every second
        if variable == 1:
            self.id = self.window.after(1000, self.tick)

    # Set the state according to the isWorking boolean
    def time_up(self):
        self.workHours, self.workMinutes, self.workSeconds, self.breakHours, self.breakMinutes, self.breakSeconds = hmsdata
        # If the user is working
        if self.isWorking == True:
            return ('Take a break!', 'BreakSound')
        # Else, the user is not working
        else:
            return ('Get to work!', 'workSound')



def instantiate_displayCounter():
    global instances
    global hmsdata
    hmsdata = [workHoursEntry, workMinutesEntry, workSecondsEntry, breakHoursEntry, breakMinutesEntry,
               breakSecondsEntry]
    for i, data in enumerate(hmsdata):
        try:
            hmsdata[i] = int(hmsdata[i].get())
        except ValueError:
            hmsdata[i] = 0
        except Exception as e:
            print(e)
        if hmsdata[i] > 60:
            print("Input " + str(hmsdata[i]) + " > 60; flooring.")
            hmsdata[i] = 60
    print("Input = " + str(hmsdata))
    # Only allow one instance of the counter
    if (instances == 0):
        d = displayCounter(window)
        instances += 1
    else:
        pass


def back():
    while variable == 1:
        os.system("TASKKILL /F /IM notepad.exe")
        os.system("TASKKILL /F /IM spotify.exe")
        os.system("TASKKILL /F /IM steam.exe")

        time.sleep(1)


def thread1():
    global variable
    variable = 1
    Thread(target=instantiate_displayCounter).start()


def thread2():
    a = ()
    Thread(target=back, args=a).start()


def end():
    global variable
    variable = 0


url = "https://www.youtube.com/watch?v=SvWfZGhjwGs"
video = pafy.new(url)
best = video.getbestaudio()

media = vlc.MediaPlayer(best.url)


def play():
    media.play()
    '''while True:
        pass'''


def pause():
    media.pause()

def thread3():
    Thread(target=play).start()
def thread4():
    Thread(target=pause).start()

# TKINTER ---------------------
# SETUP WINDOW
window = tk.Tk()
window.title("Python Pomodoro")
window.geometry("620x125")
# LABEL
headLabel = tk.Label(text="Pomodoro", font=("Times New Roman", 20))
headLabel.grid(columnspan=7, row=0, )
workTextLabel = tk.Label(text="Work length")
workTextLabel.grid(column=0, row=1)
breakTextLabel = tk.Label(text="Break length")
breakTextLabel.grid(column=0, row=2)
workHoursLabel = tk.Label(text="H")
workHoursLabel.grid(column=1, row=1)
breakHoursLabel = tk.Label(text="H")
breakHoursLabel.grid(column=1, row=2)
workMinutesLabel = tk.Label(text="M")
workMinutesLabel.grid(column=3, row=1)
breakMinutesLabel = tk.Label(text="M")
breakMinutesLabel.grid(column=3, row=2)
workSecondsLabel = tk.Label(text="S")
workSecondsLabel.grid(column=5, row=1)
breakSecondsLabel = tk.Label(text="S")
breakSecondsLabel.grid(column=5, row=2)
# ENTRY
workHoursEntry = tk.Entry()
workHoursEntry.grid(column=2, row=1)
workMinutesEntry = tk.Entry()
workMinutesEntry.grid(column=4, row=1)
workSecondsEntry = tk.Entry()
workSecondsEntry.grid(column=6, row=1)
breakHoursEntry = tk.Entry()
breakHoursEntry.grid(column=2, row=2)
breakMinutesEntry = tk.Entry()
breakMinutesEntry.grid(column=4, row=2)
breakSecondsEntry = tk.Entry()
breakSecondsEntry.grid(column=6, row=2)
# BUTTON
button1 = tk.Button(text="Start", font=("Times New Roman", 12), command=thread1)
button1.grid(column=0, row=3)
button2 = tk.Button(text="close apps", font=("Times New Roman", 12), command=thread2)
button2.grid(column=1, row=3)
button3 = tk.Button(text="end", font=("Times New Roman", 12), command=end)
button3.grid(column=5, row=3)
button4 = tk.Button(text="play", font=("Times New Roman", 12), command=thread3)
button4.grid(column=3, row=3)
button5 = tk.Button(text="pause", font=("Times New Roman", 12), command=thread4)
button5.grid(column=4, row=3)

# Use a class with this method to fix the error from python sending self
# button1.bind('<Return>', instantiate_displayCounter)
# MAINLOOP
window.mainloop()
