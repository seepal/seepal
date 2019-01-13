//
//  DocumentEntriesFactory.swift
//  SeePal
//
//  Created by Gi Soo Hur on 21/12/2018.
//  Copyright © 2018 Gi Soo Hur. All rights reserved.
//

import Foundation

class DocumentFactory {
    
    public enum DocumentType {
        case compressed
        case pdf
        case media
    }

    static let extToTypes = [ "zip" : DocumentType.compressed, "cbz" : DocumentType.compressed ]

    class func create(_ url:URL) -> Document? {
        let ext = url.pathExtension.lowercased()
        guard let type = extToTypes[ext] else {
            return nil
        }
        
        switch type {
        case .compressed:
            return CompressedDocument(fileURL: url)
        default:
            break
        }
        return nil
    }
}
