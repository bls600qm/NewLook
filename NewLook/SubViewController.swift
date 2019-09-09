//
//  SubViewController.swift
//  NewLook
//
//  Created by Rika Sumitomo on 2019/05/15.
//  Copyright © 2019 Rika Sumitomo. All rights reserved.
//

import UIKit


class SubViewController: UIViewController{
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var outlineImageView: UIImageView!
    @IBOutlet var commentLabel: UILabel!
    @IBOutlet var returnButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
    
    var Img: UIImage!
    var Comment: String!
    var Date: String!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImageView.image = Img
        commentLabel.text = Comment
        dateLabel.text = Date
       
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func returnButton(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //下スワイプで前の画面に戻る
    @IBAction func swipeReturn(_ sender: UISwipeGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
}
