import UIKit

class GNavigationController: UINavigationController {
    init() {
        super.init(nibName: nil, bundle: nil)
        
        viewControllers = [
            HomeViewController(viewModel: HomeViewModel())
        ]
        
        setupNavigationBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupNavigationBar() {
        navigationBar.barTintColor = AppColors.blue
        navigationBar.isTranslucent = false
        setupLogo()
    }
    
    private func setupLogo() {
        let image = UIImage(named: "GL_Logo")
        let imageView = UIImageView(image: image)
        let bannerWidth = navigationBar.frame.size.width
        let bannerHeight = navigationBar.frame.size.height
        let bannerX = bannerWidth / 2 - (image?.size.width ?? 0) / 2
        let bannerY = bannerHeight / 2 - (image?.size.height ?? 0) / 2
        
        imageView.frame = CGRect(x: bannerX,
                                 y: bannerY,
                                 width: bannerWidth,
                                 height: bannerHeight)
        
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
}

