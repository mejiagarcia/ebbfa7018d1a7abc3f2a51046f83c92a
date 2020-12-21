import Foundation

typealias PostListCompletionBlock = (Result<[Post], HomeServiceErrors>) -> Void

protocol HomeServiceProtocol: ServiceProtocol {
    var networking: NetworkingProtocol { get }
    
    func fetchPostList(onCompletionBlock: @escaping PostListCompletionBlock)
}
