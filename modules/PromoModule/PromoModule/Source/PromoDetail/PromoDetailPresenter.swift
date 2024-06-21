//
//  PromoDetailPresenter.swift
//  PromoModule
//
//  Created by J Andrean on 20/06/24.
//

import Combine
import Foundation

protocol PromoDetailPresentationLogic {
    var viewController: PromoDetailDisplayLogic? { get set }
    
    func presentWebView(with urlString: String)
}

class PromoDetailPresenter: PromoDetailPresentationLogic {
    weak var viewController: PromoDetailDisplayLogic?
    private var cancellables = Set<AnyCancellable>()

    func presentWebView(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        viewController?.displayWebView(request: request)
    }
}
