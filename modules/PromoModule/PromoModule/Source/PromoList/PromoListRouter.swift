//
//  PromoListRouter.swift
//  PromoModule
//
//  Created by J Andrean on 19/06/24.
//

import Foundation
import InjectorModule
import UIKit
import UtilityModule

protocol PromoListRouting: Routing {
    func navigateToPromoDetail(webViewUrlString: String?)
}

class PromoListRouter: PromoListRouting {
    var baseVC: UIViewController?
    
    @Inject var promoFactory: PromoFactory
    
    func navigateToPromoDetail(webViewUrlString: String?) {
        let viewController = promoFactory.createPromoDetailVC(webViewUrlString: webViewUrlString)
        try? route(.push(animated: true), for: viewController)
    }
}
