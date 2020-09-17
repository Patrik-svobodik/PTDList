import UIKit

open class PTDListController<Cell: PTDListCell>: UIViewController {
    open lazy var list = PTDList<Cell>(items: items)
    
    open var action: ((PTDListContext<Cell>) -> ())? {
        didSet {
            list.action = action
        }
    }
    
    open var items = [Cell.Item]() {
        didSet {
            list.items = items
        }
    }
    
    open override func viewDidLoad() {
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
