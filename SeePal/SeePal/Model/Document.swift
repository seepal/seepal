//
//  UIDocumentBase.swift
//  SeePal
//
//  Created by Gi Soo Hur on 20/12/2018.
//  Copyright © 2018 Gi Soo Hur. All rights reserved.
//

import UIKit

class Document: UIDocument {
    public var isHorizontalScroll: Bool = false

    var count:Int {
        get {
            return pages.count
        }
    }
    var pages:Array<Page> = []
    
    public enum ContentType {
        case image
        case movie
        case audio
        case unknown
    }
    
    static let extToContentTypes = [ "gif" : ContentType.image, "jpg" : ContentType.image, "jpeg" : ContentType.image, "png" : ContentType.image, "tiff" : ContentType.image, "tif" : ContentType.image,
                       "mov" : ContentType.movie, "avi" : ContentType.movie, "mpg" : ContentType.movie, "mpeg" : ContentType.movie, "mp4" : ContentType.movie, "mpg4" : ContentType.movie, "m4v" : ContentType.movie, "mp4v" : ContentType.movie, "3gp" : ContentType.movie, "3gpp" : ContentType.movie, "3g2" : ContentType.movie, "3gp2" : ContentType.movie , "rm" : ContentType.movie , "wmp" : ContentType.movie , "wmv" : ContentType.movie , "wm" : ContentType.movie ,
                       "mp3" : ContentType.audio, "m4a" : ContentType.audio, "m4p" : ContentType.audio, "m4b" : ContentType.audio, "au" : ContentType.audio, "ulw" : ContentType.audio, "aiff" : ContentType.audio, "aif" : ContentType.audio, "aifc" : ContentType.audio, "caff" : ContentType.audio, "caf" : ContentType.audio, "wav" : ContentType.audio, "asf" : ContentType.audio, "wma" : ContentType.audio, "asx" : ContentType.audio, "wmx" : ContentType.audio, "wvx" : ContentType.audio, "wax" : ContentType.audio,  "sd2" : ContentType.audio, "ram" : ContentType.audio ]
    
    func contentType(_ url:URL) -> ContentType {
        return contentType(url.path)
    }
    func contentType(_ path:String?) -> ContentType {
        if path?.range(of: "__MACOSX") != nil {
           return .unknown
        }
        guard let ext = path?.split(separator: ".").last?.lowercased() else {
            return .unknown
        }
        guard let type = Document.extToContentTypes[ext] else {
            return .unknown
        }
        return type
    }
    
    func sortPages() {
        pages.sort { (l, r) -> Bool in
            let le = l
            let re = r
            return le.path.compare(re.path, options: .numeric, range: nil, locale: nil) == .orderedAscending
        }
        var no = 1
        pages.forEach { (page) in
            page.no = no
            no += 1
        }
    }
    
    override func open(completionHandler: ((Bool) -> Void)? = nil) {
        let success = loadPages()
        if success == false {
            completionHandler?(false)
            return
        }
        sortPages()
        completionHandler?(true)
    }

    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        return Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        // Load your document from contents
    }
    
    func loadPages() -> Bool {
        return false
    }
}

