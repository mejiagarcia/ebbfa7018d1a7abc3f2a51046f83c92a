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
        notify(.isLoading)
        
        service.fetchPostList { [weak self] result in
            self?.notify(.stopLoading)

            switch result {
            case .success(let posts):
                self?.handleDataFromService(models: posts)
                
            case .failure(let error):
                self?.handleErrorFromService(error)
            }
        }
    }
    
    // MARK: - Private Methods
    private func handleDataFromService(models: [Post]) {
        dataSource = models.map {
            PostCellViewModel(userName: "\($0.firstName) \($0.lastName)",
                              message: $0.message,
                              date: $0.createdDate)
        }
        
        notify(.dataLoaded)
    }
    
    private func handleErrorFromService(_ error: HomeServiceErrors) {
        switch error {
        case .noData:
            notify(.businessError)
            
        case .unexpectedError:
            notify(.unexpectedError)
        }
    }
    
    private func notify(_ status: HomeViewModelStatus) {
        DispatchQueue.main.async { [weak self] in
            self?.status?(status)
        }
    }
}
