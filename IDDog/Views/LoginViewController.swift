//
//  ViewController.swift
//  IDDog
//
//  Created by Lucas Santos on 03/06/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signInActivityIndicator: UIActivityIndicatorView!
    
    private let presenter = LoginPresenter(service: LoginService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
    }

    @IBAction func signInPressed(_ sender: UIButton) {
        if let email = emailTextField.text {
            if(email.isValidEmail()){
                self.presenter.login(email: email)
            } else {
                showError(message: "Email Inválido!")
            }
        }
    }
    
    
    func showError(message: String){
        let alertController = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }

}


extension LoginViewController: LoginView{
    func startLoading() {
        self.signInActivityIndicator.startAnimating()
        signInButton.isHidden = true
    }
    
    func finishLoading() {
        self.signInActivityIndicator.stopAnimating()
        signInButton.isHidden = false
    }
    
    func loginSuccessful() {
        print("success")
        self.performSegue(withIdentifier: "loggedSegue", sender: nil)
    }
    
    func errorOnLogin(message: String) {
        self.showError(message: message)
    }
    
    
}

extension String {
    func isValidEmail() -> Bool{
        let stringPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let expression = try! NSRegularExpression(pattern: stringPattern, options: .caseInsensitive)
        return (expression.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil)
    }
}
