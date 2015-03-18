//
//  Helper.swift
//  PasswordLockerSwift
//
//  Created by Eray on 04/02/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import UIKit

class Helper: NSObject {
    class func seperatorTopImageView(cell: UITableViewCell) -> UIImageView {
        let separatorY: CGFloat = cell.frame.size.height
        let separatorHeight: CGFloat = 1.0 / UIScreen .mainScreen().scale
        let separatorWidth: CGFloat = cell.frame.size.width
        let separatorInset: CGFloat = 15.0
        let separatorBGColor: UIColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        let separator: UIImageView = UIImageView(frame: CGRectMake(separatorInset, 0, separatorWidth-15.0, separatorHeight))
        separator.backgroundColor = separatorBGColor
        return separator
    }
    
    class func seperatorButtomImageView(cell: UITableViewCell) -> UIImageView {
        let separatorY: CGFloat = cell.frame.size.height
        let separatorHeight: CGFloat = 1.0 / UIScreen .mainScreen().scale
        let separatorWidth: CGFloat = cell.frame.size.width
        let separatorInset: CGFloat = 15.0
        let separatorBGColor: UIColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        let separator: UIImageView = UIImageView(frame: CGRectMake(separatorInset, separatorY, separatorWidth-15.0, separatorHeight))
        separator.backgroundColor = separatorBGColor
        return separator
    }
}
