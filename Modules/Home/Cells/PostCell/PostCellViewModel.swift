import UIKit

struct PostCellViewModel: CellViewModelProtocol {
    let indentifier: String = String(describing: PostTableViewCell.self)
    let userName: String
    let message: String
    let date: String
    let image: UIImage?
}
