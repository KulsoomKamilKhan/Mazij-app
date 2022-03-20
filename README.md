# Mazaj
 Front-end - Shreya, Kulsoom, Azzaam, Varun, Taha  
 Back-end - Bhavika, Alister, Omar  

Remember to read the FRs given below to see which ones are being inplemented in stage-2 (denoted with a 1 beside the names). All FRs and NFRs associated with each page given below will have to be implemented by the people assigned to that particular page.  

## Stage 2 (if any problem with this, leave a comment here)
Report- Azzaam, Bhavika, Omar, Varun.  
Webpage- Kulsoom, Shreya  
 

### Demo
The demonstration should include:   
 
1. A **brief introduction** of who you are and your group’s company website.    
2. Each person should summarise what they have **contributed** in this stage, in a sentence or two.   
3. **High level system architecture**, so that we can see what the system components are and what software 
you are using.   
4. Demo focusing on **key features of the application**. Don’t labour over things like logging in.   
5. Include a good set of **test data**. Ideally this could have been auto-generated in some way.   
6. Mention of any **development** that has been done **which can’t be demonstrated ** but will speed up the 
remaining implementation (there might not be anything in this category).   
7. It would help if you had an **overview document** to share with your Manager, **showing your functional 
requirements and what has been achieved**. Don’t make this document too detailed (e.g., no more than a page); it 
should be easy to read.   
8. The demonstration should **not take more than 30 minutes**.   
9. Each person should take part.   
10. Members of the group should **run through the presentation** using a prepared plan of events, aimed to demonstrate the key features.   
11. There could be a little audience participation, where the Manager asks for certain features to be demonstrated. 
The Manager will not try the software directly.   
12. It’s important to **have a plan** for the demo. Prepare the examples. Ensure that you focus on the most interesting parts. Giving a demo online will be extra challenging so make sure you rehearse your demo and time yourself. At the end, there may be questions. **Be prepared to show the source code and explain how various functions of the system are implemented. **    

#### Distribution
1. Intro- what the app is about, company website - **Azzaam**
2. Tech used in app- check section 3 - **Varun**
3. System architecture- section 4, drf, api, BLOC (repo (conn to api), BLOC, UI) - **Omar**
5. contributions/ distb of work - **Shreya**
6. Func achieved (section 2, overview doc) **Azzaam**
5. backend- apps, drf, api view, phpmyadmin db, admin panel, drf api/ json req/responses  
- Bhavika - show code, admin panel, drf api/ json req/responses  
- Omar- app (folders), models  
- Bhavika- views, serializers  
- Alister- db  
6. frontend- run app and explain code, correct/incorrect data during reg, (welcome, login, forgot pass/update account,mention faq etc, login/delete) (reg, profile and posts, lib)  
- for each page- show models, repo, BLOC , UI
- Taha- 5 accounts of the diff account types, 2 posts for each  
- Taha- show code (app running in chrome, code, emulator), welcome, reg, mention faq etc  
- Kulsoom- login, forgot pass, login, update account, login, delete  
- Shreya- profile, posts
- Varun- lib  
7. Plan for stage 3 (main features) - **Kulsoom**

### App dev for Stage 2

| Feature | Group Member |
| ------ | ------ |
| reg and login | Bhavika, Omar, Shreya, Kulsoom, Taha |
| profile | Alister, Omar, Kulsoom, Varun, Taha |
| lib | Bhavika, Alister, Azzaam, Varun |

Check this-  https://ohuru.tech/blog/2020/4/15/flutter-signuplogin-application-with-django-backend-1/  
for app- https://github.com/subsystemcoding  

for UI and BLOC- https://github.com/subsystemcoding/social_pixel_frontend  
simple notes app with django+flutter (watch in 1.5x) https://www.youtube.com/watch?v=VnztChBw7Og&t=565s  
flutter app detailed tutorial- https://medium.com/@shakleenishfar/leaf-flutter-social-media-app-part-0-954ab180d476 

## For research (check for how to implement these in flutter and django)

 General - https://medium.com/flutter-community/flutter-layout-cheat-sheet-5363348d037e  
 https://github.com/Tomiwa-Ot/Social-Media-App  
 
 https://medium.com/@justinckl/how-to-connect-flutter-and-firebase-authentication-with-your-django-rest-framework-backend-b7b9a0b1f5cb#b800  
     
 integrating flutter and django- https://stackoverflow.com/questions/59525457/what-is-the-best-way-to-handle-backend-in-flutter-can-it-be-linked-with-django      
  
 more on flutter- https://www.youtube.com/watch?v=Kq5ZsygfWAc (you can check their channel for more videos)
 flutter bloc- https://www.netguru.com/blog/flutter-bloc  https://bloclibrary.dev/#/  https://www.youtube.com/watch?v=2zZkVLsySm4      
 for quick code snippets- https://docs.flutter.dev/cookbook     
 follow, like, comment, profile etc - https://github.com/CharlyKeleb/SocialMedia-App    

| FR | Group Member | Links |
| ------ | ------ |  ------ |
| 1.1 | Taha |
| 1.2 |  Taha |
| 1.3 | Taha |
| 1.4 | Taha |
| 1.5 | Taha |
| registration and login functions with NFR-3 | Omar |
| 1.6 | Alister |
| 1.7 | Alister |
| 1.8 | Kulsoom, Alister |
| 2.1 | Kulsoom |
| 2.2 | Kulsoom |
| 2.3 | Kulsoom |
| 2.4 | Kulsoom |
| adding/deleting/updating posts and personal details (2.x) & (3.1) | Alister |
| 3.1 | Shreya | upload photo - https://morioh.com/p/6d0bb6282db7#:~:text=Flutter%20Image%20upload   video - https://stackoverflow.com/questions/57869422/how-to-upload-a-video-from-gallery-in-flutter?rq=1#:~:text=you%20can%20use%20this%20widget%20from%20image_picker%20answer%20based%20n%20image_picker%20example |
| 3.2 | Shreya, Bhavika | edit- https://pub.dev/packages/image_editor_pro   chat- https://rlogicaltech.medium.com/how-to-build-group-chat-with-flutter-488dc3490bdf and https://pub.dev/packages/flutter_chat_ui using cometchat- https://github.com/SAGARSURI/Gossip  chat bubbles- https://www.kindacode.com/article/flutter-making-beautiful-chat-bubbles-2-approaches/   whieboard- https://pub.dev/packages/whiteboardkit
| 3.4 | Shreya | for changing lib - https://api.flutter.dev/flutter/widgets/PageView-class.html   for display grid- https://pub.dev/packages/flutter_staggered_grid_view  https://github.com/flutter-devs/flutter_gridview_demo
| 3.5 | Shreya, Bhavika | tag- https://stackoverflow.com/questions/57403145/how-to-implement-user-tagging-in-flutter  https://medium.flutterdevs.com/creating-tags-in-flutter-7269743d015b https://pub.dev/packages/textfield_tags 
| 3.6 | Varun, Bhavika |
| 3.7 | Azzaam , Bhavika |
| 3.8 | Shreya, Bhavika | 3.2 or https://morioh.com/p/6d0bb6282db7#:~:text=Extended%20Image%20Library%20Flutter
| 3.9 | Azzaam |
| 3.10 | Azzaam |
| 3.11 | Azzaam |
| 3.12 | Azzaam |
| 4.1 | Varun |
| 4.2 | Varun |
| 4.3 | Varun |
| Search func | | https://morioh.com/p/6ca2176eccbf#:~:text=How%20to%20integrate%20Django%20search%20with%20Flutter%20App|  
| Form with validation | | https://docs.flutter.dev/cookbook/forms/validation |
| for like button | | https://docs.flutter.dev/development/ui/interactive |
| routing/ navigation | | https://medium.com/@shakleenishfar/leaf-flutter-social-media-app-part-5-orientation-gesture-and-navigation-6cc4aea4f989#:~:text=How%20to%20navigate%20in%20Flutter%3F |
| disabling landscape mode | | https://www.kindacode.com/article/how-to-disable-landscape-mode-in-flutter/|
| downloading image | | https://pub.dev/packages/image_downloader |
| bottom navbar ||  https://www.willowtreeapps.com/craft/how-to-use-flutter-to-build-an-app-with-bottom-navigation  
 https://blog.logrocket.com/how-to-build-a-bottom-navigation-bar-in-flutter/ | 


### Requirements  

F-UR1 Registration  
F-UR 1.1 Register using email -1  
The user must be able to sign up/create an account using an email address and password.  
The user should be sent an email to confirm their email address to finalize their
registration.  
F-UR 1.2 Register using Google or Facebook -2 opt  
In case the user prefers, they must be able to create an account by logging into their
Google account or Facebook account.  
F-UR 1.3 Register for any of the several types of accounts -1  
Users must be able to register for a type of accounts as per their needs, the types being
artist accounts, student accounts, content creator accounts, and brand marketer
accounts.  

F-UR 1.4 Log in -1  
Users who already have an account must be able to log in using the username and
password they registered.  
F-UR 1.5 Log out -1  
Users must be able to log out of their account on a given browser/app.  
F-UR 1.6 Delete Account -1  
User accounts must be stored on the server until they actively decide to delete their
account.  
F-UR 1.7 Account Limit -1  
Only one account must be made per email address and no usernames should be
repeated.  

F-UR 1.8 Retrieve forgotten password -2  
Users must receive an email at their registered email address to reset their password if
they have forgotten it.  

F-UR 2 Profile information  
F-UR 2.1 Add additional user information -1  
The user must be allowed to enter additional information in their profile bio like links to
their personal websites.  
F-UR 2.2 View posts -1  
The user must be able to view their posts in their profile.  
F-UR 2.3 Delete posts -1  
The user must be able to delete any of their posts. 

F-UR 2.4 Edit user information -2  
The user must be able to edit their personal information and login details.  

F-UR 3 Application Functionality Requirements  
F-UR 3.1 Upload content -1  (from profile page, with licenses and content tag)
The app must allow users to upload content- pictures or videos.  

F-UR 3.2 Create virtual collaborative environment -2  
The system must allow users to collaborate with others to create and post collaborative
content. The virtual environment shall include a whiteboard, tools for editing of the
content created and, at the very least, chat functionality.  
F-UR 3.3 Access home page -2  
Users must be able to access their home page with posts of users and libraries they
follow.  

F-UR 3.4 Access content libraries -1  
Users must be able to access different content libraries and follow the libraries they
prefer.  

F-UR 3.5 Interact with users -2  
Users must be able to follow and search for other users, |message other users on the
platform, and share posts within the platform.| The system should also allow
mentioning/|tagging| users in posts. Furthermore, users should be able to block other
users to prevent any interaction with them.  

F-UR 3.6 Interact with content tags -1 (lib category = content tags)  
Users must be able to follow and |search| for content tags. The system should also allow
mentioning content tags in posts.  
F-UR 3.7 Support for licenses -1  
Appropriate licenses, particularly instances of Creative Commons, must be supported
and respected to ensure contributed content is used as intended.
The platform must include features that enable key pieces of information, like copyright
details and watermarks, to be displayed visually in an appropriate form for different
types of users.  

F-UR 3.8 Editing posts before posting -2 opt  
System must allow users to edit & snip shared content. The app must have simple
features for modifying shared content in libraries, such as image/audio filters, splicing
tools, and other options.  
F-UR 3.9 Interact with posts -2  
Users must be able to like and comment under posts.  

F-UR 3.10 Create mash ups of other posts -2 (+ collage + post it)  
Users must be able to create mash ups of other users’ posts. A mash up includes editing
another user’s post by either cropping it, adding text, stickers, or filters to it.  
F-UR 3.11 Report content -2  
Users must be able to report posts or accounts for having/posting explicit or illegal
content. Users must be able to flag a copyright violation if content shared does not
respect the copyright details or does not attribute the original poster/creator of the
work.  

F-UR 3.12 Access pages for additional application information -1  
Users must be able to access FAQ, privacy policy, and terms and conditions pages to for
additional help using the application.  

F-UR 4 Administration requirements  
F-UR 4.1 Login as administrators -2  
The system must allow accounts with administration rights, called platform managers to
login.  
F-UR 4.2 Use moderation tools -2  
The system must allow “platform managers” to use included moderation tools to
moderate content that is uploaded to or generated using the platform. The tools must
allow “platform managers” to delete content, block users from accessing certain groups
and take away posting privileges from violators either for a specific period (e.g., 1 day, 1
week, 2 weeks.) or indefinitely.  
F-UR 4.3 View summary reports -2  
The system must generate summary reports for “platform managers” to view,
concerning overall platform usage.   
  


### Note (if you find any points for us to remember, add them here)
 - All details and posts to be stored in db but chat not required to be stored in db.      
 - for now, images to be saved for use in mashup
 - Check the mockups for design and implementation (improve the design).  
 - Apart from the app, some will have to work on the static webpage and some on the report.  
 -

