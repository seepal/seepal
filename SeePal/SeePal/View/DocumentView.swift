//
//  DocumentView.swift
//  SeePal
//
//  Created by Gi Soo Hur on 12/01/2019.
//  Copyright © 2019 Gi Soo Hur. All rights reserved.
//

import UIKit

class DocumentView: UIScrollView {
    weak var doc:Document!
    var containView = UIView()
    var containBounds:CGRect {
        get {
            return self.bounds.applying(self.containView.transform.inverted())
        }
    }
    
    init(_ doc: Document, _ superView:UIView) {
        super.init(frame: superView.bounds)
        self.doc = doc
        
        delegate = self
        maximumZoomScale = 32.0
        translatesAutoresizingMaskIntoConstraints = false
        isPagingEnabled = false
        
        let w = self.bounds.size.width
        let h = self.bounds.size.height
        let c = CGFloat(doc.count)
        
        containView.autoresizingMask = [.flexibleBottomMargin, .flexibleLeftMargin, .flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleRightMargin]
        
        if doc.isHorizontalScroll {
            containView.frame = CGRect(x: 0, y: 0, width: w*c, height: h)
            for i in 0..<doc.count {
                let page = doc.pages[i]
                page.frame = CGRect(x: CGFloat(i)*w, y: 0, width: w, height: h)
            }
        } else {
            containView.frame = CGRect(x: 0, y: 0, width: w, height: h*c)
            for i in 0..<doc.count {
                let page = doc.pages[i]
                page.frame = CGRect(x: 0, y: CGFloat(i)*h, width: w, height: h)
            }
        }
        
        addSubview(containView)
        
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

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutPageviews()
    }
    
    func currentPages() -> [Page]? {
        let b = containBounds
        var pages:[Page]?
        for page in doc.pages {
            if b.intersects(page.frame) {
                if pages == nil {
                    pages = []
                }
                pages?.append(page)
            }
        }
        return pages
    }
    
    func layoutPageviews() {
        guard let pages = currentPages() else {
            return
        }

        let pvs = containView.subviews.filter({ (v) -> Bool in
            let ps = pages.filter({ (page) -> Bool in
                return page.no == v.tag
            })
            return ps.count > 0
        })

        for page in pages {
            var pv = pvs.filter({ (v) -> Bool in
                return v.tag == page.no
            }).last as? PageView
            
            if pv == nil {
                pv = PageView(page, containView)
            }
            pv?.display()
        }
    }
    
    func center() {
        let w = self.frame.size.width
        let h = self.frame.size.height
        let size = self.containView.frame.size

        if doc.isHorizontalScroll {
            let edge = (h-size.height)/2.0
            let insets = UIEdgeInsets(top: edge, left: 0, bottom: edge, right: 0)
            contentInset = insets
        } else {
            let edge = (w-size.width)/2.0
            let insets = UIEdgeInsets(top: 0, left: edge, bottom: 0, right: edge)
            contentInset = insets
        }
//        print(size)
    }
}


extension DocumentView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return containView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        center()
    }
}
