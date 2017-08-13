//
//  ViewController.swift
//  MemeMe
//
//  Created by Vipul Srivastav on 2017-08-06.
//  Copyright © 2017 Vipul Srivastav. All rights reserved.
//

import UIKit
//
//struct Meme {
//    let topText: UITextField,
//    let bottomText: UITextField,
//    let  originalImage: UIImageView.image,
//    let memedImage: memedImage
//    
//
//}

var memedImage: UIImage! = nil

class ViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    struct Meme {
        var textField1: String
        var textField2: String
        var originalImage: UIImage?
        var memedImage: UIImage?
    }
    
    @IBAction func pickImage(_ sender: Any) {
        
        let imageController = UIImagePickerController()
        imageController.delegate = self
         imageController.sourceType = .photoLibrary
        present(imageController, animated: true, completion: nil)
            }
    
    
    @IBAction func pickCamera(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
    }
  
    @IBOutlet var image: UIImageView!
    @IBOutlet var bottomField: UITextField!
    @IBOutlet var topField: UITextField!
    @IBOutlet var cameraButton: UIBarButtonItem!
    
    
    
    func textFieldDidBeginEditing(){
         topField.text = ""
         bottomField.text = ""
    }
    
    
    func generateMemedImage() -> UIImage {
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        memedImage  = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return memedImage
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Dismiss the keyboard when the view is tapped on
        topField.resignFirstResponder()
        bottomField.resignFirstResponder()
    }

    
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor .black,
        NSForegroundColorAttributeName: UIColor .black,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: 3.0]
    
    @IBOutlet var imagePickerView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldDidBeginEditing()
        // Do any additional setup after loading the view, typically from a nib.
        //topField.text = "Top"
        topField.textAlignment = .center
        topField.defaultTextAttributes = memeTextAttributes
        //bottomField.text = "Bottom"
        bottomField.textAlignment = .center
        bottomField.defaultTextAttributes = memeTextAttributes
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       // let UIImagePickerControllerOriginalImage: String?
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
        }
        dismiss(animated: true, completion: nil)

    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
       dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)

    }
    @IBOutlet var sharebutton: UIButton!
    @IBAction func share(_ sender: Any) {
        
        let image : UIImage = generateMemedImage()
        if image != nil {
            sharebutton.isEnabled = true
        }
        let activityCtrl = UIActivityViewController.init(activityItems: [image], applicationActivities: nil)
      
        present(activityCtrl, animated: true, completion: save)
        
        //dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    
    func save() {
        // Create the meme
        let meme = Meme(textField1: topField.text!, textField2: bottomField.text!, originalImage: image.image, memedImage: memedImage)
        
    }



}

