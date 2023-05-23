import Foundation
import UIKit
import PureLayout

class LogInViewController: UIViewController {
    
    
    private var signInButton: UIButton!
    private var signInTitle: UILabel!
    private var emailLabel: UILabel!
    private var passwordLabel: UILabel!
    private var usernameInputTextField: UITextField!
    private var passwordInputTextField: UITextField!
    
    private var emailInputContainer: UIView!
    private var passwordInputContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }
    
    private func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    private func createViews() {
        signInTitle = UILabel()
        view.addSubview(signInTitle)
        
        emailInputContainer = UIView()
        view.addSubview(emailInputContainer)
        
        emailLabel = UILabel()
        emailInputContainer.addSubview(emailLabel)
        
        usernameInputTextField = UITextField()
        emailInputContainer.addSubview(usernameInputTextField)
        
        passwordInputContainer = UIView()
        view.addSubview(passwordInputContainer)
        
        passwordLabel = UILabel()
        passwordInputContainer.addSubview(passwordLabel)
        
        passwordInputTextField = UITextField()
        passwordInputContainer.addSubview(passwordInputTextField)
        
        signInButton = UIButton()
        view.addSubview(signInButton)
    }
    
    private func styleViews() {
        view.backgroundColor = Colors.bgColor
        
        signInTitle.text = "Sign in"
        signInTitle.textColor = .white
        signInTitle.font = UIFont(name: "ProximaNova-Bold", size: 24)
        signInTitle.textAlignment = .center
        
        emailLabel.text = "Email address"
        emailLabel.textColor = .white
        emailLabel.font = UIFont(name: "ProximaNova-Bold", size: 14)
        emailLabel.textAlignment = .left
        
        usernameInputTextField.backgroundColor = Colors.darkBlue
        usernameInputTextField.layer.cornerRadius = 10
        usernameInputTextField.layer.borderWidth = 1
        usernameInputTextField.layer.borderColor = Colors.lightBlue.cgColor
        usernameInputTextField.textColor = Colors.lightBlue
        
        // padding of 16px for input text and placeholder
        let paddingView = UIView(frame: CGRectMake(12, 12, 16, 0))
        usernameInputTextField.leftView = paddingView
        usernameInputTextField.leftViewMode = UITextField.ViewMode.always
        
        // placeholder
        usernameInputTextField.attributedPlaceholder = NSAttributedString(
            string: "ex. Matt@iosCourse.com",
            attributes: [NSAttributedString.Key.foregroundColor: Colors.lightBlue]
        )
        
        passwordLabel.text = "Password"
        passwordLabel.textColor = .white
        passwordLabel.font = UIFont(name: "ProximaNova-Bold", size: 14)
        passwordLabel.textAlignment = .left
        
        passwordInputTextField.isSecureTextEntry = true
        
        passwordInputTextField.backgroundColor = Colors.darkBlue
        passwordInputTextField.layer.cornerRadius = 10
        passwordInputTextField.layer.borderWidth = 1
        passwordInputTextField.layer.borderColor = Colors.lightBlue.cgColor
        passwordInputTextField.textColor = Colors.lightBlue
        
        passwordInputTextField.layer.shadowColor = UIColor.black.cgColor
        passwordInputTextField.layer.shadowOpacity = 0.5
        passwordInputTextField.layer.shadowRadius = 3
        passwordInputTextField.layer.shadowOffset = .zero
        
        let paddingView2 = UIView(frame: CGRectMake(12, 12, 16, 0))
        
        // padding of 16px for input text and placeholder
        passwordInputTextField.leftView = paddingView2
        passwordInputTextField.leftViewMode = UITextField.ViewMode.always

        // placeholder
        passwordInputTextField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: Colors.lightBlue]
        )
        
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.backgroundColor = Colors.lightBlue
        signInButton.layer.cornerRadius = 10
        signInButton.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 14)
        
        signInButton.layer.shadowColor = UIColor.black.cgColor
        signInButton.layer.shadowOpacity = 0.5
        signInButton.layer.shadowRadius = 3
        signInButton.layer.shadowOffset = .zero
    }
    
    private func defineLayoutForViews() {
        
        signInTitle.autoSetDimension(.height, toSize: 26)
        signInTitle.autoPinEdge(toSuperviewSafeArea: .top, withInset: 48)
        signInTitle.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        signInTitle.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
        
        emailInputContainer.autoSetDimension(.height, toSize: 76)
        emailInputContainer.autoPinEdge(.top, to: .bottom, of: signInTitle, withOffset: 48)
        emailInputContainer.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        emailInputContainer.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
        
        emailLabel.autoSetDimension(.height, toSize: 20)
        emailLabel.autoPinEdge(toSuperviewEdge: .top)
        emailLabel.autoPinEdge(toSuperviewEdge: .leading)
        emailLabel.autoPinEdge(toSuperviewEdge: .trailing)
        
        usernameInputTextField.autoSetDimension(.height, toSize: 48)
        usernameInputTextField.autoPinEdge(.top, to: .bottom, of: emailLabel, withOffset: 8)
        usernameInputTextField.autoPinEdge(toSuperviewEdge: .leading)
        usernameInputTextField.autoPinEdge(toSuperviewEdge: .trailing)
        
        passwordInputContainer.autoSetDimension(.height, toSize: 76)
        passwordInputContainer.autoPinEdge(.top, to: .bottom, of: emailInputContainer, withOffset: 24)
        passwordInputContainer.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        passwordInputContainer.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)

        passwordLabel.autoSetDimension(.height, toSize: 20)
        passwordLabel.autoPinEdge(toSuperviewEdge: .top)
        passwordLabel.autoPinEdge(toSuperviewEdge: .leading)
        passwordLabel.autoPinEdge(toSuperviewEdge: .trailing)

        passwordInputTextField.autoSetDimension(.height, toSize: 48)
        passwordInputTextField.autoPinEdge(.top, to: .bottom, of: passwordLabel, withOffset: 8)
        passwordInputTextField.autoPinEdge(toSuperviewEdge: .leading)
        passwordInputTextField.autoPinEdge(toSuperviewEdge: .trailing)
        
        signInButton.autoPinEdge(.top, to: .bottom, of: passwordInputContainer, withOffset: 48)
        signInButton.autoSetDimension(.height, toSize: 40)
        signInButton.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 32)
        signInButton.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 32)
    }
    
}


