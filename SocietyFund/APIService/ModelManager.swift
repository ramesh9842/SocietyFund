//
//  ModelManager.swift
//  SocietyFund
//
//  Created by sanish on 9/3/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import Foundation

class ModelManager {
    
    var categoryNames = [String]()
    var allProjects = [CategoricalProject]()
    
    func getProfileData(model: SignInResponse) -> ProfileModel? {
        if let data = model.data {
            let firstname = data.firstname!
            let lastname = data.lastname!
            let name = "\(String(describing: firstname)) \(String(describing: lastname))"
            let picture = data.imgUrl!
            let email = data.email!
            let phone = data.phone!
            let profile = ProfileModel(name: name, firstName: firstname, lastName: lastname, picture: picture, email: email, phone: phone)
            return profile
        }
        return nil
    }
    
    func getCategories(homeModel: HomeModel) -> [String]? {
        if let data = homeModel.data {
            for count in 0..<data.count{
                if let categoryName = data[count].category{
                    categoryNames.append(categoryName)
                }
            }
            return categoryNames
        }else {
            Log.debug(msg: "data is nil")
        }
        return nil
    }
    
    func getAllProjects(homeModel: HomeModel, completion: @escaping (([CategoricalProject]?) -> Void)) {
        if let data = homeModel.data {
            for count in 0..<data.count {
                if let projects = data[count].projects {
                    for project in projects {
                        allProjects.append(project)
                    }
                    completion(allProjects)
                }
            }
        }else {
            completion(nil)
        }
    }
    
}
