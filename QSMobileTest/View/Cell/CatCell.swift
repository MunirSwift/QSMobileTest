//
//  CatCell.swift
//  QSMobileTest
//
//  Created by Rydus on 17/05/2019.
//  Copyright © 2019 Rydus. All rights reserved.
//

import UIKit

class CatCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    /*var item: ProfileViewModelItem? {
        didSet {
            guard  let item = item as? ProfileViewModelAboutItem else {
                return
            }
            aboutLabel?.text = item.about
        }
    }*/
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
