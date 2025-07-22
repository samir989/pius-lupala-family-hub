// Firebase initialization for Pius Lupala Family Hub
const firebaseConfig = {
  apiKey: "AIzaSyAXAF03tSfLLexTtFLw3KrmIHynE6k6uUE",
  authDomain: "pius-lupala-family-hub.firebaseapp.com",
  projectId: "pius-lupala-family-hub",
  storageBucket: "pius-lupala-family-hub.firebasestorage.app",
  messagingSenderId: "157663255927",
  appId: "1:157663255927:web:60bbcbb09bec2400dbd572",
  measurementId: "G-TYV63VKTDQ"
};

firebase.initializeApp(firebaseConfig);
if (firebase.analytics) {
  firebase.analytics();
}

window.db = firebase.firestore();
