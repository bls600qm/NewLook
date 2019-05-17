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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = Img
        commentLabel.text = Comment
        //imageView.contentMode = UIView.ContentMode.scaleAspectFit //画像のアスペクト比を維持しUIImageViewサイズに収まるように表示
        
        //グラデーションの開始色
        let topColor = UIColor(red: 0.8118, green: 0.2235, blue: 0.4353, alpha: 1.0) /* #cf396f */
        //グラデーションの開始色
        let bottomColor = UIColor(red: 0.9686, green: 0.8863, blue: 0.5451, alpha: 1.0) /* #f7e28b */
        //グラデーションの色を配列で管理
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        //グラデーションレイヤーを作成
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        //グラデーションの色をレイヤーに割り当てる
        gradientLayer.colors = gradientColors
        //グラデーションレイヤーをスクリーンサイズにする
        gradientLayer.frame = self.view.bounds
        
        //view.layer.addSublayer(gradientLayer)
        //ViewControllerのViewレイヤーにグラデーションレイヤーを挿入する
        self.view.layer.insertSublayer(gradientLayer,at:0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func returnButton(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
