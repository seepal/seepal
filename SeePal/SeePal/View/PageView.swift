//
//  PageView.swift
//  SeePal
//
//  Created by Gi Soo Hur on 12/01/2019.
//  Copyright © 2019 Gi Soo Hur. All rights reserved.
//

import UIKit
import UIImageViewAlignedSwift

class PageView: UIImageViewAligned {

    weak var page:Page!
    
    init(_ page:Page, _ superView:UIView) {
        super.init(frame: page.frame)
        self.page = page
        self.tag = page.no
        
        superView.addSubview(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    private var importing = false
    
    func display() {
        guard let cv = self.superview else {
            return
        }
        guard let sv = self.superview?.superview else {
            return
        }
        let b = sv.bounds.applying(cv.transform.inverted())
//        print("\(self.frame) \(b)")
        if b.intersects(self.frame) == false {
            return
        }
        if image == nil && importing == false {
            importing = true
            DispatchQueue.global(qos: .background).async {
                let img = self.page.image
                DispatchQueue.main.sync {
                    self.importing = false
                    let b = sv.bounds.applying(cv.transform.inverted())
                    if b.intersects(self.frame) {
                        self.image = img
                        print("set image = %x", img as Any)
                    } else {
                        self.image = nil
                        print("clear image by display")
                    }
                }
            }
        }
    }
}
