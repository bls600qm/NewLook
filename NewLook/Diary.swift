//
//  Diary.swift
//  NewLook
//
//  Created by Rika Sumitomo on 2019/04/29.
//Copyright © 2019 Rika Sumitomo. All rights reserved.
//

import Foundation
import RealmSwift

class Diary: Object {
    
    dynamic var date = ""
    dynamic var context = ""
    dynamic var photo: NSData? = nil
    
    override static func primaryKey() -> String? {
        return "date"
    }
    
}
