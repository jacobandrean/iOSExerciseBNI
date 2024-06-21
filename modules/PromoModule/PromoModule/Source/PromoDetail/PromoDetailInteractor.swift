//
//  PromoDetailInteractor.swift
//  PromoModule
//
//  Created by J Andrean on 20/06/24.
//

import APIModule
import Combine
import Foundation
import InjectorModule

protocol PromoDetailDataStore {
    var webViewUrlString: String? { get set }
}

protocol PromoDetailBusinessLogic {
    var presenter: PromoDetailPresentationLogic! { get set }
    
    func getWebViewUrlString()
}

class PromoDetailInteractor: PromoDetailBusinessLogic, PromoDetailDataStore {
    var presenter: PromoDetailPresentationLogic!
    var webViewUrlString: String?
    private var cancellables = Set<AnyCancellable>()
    
    func getWebViewUrlString() {
        guard let webViewUrlString else { return }
        presenter.presentWebView(with: webViewUrlString)
    }
}
