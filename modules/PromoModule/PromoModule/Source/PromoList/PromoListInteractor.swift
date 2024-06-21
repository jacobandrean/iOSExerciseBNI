//
//  PromoListInteractor.swift
//  PromoModule
//
//  Created by J Andrean on 19/06/24.
//

import APIModule
import Combine
import Foundation
import InjectorModule

protocol PromoListDataStore {
    var featureName: String? { get set }
}

protocol PromoListBusinessLogic {
    var presenter: PromoListPresentationLogic! { get set }
    func getPromos()
    func getFeatureName()
}

class PromoListInteractor: PromoListBusinessLogic, PromoListDataStore {
    var presenter: PromoListPresentationLogic!
    var featureName: String?
    private var cancellables = Set<AnyCancellable>()
    @Inject var promoService: PromoService
    
    func getPromos() {
        promoService.getPromos()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] response in
                    guard let self else { return }
                    let promos: [Promo] = response.promos.map {
                        return .init(
                            id: $0.id ?? 0,
                            name: $0.name ?? "",
                            imageUrlString: $0.imageUrlString ?? "",
                            detailUrlString: $0.detailUrlString ?? ""
                        )
                    }
                    presenter.presentPromos(promos)
                }
            )
            .store(in: &cancellables)
    }
    
    func getFeatureName() {
        guard let featureName else { return }
        presenter.presentFeatureName(name: featureName)
    }
}
