//
//  PromoListInteractorTests.swift
//  PromoModuleTests
//
//  Created by J Andrean on 21/06/24.
//

import XCTest
import Combine
import InjectorModule
@testable import APIModule
@testable import PromoModule

final class PromoListInteractorTests: XCTestCase {
    var sut: PromoListInteractor!
    
    override func setUp() {
        super.setUp()
        injectDependencies()
        sut = PromoListInteractor()
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

    func test_getPromos_success() {
        let expectation = XCTestExpectation(description: "waiting for calling of target method")
        let presenterSpy = PromoListPresenterSpy(expectation: expectation)
        let serviceStub = PromoServiceStub(.success)
        
        sut.presenter = presenterSpy
        sut.promoService = serviceStub
        sut.getPromos()
        
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(presenterSpy.presentPromosCalled)
    }
    
    func test_getPromos_successNilData() {
        let expectation = XCTestExpectation(description: "waiting for calling of target method")
        let presenterSpy = PromoListPresenterSpy(expectation: expectation)
        let serviceStub = PromoServiceStub(.successNilData)
        
        sut.presenter = presenterSpy
        sut.promoService = serviceStub
        sut.getPromos()
        
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(presenterSpy.presentPromosCalled)
        XCTAssertTrue(serviceStub.isNilData)
    }
    
    func test_getPromos_error() {
        let expectation = XCTestExpectation(description: "waiting for calling of target method")
        let presenterSpy = PromoListPresenterSpy(expectation: expectation)
        let serviceStub = PromoServiceStub(.error)
        
        sut.presenter = presenterSpy
        sut.promoService = serviceStub
        sut.getPromos()
        
        let result = XCTWaiter().wait(for: [expectation], timeout: 1)
        XCTAssertEqual(result, .timedOut, "Expected operation to not complete")
    }
    
    func test_getFeatureName_nilFeatureName() {
        let expectation = XCTestExpectation(description: "waiting for calling of target method")
        let presenterSpy = PromoListPresenterSpy(expectation: expectation)
        
        sut.presenter = presenterSpy
        sut.getFeatureName()
        let result = XCTWaiter().wait(for: [expectation], timeout: 0.1)
        XCTAssertEqual(result, .timedOut, "Expected operation to not complete")
    }
    
    func test_getFeatureName_hasFeatureName() {
        let expectation = XCTestExpectation(description: "waiting for calling of target method")
        let presenterSpy = PromoListPresenterSpy(expectation: expectation)
        
        sut.presenter = presenterSpy
        sut.featureName = "stub featureName"
        sut.getFeatureName()
        wait(for: [expectation], timeout: 0.1)
        XCTAssertTrue(presenterSpy.presentFeatureNameCalled)
    }
}

extension PromoListInteractorTests {
    // MARK: - PromoListPresenterSpy
    class PromoServiceStub: PromoService {
        enum Result {
            case success, successNilData, error
        }
        
        enum StubError: Error {
            case customError
        }
        
        private let result: Result
        var isNilData = false
        
        init(_ result: Result) {
            self.result = result
        }
        
        func getPromos() -> AnyPublisher<PromoDataResponse, Error> {
            switch result {
            case .success:
                let response = PromoDataResponse(
                    promos: [
                        .init(
                            id: 0,
                            name: "stub name",
                            imageUrlString: "stub imageUrlString",
                            detailUrlString: "stub detailUrlString"
                        )
                    ]
                )
                return Just(response)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            case .successNilData:
                let response = PromoDataResponse(
                    promos: [
                        .init(
                            id: nil,
                            name: nil,
                            imageUrlString: nil,
                            detailUrlString: nil
                        )
                    ]
                )
                if let id = response.promos.first?.id,
                   let name = response.promos.first?.name,
                   let imageUrlString = response.promos.first?.imageUrlString,
                   let detailUrlString = response.promos.first?.detailUrlString {
                    isNilData = false
                } else {
                    isNilData = true
                }
                return Just(response)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            case .error:
                return Fail(error: StubError.customError)
                    .eraseToAnyPublisher()
            }
        }
    }
    
    // MARK: - PromoListPresenterSpy
    class PromoListPresenterSpy: PromoListPresentationLogic {
        var viewController: PromoListDisplayLogic?
        var router: PromoListRouting?
        var expectation: XCTestExpectation
        var presentPromosCalled = false
        var didSelectCalled = false
        var presentFeatureNameCalled = false
        
        init(expectation: XCTestExpectation) {
            self.expectation = expectation
        }
        
        func presentPromos(_ promos: [PromoModule.Promo]) {
            presentPromosCalled = true
            expectation.fulfill()
        }
        
        func didSelect(index: Int) {
            didSelectCalled = true
            expectation.fulfill()
        }
        
        func presentFeatureName(name: String) {
            presentFeatureNameCalled = true
            expectation.fulfill()
        }
    }
}
