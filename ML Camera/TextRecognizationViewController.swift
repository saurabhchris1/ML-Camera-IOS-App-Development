//
//  TextRecognizationViewController.swift
//  ML Camera
//
//  Created by Saurabh Jaiswal on 4/24/19.
//  Copyright © 2019 Saurabh Jaiswal. All rights reserved.
//

import UIKit
import TesseractOCRSDKiOS
import Vision
import CoreData
import NaturalLanguage
import MapKit

class TextRecognizationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MGTesseractDelegate {
    
    var managedObjectContext: NSManagedObjectContext!
    
    var appDelegate: AppDelegate!
    
    var recognizedTextVar: String!
    
    var imagePickedbyUser: UIImage!

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textViewOCR: UITextView!
    
    @IBOutlet weak var findLocationButton: UIButton!
    
    @IBOutlet weak var findSentimentsButton: UIButton!
    
    @IBOutlet weak var recognizeTextButton: UIButton!
    
    @IBOutlet weak var cameraButton: UIButton!
    
    let tesseract = MGTesseract(language: "eng")
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recognizeTextButton.isEnabled = false
        findLocationButton.layer.cornerRadius = 7
        findSentimentsButton.layer.cornerRadius = 7
        recognizeTextButton.layer.cornerRadius = 7
        cameraButton.layer.cornerRadius = 7
        // Do any additional setup after loading the view.
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.managedObjectContext = appDelegate.persistentContainer.viewContext

        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        
        tesseract?.delegate = self
        textViewOCR.isSelectable = true
        textViewOCR.isEditable = true
        
        
    }
    

    func shouldCancelImageRecognition(for tesseract: MGTesseract!) -> Bool {
        return false
    }
    
    @IBAction func cameraTapped(_ sender: UIButton) {
           present(imagePicker, animated: true, completion: nil)
        recognizeTextButton.isEnabled = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            
            
            imageView.image = userPickedImage
            imagePickedbyUser = userPickedImage
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    

    
 
    
    func detectText(imageToCheck: UIImage) {
        tesseract?.image = imageToCheck
        tesseract?.recognize()
        
        recognizedTextVar = tesseract?.recognizedText
        textViewOCR.text = recognizedTextVar
    }
    
    @IBAction func recognizeTextTapped(_ sender: UIButton) {
    
        detectText(imageToCheck: imagePickedbyUser)
    }
    
    func addText(recoTextTess: String) {
        let textReco = NSEntityDescription.insertNewObject(forEntityName:
            "SavedText", into: self.managedObjectContext)
        textReco.setValue(recoTextTess, forKey: "text")
        self.appDelegate.saveContext()
    }
    
    
  
    
    
    @IBAction func findSentimentsTapped(_ sender: UIButton) {
        let myText = textViewOCR.text!
        let sentimentPredictor = try! NLModel(mlModel: SentimentClassifier().model)
        let detectedSentiments  = sentimentPredictor.predictedLabel(for: myText)!
      
        showSentimentAlert(style: .alert, objName: detectedSentiments)
        
    }
    
    @IBAction func findLocationTapped(_ sender: UIButton) {
        let myText = textViewOCR.text!
        var query = myText
        query = query.replacingOccurrences(of: " ", with: "+")
        let urlFinal = "https://www.google.co.in/search?q=" + query
        if let url = URL(string: urlFinal),  UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
        
       
    }
    
    
    @IBAction func saveTextTaped(_ sender: UIButton) {
        let myText = textViewOCR.text!
        addText(recoTextTess: myText)
        showAlert(style: .alert)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textViewOCR.resignFirstResponder()
    }
    
    func showAlert(style: UIAlertController.Style){
        let alert = UIAlertController(title: "ML Camera",
                                      message: "Text Saved Successfully", preferredStyle: style)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel,
                                         handler: { (action) in
                                            // execute some code when this option is selected
                                            
        })
        
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func showSentimentAlert(style: UIAlertController.Style, objName: String){
        let alert = UIAlertController(title: "ML Camera",
                                      message: "The sentiment is : \(objName)", preferredStyle: style)
        let oKAction = UIAlertAction(title: "Ok", style: .default,
                                         handler: { (action) in
                                            // execute some code when this option is selected
                                            
        })
        
        
        alert.addAction(oKAction)
        
        present(alert, animated: true, completion: nil)
    }

}
