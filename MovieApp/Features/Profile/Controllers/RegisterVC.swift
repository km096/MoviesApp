//
//  RegisterVC.swift
//  Task 4
//
//  Created by ME-MAC on 5/14/23.
//

import UIKit
import FirebaseAuth

protocol RegisterDelegate {
    func register(register: Bool)
}

class RegisterVC: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    
    var registerDelegate: RegisterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func registerBtnTapped(_ sender: Any) {
        guard let email = emailTxt.text, !email.isEmpty,
              let password = passwordTxt.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTxt.text, !confirmPassword.isEmpty, confirmPassword == password
        else { return }
        
        let sharedInstance = ValidationCheckManager.sharedInstance
        
        if !sharedInstance.isValidEmail(email) {
            sharedInstance.showAlert(vc: self, title: "Invalid Email", message: sharedInstance.alertEmailMsg)
                       return
        }
        
        if !sharedInstance.isValidPassword(password) {
            sharedInstance.showAlert(vc: self, title: "Invalid Password", message: sharedInstance.alertPasswordMsg)
                   return
               }
        if confirmPassword != password {
            sharedInstance.showAlert(vc: self, title: "Wrong password", message: "Passwords did not match.")
        }
        
        // Create user with email and password
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] user, error in
            guard let strongSelf = self else { return }
            strongSelf.registerDelegate?.register(register: true)
            
            if let error = error {
                sharedInstance.showAlert(vc: strongSelf, title: "Signup Failed", message: error.localizedDescription)
                return
            }
            
            strongSelf.dismiss(animated: true)
            
        }
    }
    
    @IBAction func regiterGmailBtnTapped(_ sender: Any) {
    }
    
    @IBAction func registerFbBtnTapped(_ sender: Any) {
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    func isValidEmail(_ email: String) -> Bool {
        // Regular expression pattern for validating email
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        // Password should contain at least one uppercase letter, one lowercase letter, one digit, and be at least 8 characters long
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
