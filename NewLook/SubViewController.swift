//
//  SubViewController.swift
//  NewLook
//
//  Created by Rika Sumitomo on 2019/05/06.
//  Copyright © 2019 Rika Sumitomo. All rights reserved.
//

import Foundation
import UIKit

class SubViewController: UIViewController{
    @IBOutlet var imageView: UIImageView!
    var selectedImg: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = selectedImg
        // 画像のアスペクト比を維持しUIImageViewサイズに収まるように表示
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Cell が選択された場合
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(DateManager.conversionDateFormat(indexPath: indexPath))/\(changeHeaderTitle(date: selectedImg))")
    }
    
    
    
}
