//
//  PortfolioFactory.swift
//  PortfolioModule
//
//  Created by J Andrean on 20/06/24.
//

import Foundation
import UIKit

public protocol PortfolioFactory {
    func createPortfolioVC() -> UIViewController
}

struct PortfolioModuleFactory: PortfolioFactory {
    func createPortfolioVC() -> UIViewController {
        return PortfolioViewController()
    }
    
    
}
