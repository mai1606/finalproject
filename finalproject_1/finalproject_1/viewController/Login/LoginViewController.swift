//
//  LoginViewController.swift
//  finalproject_1
//
//  Created by _maiWeb#15 on 10/20/20.
//  Copyright © 2020 ICTSUIM. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var navigationBar: UIView!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var boxNameView: UIView!
    @IBOutlet weak var NameUserTextfield: UITextField!
    
    @IBOutlet weak var boxPasswordView: UIView!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var LoginButton: UIButton!
    
    @IBOutlet weak var errorTextfield: UILabel!
    
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
               view.addGestureRecognizer(tap)
        
        navigationBar.layer.cornerRadius = 20
        navigationBar.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner ]
        
        scrollView.showsVerticalScrollIndicator = false
               
        containerView.backgroundColor = UIColor.white
        containerView.layer.cornerRadius = 20
        containerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner ]
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 20
        containerView.layer.shadowOpacity = 0.1
               
        boxNameView.layer.cornerRadius = 20
        boxNameView.layer.borderColor = UIColor.systemGray6.cgColor
        boxNameView.layer.borderWidth = 2
               
        boxPasswordView.layer.cornerRadius = 20
        boxPasswordView.layer.borderColor = UIColor.systemGray6.cgColor
        boxPasswordView.layer.borderWidth = 2
    
        PasswordTextField.isSecureTextEntry = true
               
        logInButton.layer.cornerRadius = 20
               
        cancelButton.layer.cornerRadius = 20
        cancelButton.layer.borderColor = UIColor.systemGray6.cgColor
        cancelButton.layer.borderWidth = 2
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backPage(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func LoginTapped(_ sender: Any) {
        let email = NameUserTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().signIn(withEmail: email, password: password){(result,error) in
            if error != nil {
                self.errorTextfield.text = error!.localizedDescription
                self.errorTextfield.alpha = 1
            }else{
                let user = Auth.auth().currentUser
                    guard user != nil else { return }
                        let uid = user!.uid
               
                UserDefaults.standard.set(user!.email, forKey: "userEmail")
                let db = Firestore.firestore()
                
                let docRef = db.collection("users").document(uid)
                
                docRef.getDocument() { (document, error) in
                        if let error = error {
                            print("Error getting documents: \(error)")
                        } else {
                            
                            UserDefaults.standard.set(document!.data()!["NameUser"]as! String, forKey: "userName")
                            UserDefaults.standard.set(document!.data()!["needUser"]as! String, forKey: "userNeed")
                            UserDefaults.standard.set(document!.data()!["PeriodDay"] as! Int, forKey: "periodDay")
                            UserDefaults.standard.set(document!.data()!["PeriodMonth"] as! Int, forKey: "periodMonth")
                            UserDefaults.standard.set(document!.data()!["age"] as! Int, forKey: "userAge")
                            UserDefaults.standard.set(document!.data()!["gender"] as! String, forKey: "userGender")
                            UserDefaults.standard.set(document!.data()!["status"] as! String, forKey: "status")
                            
                            if UserDefaults.standard.string(forKey: "status") == "doctor" {
                                let userMainViewController = self.storyboard?.instantiateViewController(identifier: "profilePage")
                                self.view.window?.rootViewController = userMainViewController
                                
                            } else {
                                let HomeViewController = self.storyboard?.instantiateViewController(identifier: "startapp")
                                self.view.window?.rootViewController = HomeViewController
                            }

                            self.view.window?.makeKeyAndVisible()
                
                        }
                }
            }
        }
    }
    @objc func handleTap(sender: UITapGestureRecognizer){

        self.view.endEditing(true)
        
    }
    
}
