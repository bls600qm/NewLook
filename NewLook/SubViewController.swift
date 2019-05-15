//
//  SubViewController.swift
//  NewLook
//
//  Created by Rika Sumitomo on 2019/05/15.
//  Copyright © 2019 Rika Sumitomo. All rights reserved.
//

import UIKit

class SubViewController: UIViewController{
    @IBOutlet var imageView: UIImageView!
    
    var selectedImg: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = selectedImg
       
        imageView.contentMode = UIView.ContentMode.scaleAspectFit //画像のアスペクト比を維持しUIImageViewサイズに収まるように表示
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
