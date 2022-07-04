
# Code:Mind

An extravagant mental health solution for your every need.


## Features

- In-built Audio Player for Meditation
- Interactive chatbot for diagnosing Mental Health Issues.
- Guided-Journaling Mode
- Endless Jokes
- Video-calling facility
- Therapists/ Mental Health clinics near you


## Tech Stack

**App**: Flutter  
**Backend**: Firebase Auth, Cloud Firestore  
**APIs**: Dialogflow, JokesAPI, PlacesAPI  
**Plugins**: Speech-to-Text, AgoraRTC Engine, Geolocator


## Installation

Clone the repo and follow these steps:  
- Configure the FlutterFire SDK on your system.
- Add Firebase to this project. Enable Auth and Cloud Firestore.
- Head to [Agora](https://console.agora.io), create your project and get AppID and Temp RTC token.
- Make `lib/secrets.dart` and enter these as `AppID` and `token` parameters respectively.
- Head to Google Cloud Console and enable the `Places API`. Generate an API Key for it and use it in the `Text Search API`.
- Also enable the `Dialogflow API`, create a Service Account with `Dialogflow API Admin` role, generate a key for this, and add it to `assets`
- Go Ahead and run the app.
    
## Demo

Youtube: [Demo Video](https://youtu.be/VgtxhG6vcDo)



## Roadmap

- Enable a Stream-able Audio System witha a variety of tracks for Meditation.
- Make Chatbot more interactive and enable `Actions` on it.
- Make a **Node.js** backend and migrate the backend logic.
- Configure Firebase Auth Custom Claims to enable a different access level to Medical Professionals.
- Enable *Appointments* via app.

## 🚀 About Me
I am a Flutter Developer with experience in Node.js, and blockchain. Connect with me on [LinkedIn](https://www.linkedin.com/in/vishesh-dugar-8464341b7/).
