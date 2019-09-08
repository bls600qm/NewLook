//
//  CalendarCell.swift
//  NewLook
//
//  Created by Rika Sumitomo on 2019/04/22.
//  Copyright © 2019 Rika Sumitomo. All rights reserved.
//

import UIKit

extension UIColor{
    // オリジナルのカラーを生成します。割合については下の方の参考の部分でURLを載せておきます！
    //オレンジ
    class func OrangeColor()->UIColor{
        let Black = UIColor.init(red: 1.0, green: 0.6, blue: 0, alpha: 1.0)
        return Black
    }
    //ミドリ
    class func GreenColor()->UIColor{
        let Black = UIColor.init(red: 0.0, green: 1.0, blue: 0.6, alpha: 1.0)
        return Black
    }
    //white
    class func WhiteColor()->UIColor{
        let Black = UIColor.init(red: 250, green: 250, blue: 250, alpha: 1.0)
        return Black
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
        
        self.backgroundColor = UIColor.WhiteColor()
        //self.backgroundColor = UIColor.white
        
        //UILabelを生成
        textLabel = UILabel()
        textLabel.frame = CGRect(x:0,y:-self.frame.height/3,width:self.frame.width,height:self.frame.height)
        textLabel.textAlignment = .center
        textLabel.font = UIFont(name:"AvenirNextCondensed-Medium", size: 17.5)
        self.contentView.addSubview(textLabel!)
        
        //セルの画像 こっちに作っちゃう
        imageView = UIImageView()
        imageView.frame = CGRect(x:0,y:0,width:self.frame.width*0.9,height:self.frame.width*0.9) //下でセンター指定してるのでx,yは反映されない
        imageView.center = CGPoint(x:self.frame.width/2, y:self.frame.height*2/3)
        self.contentView.addSubview(imageView!)
        
        
        
    }
}
