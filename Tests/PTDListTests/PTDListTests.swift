import XCTest
@testable import PTDList

final class PTDListTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(PTDList<String, UICollectionViewListCell>(items: []).items, [])
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

extension UICollectionViewListCell: PTDListCell {
    public func setup(item: AnyHashable, indexPath: IndexPath) {
        
    }
}
