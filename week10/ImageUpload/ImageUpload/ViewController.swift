//
//  ViewController.swift
//  ImageUpload
//
//  Created by tobiasmidskard on 18/03/2020.
//  Copyright © 2020 tobiasmidskard. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var chooseImageButton: UIButton!
    let imagePicker = UIImagePickerController()
    
    let storage = Storage.storage(url:"gs://my-personal-notes-2a1d8.appspot.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getImage()
    }
    
    @IBAction func chooseImageButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")

            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = true

            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject: AnyObject]!){
        self.dismiss(animated: true, completion: { () -> Void in

        })

        imageView.image = image
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }

        imageView.image = image
        uploadImage(image: imageView.image!)
    }
    
    func uploadImage(image: UIImage) {
        let storageRef = storage.reference()
        let folderRef = storageRef.child("images/latest.png")
        
        if let imageData = image.jpegData(compressionQuality: 0.1) {
            
            let uploadTask = folderRef.putData(imageData, metadata: nil) { (metadata, error) in
              guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
              }
              // Metadata contains file metadata such as size, content-type.
              let size = metadata.size
              // You can also access to download URL after upload.
              folderRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                  // Uh-oh, an error occurred!
                  return
                }
              }
            }
        }
    }
    
    func getImage() {
        let storageRef = storage.reference()
        let folderRef = storageRef.child("images/latest.png")
        
        folderRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
            // Uh-oh, an error occurred!
          } else {
            // Data for "images/island.jpg" is returned
            let image = UIImage(data: data!)
            self.imageView.image = image
          }
        }
    }
}

