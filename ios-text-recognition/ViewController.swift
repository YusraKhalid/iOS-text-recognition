//
//  ViewController.swift
//  ios-text-recognition
//
//  Created by Yusra Khalid on 3/7/18.
//  Copyright © 2018 Yusra Khalid. All rights reserved.
//

import UIKit
import TesseractOCR


class ViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate ,UIPickerViewDataSource, G8TesseractDelegate{
    

    let pickerData = ["6TH AVE LETHBRDIGE","ATHABASCA","BANFF", "CAMROSE","COLD LAKE ESSO","CROSSFIELD","INNISFREE","MAYOR LETHBRIDGE","NEEPAWA ESSO","PEACE RIVER","SAINT PAUL","SWIFT CURRENT","SYLVAN LAKE","VALLEY VIEW","VIKING","VIRDEN","WANDERING RIVER","WHITE HORSE","WINTERBURN" ]
    let competitorsList = [ "ESSO","FAS GAS","SHELL","HUSKY","CO-OP","SEVEN - 11","CIRCLE K","GAS KING","NO FRILLS","WHOLESALE","CANADIAN TIRES","TEMPO","TAGS","SUPERSTORE"]

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == siteName){
            return pickerData.count}
        
        else{
            return competitorsList.count}
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == siteName){
            return pickerData[row]}
        else{
            return competitorsList[row]
        }
    }
    

//    @IBOutlet weak var rateOutput: UILabel!
    @IBOutlet weak var siteName: UIPickerView!
    @IBOutlet weak var competitors: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var rateOutput: UITextField!
    @IBOutlet weak var fuel: UISegmentedControl!
    
//    var pickerData: [String] = [String]()
    
    func fuelType() -> String{
        switch fuel.selectedSegmentIndex
        {
        case 0:
            return "Diesel"
        case 1:
            return "Petrol"
        default:
            break
        }
        return ""
    }
    
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
        print("output rate/ textfield: ", rateOutput)
        
    }
    
//    @IBAction func pushImageAndData(_ sender: UIButton) {
//    }
//    
//    @IBAction func uploadImage(_ sender: UIButton) {
//         print("output rate/ textfield: ", rateOutput.text!)
//        print("fuel type is : ", fuelType())
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        siteName.delegate = self
        siteName.dataSource = self
        competitors.delegate = self
        competitors.dataSource = self
        
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

