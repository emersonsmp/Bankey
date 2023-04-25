//
//  AccountSummaryViewControllerTests.swift
//  BankeyUnitTests
//
//  Created by Emerson Sampaio on 24/04/23.
//
 
import Foundation
import XCTest

@testable import Bankey

class AccountSummaryViewControllerTests: XCTestCase {
    var vc: AccountSummaryViewController!
    var mockManager: MockProfileManager!
    
    class MockProfileManager: ProfileManager {
        var profile: Profile?
        var error: NetworkError?
        
        override func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile, NetworkError>) -> Void) {
            if error != nil{
                completion(.failure(error!))
                return
            }
            
            profile = Profile(id: "1", firstName: "FirstName", lastName: "LasName")
            completion(.success(profile!))
        }
    }
    
    override func setUp() {
        super.setUp()
        vc = AccountSummaryViewController()
        // vc.loadViewIfNeeded()
        
        mockManager = MockProfileManager()
        vc.profileManager = mockManager
    }
    
    func testTitleAndMessageForServerError() throws {
        let titleAndMessage = vc.titleAndMessage(for: .serverError)
        XCTAssertEqual("Server Error", titleAndMessage.0)
        XCTAssertEqual("Ensure you are connected to the internet. please try again.", titleAndMessage.1)
    }
    
    func testTitleAndMessageForDecoderError() throws {
        let titleAndMessage = vc.titleAndMessage(for: .decodingError)
        XCTAssertEqual("Decoding Error", titleAndMessage.0)
        XCTAssertEqual("We could not process your request. please try again.", titleAndMessage.1)
    }
    
    func testAlertForServerError() throws{
        mockManager.error = NetworkError.serverError
        vc.forceFetchProfile()
        
        XCTAssertEqual("Server Error", vc.errorAlert.title)
        XCTAssertEqual("Ensure you are connected to the internet. please try again.", vc.errorAlert.message)
    }
}
