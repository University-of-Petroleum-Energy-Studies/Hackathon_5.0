import cv2
import os

if not os.path.exists("data"):
    os.makedirs("data")
    os.makedirs("data/train")
    os.makedirs("data/test")
    os.makedirs("data/train/0")
    os.makedirs("data/test/0")

mode='train'
directory='data/'+mode+'/'
cap=cv2.VideoCapture(0)

while True:
    _,frame=cap.read()
    frame=cv2.flip(frame,1)
    count={'zero':len(os.listdir(directory+"/0"))}
    x1=int(0.5*frame.shape[1]) #ROI
    y1=10
    x2=frame.shape[1]-10
    y2=int(0.5*frame.shape[1])
    cv2.rectangle(frame,(x1-1,y1-1),(x2+1,y2+1),(255,0,0),1)
    roi=frame[y1:y2, x1:x2]
    roi=cv2.resize(roi,(64, 64))
    cv2.imshow("Frame",frame)
    roi=cv2.cvtColor(roi,cv2.COLOR_BGR2GRAY)
    _,roi=cv2.threshold(roi,120,255,cv2.THRESH_BINARY)
    cv2.imshow("ROI",roi)
    interrupt=cv2.waitKey(10)
    if interrupt & 0xFF==27:
        break
    if interrupt & 0xFF==ord('0'):
        cv2.imwrite(directory+'0/'+str(count['zero'])+'.jpg',roi)
cap.release()
cv2.destroyAllWindows()
