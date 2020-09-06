//
//  MenuRouter.swift
//  SocietyFund
//
//  Created by sanish on 9/1/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import UIKit

protocol MenuRouterProtocol {
    
}

class MenuRouter {
    var _viewControler: MenuViewController?
    func buildModule() -> MenuViewController {
        _viewControler = UIStoryboard(name: "Menu", bundle: nil).instantiateViewController(ofType: MenuViewController.self)
        var presenter: MenuPresenterProtocol = MenuPresenter()
        let router: MenuRouterProtocol = self
        let interactor: MenuInteractorProtocol = MenuInteractor()
        _viewControler?.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = _viewControler
        return _viewControler!
    }
}

extension MenuRouter: MenuRouterProtocol {
    
}
