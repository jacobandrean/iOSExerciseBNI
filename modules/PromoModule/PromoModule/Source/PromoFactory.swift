//
//  PromoFactory.swift
//  PromoModule
//
//  Created by J Andrean on 19/06/24.
//

import Foundation
import UIKit

public protocol PromoFactory {
    func createPromoListVC(featureName: String?) -> UIViewController
    func createPromoDetailVC(webViewUrlString: String?) -> UIViewController
}

struct PromoModuleFactory: PromoFactory {
    func createPromoListVC(featureName: String?) -> UIViewController {
        let viewController: UIViewController & PromoListDisplayLogic = PromoListViewController()
        var presenter: PromoListPresentationLogic = PromoListPresenter()
        var interactor: PromoListDataStore & PromoListBusinessLogic = PromoListInteractor()
        viewController.interactor = interactor
        viewController.presenter = presenter
        presenter.viewController = viewController
        interactor.presenter = presenter
        interactor.featureName = featureName
        
        var router: PromoListRouting = PromoListRouter()
        router.baseVC = viewController
        presenter.router = router
        
        return viewController
    }
    
    func createPromoDetailVC(webViewUrlString: String?) -> UIViewController {
        let viewController: UIViewController &  PromoDetailDisplayLogic = PromoDetailViewController()
        var presenter: PromoDetailPresentationLogic = PromoDetailPresenter()
        var interactor: PromoDetailDataStore & PromoDetailBusinessLogic = PromoDetailInteractor()
        viewController.interactor = interactor
        viewController.presenter = presenter
        presenter.viewController = viewController
        interactor.presenter = presenter
        interactor.webViewUrlString = webViewUrlString
        
        return viewController
    }
}
