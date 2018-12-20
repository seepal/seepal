//
//  Document.swift
//  SeePal
//
//  Created by Gi Soo Hur on 20/12/2018.
//  Copyright © 2018 Gi Soo Hur. All rights reserved.
//

import UIKit

class Document: UIDocument {
    
    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        return Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        // Load your document from contents
    }
}

