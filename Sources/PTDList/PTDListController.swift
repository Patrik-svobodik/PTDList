import UIKit

open class PTDListController<Item: Hashable, Cell: PTDListCell>: UIViewController {
    open var list: PTDList<Item, Cell>!
    
    open var items = [Item]() {
        didSet {
            guard let list = list else { return }
            list.items = items
        }
    }
    
    open override func viewDidLoad() {
        list = PTDList(items: items)
        view.addSubview(list)
        list.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            list.topAnchor.constraint(equalTo: view.topAnchor),
            list.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            list.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            list.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        list.items = items
    }
}
