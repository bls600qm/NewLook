//
//  ViewController.swift
//  NewLook
//
//  Created by Rika Sumitomo on 2019/04/14.
//  Copyright © 2019 Rika Sumitomo. All rights reserved.
//



import UIKit
import RealmSwift

extension UIColor {
    class func lightBlue() -> UIColor {
        return UIColor(red: 92.0 / 255, green: 192.0 / 255, blue: 210.0 / 255, alpha: 1.0)
    }

    class func lightRed() -> UIColor {
        return UIColor(red: 195.0 / 255, green: 123.0 / 255, blue: 175.0 / 255, alpha: 1.0)
    }
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    let dateManager = DateManager()
    let daysPerWeek: Int = 7
    let cellMargin: CGFloat = 2.0 //セルの余白
    var selectedDate = NSDate() //今日の日付
    //var today: NSDate!
    var today: String!
    let weekArray = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    let margin: CGFloat = 3.0

    var date: String!
   // var photos: [UIImageView] = []
    var photos: NSData!
    var context: String!
    
    var Path: Int!
    
    var diarys: [(photo: NSData, date: String, context: String )] = []
    
    var img: UIImage? = nil
    var selectedImage: UIImage?
    var selectedComment: String?

    
    @IBOutlet weak var writeButton: UIButton!
    @IBOutlet weak var headerPrevBtn: UIButton!//①
    @IBOutlet weak var headerNextBtn: UIButton!//②
    @IBOutlet weak var headerTitle: UILabel!    //③
    @IBOutlet weak var calenderHeaderView: UIView! //④
    @IBOutlet weak var calenderCollectionView: UICollectionView!//⑤

    @IBOutlet var photoImageView: UIImageView! //右下の
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let barHeight = UIApplication.shared.statusBarFrame.size.height
        let width = self.view.frame.width
        let height = self.view.frame.height
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        
        //collectionViewの大きさ
        calenderCollectionView.frame = CGRect(x:0, y:barHeight + 60, width:width, height:height - barHeight - 140)
        calenderCollectionView.register(CalendarCell.self, forCellWithReuseIdentifier: "CalendarCell")// セルの再利用のための設定
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
    //書くボタンの画面遷移
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDiary") {
            let diaryView = segue.destination as! DiaryViewController
            diaryView.date = self.date
        }
        if (segue.identifier == "toSubViewController") {
            let subVC: SubViewController = (segue.destination as? SubViewController)!
            subVC.Img = selectedImage // SubViewController のselectedImgに選択された画像を設定する
            subVC.Comment = selectedComment //値を渡す
        }
    }
    
    //Realmから値を読み込む
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        calenderCollectionView.reloadData()  //今日の画像更新するように追加した
       // DispatchQueue(label: "background").async { //?いる？
          //  let realm = try! Realm()
            
           // realm.objects(Diary.self) Diaryオブジェクト全て読み込み そのあとフィルター
//            if let savedDiary = realm.objects(Diary.self).filter("date == '\(self.date!)'").first { //nilじゃない場合 1日やから.firstでもlastでもいいっぽい
//
//                let photoData = savedDiary.photo
//                //読み込んだ NSData を UIImage へ変換
//                let img: UIImage! = UIImage(data:photoData! as Data)
//                 //imageViewに画像を表示
//                self.photoImageView.image = img
//
//            }
        
//            //るーぷ？
//            let savedDiary = realm.objects(Diary.self)
//            for diary in savedDiary{
//                let photoData = diary.photo
//                //読み込んだ NSData を UIImage へ変換
//                let img: UIImage! = UIImage(data:photoData! as Data)
//                //imageViewに画像を表示
//                self.photoImageView.image = img
//
//
//            }
            
       // }
    }
    
    //①タップ時
    @IBAction func tappedHeaderPrevBtn(sender: UIButton) {
        selectedDate = dateManager.prevMonth(date: selectedDate as Date) as NSDate
        calenderCollectionView.reloadData()
        headerTitle.text = changeHeaderTitle(date: selectedDate)
    }
    //②タップ時

    @IBAction func tappedHeaderNextBtn(sender: UIButton) {
        selectedDate = dateManager.nextMonth(date: selectedDate as Date) as NSDate
        calenderCollectionView.reloadData()
        headerTitle.text = changeHeaderTitle(date: selectedDate)
    }
    //左スワイプで前月を表示
    @IBAction func swipePrevCalendar(_ sender: UISwipeGestureRecognizer) {
        selectedDate = dateManager.prevMonth(date: selectedDate as Date) as NSDate
        calenderCollectionView.reloadData()
        headerTitle.text = changeHeaderTitle(date: selectedDate)
    }
    
    //右スワイプで次月を表示
    @IBAction func swipeNextCalendar(_ sender: UISwipeGestureRecognizer) {
        selectedDate = dateManager.nextMonth(date: selectedDate as Date) as NSDate
        calenderCollectionView.reloadData()
        headerTitle.text = changeHeaderTitle(date: selectedDate)
       
    }
    
    //かくボタン押したとき
    @IBAction func writeButtonPushed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toDiary", sender: nil)
    }

    //1
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    //2 // cellの数を返す関数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Section毎にCellの総数を変える.
        if section == 0 {
            return 7
        } else {
            return dateManager.daysAcquisition()
        }
    }
    
    //3 // cellに情報を入れていく関数
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath as IndexPath) as! CalendarCell //元々書いてたやつ これならテキスト（日付）出せる
        
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
        }
        

        
        let realm = try! Realm()
        let savedDiary = realm.objects(Diary.self)
        
        for diary in savedDiary{
            
            let element = (photo: diary.photo, date: diary.date, context: diary.context ) //タプル
            diarys.append(element as! (photo: NSData, date: String, context: String))
            
            if ("\(changeHeaderTitle(date: selectedDate))/\(dateManager.conversionDateFormat(indexPath: indexPath))") == (element.date) {
                
                print("\(changeHeaderTitle(date: selectedDate))/\(dateManager.conversionDateFormat(indexPath: indexPath))")
                print(element.date)
               // print(element.photo)
                print("日付の一致を発見！")
                
                Path = indexPath.row
                
                print("その日のパス:\(Path)")
                
                print (indexPath.row)
                
                if indexPath.row == Path {
                    //読み込んだ NSData を UIImage へ変換
                    img = UIImage(data: element.photo! as Data)
                    print(img)
                
                    //imageViewに画像を表示
                    cell.imageView.image = img
                    
                    print("indexPath.row:\(indexPath.row)")
                    print("Path:\(Path)")
                    
                    let comment: String! = element.context
                    print("コメント表示:\(String(describing: comment))")
                   
                    return cell // 合致するものがあれば，それ以降の保存データと比べないように *
                }
            }else{
                cell.imageView.image = nil //他の月に画像が表示されないように *
                print("else:\(changeHeaderTitle(date: selectedDate))/\(dateManager.conversionDateFormat(indexPath: indexPath))")
                print("else:\(element.date)")
            }
        }
        
        return cell

    }

    
    // cell選択時に呼ばれる関数 //ログに日付返す
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print("\(dateManager.conversionDateFormat(indexPath: indexPath))") ///日の数字だけ帰ってくる
        print("押された日:\(changeHeaderTitle(date: selectedDate))/\(dateManager.conversionDateFormat(indexPath: indexPath))")
        print("押されたパス\(indexPath.row)")
        
        
        let realm = try! Realm()
        let savedDiary = realm.objects(Diary.self)
        
        for diary in savedDiary{
            
            let element = (photo: diary.photo, date: diary.date, context: diary.context ) //タプル
            diarys.append(element as! (photo: NSData, date: String, context: String))
            
            if ("\(changeHeaderTitle(date: selectedDate))/\(dateManager.conversionDateFormat(indexPath: indexPath))") == (element.date){
                print("選択した日に保存データあり")
                selectedImage = UIImage(data: element.photo! as Data)
                selectedComment = element.context
                
                if selectedImage != nil {
                    print(selectedImage)
                    print(selectedComment)
                    // SubViewController へ遷移するために Segue を呼び出す
                    performSegue(withIdentifier: "toSubViewController",sender: nil)
                }
                
            }else {
                print("データ無い or 不一致")
            }
        }
        
        
        
       
    }
    
    //セルのサイズを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfMargin: CGFloat = 8.0
        let width: CGFloat = (collectionView.frame.size.width - cellMargin * numberOfMargin) / CGFloat(daysPerWeek)
        let height: CGFloat = width * 1.6 //セルの縦幅
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
        formatter.dateFormat = "yyyy/MM"
        
        let selectMonth = formatter.string(from: date as Date)
        
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy/MM/d", options: 0, locale: Locale(identifier: "ja_JP"))
    
        self.date = formatter.string(from: Date())
    
        //print("今日の日付:\(formatter.string(from: Date()))")
        
        //print(selectMonth)
        
        return selectMonth
    }

    
    
}
//黄色いエラーをたくさん直した _抜けてるとか
//書き方の順番
// 変数宣言 @Outlet
//override func viwDidload
//@IBAction
//func

