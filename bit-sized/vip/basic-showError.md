# Basic show error

```swift


enum NetworkResponse<SuccessData, NetworkError: Error> {
    case success(data: SuccessData) // Successful API response with data
    case requestFailure(message: String) // API responded with an error message
    case networkFailure(error: NetworkError) // Network or server error occurred
}


protocol ShowErrorPresenterProtocol {
    var showErrorViewController: ShowErrorViewControllerProtocol? { get }
    func presentError<Message>(_ message: Message)
}

protocol ShowErrorViewControllerProtocol: BaseVC {}

extension ShowErrorPresenterProtocol {
    func presentErrorMessage(_ message: String) {
        showErrorViewController?.showAlert(message)
    }
}

class BaseVC: UIViewController {
    func showAlert(_ message: String) {
        print(message)
    }
}

```
