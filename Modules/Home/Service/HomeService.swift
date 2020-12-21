import Foundation

class HomeService: HomeServiceProtocol {
    // MARK: - Properties
    var networking: NetworkingProtocol
    
    // MARK: - Life Cycle
    init(networking: NetworkingProtocol) {
        self.networking = networking
    }
    
    // MARK: - Internal Methods
    func fetchPostList(onCompletionBlock: @escaping PostListCompletionBlock) {
        networking.get(endpoint: getPostListEndpoint()) { [weak self] (result: Result<[Post], NetworkingError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let entities):
                onCompletionBlock(.success(entities))
                
            case .failure(let error):
                onCompletionBlock(.failure(self.getServiceError(with: error)))
            }
        }
    }
    
    // MARK: - Private Methods
    private func getPostListEndpoint() -> URL {
        return URL(string: "http://gl-endpoint.herokuapp.com/feed")! // FIXME
    }
    
    private func getServiceError(with error: NetworkingError) -> HomeServiceErrors {
        switch error {
        case .unexcpetedError, .serializationError:
            return .unexpectedError
            
        case .noData:
            return .noData
        }
    }
}
