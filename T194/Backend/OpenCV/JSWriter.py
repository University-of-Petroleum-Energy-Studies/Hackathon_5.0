import cv2
import os
import Process
import numpy as np
cap = cv2.VideoCapture(0)
cor=[(0,0)]
# np.save('cordinates',np.array(cor))
try:
    if not os.path.exists('out'):
        os.makedirs('out')
except OSError:
    print('Error: Creating directory of out')
board = np.zeros((480, 640, 3),np.uint8)
# board=None
i=0
while True:
    _,frame=cap.read()
    Process.BlackBoard(frame,i,cor,board)
    # print(board)
    # print(cor)
    i+=1
    if cv2.waitKey(1)&0xFF==27:
        break
cap.release()
cv2.destroyAllWindows()