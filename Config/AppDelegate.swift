import UIKit

@main class AppDelegate: UIResponder {
    // MARK: - Properties
    var window: UIWindow?
    
    // MARK: - Private Methods
    private func setupInitialViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = GNavigationController()
    }
}

// MARK: - UIApplicationDelegate
extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupInitialViewController()
        
        return true
    }
}

