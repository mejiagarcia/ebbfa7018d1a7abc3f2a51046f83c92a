import UIKit
import Foundation

class TableViewAdapter: NSObject, TableViewAdapterProtocol {
    // MARK: - Properties
    weak var delegate: TableViewDataSource?
    weak var tableView: UITableView? {
        didSet {
            tableView?.dataSource = self
        }
    }
}

// MARK: - UITableViewDataSource
extension TableViewAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return delegate?.dataSource.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = delegate?.dataSource[indexPath.row].indentifier ?? ""
        let viewModel = delegate?.dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                 for: indexPath)
        (cell as? CellProtocol)?.setupWith(viewModel: viewModel)
        
        return cell
    }
}
