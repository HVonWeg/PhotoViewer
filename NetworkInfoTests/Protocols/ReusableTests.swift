//
//  ReusableTests.swift
//  NetworkInfoTests
//
//  Created by Heiko von Wegerer on 07.11.21.
//

import XCTest
@testable import NetworkInfo

class ReusableTests: XCTestCase {

    func testReuseIdentifier() throws {
        XCTAssertEqual(ImageCollectionViewCell.reuseIdentifier, "ImageCollectionViewCell")
    }

}
