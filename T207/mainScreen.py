# File created by Utkarsh Gupta
# Dated 30/12/2020

# Touched on 30/12/2020 by Utkarsh Gupta

# GUI design of main screen

# Libraries
from kivy.app import App
from kivy.properties import ObjectProperty
from kivy.uix.boxlayout import BoxLayout
from kivy.core.window import Window
from kivy.uix.label import Label

from reportsAnalyserScreen import reportsAnalyserScreenApp


# Layout inside the window
class mainScreenLayout(BoxLayout):
    def onSendButtonPress(self):
        chatArea = self.ids['ChatArea2']
        message = self.ids['message_box']
        if message.text == "":
            return
        label = Label(text=message.text, font_size='20dp')
        #a = message.text
        chatArea.bind(minimum_height=chatArea.setter('height'))
        chatArea.add_widget(label)
        self.ids['ChatAreaScrollView'].scroll_to(label)
        message.text = ""
        chatArea = self.ids['ChatArea1']
        label = Label(text=" ", font_size='20dp')
        chatArea.bind(minimum_height=chatArea.setter('height'))
        chatArea.add_widget(label)
        self.ids['ChatAreaScrollView'].scroll_to(label)


    def onBaymaxResponse(self, message):
        chatArea = self.ids['ChatArea1']
        label = Label(text=message, font_size='20dp')
        chatArea.bind(minimum_height=chatArea.setter('height'))
        chatArea.add_widget(label)
        self.ids['ChatAreaScrollView'].scroll_to(label)
        chatArea = self.ids['ChatArea2']
        label = Label(text=" ", font_size='20dp')
        chatArea.bind(minimum_height=chatArea.setter('height'))
        chatArea.add_widget(label)
        self.ids['ChatAreaScrollView'].scroll_to(label)


# Actual window
class mainScreenApp(App):
    def build(self):
        self.title = "Baymax"
        self.icon = "./assets/icons/baymaxIcon.png"
        Window.fullscreen = 'auto'
        return mainScreenLayout()

    def onSpeakButtonPress(self):
        print("Speak")

    def onReportsAnalyserButtonPress(self):
        self.get_running_app().stop()
        reportsAnalyserScreenApp().run()
