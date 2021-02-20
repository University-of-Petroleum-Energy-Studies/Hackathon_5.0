import cv2                                                                              #importing various libraries
import numpy as np
import face_recognition

imgnakku = face_recognition.load_image_file('ImagesBasic/nakku.jpeg')                   #importing the image
imgnakku = cv2.cvtColor(imgnakku,cv2.COLOR_BGR2RGB)                                     #changing the colour from BGR to RGB
imgTest = face_recognition.load_image_file('ImagesBasic/pp.jpg')
imgTest = cv2.cvtColor(imgTest,cv2.COLOR_BGR2RGB)

faceLoc = face_recognition.face_locations(imgnakku)[0]                                  #location of face in image
encodenakku = face_recognition.face_encodings(imgnakku)[0]
cv2.rectangle(imgnakku,(faceLoc[3],faceLoc[0]),(faceLoc[1],faceLoc[2]),(255,0,255),2)   #creating a rectangle around the detected face

faceLocTest = face_recognition.face_locations(imgTest)[0]
encodeTest = face_recognition.face_encodings(imgTest)[0]
cv2.rectangle(imgTest,(faceLocTest[3],faceLocTest[0]),(faceLocTest[1],faceLocTest[2]),(255,0,255),2)

results = face_recognition.compare_faces([encodenakku],encodeTest)                      #comparing the face in the two images
faceDis = face_recognition.face_distance([encodenakku],encodeTest)
print(results,faceDis)                                                                  #printing the result either true or false
cv2.putText(imgTest,f'{results} {round(faceDis[0],2)}',(50,50),cv2.FONT_HERSHEY_COMPLEX,1,(0,0,255),2)

cv2.imshow('nakku',imgnakku)                                                            #printing image 1
cv2.imshow('na',imgTest)
cv2.waitKey(0)

