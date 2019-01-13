//
//  PageData.swift
//  SeePal
//
//  Created by Gi Soo Hur on 12/01/2019.
//  Copyright © 2019 Gi Soo Hur. All rights reserved.
//

import Foundation

class PageData {
    var entry:AnyObject!
    weak var archive:AnyObject!

    init(_ entry:AnyObject, _ archive:AnyObject) {
        self.entry = entry
        self.archive = archive
    }

    func binary() -> Data? { return nil }
}

import ZIPFoundation

class CompressedPageData : PageData {
    override func binary() -> Data? {
        let a = archive as! Archive
        let e = entry as! Entry
        var ret:Data = Data()
        lock(obj: a) {
            do {
                _ = try a.extract(e, consumer: { (data) in
                    ret.append(data)
                })
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return ret.count == 0 ? nil : ret
    }
}
