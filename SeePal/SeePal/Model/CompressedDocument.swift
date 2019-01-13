//
//  CompressedDocument.swift
//  SeePal
//
//  Created by Gi Soo Hur on 12/01/2019.
//  Copyright © 2019 Gi Soo Hur. All rights reserved.
//

import UIKit
import ZIPFoundation

class CompressedDocument : Document {
    var archive:Archive?

    override func loadPages() -> Bool {
        if archive != nil {
            return false
        }
        
        guard let a = Archive(url: fileURL, accessMode: .read) else {
            return false
        }
        archive = a
        let it = a.makeIterator()
        var entry = it.next()
        var no = 0
        repeat {
            guard let ent = entry else {
                continue
            }
            if ent.type == .file {
                let type = contentType(ent.path)
                switch type {
                case .unknown:
                    break
                default:
                    no += 1
                    let data = CompressedPageData(ent as AnyObject, a as AnyObject)
                    pages.append(Page(data, ent.path, type, no))
                }
            }
            entry = it.next()
        } while (entry != nil)
        
        return true
    }
}
