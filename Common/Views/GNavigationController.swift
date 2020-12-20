import UIKit

class GNavigationController: UINavigationController {
    init() {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = [HomeViewController()]
        
        setupNavigationBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupNavigationBar() {
        
    }
}

