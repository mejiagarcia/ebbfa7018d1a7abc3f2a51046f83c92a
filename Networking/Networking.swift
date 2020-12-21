import Foundation

struct Networking: NetworkingProtocol {
    // MARK: - Properties
    private let session: URLSession
    private let decoder: JSONDecoder

    // MARK: - Life Cycle
    init(session: URLSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    // MARK: - Internal Methods
    func get<T: Codable>(endpoint: URL,
                         onCompletionBlock: @escaping (Result<T, NetworkingError>) -> Void) {
        
        let urlRequest = URLRequest(url: endpoint)
        
        session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                return onCompletionBlock(.failure(.unexcpetedError))
            }
            
            guard let data = data else {
                return onCompletionBlock(.failure(.noData))
            }
            
            do {
                let result: T = try decoder.decode(T.self, from: data)
                onCompletionBlock(.success(result))
                
            } catch {
                print("->>>>>> Serlialization error, details: <<<<<<< \n")
                print(error.localizedDescription)
                
                onCompletionBlock(.failure(.serializationError))
            }

        }.resume()
    }
}
