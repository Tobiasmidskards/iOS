//
//  Story.swift
//  CustomTableViewCell
//
//  Created by tobiasmidskard on 12/04/2020.
//  Copyright © 2020 tobiasmidskard. All rights reserved.
//

import Foundation

class Story {
    var text:String = ""
    var image:String = ""
    
    init(txt:String, img:String) {
        text = txt
        image = img
    }
    
    func hasImage() -> Bool {
        return image.count > 0
    }
}
