//
//  HomeViewController.swift
//  Authentication
//
//  Created by tobiasmidskard on 21/05/2020.
//  Copyright © 2020 tobiasmidskard. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }
    
    func setUpElements() {
        Utilities.styleFilledButton(logoutButton)
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.transitionToIndex()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
    func transitionToIndex() {
        view.window?.rootViewController = storyboard?.instantiateInitialViewController()
        view.window?.makeKeyAndVisible()
    }

}
    
