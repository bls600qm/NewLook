//
//  CalendarCell.swift
//  NewLook
//
//  Created by Rika Sumitomo on 2019/04/22.
//  Copyright © 2019 Rika Sumitomo. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    public var textLabel: UILabel!
    public var imageView: UIImageView!
    
    required init(coder aDecoder:NSCoder){
        super.init(coder: aDecoder)!
    }
    
    override init(frame:CGRect){
        super.init(frame:frame)
        
        //UILabelを生成
        textLabel = UILabel()
        textLabel.frame = CGRect(x:0,y:0,width:self.frame.width,height:self.frame.height)
        textLabel.textAlignment = .center
        self.contentView.addSubview(textLabel!)
        
        //セルの画像 こっちに作っちゃう
        imageView = UIImageView()
        imageView.frame = CGRect(x:self.frame.width/2,y:self.frame.height/1.5,width:self.frame.width/1.7,height:self.frame.height/2)
        self.contentView.addSubview(imageView!)
        
        
        
    }
}
