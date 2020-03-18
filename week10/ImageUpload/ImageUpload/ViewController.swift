//
//  ViewController.swift
//  ImageUpload
//
//  Created by tobiasmidskard on 18/03/2020.
//  Copyright © 2020 tobiasmidskard. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    let storage = Storage.storage(url:"gs://my-personal-notes-2a1d8.appspot.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uploadImage(image: imageView.image!)
    }
    
    func uploadImage(image: UIImage) {
        let storageRef = storage.reference()
        let folderRef = storageRef.child("images/apple.png")
        
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


}

