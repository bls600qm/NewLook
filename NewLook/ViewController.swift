//
//  ViewController.swift
//  NewLook
//
//  Created by Rika Sumitomo on 2019/04/14.
//  Copyright © 2019 Rika Sumitomo. All rights reserved.
//



import UIKit

extension UIColor {
    class func lightBlue() -> UIColor {
        return UIColor(red: 92.0 / 255, green: 192.0 / 255, blue: 210.0 / 255, alpha: 1.0)
    }
    
    class func lightRed() -> UIColor {
        return UIColor(red: 195.0 / 255, green: 123.0 / 255, blue: 175.0 / 255, alpha: 1.0)
    }
}

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // cellの数を返す関数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return weekArray.count
    }
    // cellに情報を入れていく関数
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        return cell
    }
    
    
    
    let dateManager = DateManager()
    let daysPerWeek: Int = 7
    let cellMargin: CGFloat = 2.0
    var selectedDate = NSDate()
    var today: NSDate!
    let weekArray = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    @IBOutlet weak var button: UIButton!
    //@IBOutlet var photoImageView: UIImageView!
    
    @IBOutlet weak var headerPrevBtn: UIButton!//①
    @IBOutlet weak var headerNextBtn: UIButton!//②
    @IBOutlet weak var headerTitle: UILabel!    //③
    @IBOutlet weak var calenderHeaderView: UIView! //④
    @IBOutlet weak var calenderCollectionView: UICollectionView!//⑤
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // ボタンの装飾
        let rgba = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0) // ボタン背景色設定
        button.backgroundColor = rgba                                               // 背景色
        button.layer.borderWidth = 0.5                                              // 枠線の幅
        button.layer.borderColor = UIColor.black.cgColor                            // 枠線の色
        button.layer.cornerRadius = 10.0                                             // 角丸のサイズ
        
        calenderCollectionView.delegate = self
        calenderCollectionView.dataSource = self
//        calenderCollectionView.backgroundColor = UIColor.white
    }
    
    //①タップ時
    @IBAction func tappedHeaderPrevBtn(sender: UIButton) {
    }
    
    //②タップ時
    @IBAction func tappedHeaderNextBtn(sender: UIButton) {
    }
    
    
    //アルバムから選択かカメラで撮影かを選択するAlertControllerを出す
    @IBAction func showAlert(_ sender: Any) {
        let actionSheet = UIAlertController(title: "画像の選択", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let action1 = UIAlertAction(title: "アルバムから選択", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
            print("アルバムから選択")
            self.tappedlibrary()
        })
        
        let action2 = UIAlertAction(title: "カメラで撮影", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
            print("カメラで撮影")
            self.tappedcamera()
            
        })

        let cancel = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
            print("キャンセルをタップした時の処理")
        })
        
        actionSheet.addAction(action1)
        actionSheet.addAction(action2)
        actionSheet.addAction(cancel)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    //アルバムから選択するメソッド
    func tappedlibrary() {
        let sourceType:UIImagePickerController.SourceType =
            UIImagePickerController.SourceType.photoLibrary
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.photoLibrary){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
        else{
            print("error")
            
        }
    }
    //カメラを起動するメソッド
    func tappedcamera() {
        let sourceType:UIImagePickerController.SourceType =
            UIImagePickerController.SourceType.camera
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.camera){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
        else{
            print("error")
        }
    }
    // 撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //撮影が完了した時に呼ばれる
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        self.dismiss(animated: true, completion: nil)
         //画像を出力
        //photoImageView.image = info[.originalImage] as? UIImage
    }
    

}

