//
//  LoginVC.swift
//  Task 4
//
//  Created by ME-MAC on 5/14/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

protocol LoginDelegate {
    func login(loggedin: Bool)
}

class LoginVC: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
//    @IBOutlet weak var gmailBtn: GIDSignInButton!
    
    var isLoggedin = false
    var delegate: LoginDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    

    @IBAction func loginBtnTapped(_ sender: Any) {
        guard let email = emailTxt.text, !email.isEmpty,
              let password = passwordTxt.text, !password.isEmpty else {
            return
        }
        
        let sharedInstance = ValidationCheckManager.sharedInstance
        
        if !sharedInstance.isValidEmail(email) {
            sharedInstance.showAlert(vc: self, title: "Invalid Email", message: sharedInstance.alertEmailMsg)
            return
        }
        
        if !sharedInstance.isValidPassword(password) {
            sharedInstance.showAlert(vc: self, title: "Invalid Password", message: sharedInstance.alertPasswordMsg)
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
          guard let strongSelf = self else { return }
            
            if let error = error {
                sharedInstance.showAlert(vc: strongSelf, title: "Login Failed", message: error.localizedDescription)
            }
            
            if (error != nil) {
                sharedInstance.showAlert(vc: strongSelf, title: "Login Failed", message: "Ther is no user with this credentias.")
            } else  {
                Auth.auth().addStateDidChangeListener { [weak self] auth, user in
                    guard let strongSelf = self else { return }
                    
                    if user == user {
                        strongSelf.isLoggedin = true
                        strongSelf.delegate?.login(loggedin: true)
                        strongSelf.dismiss(animated: true)
                        
                    } else {
                        strongSelf.delegate?.login(loggedin: false)

                    }
                }
            }
        }
    }
    
    @IBAction func xBtnTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func gmailBtnTapped(_ sender: Any) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] Result, error in
            guard  error == nil else { return }
            
            guard let user = Result?.user,
            let idToken = user.idToken?.tokenString else { return }
            
            let email = user.profile?.email
            let fullName = user.profile?.name
            let givenName = user.profile?.givenName
            let familyName = user.profile?.familyName
            
            print("email: \(email), fullName: \(fullName), givenName: \(givenName), familyName: \(familyName)")

            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { Result, error in
                //
            }
        }
    }
    
    @IBAction func regiserBtnTapped(_ sender: Any) {
        guard let registerVC = storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as? RegisterVC else { return }
        presentingViewController?.presentSecondaryDetail(registerVC)
    }
    
}

