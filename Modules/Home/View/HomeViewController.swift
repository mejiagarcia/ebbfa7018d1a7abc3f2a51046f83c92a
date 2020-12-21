import UIKit

class HomeViewController: BaseViewController {
    // MARK: - UI References
    @IBOutlet private weak var tableView: UITableView?
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView?
    @IBOutlet private weak var newPostView: UIView?
    @IBOutlet private weak var dateLabel: UILabel?

    // MARK: - Properties
    private var tableAdapter: TableViewAdapterProtocol
    private var viewModel: HomeViewModelProtocol
    private lazy var router: HomeRouterProtocol = HomeRouter(in: self)
    
    // MARK: - Life Cycle
    init(tableAdapter: TableViewAdapterProtocol = TableViewAdapter(),
         viewModel: HomeViewModelProtocol) {
        
        self.tableAdapter = tableAdapter
        self.viewModel = viewModel
        
        super.init(nibName: String(describing: HomeViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        title = ""
        subcribeToViewModelStatus()
        setupTableView()
        setupNewPostButton()
        setupCurrentDateLabel()
        
        viewModel.fetchData()
    }
    
    private func setupNewPostButton() {
        /**
         You are probably wondering, why this guy just didn't use a button?
         answer: I didn't wanted to create an invisible button (or a huge one)
         */
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(newPostViewTapped))
        
        newPostView?.addGestureRecognizer(gesture)
    }
    
    @objc private func newPostViewTapped() {
        router.routeTo(transition: .createPost(delegate: self))
    }
    
    private func setupTableView() {
        tableView?.separatorStyle = .none
        tableView?.register(UINib(nibName: String(describing: PostTableViewCell.self),
                                  bundle: nil),
                            forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        
        tableAdapter.tableView = tableView
        tableAdapter.delegate = viewModel
    }
    
    private func setupCurrentDateLabel() {
        dateLabel?.text = Dates.dateToString(date: Date(), style: .medium).uppercased()
    }
    
    private func subcribeToViewModelStatus() {
        viewModel.status = { [weak self] status in
            switch status {
            case .isLoading:
                self?.activityIndicator?.startAnimating()
                
            case .stopLoading:
                self?.activityIndicator?.stopAnimating()

            case .dataLoaded:
                self?.tableView?.reloadData()
                
            case .businessError:
                self?.handleBusinessError()
                
            case .unexpectedError:
                self?.handleUnexpectedError()
            }
        }
    }
    
    // MARK: - Error Methods
    
    // FIXME: Hardcoded strings
    
    private func handleBusinessError() {
        Dialogs.show(title: "Error", message: "Business error!", on: self)
    }
    
    private func handleUnexpectedError() {
        Dialogs.show(title: "Error", message: "Unexcpeted error!", on: self)
    }
}

// MARK: - CreatePostDelegate
extension HomeViewController: CreatePostDelegate {
    func postCreated(_ post: PostCreated) {
        viewModel.addPost(post)
    }
}
