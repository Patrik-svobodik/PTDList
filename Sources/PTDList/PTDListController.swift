import UIKit

class PTDListController<Item: Hashable, Cell: PTDListCell>: UIViewController {
    private var list: PTDList<Item, Cell>!
    
    var items = [Item]()
    
    override func viewDidLoad() {
        list = PTDList(items: items)
        view.addSubview(list)
        list.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            list.topAnchor.constraint(equalTo: view.topAnchor),
            list.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            list.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            list.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
