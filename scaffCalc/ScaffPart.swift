//
//  ScaffPart.swift
//  scaffCalc
//
//  Created by Alessio on 2020-03-12.
//  Copyright © 2020 Alessio. All rights reserved.
//

import Foundation
class ScaffPart{
    
    var title:String
    var image:String
    var qty:Int
    
    init(title:String = "", image:String = "", qty:Int = 0) {
        self.title = title
        self.image = image
        self.qty = qty
    }
}
