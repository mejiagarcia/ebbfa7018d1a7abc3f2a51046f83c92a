import UIKit

protocol ImagePickerDelegate: class {
    func imageSelected(image: UIImage?)
}

class ImagePicker: NSObject {
    // MARK: - Properties
    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?

    // MARK: - Life Cycle
    public init(presentationController: UIViewController, delegate: ImagePickerDelegate) {
        self.pickerController = UIImagePickerController()

        super.init()

        self.presentationController = presentationController
        self.delegate = delegate

        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = ["public.image"]
    }
    
    // MARK: - Internal Methods
    func open() {
        pickerController.sourceType = .photoLibrary
        presentationController?.present(pickerController, animated: true)
    }

    // MARK: - Private Methods
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)

        self.delegate?.imageSelected(image: image)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension ImagePicker: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        pickerController(picker, didSelect: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        guard let image = info[.editedImage] as? UIImage else {
            return pickerController(picker, didSelect: nil)
        }
        
        pickerController(picker, didSelect: image)
    }
}

// MARK: - UINavigationControllerDelegate
extension ImagePicker: UINavigationControllerDelegate {}
