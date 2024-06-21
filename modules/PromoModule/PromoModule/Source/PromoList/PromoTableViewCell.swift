//
//  PromoTableViewCell.swift
//  PromoModule
//
//  Created by J Andrean on 20/06/24.
//

import Foundation
import UIKit
import UIModule

class PromoTableViewCell: UITableViewCell {
    static let reuseIdentifier = "PromoTableViewCell"
    
    private let promoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let promoNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(urlString: String, name: String) {
        promoImageView.loadImage(from: urlString, placeholder: UIImage(systemName: "xmark"))
        promoNameLabel.text = name
    }
    
    private func setupViews() {
        contentView.addSubview(promoImageView)
        contentView.addSubview(promoNameLabel)
        
        NSLayoutConstraint.activate {
            promoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
            promoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            promoImageView.heightAnchor.constraint(equalToConstant: 40)
            promoImageView.widthAnchor.constraint(equalToConstant: 40)
            promoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16)
            promoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            
            promoNameLabel.leadingAnchor.constraint(equalTo: promoImageView.trailingAnchor, constant: 8)
            promoNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
            promoNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        }
    }
}
