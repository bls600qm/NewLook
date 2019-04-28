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

    let dateManager = DateManager()
    let daysPerWeek: Int = 7
    let cellMargin: CGFloat = 2.0
    var selectedDate = NSDate()
    var today: NSDate!
    let weekArray = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    @IBOutlet weak var button: UIButton!
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
        button.layer.cornerRadius = 10.0                                             //
        

        let barHeight = UIApplication.shared.statusBarFrame.size.height
        let width = self.view.frame.width
        let height = self.view.frame.height
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)

        calenderCollectionView.frame = CGRect(x:0, y:barHeight + 50, width:width, height:height - barHeight - 50)
        calenderCollectionView.register(CalendarCell.self, forCellWithReuseIdentifier: "CalendarCell")
        calenderCollectionView.delegate = self
        calenderCollectionView.dataSource = self
//        calenderCollectionView.backgroundColor = UIColor.white
        headerTitle.text = changeHeaderTitle(date: selectedDate) //追記

        self.view.addSubview(calenderCollectionView)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //①タップ時
    @IBAction func tappedHeaderPrevBtn(_ sender: UIButton) {
        selectedDate = dateManager.prevMonth(date: selectedDate as Date) as NSDate
        calenderCollectionView.reloadData()
        headerTitle.text = changeHeaderTitle(date: selectedDate)
    }
    //②タップ時
    
    @IBAction func tappedHeaderNextBtn(_ sender: UIButton) {
        selectedDate = dateManager.nextMonth(date: selectedDate as Date) as NSDate
        calenderCollectionView.reloadData()
        headerTitle.text = changeHeaderTitle(date: selectedDate)
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

    //1
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    //2
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Section毎にCellの総数を変える.
        if section == 0 {
            return 7
        } else {
            return dateManager.daysAcquisition() //ここは月によって異なる(後ほど説明します)
        }
    }
    //3
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath as IndexPath) as! CalendarCell
        //テキストカラー
        if (indexPath.row % 7 == 0) {
            cell.textLabel.textColor = UIColor.lightRed()
        } else if (indexPath.row % 7 == 6) {
            cell.textLabel.textColor = UIColor.lightBlue()
        } else {
            cell.textLabel.textColor = UIColor.gray
        }
        //テキスト配置
        if indexPath.section == 0 {
            cell.textLabel.text = weekArray[indexPath.row]
        } else {
            cell.textLabel.text = dateManager.conversionDateFormat(indexPath: indexPath)
            //月によって1日の場所は異なる(後ほど説明します)
        }
        return cell
    }
    
    //セルのサイズを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfMargin: CGFloat = 8.0
        let width: CGFloat = (collectionView.frame.size.width - cellMargin * numberOfMargin) / CGFloat(daysPerWeek)
        let height: CGFloat = width * 1.0
        //return CGSizeMake(width,height)

        return CGSizeMake(width, height)
    }
    
    func CGSizeMake(_ width: CGFloat, _ height: CGFloat) -> CGSize {
        return CGSize(width: width, height: height)
    }
    
    //セルの垂直方向のマージンを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }

    //セルの水平方向のマージンを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }

    //headerの月を変更
    func changeHeaderTitle(date: NSDate) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "M/yyyy"
        let selectMonth = formatter.string(from: date as Date)
        return selectMonth
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
//黄色いエラーをたくさん直した _抜けてるとか
//書き方の順番
// 変数宣言 @Outlet
//override func viwDidload
//@IBAction
//func

