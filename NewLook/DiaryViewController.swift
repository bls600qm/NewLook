//
//  DiaryViewController.swift
//  NewLook
//
//  Created by Rika Sumitomo on 2019/04/29.
//  Copyright © 2019 Rika Sumitomo. All rights reserved.
//

import UIKit
import RealmSwift

extension UIImage {
    func resize(size _size: CGSize) -> UIImage? {
        let widthRatio = _size.width / size.width
        let heightRatio = _size.height / size.height
        let ratio = widthRatio < heightRatio ? widthRatio : heightRatio
        
        let resizedSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        
        UIGraphicsBeginImageContextWithOptions(resizedSize, false, 0.0) // 変更
        draw(in: CGRect(origin: .zero, size: resizedSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
}

class DiaryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    var date: String!
    var photo: NSData!
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var contextTextField: UITextField!
    @IBOutlet var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Realmから値を読み込む
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dateLabel.text = date
        
        
        DispatchQueue(label: "background").async {
            let realm = try! Realm()
            
            if let savedDiary = realm.objects(Diary.self).filter("date == '\(self.date!)'").last {
                let context = savedDiary.context
              //*1  let photoData = savedDiary.photo
                
                // 読み込んだ NSData を UIImage へ変換します。
             //*2   let img : UIImage! = UIImage(data:photoData! as Data)
                
                DispatchQueue.main.async {
                    self.contextTextField.text = context
                    //imageViewに画像を表示
             //*3 self.photoImageView.image = img

                    //*のついてる所が画像を表示させる所
                }
            }
        }
        
    }
    
    @IBAction func saveButtonPushed(_ sender: UIButton) {
        
        // STEP.1 Realmを初期化
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        //STEP.2 保存する要素を書く
        let diary = Diary()
        diary.date = date
        diary.context = contextTextField.text!
        diary.photo = photo
        
            
        //STEP.3 Realmに書き込み
        try! realm.write {
            realm.add(diary, update: true)
        }
        
        //画面遷移して前の画面に戻る
        self.dismiss(animated: true, completion: nil)
        
    }
    
    //改行で入力確定
    @IBAction func memo(_ sender: Any) {
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
        self.dismiss(animated: true, completion: nil)
        
        // 選択した写真を取得する
        let image = info[.originalImage] as! UIImage
        //画像を出力
        photoImageView.image = image
        //画像をNSDataに変換
        photo = image.pngData() as NSData?
        print(photo as Any)
    
    }
}
