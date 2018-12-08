//
//  StudentModel.swift
//  Tracker
//
//  Created by Carlos Mendez on 12/7/18.
//  Copyright © 2018 Carlos Mendez. All rights reserved.
//

import UIKit

class StudentModel{
    
    var name :String
    var photo :UIImage?
    
    init?(name: String, photo:UIImage?) {
        
        if(name.isEmpty){
            return nil
        }
        
        self.name = name
        self.photo = photo
        
    }
}
