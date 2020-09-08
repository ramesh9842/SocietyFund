//
//  MenuViewModel.swift
//  SocietyFund
//
//  Created by sanish on 9/1/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import Foundation

protocol HomeViewDelegate: class {
    func onSuccess(_ projects: [CategoricalProject])
    func onFailure(msg: String)
}

class HomeViewModel {
    var delegate: HomeViewDelegate?
    func setUpView() {
        APIService.shared.request("https://run.mocky.io/v3/460fd42e-b27e-4719-a41d-3714d1d1f847", method: .GET, params: nil) { (result: Result<HomeModel,APIError>) in
            switch result {
            case .success(let homeModel):
                self.setProjects(model: homeModel)
            case .failure(let error):
                self.delegate?.onFailure(msg: error.rawValue)
            }
        }
    }
    
    func setProjects(model: HomeModel)  {
        ModelManager().getAllProjects(homeModel: model) { [weak self](projects) in
            if projects != nil {
                self?.delegate?.onSuccess(projects!)
            }else {
                self?.delegate?.onFailure(msg: "No Projects to show!!!")
            }
        }
    }
    
}
