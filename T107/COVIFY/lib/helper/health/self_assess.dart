class SelfAssess {
  List<String> question1 = [
    'Welcome to Covify COVID-19 self assessment test',
    'Are you experiencing any of the following symptoms?',
  ];

  List<String> question2 = ['Have you ever had any of the following?'];

  List<String> question3 = ['Which of the following apply to you?'];

  List<String> option1 = [
    'Fever',
    'Cough',
    'Difficulty in Breathing',
    'Loss of Taste',
  ];

  List<String> option2 = [
    'Diabetes',
    'Hypertension',
    'Heart Disease',
    'Kidney Disorder',
  ];

  List<String> option3 = [
    'Traveled internationally in last 14 days',
    'Recently interacted with Covid-19 patient',
    'I am a health worker',
  ];

  List<String> answerOk = ['You are risk free', 'Stay Home, Stay Safe'];

  List<String> answerAtRisk = [
    'Currently you are at risk, please contact nearby authorities about your situation and have a covid-19 test',
    'Please avoid going to public places and being in physical contact with anyone'
  ];

  List<String> answerNominalRisk = [
    'Currently you are at nominal risk and it is suggested to self quarantine yourself and try to have no physical contact with with anyone'
  ];
}
