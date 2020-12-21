import UIKit

enum CreatePostViewModelStatus {
    case dataCreated(post: PostCreated)
    case missingCharacters
    case charactersExceeded
}

class CreatePostViewModel: CreatePostViewModelProtocol {
    // MARK: - Propeties
    lazy var charConfig = (min: 1, max: charLimit)
    let charLimit = 155
    var status: ViewModelStatus<CreatePostViewModelStatus>?
    var imagePicked: UIImage?
    
    // MARK: - Internal Methods
    func createPost(message: String) {
        if message.count > charConfig.max {
            return notify(.charactersExceeded)
        }
        
        if message.count < charConfig.min {
            return notify(.missingCharacters)
        }
        
        let postCreated = PostCreated(firstName: "Carlos",
                                      lastName: "Mejía",
                                      message: message,
                                      createdDate: Date(),
                                      image: imagePicked)
        
        notify(.dataCreated(post: postCreated))
    }
    
    // MARK: - Private Methods
    private func notify(_ status: CreatePostViewModelStatus) {
        DispatchQueue.main.async { [weak self] in
            self?.status?(status)
        }
    }
}
