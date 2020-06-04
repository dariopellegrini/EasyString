import XCTest
@testable import EasyString

final class EasyStringTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(EasyString().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
