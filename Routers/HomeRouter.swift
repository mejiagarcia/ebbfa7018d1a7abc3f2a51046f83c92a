import UIKit

enum HomeTransitions {
    case home
    case createPost
}

protocol HomeRouterProtocol {
    func routeTo(transition: HomeTransitions)
}

class HomeRouter: HomeRouterProtocol, RouterProtocol {
    // MARK: - Properties
    private let navigationController: UINavigationController?
    typealias Transitions = HomeTransitions
    
    // MARK: - Life Cycle
    init(in viewController: UIViewController) {
        self.navigationController = viewController.navigationController
    }

    // MARK: - Internal Methods
    func routeTo(transition: HomeTransitions) {
        switch transition {
        case .home:
            let homeViewController = HomeViewController(viewModel: HomeViewModel())
            
            navigationController?.setViewControllers([homeViewController],
                                                     animated: true)
            
        case .createPost:
            navigationController?.pushViewController(CreatePostViewController(),
                                                     animated: true)
        }
    }
}
