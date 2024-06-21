//
//  PromoListPresenter.swift
//  PromoModule
//
//  Created by J Andrean on 19/06/24.
//

import Combine
import Foundation

protocol PromoListPresentationLogic {
    var viewController: PromoListDisplayLogic? { get set }
    var router: PromoListRouting? { get set }
    
    func presentPromos(_ promos: [Promo])
    func didSelect(index: Int)
    func presentFeatureName(name: String)
}

class PromoListPresenter: PromoListPresentationLogic {
    weak var viewController: PromoListDisplayLogic?
    var router: PromoListRouting?
    private var promos: [Promo] = []
    private var cancellables = Set<AnyCancellable>()
    
    func presentPromos(_ promos: [Promo]) {
        self.promos = promos
        viewController?.displayPromos(promos)
    }
    
    func didSelect(index: Int) {
        let detailUrlString = promos[index].detailUrlString
        router?.navigateToPromoDetail(webViewUrlString: detailUrlString)
    }
    
    func presentFeatureName(name: String) {
        viewController?.displayTitle(title: name)
    }
}
