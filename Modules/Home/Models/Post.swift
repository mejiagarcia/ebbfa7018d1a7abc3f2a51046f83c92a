import Foundation

struct Post: Codable {
    let firstName: String
    let lastName: String
    let message: String
    let timestamp: String
}

// MARK: - Custom Conding Keys
private extension Post {
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case message = "post_body"
        case timestamp = "unix_timestamp"
    }
}
