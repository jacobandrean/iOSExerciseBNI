//
//  ViewController.swift
//  iOSExerciseBNI
//
//  Created by J Andrean on 19/06/24.
//

import InjectorModule
import UIKit
import UIModule
import QRISModule
import PromoModule
import PortfolioModule

class ViewController: UIViewController {
    
    enum Feature: CaseIterable {
        case qris, promo, portfolio, pushNotif
        
        var name: String {
            switch self {
            case .qris: return "Aplikasi Mobile App Pembayaran QRIS"
            case .promo: return "Aplikasi Mobile App Promo"
            case .portfolio: return "Aplikasi Mobile App Portfolio"
            case .pushNotif: return "Aplikasi Mobile PUSH Notif"
            }
        }
    }
    
    @Inject var qrisFactory: QRISFactory
    @Inject var promoFactory: PromoFactory
    @Inject var portfolioFactory: PortfolioFactory
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(stackView)
        setupConstraints()
        setupButtons()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate {
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        }
    }
    
    private func setupButtons() {
        let features = Feature.allCases
        for feature in features {
            let button = UIButton(type: .system)
            button.setTitle(feature.name, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .blue
            button.layer.cornerRadius = 8
            setupButtonTarget(for: feature, button: button)
            stackView.addArrangedSubview(button)
        }
    }
    
    private func setupButtonTarget(for feature: Feature, button: UIButton) {
        let viewController: UIViewController
        switch feature {
        case .qris:
            viewController = qrisFactory.createQRISLandingVC(featureName: feature.name)
        case .promo:
            viewController = promoFactory.createPromoListVC(featureName: feature.name)
        case .portfolio:
            viewController = portfolioFactory.createPortfolioVC()
        case .pushNotif:
            viewController = UIViewController()
            viewController.view.backgroundColor = .white
        }
        button.addAction { [weak self] in
            guard let self else { return }
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

