# importing vlc module
import vlc

# importing pafy module
import pafy

url = "https://www.youtube.com/watch?v=KzvbEizIUJw"

video = pafy.new(url)


best = video.getbestaudio()


media = vlc.MediaPlayer(best.url)


media.play()
while True:
     pass