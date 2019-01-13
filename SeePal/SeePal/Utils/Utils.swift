//
//  Utils.swift
//  SeePal
//
//  Created by Gi Soo Hur on 13/01/2019.
//  Copyright © 2019 Gi Soo Hur. All rights reserved.
//

import Foundation

func lock(obj: AnyObject, blk:() -> ()) {
    objc_sync_enter(obj)
    blk()
    objc_sync_exit(obj)
}
