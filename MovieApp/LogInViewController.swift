import Foundation
import UIKit
import PureLayout

class LogInViewController: UIViewController {
    
    private let bgColor = UIColor(red: 0.07, green: 0.23, blue: 0.39, alpha: 1.00)
    private let lightBlue = UIColor(red: 0.30, green: 0.70, blue: 0.87, alpha: 1.00)
    private let darkBlue = UIColor(red: 0.082, green: 0.302, blue: 0.521, alpha: 1.00)
    private let shadowColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.09)
    
    private var button: UIButton!
    private var label: UILabel!
    private var email: UILabel!
    private var password: UILabel!
    private var username: UITextField!
    private var pass: UITextField!
    
    private var inputView1: UIView!
    private var inputView2: UIView!
    
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
        label = UILabel()
        view.addSubview(label)
        label.text = "Sign in"
        
        inputView1 = UIView()
        view.addSubview(inputView1)
        
        email = UILabel()
        inputView1.addSubview(email)
        email.text = "Email address"
        
        username = UITextField()
        inputView1.addSubview(username)
        
        inputView2 = UIView()
        view.addSubview(inputView2)
        
        password = UILabel()
        inputView2.addSubview(password)
        password.text = "Password"
        
        pass = UITextField()
        inputView2.addSubview(pass)
        
        button = UIButton()
        view.addSubview(button)
        
        
    }
    
    private func styleViews() {
        view.backgroundColor = bgColor
        
        label.textColor = .white
        label.font = UIFont(name: "ProximaNova-Bold", size: 24)
        label.textAlignment = .center
        
        email.textColor = .white
        email.font = UIFont(name: "ProximaNova-Bold", size: 14)
        email.textAlignment = .left
        
        username.backgroundColor = darkBlue
        username.layer.cornerRadius = 10
        username.layer.borderWidth = 1
        username.layer.borderColor = lightBlue.cgColor
        username.textColor = lightBlue
        
        username.layer.shadowColor = UIColor.black.cgColor
        username.layer.shadowOpacity = 0.5
        username.layer.shadowRadius = 3
        username.layer.shadowOffset = .zero
        
        // padding of 16px for input text and placeholder
        let paddingView = UIView(frame: CGRectMake(12, 12, 16, self.username.frame.height))
        username.leftView = paddingView
        username.leftViewMode = UITextField.ViewMode.always
        
        // placeholder
        username.attributedPlaceholder = NSAttributedString(
            string: "ex. Matt@iosCourse.com",
            attributes: [NSAttributedString.Key.foregroundColor: lightBlue]
        )
        
        password.textColor = .white
        password.font = UIFont(name: "ProximaNova-Bold", size: 14)
        password.textAlignment = .left
        
        pass.isSecureTextEntry = true
        
        pass.backgroundColor = darkBlue
        pass.layer.cornerRadius = 10
        pass.layer.borderWidth = 1
        pass.layer.borderColor = lightBlue.cgColor
        pass.textColor = lightBlue
        
        pass.layer.shadowColor = UIColor.black.cgColor
        pass.layer.shadowOpacity = 0.5
        pass.layer.shadowRadius = 3
        pass.layer.shadowOffset = .zero
        
        let paddingView2 = UIView(frame: CGRectMake(12, 12, 16, self.username.frame.height))
        
        // padding of 16px for input text and placeholder
        pass.leftView = paddingView2
        pass.leftViewMode = UITextField.ViewMode.always

        // placeholder
        pass.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: lightBlue]
        )
        
        button.setTitle("Sign in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = lightBlue
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 14)
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 3
        button.layer.shadowOffset = .zero
        

    }
    
    private func defineLayoutForViews() {
        
        label.autoSetDimension(.height, toSize: 26)
        label.autoPinEdge(toSuperviewSafeArea: .top, withInset: 48)
        label.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        label.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
        
        inputView1.autoSetDimension(.height, toSize: 76)
        inputView1.autoPinEdge(.top, to: .bottom, of: label, withOffset: 48)
        inputView1.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        inputView1.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
        
        email.autoSetDimension(.height, toSize: 20)
        email.autoPinEdge(toSuperviewEdge: .top)
        email.autoPinEdge(toSuperviewEdge: .leading)
        
        username.autoSetDimension(.height, toSize: 48)
        username.autoPinEdge(.top, to: .bottom, of: email, withOffset: 8)
        username.autoPinEdge(toSuperviewEdge: .leading)
        username.autoPinEdge(toSuperviewEdge: .trailing)
        
        inputView2.autoSetDimension(.height, toSize: 76)
        inputView2.autoPinEdge(.top, to: .bottom, of: inputView1, withOffset: 24)
        inputView2.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        inputView2.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)

        password.autoSetDimension(.height, toSize: 20)
        password.autoPinEdge(toSuperviewEdge: .top)
        password.autoPinEdge(toSuperviewEdge: .leading)

        pass.autoSetDimension(.height, toSize: 48)
        pass.autoPinEdge(.top, to: .bottom, of: password, withOffset: 8)
        pass.autoPinEdge(toSuperviewEdge: .leading)
        pass.autoPinEdge(toSuperviewEdge: .trailing)
        
        button.autoPinEdge(.top, to: .bottom, of: inputView2, withOffset: 48)
        button.autoSetDimension(.height, toSize: 40)
        button.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 32)
        button.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 32)
    }
    
}
