//
//  DiaryViewController.swift
//  NewLook
//
//  Created by Rika Sumitomo on 2019/04/29.
//  Copyright © 2019 Rika Sumitomo. All rights reserved.
//

import UIKit
import RealmSwift

class DiaryViewController: UIViewController {

    var date: String!
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var contextTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        dateLabel.text = date
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonPushed(_ sender: UIButton) {
        
        // STEP.1 Realmを初期化
        let realm = try! Realm()
        
        //STEP.2 保存する要素を書く
        let diary = Diary()
        diary.date = date
        diary.context = contextTextField.text!
        
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
    
}
