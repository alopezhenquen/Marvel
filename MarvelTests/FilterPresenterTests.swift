//
//  FilterPresenterTests.swift
//  Marvel
//
//  Created by Sameh Mabrouk on 4/26/16.
//  Copyright © 2016 smapps. All rights reserved.
//

import XCTest
@testable import Marvel

class FilterPresenterTests: XCTestCase {

    // Since there is no Mock framwork for swift like OCMock for Objective C, so for now the only way I see is to create a hand rolled mock. In swift this is a little bit less painful since you can create inner classes within a method, but still is not as handy as a mocking framework.

    // Mock Factory class
    class ListWireframeMock: FilterWireframe {

        // This variable to achieve the XCTest expect method like OCMock framework expect method.
        var presentFilterInterfaceWasCalled = false

        override func PresentDetailsInterface(selectedCellIndex: Int, characters: [Marvel.Character]) {
            presentFilterInterfaceWasCalled = true
        }
    }

    // Mock Factory class
    class FilterCharactersTableViewControllerMock: FilterViewInterface {

        // This variable to achieve the XCTest expect method like OCMock framework expect method.
        var showCharactersWasCalled = false

        func showCharacters(characters: [Marvel.Character]) {
            showCharactersWasCalled = true
        }
    }

    var sut: FilterPresenter!
    var ui: FilterCharactersTableViewControllerMock!
    var listWireframeMocked: ListWireframeMock!

    var characters:[Marvel.Character] = []

    override func setUp() {
        super.setUp()

        ui = FilterCharactersTableViewControllerMock()

        listWireframeMocked = ListWireframeMock()

        sut = FilterPresenter()
        sut.userInterface = ui
        sut.filterWireframe = listWireframeMocked

        // Parse the local test json data as Array of Character dictionaries.
        if let characterJsonFileURL = NSBundle(forClass: self.dynamicType).URLForResource("Characters", withExtension: "json") {
            XCTAssertNotNil(characterJsonFileURL)

            if let data = NSData(contentsOfURL: characterJsonFileURL), langDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: [])) as? NSDictionary{

                let rootClass:RootClass = RootClass(fromDictionary: langDictionary)
                characters = rootClass.data.results
            }
            
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

    func testFoundCharacters() {

        // Test
        sut.foundCharacters(characters)

        // Verify
        XCTAssertTrue(ui.showCharactersWasCalled)
    }

    func testTableViewCellSelectedActionPresentsDetailsUI() {

        // Test
        sut.tableViewCellSelected(1, characters: characters)

        // Verify
        XCTAssertTrue(listWireframeMocked.presentFilterInterfaceWasCalled)
    }
}
