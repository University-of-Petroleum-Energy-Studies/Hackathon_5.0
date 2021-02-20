import cv2
import numpy as np

class BlackBoard():
    def __init__(self,img,i,cor,board):
        self.cor=cor
        self.frame=img
        self.range=np.load('ohyea.npy')
        self.board=board
        self.flag=1
        self.i=i
        self.draw()

    def draw(self):
        self.frame=cv2.flip(self.frame,1)
        if self.board is None:
            self.board=np.zeros_like(self.frame)
        mask=self.CreateMask()
        contours=self.DetectContour(mask)
        self.DrawLine(contours)
        self.Display()

    def CreateMask(self):
        hsv=cv2.cvtColor(self.frame, cv2.COLOR_BGR2HSV)
        low=self.range[0]
        up=self.range[1]
        mask=cv2.inRange(hsv,low,up)
        return mask

    def DetectContour(self,mask):
        contours,hierarchy=cv2.findContours(mask,cv2.RETR_EXTERNAL,cv2.CHAIN_APPROX_SIMPLE)
        return contours

    def DrawLine(self, contours):
        if contours and cv2.contourArea(max(contours,key=cv2.contourArea))>100:
            cv2.circle(self.frame,(10,10),10,(0,255,0),-1)
            c=max(contours,key=cv2.contourArea)
            x2,y2,w,h=cv2.boundingRect(c)
            if self.cor[0][0] == 0 and self.cor[0][1]==0:
                self.cor[0] = (x2,y2)
            else:
                # for i in range(1, len(self.cor)-1):
                self.board = cv2.line(self.board, self.cor[0], (x2,y2),[255 * self.flag, 0, 0],10)
            self.cor[0]=(x2,y2)
        else:
            # self.cor[0]=(0,0)
            cv2.circle(self.frame,(10,10),10,(0,0,255),-1)
            # for i in range(1, len(self.cor) - 1):
            #     self.board = cv2.line(self.board, self.cor[i], self.cor[i + 1], [255 * self.flag, 0, 0], 10)
            return list(self.cor)

    def Display(self):
        self.frame=cv2.add(self.frame,self.board)
        path='./out/frame-'+str(self.i)+'.jpg'
        cv2.imwrite(path,self.board)
        cv2.imshow('frame',self.frame)
        cv2.imshow('Board',self.board)
        return list(self.cor)

    def Switch(self, k):
        if k==ord('c'):
            self.board=None
        if k==ord('e'):
            self.flag=int(not self.flag)
# if __name__=='__main__':
#     BlackBoard()
cv2.destroyAllWindows()