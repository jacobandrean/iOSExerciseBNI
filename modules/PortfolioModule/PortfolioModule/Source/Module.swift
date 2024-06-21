//
//  Module.swift
//  PortfolioModule
//
//  Created by J Andrean on 20/06/24.
//

import Foundation
import InjectorModule

public struct Module: InjectorModule.Module {
    public init() {}
    
    public func register(for injector: Injector) {
        injector.register(PortfolioModuleFactory(), for: PortfolioFactory.self)
    }
}
