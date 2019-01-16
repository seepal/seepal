//
//  PDFPageData.swift
//  SeePal
//
//  Created by Gi Soo Hur on 16/01/2019.
//  Copyright © 2019 Gi Soo Hur. All rights reserved.
//

import UIKit
import CoreGraphics.CGPDFDocument

class PDFPageData : PageData {
    override func binary() -> Data? {
        let a = archive as! CGPDFDocument
        let e = entry as! CGPDFPage
        var ret:Data?
        lock(obj: a) {
            let s = UIScreen.main.scale
            let orgRect = e.getBoxRect(CGPDFBox.cropBox)
            var rect = orgRect
            rect.size.width *= s
            rect.size.height *= s
            let size = rect.size

            UIGraphicsBeginImageContext(size)
            guard let context = UIGraphicsGetCurrentContext() else {
                return
            }
            
            context.saveGState()

            let rotate = e.rotationAngle
            let transform = e.getDrawingTransform(CGPDFBox.cropBox, rect: orgRect, rotate: rotate, preserveAspectRatio: true)
            context.concatenate(transform)
            context.translateBy(x: 0, y: size.height)
            context.scaleBy(x: CGFloat(s), y: CGFloat(-s))
            context.drawPDFPage(e)
            
            context.restoreGState()
            
            guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
                UIGraphicsEndImageContext()
                return
            }
            ret = image.pngData()
            UIGraphicsEndImageContext()
        }
        return ret
    }
}
