//
//  PDFDocument.swift
//  SeePal
//
//  Created by Gi Soo Hur on 16/01/2019.
//  Copyright © 2019 Gi Soo Hur. All rights reserved.
//

import Foundation
import CoreGraphics.CGPDFDocument

class PDFDocument : Document {
    var archive:CGPDFDocument?
    
    override func loadPages() -> Bool {
        if archive != nil {
            return false
        }
        
        guard let a = CGPDFDocument(fileURL as CFURL) else {
            return false
        }
        archive = a
        let c = a.numberOfPages
        for no in 1...c {
            let ent = a.page(at: no)
            let data = PDFPageData(ent as AnyObject, a as AnyObject)
            pages.append(Page(data, "\(no)", .image, no))
        }
        
        return true
    }
}
