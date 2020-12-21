import UIKit

enum HomeTransitions {
    case home
    case createPost(delegate: CreatePostDelegate?)
    case back
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
            
        case .createPost(let delegate):
            navigationController?.pushViewController(CreatePostViewController(viewModel: CreatePostViewModel(),
                                                                              delegate: delegate,
                                                                              router: self),
                                                     animated: true)
            
        case .back:
            navigationController?.popViewController(animated: true)
        }
    }
}
