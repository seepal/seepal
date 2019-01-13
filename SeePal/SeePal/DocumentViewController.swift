//
//  DocumentViewController.swift
//  SeePal
//
//  Created by Gi Soo Hur on 20/12/2018.
//  Copyright © 2018 Gi Soo Hur. All rights reserved.
//

import UIKit

class DocumentViewController: UIViewController {
    
    @IBOutlet weak var documentNameLabel: UILabel!
    
    var document: UIDocument?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Access the document
        document?.open(completionHandler: { (success) in
            if success {
                // Display the content of the document, e.g.:
//                self.documentNameLabel.text = self.document?.fileURL.lastPathComponent
                _ = DocumentView(self.document as! Document, self.view)
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
    }
    
    @IBAction func dismissDocumentViewController() {
        dismiss(animated: true) {
            self.document?.close(completionHandler: nil)
        }
    }
}
