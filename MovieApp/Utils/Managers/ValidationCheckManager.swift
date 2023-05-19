//
//  ValidationCheck.swift
//  MovieApp
//
//  Created by ME-MAC on 5/20/23.
//

import Foundation
import UIKit

class ValidationCheckManager {
    
    static let sharedInstance = ValidationCheckManager()
    private init() {}
    
    let alertEmailMsg = "Please enter a valid email address."
    let alertPasswordMsg = "Please enter a password that is at least 8 characters long and contains at least one uppercase letter, one lowercase letter, and one digit."
    
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
    
    func showAlert(vc: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        vc.present(alert, animated: true)
    }
}
