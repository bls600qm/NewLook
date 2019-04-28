//
//  CalendarCell.swift
//  NewLook
//
//  Created by Rika Sumitomo on 2019/04/22.
//  Copyright © 2019 Rika Sumitomo. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    var textLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        textLabel.font = UIFont(name: "HirakakuPro-W3", size: 12)
        textLabel.textAlignment = .center
        self.addSubview(textLabel!)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
}
