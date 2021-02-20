import firebase from 'firebase';

const firebaseConfig = {
    apiKey: "AIzaSyCAEY3QYj2ubaSIc1ye8fUMT41jyjSRLLU",
    authDomain: "agrivend.firebaseapp.com",
    projectId: "agrivend",
    storageBucket: "agrivend.appspot.com",
    messagingSenderId: "1056221659260",
    appId: "1:1056221659260:web:e6bdf0975d13e46ddec9f9",
    measurementId: "G-36HJCEWXXL"
};

const firebaseApp = firebase.initializeApp(firebaseConfig);
const db = firebaseApp.firestore();
const auth = firebase.auth();
const provider = new firebase.auth.GoogleAuthProvider();

export { db, auth, provider, firebaseApp };