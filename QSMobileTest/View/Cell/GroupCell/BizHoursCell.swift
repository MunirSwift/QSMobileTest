//
//  BizHoursCell.swift
//  QSMobileTest
//
//  Created by Rydus on 18/05/2019.
//  Copyright © 2019 Rydus. All rights reserved.
//

import UIKit

class BizHoursCell: UITableViewCell {

    @IBOutlet weak var v1: UIView!
    @IBOutlet weak var v2: UIView!
    @IBOutlet weak var v3: UIView!
    @IBOutlet weak var v4: UIView!
    @IBOutlet weak var v5: UIView!
    @IBOutlet weak var v6: UIView!
    @IBOutlet weak var v7: UIView!
    
    @IBOutlet weak var lbSun: UILabel!
    @IBOutlet weak var lbMon: UILabel!
    @IBOutlet weak var lbTue: UILabel!
    @IBOutlet weak var lbWed: UILabel!
    @IBOutlet weak var lbThr: UILabel!
    @IBOutlet weak var lbFri: UILabel!
    @IBOutlet weak var lbSat: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        v1.addBorder(toSide: .Bottom, withColor: UIColor.lightGray as! CGColor, andThickness: 1)
        v2.addBorder(toSide: .Bottom, withColor: UIColor.lightGray as! CGColor, andThickness: 1)
        v3.addBorder(toSide: .Bottom, withColor: UIColor.lightGray as! CGColor, andThickness: 1)
        v4.addBorder(toSide: .Bottom, withColor: UIColor.lightGray as! CGColor, andThickness: 1)
        v5.addBorder(toSide: .Bottom, withColor: UIColor.lightGray as! CGColor, andThickness: 1)
        v6.addBorder(toSide: .Bottom, withColor: UIColor.lightGray as! CGColor, andThickness: 1)
        v7.addBorder(toSide: .Bottom, withColor: UIColor.lightGray as! CGColor, andThickness: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//  MARK:   View Border without image : https://gist.github.com/MrJackdaw/6ffbc33fc274838412bfe3ad48592b9b
extension UIView {
    // Example use: myView.addBorder(toSide: .Left, withColor: UIColor.redColor().CGColor, andThickness: 1.0)
    
    enum ViewSide {
        case Left, Right, Top, Bottom
    }
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color
        switch side {
        case .Left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
        case .Right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
        case .Top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); break
        case .Bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness); break
        }
        layer.addSublayer(border)
    }
}
