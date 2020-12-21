import UIKit

class GNavigationController: UINavigationController {
    init() {
        super.init(nibName: nil, bundle: nil)
        
        viewControllers = [
            HomeViewController(tableAdapter: TableViewAdapter(),
                               viewModel: HomeViewModel(service: HomeService(networking: Networking())))
        ]
        
        setupNavigationBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupNavigationBar() {
        
    }
}

