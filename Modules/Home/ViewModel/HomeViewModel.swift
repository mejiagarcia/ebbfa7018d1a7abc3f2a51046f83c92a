import Foundation

class HomeViewModel: HomeViewModelProtocol {
    // MARK: - Properties
    private var service: HomeServiceProtocol
    
    var dataSource = [CellViewModelProtocol]()
    var status: ViewModelStatus<HomeViewModelStatus>?
    
    // MARK: - Life Cycle
    required init(service: HomeServiceProtocol) {
        self.service = service
    }
    
    // MARK: - Internal Methods
    func fetchData() {
        status?(.isLoading)
    }
}
