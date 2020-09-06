//
//  Log.swift
//  SocietyFund
//
//  Created by sanish on 9/2/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import Foundation

struct Log {
    /// Prints in debug only
    static func debug(msg: Any, line: Int = #line, fileName: String = #file, funcName: String = #function) {
        let fname = (fileName as NSString).lastPathComponent
        print("\(fname):\(funcName):\(line)", msg)
    }
    
    /// Prints an error message in debug only
    static func error(msg: Any, line: Int = #line, fileName: String = #file, funcName: String = #function) {
        debug(msg: "ERROR: \(msg)!!", line: line, fileName: fileName, funcName: funcName)
    }
    
    /// Prints the debug mark for the line
    static func mark(line: Int = #line, fileName: String = #file, funcName: String = #function) {
        debug(msg: "called", line: line, fileName: fileName, funcName: funcName)
    }
    
}
