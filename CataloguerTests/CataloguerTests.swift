//
//  CataloguerTests.swift
//  CataloguerTests
//
//  Created by Alex Dreier on 7/8/23.
//

import XCTest
@testable import Cataloguer

final class CataloguerTests: XCTestCase {
    var user = User()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        user = User()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddUniquAlbums() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        var album1 = Album(isCompilation: false, isMix: false, isGH: false, isCollection: false, isLive: false, genre: "Swing", releaseYear: 1955, title: "swing1", label: "label1", value: 20, cost: 20)
        let record1 = Record(isCompilation: false, isMix: false, isGH: false, isCollection: false, isLive: false, genre: "Swing", releaseYear: 1955, title: "", label: "label1", speed: 33, value: 20, cost: 20, album: album1)
        let track1 = Track(title: "swingsong1", releaseYear: 1955, genre: "Swing", isLive: false)
        record1.tracks.append(track1)
        album1.records.append(record1)
        let uniqueness1 = user.catalogue.addAlbum(album: &album1)
        XCTAssertEqual(UniqueTracks.Uniqueness.unique, uniqueness1)
        XCTAssert(user.catalogue.contains(album1))
        XCTAssert(user.catalogue.contains(record1))
        XCTAssert(user.catalogue.contains(track1))
    }
    
    func testStartTrips() throws {
        let user = User()
        let _ = user.startTrip()
        XCTAssertEqual(1, user.trips.count)
        let _ = user.startTrip()
        XCTAssertEqual(2, user.trips.count)
        
    }
    
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
