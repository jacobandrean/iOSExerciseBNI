//
//  PromoListViewController.swift
//  PromoModule
//
//  Created by J Andrean on 19/06/24.
//

import UIKit
import UIModule

protocol PromoListDisplayLogic: AnyObject {
    var interactor: PromoListBusinessLogic! { get set }
    var presenter: PromoListPresentationLogic! { get set }
    
    func displayPromos(_ promos: [Promo])
    func displayTitle(title: String)
}

class PromoListViewController: BaseVC {
    enum Section: Hashable {
        case one
    }
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PromoTableViewCell.self, forCellReuseIdentifier: PromoTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    var interactor: PromoListBusinessLogic!
    var presenter: PromoListPresentationLogic!
    
    private lazy var dataSource: UITableViewDiffableDataSource<Section, Promo> = {
        let dataSource = UITableViewDiffableDataSource<Section, Promo>(tableView: tableView) { [weak self] tableView, indexPath, item in
            guard let self, let cell = tableView.dequeueReusableCell(withIdentifier: PromoTableViewCell.reuseIdentifier) as? PromoTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(urlString: item.imageUrlString, name: item.name)
            return cell
        }
        return dataSource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.getPromos()
        interactor.getFeatureName()
        setupViews()
    }
    
    private func setupViews() {
        tableView.delegate = self
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate {
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            tableView.topAnchor.constraint(equalTo: view.topAnchor)
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        }
    }
    
    private func setupDataSourceSnapshot(with promos: [Promo]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Promo>()
        snapshot.appendSections([.one])
        snapshot.appendItems(promos, toSection: .one)
        DispatchQueue.main.async { [weak self] in
            self?.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
}

extension PromoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelect(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension PromoListViewController: PromoListDisplayLogic {
    func displayPromos(_ promos: [Promo]) {
        setupDataSourceSnapshot(with: promos)
    }
    
    func displayTitle(title: String) {
        self.title = title
    }
}
