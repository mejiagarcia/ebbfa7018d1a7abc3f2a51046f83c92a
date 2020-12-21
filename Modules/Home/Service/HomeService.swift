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
        guard let endpoint = getPostListEndpoint() else {
            return onCompletionBlock(.failure(.unexpectedError))
        }
        
        networking.get(endpoint: endpoint) { [weak self] (result: Result<[Post], NetworkingError>) in
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
    private func getPostListEndpoint() -> URL? {
        // I totally understand that this is a very basic implementation:
        // My ideas:
        // 1. Put domain in user-defined properties in project level config
        // 2. Put the endpoint "/feed" in some kind of "Endpoints.plist" file
        // The time was not enough
        return URL(string: "http://gl-endpoint.herokuapp.com/feed")
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
