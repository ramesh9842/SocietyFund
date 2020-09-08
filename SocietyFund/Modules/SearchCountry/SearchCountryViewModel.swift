//
//  SearchCountryViewModel.swift
//  SocietyFund
//
//  Created by sanish on 9/7/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import Foundation


class SearchCountryViewModel {
    
    func getDialCode(completion: ([CountryCode]) -> Void) {
        if let path = Bundle.main.url(forResource: "CountryCode", withExtension: "json") {
            print(path)
            do {
                let data = try Data(contentsOf: path, options: .mappedIfSafe)
                print(data)
                let jsonResult = try JSONDecoder().decode([CountryCode].self, from: data)
                completion(jsonResult)
            } catch {
                Log.debug(msg: error)
            }
        }else {
            print("path nil")
        }
    }
    
}
