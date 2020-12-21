import UIKit

protocol CreatePostDelegate: class {
    func postCreated(_ post: PostCreated)
}

class CreatePostViewController: BaseViewController {
    // MARK: - UI References
    @IBOutlet private weak var messageText: UITextView?
    @IBOutlet private weak var charactersLabel: UILabel?
    @IBOutlet private weak var imagePicked: UIImageView?

    // MARK: - Properties
    private var viewModel: CreatePostViewModelProtocol
    private let router: HomeRouterProtocol
    private weak var delegate: CreatePostDelegate?
    private lazy var imagePicker = ImagePicker(presentationController: self, delegate: self)
    
    private var textCount: Int {
        messageText?.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
    }
    
    // MARK: - Life Cycle
    init(viewModel: CreatePostViewModelProtocol,
         delegate: CreatePostDelegate?,
         router: HomeRouterProtocol) {
        
        self.viewModel = viewModel
        self.delegate = delegate
        self.router = router

        super.init(nibName: String(describing: CreatePostViewController.self),
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        messageText?.becomeFirstResponder()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        title = CreatePostLang.title
        
        setupTextListener()
        subcribeToViewModelStatus()
        setupLabelCharacters()
        setupShareButton()
    }
    
    private func setupTextListener() {
        messageText?.delegate = self
    }
    
    private func subcribeToViewModelStatus() {
        viewModel.status = { [weak self] status in
            guard let self = self else { return }
            
            switch status {
            case .dataCreated(let post):
                self.delegate?.postCreated(post)
                self.router.routeTo(transition: .back)
                
            case .missingCharacters:
                Dialogs.show(title: CreatePostLang.Error.title, message: CreatePostLang.Error.message, on: self)
                
            case .charactersExceeded:
                Dialogs.show(title: CreatePostLang.Error.title, message: CreatePostLang.Error.message, on: self)
            }
        }
    }
    
    private func setupShareButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: CreatePostLang.shareButton,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(shareButtonTapped))
    }
    
    @objc func shareButtonTapped() {
        viewModel.createPost(message: messageText?.text ?? "")
    }
    
    private func setupLabelCharacters() {
        charactersLabel?.textColor = textCount > viewModel.charLimit ? .red : .lightGray
        charactersLabel?.text = "\(textCount)/\(viewModel.charLimit)"
    }
    
    // MARK: - UI Actions
    @IBAction private func addPhotoButtonAction() {
        imagePicker.open()
    }
}

// MARK: - UITextViewDelegate
extension CreatePostViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        setupLabelCharacters()
    }
}

// MARK: - ImagePickerDelegate
extension CreatePostViewController: ImagePickerDelegate {
    func imageSelected(image: UIImage?) {
        viewModel.imagePicked = image
        imagePicked?.image = image
    }
}
