//
//  StudentDB.swift
//  Tracker
//
//  Created by Carlos Mendez on 12/22/18.
//  Copyright © 2018 Carlos Mendez. All rights reserved.
//

import RealmSwift

class StudentDB: Object {
    @objc dynamic var name :String = ""
    @objc dynamic var photoPath :String = ""
}
