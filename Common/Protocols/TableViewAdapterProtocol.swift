import UIKit

protocol TableViewAdapterProtocol {
    var delegate: TableViewDataSource? { get set }
    var tableView: UITableView? { get set }
}
