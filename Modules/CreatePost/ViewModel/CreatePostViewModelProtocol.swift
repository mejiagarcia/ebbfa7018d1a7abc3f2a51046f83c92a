import UIKit

protocol CreatePostViewModelProtocol {
    var status: ViewModelStatus<CreatePostViewModelStatus>? { get set }
    var charLimit: Int { get }

    func createPost(message: String, imagePicked: UIImage?)
}
