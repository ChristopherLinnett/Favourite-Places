//
//  Favourite_PlacesTests.swift
//  Favourite PlacesTests
//
//  Created by Christopher Linnett on 9/5/2022.
//
import CoreData
import XCTest
@testable import Favourite_Places
import MapKit


class TestCoreDataStack: NSObject {
    lazy var persistentContainer: NSPersistentContainer = {
        let description = NSPersistentStoreDescription()
        description.url = URL(fileURLWithPath: "/dev/null")
        let container = NSPersistentContainer(name: "TestPlace")
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
}

class Favourite_PlacesTests: XCTestCase {
    var testStack = TestCoreDataStack()
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    // initialise a map region to test ability to edit

    func testMapFeatures() throws {
        var testMapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 10, longitude: 10), latitudinalMeters: 100, longitudinalMeters: 100)
        XCTAssertEqual(testMapRegion.latitudeString, "10.0")  //Testing variable getter is able to pull a string from the initialised lat Double value
        XCTAssertEqual(testMapRegion.longitudeString, "10.0") //Testing variable getter is able to pull a string from the initialised lat Double value
        testMapRegion.sendToMapLat(latitude: "80")  //attempting to modify map region value
        testMapRegion.sendToMapLon(longitude: "80") //attempting to modify map region value
        XCTAssertEqual(testMapRegion.latitudeString, "80.0") //checking modification was successful
        XCTAssertEqual(testMapRegion.longitudeString, "80.0") //checking modification was successful
        XCTAssertEqual(testMapRegion.center.latitude, 80) //Testing that map's co-ordinate region is also updated on string change
        XCTAssertEqual(testMapRegion.center.longitude, 80) //Testing that map's co-ordinate region is also updated on string change

        testMapRegion.sendToMapLat(latitude: "200")  //attempting to set map value out of bounds (success = no change in map value)
        testMapRegion.sendToMapLon(longitude: "200")  //attempting to set map value out of bounds (success = no change in map value)
        XCTAssertNotEqual(testMapRegion.latitudeString, "200.0") //making sure new value of 200 was not set
        XCTAssertNotEqual(testMapRegion.longitudeString, "200.0") //making sure new value of 200 was not set
        
    }
    ///tests the function for updating the sunrise and sunset from an API
    @MainActor func testSunriseSunsetUpdater() async throws {
        let testViewModel = ViewModel()
        testViewModel.region.latitudeString = "-27.4705"    //set a location's lat for input
        testViewModel.region.longitudeString = "153.0260"   //set a locatin's lon for input
        XCTAssertEqual(testViewModel.sunriseSunset.sunset, "unknown")   //check default values are intact
        XCTAssertEqual(testViewModel.sunriseSunset.sunrise, "unknown")  // check default values are intact
        try! await testViewModel.lookupSunriseAndSunset()               //run async function to get the sunrise/sunset times
        XCTAssertNotEqual(testViewModel.sunriseSunset.sunset, "unknown")        //check async function has changed the default sunset time
        XCTAssertNotEqual(testViewModel.sunriseSunset.sunrise, "unknown")       //check async function has updated the default sunrise time
    }
    

    func testExample() throws {

        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
