//
//  ModelManager.swift
//  SocietyFund
//
//  Created by sanish on 9/3/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import Foundation

struct TestModel {
    var title: String?
    var url: String?
    var category: String?
    var views: Int?
}

class ModelManager {
    
    func transform(jsonObject: Any) -> TestModel {
        let jsonObjects = jsonObject as? Dictionary<String, Any>
        let title = jsonObjects?["title"] as? String
        let url = jsonObjects?["url"] as? String
        let category = jsonObjects?["category"] as? String
        let views = jsonObjects?["views"] as? Int
        return TestModel(title: title, url: url, category: category, views: views)
    }
    
}
