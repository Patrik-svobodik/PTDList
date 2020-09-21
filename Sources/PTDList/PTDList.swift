import UIKit

open class PTDList<Cell: PTDListCell>: UICollectionView, UICollectionViewDelegate {
    
    open var items: [Cell.Item] { didSet { apply() } }
    
    open var action: ((PTDListContext<Cell>) -> ())?
    
    public lazy var diffableDataSource = makeDataSource()
    
    open weak var listController: PTDListController<Cell>?
    
    public init(items: [Cell.Item]) {
        self.items = items
        #if os(tvOS)
        let config = UICollectionLayoutListConfiguration(appearance: .grouped)
        #else
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        #endif
        let list = UICollectionViewCompositionalLayout.list(using: config)
        super.init(frame: .zero, collectionViewLayout: list)
        self.dataSource = diffableDataSource
        self.delegate = self
        apply()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented, PTDList isn't ready for Storyboard usage.")
    }
    
    private func makeDataSource() -> DataSource {
        DataSource(collectionView: self) { [weak self] (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let self = self else { return nil }
            return collectionView.dequeueConfiguredReusableCell(using: self.cell,
                                                                for: indexPath,
                                                                item: item)
        }
    }
    
    private func apply() {
        var snapshot = Snapshot()
        snapshot.appendSections([.only])
        snapshot.appendItems(items)
        diffableDataSource.apply(snapshot)
    }
    
    public typealias DataSource = UICollectionViewDiffableDataSource<Section, Cell.Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Cell.Item>
    
    public enum Section: Hashable {
        case only
    }
    
    lazy var cell = UICollectionView.CellRegistration<Cell, Cell.Item> { [weak self] (cell, indexPath, item) in
        guard let self = self else { return }
        var context = PTDListContext(indexPath: indexPath, item: item, list: self, controller: self.listController)
        cell.setup(context: context)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let item = diffableDataSource.itemIdentifier(for: indexPath) else { return }
        action?(PTDListContext(indexPath: indexPath, item: item, list: self, controller: listController))
    }
}

public protocol PTDListCell: UICollectionViewCell {
    associatedtype Item: Hashable
    func setup(context: PTDListContext<Self>)
}

public struct PTDListContext<Cell: PTDListCell> {
    public var indexPath: IndexPath
    public var item: Cell.Item
    public var list: PTDList<Cell>
    public weak var controller: PTDListController<Cell>?
}
