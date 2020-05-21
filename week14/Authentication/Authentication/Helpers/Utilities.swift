//
//  Utilities.swift
//  Authentication
//
//  Created by tobiasmidskard on 21/05/2020.
//  Copyright © 2020 tobiasmidskard. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    static func styleTextField(_ textField: UITextField) {
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
        
        textField.borderStyle = .none
        
        textField.layer.addSublayer(bottomLine)
        
    }

    static func styleFilledButton(_ button: UIButton) {
        button.backgroundColor = UIColor(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        let testPassword = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        
        return testPassword.evaluate(with: password)
    }
}
