//
//  ABCCell.swift
//  QSMobileTest
//
//  Created by Rydus on 18/05/2019.
//  Copyright © 2019 Rydus. All rights reserved.
//

import UIKit

class ContactInfoCell: UITableViewCell {

    //  Labels
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var lbTollFree: UILabel!
    @IBOutlet weak var lbFax: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbWeb: UILabel!
    
    //  Buttons
    @IBOutlet weak var btnPhSms: UIButton!
    @IBOutlet weak var btnPhCall: UIButton!

    @IBOutlet weak var btnTFSms: UIButton!
    @IBOutlet weak var btnTFCall: UIButton!
    
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var btnWeb: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
