import XCTest
@testable import Note

class NetworkManagerTests: XCTestCase {
    private var sut: DefaultNetworkManager!

    override func setUp() {
        super.setUp()
        sut = DefaultNetworkManager()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testNetworkManagerReturnsData() {
       let expectation = expectation(description: "Wait for ")
    }
}
