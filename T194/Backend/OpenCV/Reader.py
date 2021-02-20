import cv2
cap=cv2.VideoCapture(0)
i=0
while True:
    path='./out/frame-'+str(i)+'.jpg'
    frame=cv2.imread(path)
    cv2.imshow('Board',frame)
    i+=1
    if cv2.waitKey(1) & 0xFF == 27:
        break
cap.release()
cv2.destroyAllWindows()


