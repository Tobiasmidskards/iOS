//
//  TableViewCellTextOnly.swift
//  CustomTableViewCell
//
//  Created by tobiasmidskard on 12/04/2020.
//  Copyright © 2020 tobiasmidskard. All rights reserved.
//

import UIKit

class TableViewCellTextOnly: UITableViewCell {

    @IBOutlet weak var myLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
