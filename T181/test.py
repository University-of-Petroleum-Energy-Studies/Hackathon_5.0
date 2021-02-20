try:
    import tkinter as tk  # for Python 3
except:
    import Tkinter as tk  # for Python 2.7

import time

# Initializing some global variables
# Initial time range for work time (standard 25 min)
workingTime = 10  # 25 * 60
# Short break time (5 min)
shortBreakTime = 5  # 5 * 60
# Long break time (15 min)
longBreakTime = 15  # 15 * 60

globalworkCount = 0
globalshortBreakCount = 0
globallongBreakCount = 0


class SampleApp(tk.Tk):
    def __init__(self):
        tk.Tk.__init__(self)
        self._frame = None
        self.switch_frame(StartPage)

    def switch_frame(self, frame_class):
        # self.isPauseClicked = True
        new_frame = frame_class(self)
        if self._frame is not None:
            self._frame.destroy()
        self._frame = new_frame
        self._frame.pack()


class StartPage(tk.Frame):
    def __init__(self, master):
        tk.Frame.__init__(self, master, bg='khaki')
        tk.Label(self, text="Start page", font=('MathJax_SansSerif-Bold', 18, "bold")).pack(side="top", fill="x",
                                                                                            pady=5)
        tk.Button(self, text="README", font=('MathJax_SansSerif-Bold', 18, "bold"),
                  command=lambda: master.switch_frame(READMEPage)).pack(fill='x', pady=10)
        tk.Button(self, text="START POMODORO", font=('MathJax_SansSerif-Bold', 18, "bold"),
                  command=lambda: master.switch_frame(PomodoroPage)).pack(fill='x', pady=10)
        tk.Button(self, text="Quit", font=('MathJax_SansSerif-Bold', 18, "bold"), command=master.quit).pack(fill='x',
                                                                                                            pady=10)


class READMEPage(tk.Frame):
    def __init__(self, master):
        tk.Frame.__init__(self, master)
        tk.Frame.configure(self, bg='brown')
        tk.Label(self, text="README", font=('MathJax_SansSerif-Bold', 18, "bold")).pack(side="top", fill="x", pady=5)

        tk.Button(self, text="Go back", font=('MathJax_SansSerif-Bold', 14, "bold"),
                  command=lambda: master.switch_frame(StartPage)).pack()

        self.textDescription = '''A personal Pomodoro app written from scratch in Python. 
		An attempt to create personal Pomodoro with additional settings \nsuch as tracking my own progress, adjustable settings, 
		easy to use application with a nice GUI interface.\n
		The app (in its final developed stage) is intended to be easy to use and versatile.\n
		--- What is a Pomodoro? ---
		The Pomodoro Technique is a time management method developed by Francesco Cirillo in the late 1980s. 
		The technique uses a timer to break down work into intervals, traditionally 25 minutes in length, 
		separated by short breaks (usually 5 minutes and 15-minute longer breaks). \n
		Each interval is known as a pomodoro, from the Italian word for 'tomato', after the tomato-shaped kitchen timer 
		that Cirillo used as a university student (source: Wikipedia).'''

        tk.Label(self, text=self.textDescription, font=('MathJax_SansSerif-Bold', 12, "bold")).pack(side="top",
                                                                                                    fill="both")
        tk.Button(self, text="Go back", font=('MathJax_SansSerif-Bold', 14, "bold"),
                  command=lambda: master.switch_frame(StartPage)).pack()


class PomodoroPage(tk.Frame):
    def __init__(self, master):
        '''
        Initial setup of the counter:
        Working regime, countdoown.
        After that a short break. Then, work again.
        And so on. In idea, every 3rd break should be a long break.
        '''
        # Setting flags to check if it is time to work or to rest.
        self.pause = False
        self.isPauseClicked = False

        self.TimeForWork = True
        self.TimeForLongBreak = False
        self.TimeForShortBreak = False

        # assigning the time range from global variables
        self.workCount = globalworkCount
        self.shortBreakCount = globalshortBreakCount
        self.longBreakCount = globallongBreakCount

        # counter to track the current time
        self.currentTimeCount = 0

        self.Message = "Time to Work"

        tk.Frame.__init__(self, master)

        tk.Frame.configure(self, bg='green')
        self.LabelMessage = tk.Label(self, text=self.Message, font=('MathJax_SansSerif-Bold', 18, "bold"))

        label_font = ('MathJax_SansSerif-Bold', 40)
        self.time_str = tk.StringVar()
        self.LabelTime = tk.Label(self, textvariable=self.time_str, font=label_font, bg='white',
                                  fg='blue', relief='raised', bd=3)

        self.StartButton = tk.Button(self, text='Start Pomodoro', command=self.start_working,
                                     font=('MathJax_SansSerif-Bold', 14, "bold"))

        self.PauseButton = tk.Button(self, text='Pause Pomodoro', command=self.hold_pause,
                                     font=('MathJax_SansSerif-Bold', 14, "bold"))

        self.goBackButton = tk.Button(self, text="Go back", font=('MathJax_SansSerif-Bold', 14, "bold"),
                                      command=lambda: master.switch_frame(StartPage))

        self.show_widgets()

    def hold_pause(self):

        self.pause = True
        self.isPauseClicked = True

    def start_working(self):
        # while working, setting pause flag to false
        self.pause = False
        # creating the main function of counting down the time
        self.count_down()

    def count_down(self):

        try:
            # Setting the condition of running a Pomodoro continuously as long
            # as the pasue is not pressed
            while (self.pause == False):

                # Checking which time range to choose - to work, break or long break?
                if (self.TimeForWork == True):
                    # for a moment, setting the time as long as test working time (10sec)
                    self.currentTiming = workingTime
                    # checking if we continue after the pause:
                    if (self.isPauseClicked == True):
                        self.currentTiming = self.currentTimeCount
                elif (self.TimeForShortBreak == True):
                    # checking if we continue after the pause:
                    self.currentTiming = shortBreakTime
                    if (self.isPauseClicked == True):
                        self.currentTiming = self.currentTimeCount
                elif (self.TimeForLongBreak == True):
                    self.currentTiming = longBreakTime
                    # checking if we continue after the pause:
                    if (self.isPauseClicked == True):
                        self.currentTiming = self.currentTimeCount

                # checking if puase button is pressed
                self.isPauseClicked = False

                # The count-down timer. The "meat" of the program.
                for self.t in range(self.currentTiming, -1, -1):
                    # format as 2 digit integers, fills with zero to the left
                    # divmod() gives minutes, seconds
                    self.sf = "{:02d}:{:02d}".format(*divmod(self.t, 60))
                    # print(sf)  # test
                    self.time_str.set(self.sf)
                    self.update()
                    # delay one second
                    time.sleep(1)

                    print(self.t)

                    # tracking the current time left to finish the streak
                    # need it to continue the work after the pause
                    self.currentTimeCount = self.t

                    # stopping the timer if pause button pressed
                    if self.pause == True:
                        self.isPauseClicked = True
                        break

                    # changing the regime between work/break/long break
                    # when counter reached zero
                    if (self.t == 0):
                        if (self.TimeForWork == True):
                            self.workCount += 1
                            self.TimeForWork = False
                            print('\007')  # a bell signal
                            print("Time for a break!")
                            self.Message = 'Time for a break!'

                            # activating either a short or long break
                            if (self.shortBreakCount % 2 == 0) and (self.shortBreakCount != 0):
                                self.TimeForLongBreak = True
                                self.TimeForShortBreak = False
                            else:
                                self.TimeForShortBreak = True
                                self.TimeForLongBreak = False

                        elif (self.TimeForShortBreak == True):
                            self.shortBreakCount += 1
                            self.TimeForShortBreak = False
                            print("Time to Work!")
                            self.Message = 'Time to Work!'
                            # activating the work counter instead
                            self.TimeForWork = True

                        elif (self.TimeForLongBreak == True):
                            self.longBreakCount += 1
                            self.TimeForLongBreak = False
                            print('\007')
                            print('Time to Work!')
                            self.Message = 'Time to Work!'
                            self.TimeForWork = True

                        print("Counter:\nWork = {work}, Short break = {shbreak}, long break = {lbreak}".format(
                            work=self.workCount, shbreak=self.shortBreakCount, lbreak=self.longBreakCount))

        except Exception as e:
            # in case of any error, print the error
            print(str(e))

    def show_widgets(self):
        self.LabelTime.pack(fill='x', padx=5, pady=5)
        self.LabelMessage.pack(side="top", fill="x", pady=5)

        self.StartButton.pack(fill='x', pady=10)
        self.PauseButton.pack(fill='x', pady=10)
        self.goBackButton.pack(fill='x', pady=10)


if (__name__ == "__main__"):
    app = SampleApp()
    app.mainloop()