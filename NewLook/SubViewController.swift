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
    @IBOutlet var commentLabel: UILabel!
    @IBOutlet var rerutnButton: UIButton!
    
    var Img: UIImage!
    var Comment: String!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = Img
        commentLabel.text = Comment
        //imageView.contentMode = UIView.ContentMode.scaleAspectFit //画像のアスペクト比を維持しUIImageViewサイズに収まるように表示
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func returnButton(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
