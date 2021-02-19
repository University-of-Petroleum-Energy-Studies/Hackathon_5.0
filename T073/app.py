
from flask import Flask, render_template, request, url_for
from flask_ngrok import run_with_ngrok
from sklearn.externals import joblib
import numpy as np
import pandas as pd
from sklearn.linear_model import LogisticRegression
import urllib.request

app = Flask(__name__)

@app.route("/")
def index():
    return render_template("index.html")
def test_engg(X, feat=['age','trestbps','chol','thalach']):
  outlier_dict={'age': [28.5, 80.5],
             'chol': [117.875, 368.875],
             'thalach': [91.375, 210.375],
             'trestbps': [90.0, 170.0]}
  scale_dict={'age': [3.9823550827234575, 0.17778529316927438],
             'chol': [5.48462168255333, 0.19607091562757256],
             'thalach': [4.999612210722678, 0.1583236573840559],
             'trestbps': [4.860696668723551, 0.12263413735978775]}

  for f in feat:

    # outlier
    X[f]= np.where(X[f]>outlier_dict[f][1], outlier_dict[f][1],np.where(X[f]<outlier_dict[f][0], outlier_dict[f][0], X[f]))
    
    # transformation/normalization
    X[f]=np.log(X[f])

    # scaling
    X[f]=(X[f]-scale_dict[f][0])/scale_dict[f][1]
  return X

@app.route("/heart_predictor",methods=["GET", "POST"])

def heart_predictor():

    if request.method == "POST":
        myDict = request.form
        age = int(myDict['age'])
        sex = int(myDict['sex'])
        cp = int(myDict['cp'])
        trestbps = int(myDict['trestbps'])
        chol = int(myDict['chol'])
        fbs = int(myDict['fbs'])
        restecg = int(myDict['restecg'])
        thalach = int(myDict['thalach'])
        exang = int(myDict['exang'])
        oldpeak = float(myDict['oldpeak'])
        slope = int(myDict['slope'])
        ca = int(myDict['ca'])
        thal = int(myDict['thal'])

        logreg = joblib.load('Heart_LogReg.pkl')  
  
        # Use the loaded model to make predictions 
        pred = logreg.predict_proba(test_engg(pd.DataFrame(np.array([[age,sex,cp,trestbps,chol,fbs,restecg,thalach,exang,oldpeak,slope,ca,thal]]), columns= ['age', 'sex', 'cp', 'trestbps', 'chol', 'fbs', 'restecg', 'thalach',
       'exang', 'oldpeak', 'slope', 'ca', 'thal']))) 

        import math
        return render_template("heart_predictor.html", pred=round(pred[0][1]*100,0))
    return render_template("heart_predictor.html")

if __name__ == '__main__':
    app.run(debug=True)

# run_with_ngrok(app)
# app.run()