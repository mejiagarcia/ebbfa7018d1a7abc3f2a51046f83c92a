import UIKit

class PostTableViewCell: UITableViewCell {
    // MARK: - UI References
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var dateLabel: UILabel?
    @IBOutlet private weak var messageLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel?.text = nil
        dateLabel?.text = nil
        messageLabel?.text = nil
    }
    
    // MARK: - Private Methods
    private func setupCellWith(viewModel: PostCellViewModel) {
        titleLabel?.text = viewModel.userName
        dateLabel?.text = viewModel.date?.description // FIXME
        messageLabel?.text = viewModel.message
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

