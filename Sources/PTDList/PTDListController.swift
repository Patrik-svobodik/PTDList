import UIKit

open class PTDListController<Cell: PTDListCell>: UIViewController {
    open var list: PTDList<Cell>!
    
    open var action: ((PTDListContext<Cell>) -> ())? {
        didSet {
            guard let list = list else { return }
            list.action = action
        }
    }
    
    open var items = [Cell.Item]() {
        didSet {
            guard let list = list else { return }
            list.items = items
        }
    }
    
    open override func viewDidLoad() {
        list = PTDList(items: items)
        list.listController = self
        view.addSubview(list)
        list.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            list.topAnchor.constraint(equalTo: view.topAnchor),
            list.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            list.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            list.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        list.items = items
        list.action = action
    }
}
