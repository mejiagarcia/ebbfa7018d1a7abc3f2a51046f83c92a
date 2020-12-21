import Foundation

protocol TableViewDataSource: class {
    var dataSource: [CellViewModelProtocol] { get }
}
