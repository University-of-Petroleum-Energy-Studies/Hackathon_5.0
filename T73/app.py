
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

@app.route("/disease_predictor", methods= ["GET","POST"])
def disease_predictor():
        
    s=['itching','skin_rash',
    'nodal_skin_eruptions',
    'continuous_sneezing',
    'shivering',
    'chills',
    'joint_pain',
    'stomach_pain',
    'acidity',
    'ulcers_on_tongue',
    'muscle_wasting',
    'vomiting',
    'burning_micturition',
    'spotting_ urination',
    'fatigue',
    'weight_gain',
    'anxiety',
    'cold_hands_and_feets',
    'mood_swings',
    'weight_loss',
    'restlessness',
    'lethargy',
    'patches_in_throat',
    'irregular_sugar_level',
    'cough',
    'high_fever',
    'sunken_eyes',
    'breathlessness',
    'sweating',
    'dehydration',
    'indigestion',
    'headache',
    'yellowish_skin',
    'dark_urine',
    'nausea',
    'loss_of_appetite',
    'pain_behind_the_eyes',
    'back_pain',
    'constipation',
    'abdominal_pain',
    'diarrhoea',
    'mild_fever',
    'yellow_urine',
    'yellowing_of_eyes',
    'acute_liver_failure',
    'fluid_overload',
    'swelling_of_stomach',
    'swelled_lymph_nodes',
    'malaise',
    'blurred_and_distorted_vision',
    'phlegm',
    'throat_irritation',
    'redness_of_eyes',
    'sinus_pressure',
    'runny_nose',
    'congestion',
    'chest_pain',
    'weakness_in_limbs',
    'fast_heart_rate',
    'pain_during_bowel_movements',
    'pain_in_anal_region',
    'bloody_stool',
    'irritation_in_anus',
    'neck_pain',
    'dizziness',
    'cramps',
    'bruising',
    'obesity',
    'swollen_legs',
    'swollen_blood_vessels',
    'puffy_face_and_eyes',
    'enlarged_thyroid',
    'brittle_nails',
    'swollen_extremeties',
    'excessive_hunger',
    'extra_marital_contacts',
    'drying_and_tingling_lips',
    'slurred_speech',
    'knee_pain',
    'hip_joint_pain',
    'muscle_weakness',
    'stiff_neck',
    'swelling_joints',
    'movement_stiffness',
    'spinning_movements',
    'loss_of_balance',
    'unsteadiness',
    'weakness_of_one_body_side',
    'loss_of_smell',
    'bladder_discomfort','foul_smell_of urine','continuous_feel_of_urine','passage_of_gases','internal_itching','toxic_look_(typhos)','depression','irritability','muscle_pain','altered_sensorium','red_spots_over_body','belly_pain','abnormal_menstruation','dischromic _patches','watering_from_eyes','increased_appetite','polyuria','family_history','mucoid_sputum','rusty_sputum','lack_of_concentration','visual_disturbances','receiving_blood_transfusion','receiving_unsterile_injections','coma','stomach_bleeding','distention_of_abdomen','history_of_alcohol_consumption','fluid_overload.1','blood_in_sputum','prominent_veins_on_calf','palpitations','painful_walking','pus_filled_pimples','blackheads','scurring','skin_peeling','silver_like_dusting','small_dents_in_nails','inflammatory_nails','blister','red_sore_around_nose','yellow_crust_ooze']

    diseases=['(vertigo) Paroymsal  Positional Vertigo', 'AIDS', 'Acne',
       'Alcoholic hepatitis', 'Allergy', 'Arthritis', 'Bronchial Asthma',
       'Cervical spondylosis', 'Chicken pox', 'Chronic cholestasis',
       'Common Cold', 'Dengue', 'Diabetes ',
       'Dimorphic hemmorhoids(piles)', 'Drug Reaction',
       'Fungal infection', 'GERD', 'Gastroenteritis', 'Heart attack',
       'Hepatitis B', 'Hepatitis C', 'Hepatitis D', 'Hepatitis E',
       'Hypertension ', 'Hyperthyroidism', 'Hypoglycemia',
       'Hypothyroidism', 'Impetigo', 'Jaundice', 'Malaria', 'Migraine',
       'Osteoarthristis', 'Paralysis (brain hemorrhage)',
       'Peptic ulcer diseae', 'Pneumonia', 'Psoriasis', 'Tuberculosis',
       'Typhoid', 'Urinary tract infection', 'Varicose veins',
       'hepatitis A']
    if request.method == "POST":
        myDict = request.form
        symptoms_list=[]
        for k,v in myDict.items(multi=True):
            symptoms_list.append(v)
        data= np.array([1 if (x in symptoms_list) else 0 for x in s]).reshape(1,-1)
        logreg_disease = joblib.load('Disease_LogReg.pkl')

        pred= logreg_disease.predict_proba(data)*100
        print('******pred', pred)
        dis_dict=dict(zip(diseases,list(pred[0])))
        print('**dis_dict', dis_dict)
        dis_dict= dict(sorted(dis_dict.items(), key=lambda item: item[1],reverse=True))
        top= list(dis_dict.keys())[:5]

        precautions= pd.read_csv('symptom_precaution.csv')
        precs=[]
        for x in top:
            precs.append(list(precautions[precautions['Disease']==x].values[0])[1:])
        top_dict= dict(zip(top, precs))
        # idx= []
        # for i in range(5):
        #     idx.append(pred.argmax())
        #     pred=np.delete(pred, pred.argmax())
        # dlist= [diseases[x] for x in idx]
        # print(dlist)      
        print(top)
        return render_template("disease_predictor.html", sl=s, top=top_dict)

    return render_template("disease_predictor.html", sl=s, top={})

if __name__ == '__main__':
    app.run(debug=True)

# run_with_ngrok(app)
# app.run()