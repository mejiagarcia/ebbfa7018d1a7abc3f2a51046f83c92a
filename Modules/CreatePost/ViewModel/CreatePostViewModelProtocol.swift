import UIKit

protocol CreatePostViewModelProtocol {
    var status: ViewModelStatus<CreatePostViewModelStatus>? { get set }
    var charLimit: Int { get }
    var imagePicked: UIImage? { get set }
    func createPost(message: String)
}
