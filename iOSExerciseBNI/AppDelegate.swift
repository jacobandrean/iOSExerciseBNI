//
//  AppDelegate.swift
//  iOSExerciseBNI
//
//  Created by J Andrean on 19/06/24.
//

import InjectorModule
import UIKit
import APIModule
import NetworkModule
import QRISModule
import PromoModule
import PortfolioModule

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        injectDependencies()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    private func injectDependencies() {
        let injector = Injector.shared
        
        injector.register(module: APIModule.Module())
        let bearerToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjc1OTE0MTUwLCJleHAiOjE2Nzg1MDYxNTB9.TcIgL5CDZYg9o8CUsSjUbbUdsYSaLutOWni88ZBs9S8"
        injector.register(
            AppServiceContext(
                urlString: "http://demo5853970.mockable.io",
                defaultHeader: ["Authorization": "Bearer \(bearerToken)"]
            ),
            for: ServiceContext.self
        )
        injector.register(module: QRISModule.Module())
        injector.register(module: PromoModule.Module())
        injector.register(module: PortfolioModule.Module())
    }
}

