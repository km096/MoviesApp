//
//  ProfileVC.swift
//  Task 4
//
//  Created by ME-MAC on 5/14/23.
//

import UIKit
import FirebaseAuth

class ProfileVC: UIViewController, LoginDelegate, RegisterDelegate {
    
    

    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var logoutBtn: RoundedUIButton!
    
    var isLoggedIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkLoggedin()
        createInstanceFromRgisterVC()
    }
    
    func checkLoggedin() {
        if (Auth.auth().currentUser != nil) {
            isLoggedIn = true
            loginView.isHidden = true
            logoutBtn.isHidden = false
        } else {
            isLoggedIn = false
            loginView.isHidden = false
            logoutBtn.isHidden = true
        }
    }
    
    func createInstanceFromRgisterVC() {
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let registerVC = storyboard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        registerVC.registerDelegate = self
    }
    
    func login(loggedin: Bool) {
        if loggedin {
            isLoggedIn = true
            viewWillAppear(true)
        }
    }
    
    func register(register: Bool) {
        if register {
            isLoggedIn = true
            viewWillAppear(true)
        }
    }
    
    @IBAction func loginBtnTapped(_ sender: Any) {

        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        loginVC.delegate = self
        present(loginVC, animated: true)

    }
    
    @IBAction func logoutBtnTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            viewWillAppear(true)

        } catch {
            print("an error occurred")
        }
    }
}
