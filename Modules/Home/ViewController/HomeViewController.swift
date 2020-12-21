import UIKit

class HomeViewController: BaseViewController {
    // MARK: - UI References
    @IBOutlet private weak var tableView: UITableView?
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView?

    // MARK: - Properties
    private var tableAdapter: TableViewAdapterProtocol
    private var viewModel: HomeViewModelProtocol
    
    // MARK: - Life Cycle
    init(tableAdapter: TableViewAdapterProtocol, viewModel: HomeViewModelProtocol) {
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
        subcribeToViewModelStatus()
        setupTableView()
    }
    
    private func setupTableView() {
        tableAdapter.tableView = tableView
        tableAdapter.delegate = viewModel
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
