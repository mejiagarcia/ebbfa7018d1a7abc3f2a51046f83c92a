import UIKit

enum HomeViewModelStatus {
    case isLoading
    case stopLoading
    case dataLoaded
    case businessError
    case unexpectedError
}

protocol HomeViewModelProtocol: TableViewDataSource {
    var status: ViewModelStatus<HomeViewModelStatus>? { get set }
    
    init(service: HomeServiceProtocol)
    
    func fetchData()
    func addPost(_ post: PostCreated)
}
