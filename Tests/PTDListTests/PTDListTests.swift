import XCTest
@testable import PTDList
import UIKit

final class PTDListTests: XCTestCase {
    func testDataSource() {
        let list = PTDList<PTDListTestCell>(items: ["What lol"])
        XCTAssertEqual(list.dataSource?.collectionView(list, numberOfItemsInSection: 0), 1)
    }
    func testCell() {
        let validTitle = "Ree"
        let indexPath = IndexPath(item: 0, section: 0)
        
        let cell = PTDListTestCell()
        cell.setup(context: .init(indexPath: indexPath, item: validTitle, list: .init(items: []), controller: nil))
        XCTAssertEqual(cell.text, validTitle)
        XCTAssertEqual(cell.secondaryText, "\(indexPath)")
    }
    func testTap() {
        let list = PTDList<PTDListTestCell>(items: ["What lol"])
        var success = false
        list.action = { _ in success = true }
        list.delegate?.collectionView?(list, didSelectItemAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(success)
    }
    func testController() {
        let arr = ["What lol"]
        let controller = PTDListController<PTDListTestCell>()
        controller.items = arr
        XCTAssertTrue(controller.list.items == arr)
    }

    static var allTests = [
        ("Test dataSource", testDataSource),
        ("Test cell setup", testCell),
        ("Test controller", testController),
    ]
}

final class PTDListTestCell: UICollectionViewListCell, PTDListCell {
    typealias Item = String
    var text: String?
    var secondaryText: String?
    
    func setup(context: PTDListContext<PTDListTestCell>) {
        text = context.item
        secondaryText = "\(context.indexPath)"
    }
}
