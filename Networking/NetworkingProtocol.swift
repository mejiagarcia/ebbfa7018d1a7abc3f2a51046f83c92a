import Foundation

protocol NetworkingProtocol {
    func get<T: Codable>(endpoint: URL,
                         onCompletionBlock: @escaping (Result<T, NetworkingError>) -> Void)
}
