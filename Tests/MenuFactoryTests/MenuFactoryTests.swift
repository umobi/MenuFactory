import XCTest
@testable import MenuFactory

final class MenuFactoryTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(MenuFactory().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
