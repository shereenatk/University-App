//
//  ListingViewControllerTests.swift
//  University
//
//  Created by ios on 08/05/2024.
//

import XCTest
@testable import University

class ListingViewControllerTests: XCTestCase {
    var viewController: ListingViewController!

    override func setUpWithError() throws {
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListingViewController") as? ListingViewController
        viewController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        viewController = nil
    }

    func testViewDidLoad() throws {
        XCTAssertNotNil(viewController.universityTableView.dataSource)
        XCTAssertNotNil(viewController.universityTableView.delegate)
        XCTAssertNotNil(viewController.refreshControl)
    }
   
}
