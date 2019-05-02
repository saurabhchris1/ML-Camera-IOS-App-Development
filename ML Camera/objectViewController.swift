//
//  objectViewController.swift
//  ML Camera
//
//  Created by Saurabh Jaiswal on 4/25/19.
//  Copyright © 2019 Saurabh Jaiswal. All rights reserved.
//

import UIKit
import CoreML
import Vision

class objectViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var imageViewObject: UIImageView!
    
    @IBOutlet weak var objectLabel: UILabel!
    
    @IBOutlet weak var cameraButton: UIButton!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cameraButton.layer.cornerRadius = 7
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            imageViewObject.image = userPickedImage
            guard let ciimage = CIImage(image: userPickedImage) else{
                
                fatalError("Could not convert UIImage into CIImage")
            }
            
            detect(image: ciimage)
            
        }
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    func detect(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Loding Core ML Failed")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else{
                fatalError("Model failed to process image")
            }
            if let firstResult = results.first{
            
                self.objectLabel.text = "The detected object by Inception V3 model is: " + firstResult.identifier
                
                
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do{
            
            try handler.perform([request])
            
        }
        catch{
            print(error)
        }
    }

    @IBAction func cameraTapped(_ sender: UIButton) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
