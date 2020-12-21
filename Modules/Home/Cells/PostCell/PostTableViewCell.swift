import UIKit

class PostTableViewCell: UITableViewCell {
    // MARK: - UI References
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var dateLabel: UILabel?
    @IBOutlet private weak var messageLabel: UILabel?
    @IBOutlet private weak var postImageView: UIImageView?
    @IBOutlet private weak var postImageViewHeightConstraint: NSLayoutConstraint?

    // MARK: - Properties
    private let postImageViewHeight: CGFloat = 280
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel?.text = nil
        dateLabel?.text = nil
        messageLabel?.text = nil
        postImageView?.image = nil
        postImageViewHeightConstraint?.constant = postImageViewHeight
    }
    
    // MARK: - Private Methods
    private func setupCellWith(viewModel: PostCellViewModel) {
        titleLabel?.text = viewModel.userName
        messageLabel?.text = viewModel.message
        dateLabel?.text = viewModel.date
        
        if let postImage = viewModel.image {
            postImageView?.image = postImage
        } else {
            postImageViewHeightConstraint?.constant = .zero
        }
    }
}

// MARK: - CellProtocol
extension PostTableViewCell: CellProtocol {
    func setupWith(viewModel: CellViewModelProtocol?) {
        guard let viewModel = viewModel as? PostCellViewModel else {
            return
        }
        
        setupCellWith(viewModel: viewModel)
    }
}

