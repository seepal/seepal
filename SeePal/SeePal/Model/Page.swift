//
//  Page.swift
//  SeePal
//
//  Created by Gi Soo Hur on 12/01/2019.
//  Copyright © 2019 Gi Soo Hur. All rights reserved.
//

import UIKit

class Page {
    let data:PageData
    let type:Document.ContentType
    let path:String
    var no:Int
    var frame:CGRect = CGRect.zero
    var image:UIImage? {
        get {
            guard let d = data.binary() else {
                return nil
            }
            return UIImage(data: d)
        }
    }
    
    init(_ data:PageData, _ path:String, _ type:Document.ContentType, _ no:Int) {
        self.data = data
        self.path = path
        self.type = type
        self.no = no
    }
}
