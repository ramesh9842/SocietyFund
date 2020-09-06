//
//  Dictionary+Extensions.swift
//  SocietyFund
//
//  Created by sanish on 8/28/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import Foundation

extension Dictionary {
   
    static func += (lhs: inout Dictionary, rhs: Dictionary) {
        lhs.merge(rhs) { (_, new) in new }
    }
    
    func authMessage() -> String? {
        if let theJSONData = try? JSONSerialization.data(withJSONObject: self, options: []),
            let theJSONText = String(data: theJSONData, encoding: String.Encoding.ascii) {
            let message = "fonepay,FONEPAY@RPS,POST,application/json,/reward/rewards,\(theJSONText)"
            return message
        } else {
            return nil
        }
    }
    
    func printAsJSON() {
        if let theJSONData = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted),
            let theJSONText = String(data: theJSONData, encoding: String.Encoding.ascii) {
            print("\(theJSONText)")
        }
    }
    
    mutating func merge(dict: [Key: Value]){
         for (k, v) in dict {
             updateValue(v, forKey: k)
         }
     }
}
