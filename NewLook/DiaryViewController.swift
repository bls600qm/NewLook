//
//  DiaryViewController.swift
//  NewLook
//
//  Created by Rika Sumitomo on 2019/04/29.
//  Copyright © 2019 Rika Sumitomo. All rights reserved.
//

import UIKit

class DiaryViewController: UIViewController {

    var date: String!
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var contextTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    }


}
