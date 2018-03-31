//
//  ViewController.swift
//  ios-text-recognition
//
//  Created by Yusra Khalid on 3/7/18.
//  Copyright © 2018 Yusra Khalid. All rights reserved.
//

import UIKit
import TesseractOCR


class ViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate , G8TesseractDelegate{

    @IBOutlet weak var rateOutput: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func captureImage(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction ) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
            else{
                let action2 = UIAlertController(title: "Error", message: "Camera Not available.", preferredStyle: .alert)
                action2.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
                self.present(action2, animated: true, completion: nil)
            }
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .default, handler: {(action:UIAlertAction ) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true,completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        picker.dismiss(animated: true, completion: nil)
        recognizeImage(requiredImage:image)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    
    }
    
    @IBAction func pushImage(_ sender: UIButton) {
    }
    
    @IBAction func pushImageAndData(_ sender: UIButton) {
    }
    
    @IBAction func uploadImage(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // construct here
    }

    func recognizeImage(requiredImage:UIImage){
        var tesseract:G8Tesseract = G8Tesseract(language: "eng") 
        tesseract.delegate = self
        //tesseract.charWhitelist = "01234567890"
        tesseract.image = requiredImage
        tesseract.recognize()
        print("\nText = ", tesseract.recognizedText)
        displayOutput(textDisplay: tesseract.recognizedText)
    }
    
    func displayOutput(textDisplay:String){
        rateOutput.text = textDisplay
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func shouldCancelImageRecognitionForTesseract(tesseract: G8Tesseract!) -> Bool {
        return false // return true if you need to interrupt tesseract before it finishes
    }

}

