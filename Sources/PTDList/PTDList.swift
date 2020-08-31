import UIKit

open class PTDList<Item: Hashable, Cell: PTDListCell>: UICollectionView {
    
    open var items: [Item]
    
    public lazy var diffableDataSource = makeDataSource()
    
    init(items: [Item]) {
        self.items = items
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let list = UICollectionViewCompositionalLayout.list(using: config)
        super.init(frame: .zero, collectionViewLayout: list)
        self.dataSource = diffableDataSource
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    public typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    public enum Section: Hashable {
        case only
    }
    
    let cell = UICollectionView.CellRegistration<Cell, Item> { (cell, indexPath, item) in
        cell.setup(item: item, indexPath: indexPath)
    }
}

public protocol PTDListCell: UICollectionViewCell {
    func setup(item: AnyHashable, indexPath: IndexPath)
}
