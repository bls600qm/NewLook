//
//  DiaryViewController.swift
//  NewLook
//
//  Created by Rika Sumitomo on 2019/04/29.
//  Copyright © 2019 Rika Sumitomo. All rights reserved.
//

import UIKit
import RealmSwift

//extension UIImage {
//    func resize(size _size: CGSize) -> UIImage? {
//        let widthRatio = _size.width / size.width
//        let heightRatio = _size.height / size.height
//        let ratio = widthRatio < heightRatio ? widthRatio : heightRatio
//        
//        let resizedSize = CGSize(width: size.width * ratio, height: size.height * ratio)
//        
//        UIGraphicsBeginImageContextWithOptions(resizedSize, false, 0.0) // 変更
//        draw(in: CGRect(origin: .zero, size: resizedSize))
//        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        return resizedImage
//    }
//}
extension UIImage {
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}


class DiaryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    var date: String!
    var photo: NSData!
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var contextTextField: UITextField!
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var OutlineImageView: UIImageView!
    
    //@IBOutlet var contextTextView: UITextView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.contextTextField.delegate = self //閉じれない
        contextTextField.delegate = self
        imagePickerController.delegate = self
//        //グラデーションの開始色
//        let topColor = UIColor(red: 0.8118, green: 0.2235, blue: 0.4353, alpha: 1.0) /* #cf396f */
//        //グラデーションの開始色
//        let bottomColor = UIColor(red: 0.9686, green: 0.8863, blue: 0.5451, alpha: 1.0) /* #f7e28b */
//        //グラデーションの色を配列で管理
//        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
//        //グラデーションレイヤーを作成
//        let gradientLayer: CAGradientLayer = CAGradientLayer()
//        //グラデーションの色をレイヤーに割り当てる
//        gradientLayer.colors = gradientColors
//        //グラデーションレイヤーをスクリーンサイズにする
//        gradientLayer.frame = self.view.bounds
//        
//        //view.layer.addSublayer(gradientLayer)
//        //ViewControllerのViewレイヤーにグラデーションレイヤーを挿入する
//        self.view.layer.insertSublayer(gradientLayer,at:0)
//        
        dateLabel.textColor = UIColor.white //日付ラベル白にする
        
        // 枠のカラー
        photoImageView.layer.borderColor = UIColor.white.cgColor
        // 枠の幅
        photoImageView.layer.borderWidth = 3.0
        
        //        //TextViewで完了のバーを表示させる
        //        // 仮のサイズでツールバー生成
        //        let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        //        kbToolBar.barStyle = UIBarStyle.default  // スタイルを設定
        //
        //        kbToolBar.sizeToFit()  // 画面幅に合わせてサイズを変更
        //
        //        // スペーサー
        //        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        //
        //        // 閉じるボタン
        //        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: "commitButtonTapped")
        //
        //        kbToolBar.items = [spacer, commitButton]
        //
        //
        //        contextTextView.inputAccessoryView = kbToolBar
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        contextTextField.resignFirstResponder()
        return true
    }
    
    //Realmから値を読み込む
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dateLabel.text = date
        
//        let realm = try! Realm()

//        if let savedDiary = realm.objects(Diary.self).filter("date == '\(self.date!)'").last { //nilじゃない場合 //今日のやつ
//            //すでに値が入ってたらけしちゃう！
//            try! realm.write {
//                realm.delete(savedDiary)
//            }
//        }
        
    }

    
    @IBAction func saveButtonPushed(_ sender: UIButton) {
        
        print("保存ボタン押された")
        // STEP.1 Realmを初期化
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        //STEP.2 保存する要素を書く
        let diary = Diary()
        diary.date = date
        diary.context = contextTextField.text!
        diary.photo = photo

        
        
        //*過去データを保存したい時* pngで画像入れて指定する
//        diary.date = "2019/05/25"
//        diary.context = " "
//        if let image = UIImage(named:"photo9"){
//            diary.photo = image.pngData() as NSData?
//            //print(diary.photo)
//        }
        
        //STEP.3 Realmに書き込み
        if diary.photo != nil{
            try! realm.write {
                realm.add(diary, update: true)
                print("書き込みました")
            }
        } else {
            self.dismiss(animated: true, completion: nil)
        }
        //画面遷移して前の画面に戻る/Users/rikasumitomo/Downloads/jpg
        self.dismiss(animated: true, completion: nil)
        
    }

    //カメラの処理
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
            self.dismiss(animated: true, completion: nil)
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
            cameraPicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
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
            cameraPicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
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
    
    
    //写真のピックが完了した時に呼ばれる
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        // 選択した写真を取得する
        let image = info[.originalImage] as! UIImage
//        print(image.size)
//        let Resize:CGSize = CGSize.init(width: image.size.width * 0.5, height:image.size.height * 0.5)
//        //UIImageを指定のサイズにリサイズ
//        let imageResize = image.resize(size: Resize)
//        print(imageResize)
        //画像を出力
        photoImageView.image = image
        
        //画像データ小さく
        let resizedImage = image.resized(withPercentage: 0.7)
        //画像をNSDataに変換
       // photo = image.pngData() as NSData?
        photo = resizedImage?.pngData() as NSData?
    
       // print(photo as Any)
        self.dismiss(animated: true, completion: nil)
    
        
    }
    //下スワイプで前の画面に戻る
    @IBAction func swipeReturn(_ sender: UISwipeGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
}
