# MoBIAL

## Inspiration

With changing priorities of air travel passengers, the travel industry constantly needs to introduce new solutions and services that will improve passenger experience and give them a highly comfortable environment while flying. We have built an innovative solution -MoBIAL using Microsoft Azure Services to improve the travel experience at BIAL.
Our App MoBIAL - leverages Computer Vision, Text Translation, Cloud Storage, Flight Info, Vehicle lending, Renting and Real-time messaging among other features to enhance the travel experience and aid them before, during, and after their journey

## What it does
- People often find it difficult to judge what they should keep on flight and whatnot, or what quantities are allowed and what custom duty will be applicable to them if they carry above the set quantity like laptops, electronic items, luggage, etc. To help the traveling community we have to provide a platform to the user where they can get the customs duty on different items they are carrying, by simply clicking a picture of the item from their mobile camera and using Microsoft Azure Computer Vision API on the backend will process the image, detect the item and give the custom duty applicable on the item and what quantities are allowed per person. They can also search for the item in the list to get the details.
- Also, we have provided an option to the user if they are leaving their vehicle in the parking area, they will be able to rent their car to the visitors who seek to rent the car. This feature will also require physical assistance from the BIAL to make all this secure and protect car seekers and owners . The vehicles will be tagged with GPS and the renter needs to give proper collateral/ID for renting. This feature will also support vehicles that will be available on rent from BIAL to facilitate their passengers. The Rentee needs to provide car RC as proof while posting a new Car request.
- The Rent Vehicle feature will help those who come to Bengaluru for a business trip or so i.e. short span and didn’t want to take the hassle of booking a ride every time for their commute. They can rent a car, pick it up from airport parking and use it for their need, visit places, etc., and then return it to airport parking. They need to provide their ID proof while generating requests for new vehicles. This will also help to increase the revenue of the airport along with convenience for travelers.
- To promote people's health and engage them while at BAIL, we introduce a feature/ game that will provide the option to collect points from all over the airport by scanning QR codes. These QR codes will be available at open places and some in duty shops on BIAL. This will promote local shops and increase their revenue. To make it more interesting this system will be incentivized and after certain limits, people can redeem these points at airport shops and lounges or in-flight ticket discounts. To aid people to find these QR codes we have provided an airport map that contains markers to locations of points.
- While at the airport waiting for their flight, people resort to either their phones or they sleep. To make things funs and interesting, we have introduced a social section in our app that will show all the registered people currently at the airport, people can create their profile, add a nice picture, create a bio, etc. People can look on to other people’s profiles, DM them, share pics, chat with them in multiple languages with support from Azure Translation API, gain new experiences, make new friends and socialize. The platform will also help users to find other passengers to better socialize while at the airport waiting for their flights.
- Also, a simple portal to get all the information of the user’s flight, where he will provide his/her ticket info and the complete details of the flight will be displayed. The person can check up flight status, running time, etc. Also, a Travel checklist and Important guidelines are shown to users where users can add items to the  checklist and cross them out once confirmed.
With this app, with the above-mentioned features, we aim to enhance user experience while at BIAL and overcome common problems faced by travelers along with increasing revenue for BIAL


## Instruction to Run the repos:
### Frontend
#### - Clone the repo using git:
     git clone https://github.com/ayushkulshrestha2001/mobial.git
#### - To install Flutter packages, run (preferably in flutter console) :
     flutter  pub get
#### - Start the server and frontend using:
	   npm start
#### -for run:
     flutter run
#### -for release apk:
     flutter build apk


 
### Backend
#### - Clone the repo using git:
 	   git clone https://github.com/jinik21/MoBial-backend.git

#### - Install Node packages using NPM run :
     npm i
#### - Start the server using:
     npm start
    
## Technologies Used:
#### MoBIAL
- Microsoft Azure Web App Services
- Microsoft Azure Computer Vision Api
- Microsoft Azure Translate Api
- Microsoft Azure Maps
- Avaitionstack Api(flight info)
- Flutter(Dart)
- NodeJS(Express JS)
- Firebase
- MongoDB
- Material Design
- Git/Github

## What's next for MoBIAL: 
- Payment System and Car Track system Car Rent/Lend Feature can be implemented after taking privacy permissions from rentee and renter.
- Customer Support AI Chatbot can be integrated to assist and aid travelers and smart feedback system using sentiment analysis can be integrated (Ref: our Other Project -Botalysis ,BotalysisChat)
- Better API support for flight Info and Booking options can be provided once given required access to Premium APIs from BIAL. 
- Online support for buying/placing orders at BIAL Shops and Parking Ticket Management System. 
- UI Upgradations and Chat system support can be optimized for sending documents and other stuff
- Car Pool System can be implemented but since it will affect the user’s right to privacy after taking proper permissions for location and sharing with other people can be easily implemented.   

## Video Demo at:
- https://youtu.be/yiX_RNbmt14

## Live Demo at:
- https://drive.google.com/file/d/1OCVItRBph47yggOEPlmdqtbQEhj_ey2z/view (APP)
- https://mobial.azurewebsites.net/ (Backend)

## Our Repositories:
- https://github.com/ayushkulshrestha2001/mobial
- https://github.com/jinik21/MoBial-backend
