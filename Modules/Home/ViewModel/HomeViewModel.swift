import Foundation

class HomeViewModel: HomeViewModelProtocol {
    // MARK: - Properties
    private var service: HomeServiceProtocol
    
    var dataSource = [CellViewModelProtocol]()
    var status: ViewModelStatus<HomeViewModelStatus>?
    
    // MARK: - Life Cycle
    required init(service: HomeServiceProtocol = HomeService(networking: Networking())) {
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
    
    func addPost(_ post: PostCreated) {
        let newPost = PostCellViewModel(userName: "\(post.firstName) \(post.lastName)",
                                        message: post.message,
                                        date: Dates.dateToString(date: post.createdDate, style: .short),
                                        image: nil)
        dataSource.insert(newPost, at: .zero)
        
        notify(.dataLoaded)
    }
    
    // MARK: - Private Methods
    private func handleDataFromService(models: [Post]) {
        dataSource = models.map {
            var stringDate = ""
            
            if let timeInterval = TimeInterval($0.timestamp) {
                let date = Date(timeIntervalSince1970: timeInterval)
                
                stringDate = Dates.dateToString(date: date, style: .short)
            }
            
            return PostCellViewModel(userName: "\($0.firstName) \($0.lastName)",
                                     message: $0.message,
                                     date: stringDate,
                                     image: nil)
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
