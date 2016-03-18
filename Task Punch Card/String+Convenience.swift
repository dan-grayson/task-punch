//
//  String+Convenience.swift
//  Task Punch Card
//
//  Created by Daniel Grayson on 3/18/16.
//  Copyright © 2016 Daniel Grayson. All rights reserved.
//

import Foundation

extension String {
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
    func length()-> Int {
        return self.characters.count
    }
}