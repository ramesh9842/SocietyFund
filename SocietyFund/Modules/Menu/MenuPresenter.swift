//
//  MenuPresenter.swift
//  SocietyFund
//
//  Created by sanish on 9/1/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import Foundation

protocol MenuPresenterProtocol {
    var interactor: MenuInteractorProtocol? { get set}
    var router: MenuRouterProtocol? { get set}
    var view: MenuViewProtocol? { get set}
    func viewDidLoad()
    
}

class MenuPresenter {
    var interactor: MenuInteractorProtocol?
    var router: MenuRouterProtocol?
    var view: MenuViewProtocol?
}

extension MenuPresenter: MenuPresenterProtocol {
    func viewDidLoad() {
    
    }
}
