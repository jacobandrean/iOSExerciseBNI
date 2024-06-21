//
//  PromoListPresenterTests.swift
//  PromoModuleTests
//
//  Created by J Andrean on 21/06/24.
//

import XCTest
import InjectorModule
@testable import APIModule
@testable import PromoModule

final class PromoListPresenterTests: XCTestCase {
    var sut: PromoListPresenter!
    
    override func setUp() {
        super.setUp()
        injectDependencies()
        sut = PromoListPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func injectDependencies() {
        let injector = Injector.shared
        injector.register(module: APIModule.Module())
        injector.register(module: PromoModule.Module())
    }
    
    func test_presentPromos() {
        let expectation = XCTestExpectation(description: "waiting for calling of target method")
        let viewControllerSpy = PromoListViewControllerSpy(expectation: expectation)
        sut.viewController = viewControllerSpy
        sut.presentPromos([.init(id: 0, name: "stub name", imageUrlString: "stub imageUrlString", detailUrlString: "stub detailUrlString")])
    
        wait(for: [expectation], timeout: 0.1)
        XCTAssertTrue(viewControllerSpy.displayPromosCalled)
    }
    
    func test_didSelect() {
        let expectation = XCTestExpectation(description: "waiting for calling of target method")
        let routerSpy = PromoListRouterSpy(expectation: expectation)
        sut.router = routerSpy
        sut.presentPromos([.init(id: 0, name: "stub name", imageUrlString: "stub imageUrlString", detailUrlString: "stub detailUrlString")])
        sut.didSelect(index: 0)
    
        wait(for: [expectation], timeout: 0.1)
        XCTAssertTrue(routerSpy.navigateToPromoDetailCalled)
    }
    
    func test_presentFeatureName() {
        let expectation = XCTestExpectation(description: "waiting for calling of target method")
        let viewControllerSpy = PromoListViewControllerSpy(expectation: expectation)
        sut.viewController = viewControllerSpy
        sut.presentFeatureName(name: "stub featureName")
    
        wait(for: [expectation], timeout: 0.1)
        XCTAssertTrue(viewControllerSpy.displayTitleCalled)
    }
}

extension PromoListPresenterTests {
    // MARK: - PromoListRouterSpy
    class PromoListRouterSpy: PromoListRouting {
        var baseVC: UIViewController?
        var expectation: XCTestExpectation
        var navigateToPromoDetailCalled = false
        
        init(expectation: XCTestExpectation) {
            self.expectation = expectation
        }
        
        func navigateToPromoDetail(webViewUrlString: String?) {
            navigateToPromoDetailCalled = true
            expectation.fulfill()
        }
    }
    
    // MARK: - PromoListViewControllerSpy
    class PromoListViewControllerSpy: PromoListDisplayLogic {
        var interactor: PromoListBusinessLogic!
        var presenter: PromoListPresentationLogic!
        var expectation: XCTestExpectation
        var displayPromosCalled = false
        var displayTitleCalled = false
        
        init(expectation: XCTestExpectation) {
            self.interactor = PromoListInteractor()
            self.presenter = PromoListPresenter()
            self.expectation = expectation
        }
        
        func displayPromos(_ promos: [Promo]) {
            displayPromosCalled = true
            expectation.fulfill()
        }
        
        func displayTitle(title: String) {
            displayTitleCalled = true
            expectation.fulfill()
        }
    }
}
