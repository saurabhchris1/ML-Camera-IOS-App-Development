# ML-Camera-IOS-App-Development

Application Name: ML Camera 

## Compatibility:  	
* IOS 12
*	I-phone 8 and onwards (Does not works on Simulators)
*	Swift 5 and XCode Version 10.2.1


## Description: 
ML Camera is an application which has text recognition and object recognition functionality.

## How to Use the application?

* To open the project use “ML Camera.xcworkspace” to open and not ML Camera.xcodeproj
* The home view of app has 3 buttons to choose functionality.
  *	Text Recognition: To enter the text recognition view
  *	Saved Text: To save the text recognized from text recognition
  *	Object Recognition: To recognize the object in the captured image.
*	Text Recognition View:
  *	In this view there are buttons to perform various functions.
  *	The first button is “Take Image from Camera”. Use this button to capture image of text using camera.
  *	Second button is “Recognize text” which is initially inactive. This button enables after the image is captured using first
    button. Use this button to generate text from captured image. On tap of this button the recognized text will appear in the
  * Text View box. 
  *	Text View: On tap in the text view you can edit the text. It is useful when the algorithms adds some unknown text as
    symbols in the text view.
  *	After the text is edited in the text view, the “Find Sentiments” button can be used to find the sentiments in the text.
    (This is useful only for movie reviews as the model is trained on movie review dataset). 
  *	If the recognized text in the text view is an address of any place, then the button “Find Location from Text” can be used
    to find the location in the google. (The text needs to be proper in order to work with this feature. Try to edit the code
    if it doesn’t work and try again)
  *	If the recognized text is important and the user wants to save this in the app, the “Save Text” button can be used to
    save the text
  *	The image view shows the image captured from camera.
*	Saved Text View:
  *	The user can read the saved text in the app by tapping the “Saved Text” button on the home view.
  *	In the saved text view, each row represents the saved text. 
  *	User can tap on the row to see the saved text. 
  *	The user can delete the saved text in the Saved text view by left swipe on the row.
*	Object Recognition View:
  *	In this view, the user can capture image using “Open Camera” button and the object will be recognized by the “Inception
    V3” ML model. The object description will be shown in the view along with the image.





IOS functionality Used:

•	TesseractOCRSDKiOS used for text recognition.
•	IOS CreateML and CoreML will be used for text sentiment classification and image object detection. Used CreateML to train the text sentiment model.
o	https://developer.apple.com/documentation/createml/creating_a_text_classifier_model
o	http://boston.lti.cs.cmu.edu/classes/95-865-K/HW/HW3/ Movie review dataset used to train the model.
•	IOS table view for displaying saved recognized text by user.
•	Core Data for CRUD.
•	Segue between views.
•	Camera functionality.
•	Natural Language for text sentimental analysis.
•	Alerts used for showing that the text is saved in the database and for sentiments result.
•	Used Cocoa Pods to add TesseractOCRSDKiOS  https://cocoapods.org/pods/TesseractOCRSDKiOS


Note: 
•	To disable keyboard after typing, tap anywhere on screen expect keyboard. 
•	For find location feature the text needs to be properly edited. Try to edit the text if it doesn’t work and try again.
