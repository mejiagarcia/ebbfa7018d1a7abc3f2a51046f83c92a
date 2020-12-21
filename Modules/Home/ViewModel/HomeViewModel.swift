import Foundation

class HomeViewModel: HomeViewModelProtocol {
    // MARK: - Properties
    var dataSource = [CellViewModelProtocol]()
    var status: ViewModelStatus<HomeViewModelStatus>?
    
    // MARK: - Internal Methods
    func fetchData() {
        status?(.isLoading)
    }
}
