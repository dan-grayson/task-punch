//
//  Task.swift
//  Task Punch Card
//
//  Created by Daniel Grayson on 2/22/16.
//  Copyright © 2016 Daniel Grayson. All rights reserved.
//

import Foundation

struct TimePair {
    var start = NSDate()
    var end: NSDate?
}

struct Task {
    var name: String
    var times: [TimePair]
}