import UIKit

struct Dialogs {
    static func show(title: String,
                     message: String,
                     on vieController: UIViewController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Im sorry but this isn't enough to set language constants
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
        
        vieController.present(alert, animated: true, completion: nil)
    }
}
