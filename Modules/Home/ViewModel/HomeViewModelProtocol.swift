import UIKit

typealias ViewModelStatus<T> = (T) -> Void

enum HomeViewModelStatus {
    case isLoading
    case stopLoading
    case dataLoaded
    case businessError
    case unexpectedError
}

protocol HomeViewModelProtocol: TableViewDataSource {
    var status: ViewModelStatus<HomeViewModelStatus>? { get set }
    func fetchData()
}
