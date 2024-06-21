//
//  Module.swift
//  PromoModule
//
//  Created by J Andrean on 19/06/24.
//

import Foundation
import InjectorModule

public struct Module: InjectorModule.Module {
    public init() {}
    
    public func register(for injector: Injector) {
        injector.register(PromoModuleFactory(), for: PromoFactory.self)
    }
}
