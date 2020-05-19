//
//  ViewController.swift
//  MediaCapture
//
//  Created by tobiasmidskard on 19/05/2020.
//  Copyright © 2020 tobiasmidskard. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var textInput: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    @IBAction func addTextButtonPressed(_ sender: UIButton) {
        if let topText = textInput.text {
            if let image = ImageView.image {
                
                let imageWithText = textOnImage(drawText: topText, inImage: image, atPoint: CGPoint(x: 0, y: 0))
                ImageView.image = imageWithText
            }
        }
    }
    
    func textOnImage(drawText: String, inImage: UIImage, atPoint: CGPoint) -> UIImage{
            
            let color = UIColor.white;
            let font = UIFont(name: "Times New Roman", size: 80)!
            
            let scale = UIScreen.main.scale
            UIGraphicsBeginImageContextWithOptions(inImage.size, false, scale)
            
            let textAttributes = [
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: color,
            ]
            
            inImage.draw(in: CGRect(x: 0, y: 0, width: inImage.size.width, height: inImage.size.height))
            
            drawText.draw(in: CGRect(x: atPoint.x, y: atPoint.y, width: inImage.size.width, height: inImage.size.height), withAttributes: textAttributes)
            
            let imageWithText = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()

            return imageWithText!
    }
    
    @IBAction func PhotosButtonPressed(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraPhotoButtonPressed(_ sender: UIButton) {
        imagePicker.sourceType = .camera
        imagePicker.showsCameraControls = true
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        
        ImageView.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }

}

