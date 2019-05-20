//
//  CalendarCell.swift
//  NewLook
//
//  Created by Rika Sumitomo on 2019/04/22.
//  Copyright © 2019 Rika Sumitomo. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat) {
        let v = hex.map { String($0) } + Array(repeating: "0", count: max(6 - hex.count, 0))
        let r = CGFloat(Int(v[0] + v[1], radix: 16) ?? 0) / 255.0
        let g = CGFloat(Int(v[2] + v[3], radix: 16) ?? 0) / 255.0
        let b = CGFloat(Int(v[4] + v[5], radix: 16) ?? 0) / 255.0
        self.init(red: r, green: g, blue: b, alpha: min(max(alpha, 0), 1))
    }
    
    convenience init(hex: String) {
        self.init(hex: hex, alpha: 1.0)
    }
}

class CalendarCell: UICollectionViewCell {
    
    public var textLabel: UILabel!
    public var imageView: UIImageView!
    
    required init(coder aDecoder:NSCoder){
        super.init(coder: aDecoder)!
    }
    
    override init(frame:CGRect){
        super.init(frame:frame)
        
        //self.backgroundColor = UIColor(hex: "FFFDF")
        self.backgroundColor = UIColor.white
        
        //UILabelを生成
        textLabel = UILabel()
        textLabel.frame = CGRect(x:0,y:-self.frame.height/3,width:self.frame.width,height:self.frame.height)
        textLabel.textAlignment = .center
        self.contentView.addSubview(textLabel!)
        
        //セルの画像 こっちに作っちゃう
        imageView = UIImageView()
        imageView.frame = CGRect(x:0,y:0,width:self.frame.width*0.9,height:self.frame.width*0.9) //下でセンター指定してるのでx,yは反映されない
        imageView.center = CGPoint(x:self.frame.width/2, y:self.frame.height*2/3)
        self.contentView.addSubview(imageView!)
        
        
        
    }
}
