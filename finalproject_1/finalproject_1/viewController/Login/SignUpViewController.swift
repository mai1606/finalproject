//
//  SignUpViewController.swift
//  finalproject_1
//
//  Created by _maiWeb#15 on 10/20/20.
//  Copyright © 2020 ICTSUIM. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var navigationBar: UIView!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var boxNameUser: UIView!
    @IBOutlet weak var NameUserTextField: UITextField!
    
    @IBOutlet weak var boxEmailUser: UIView!
    @IBOutlet weak var EmailUserTextField: UITextField!
    
    @IBOutlet weak var boxPassword: UIView!
    @IBOutlet weak var PasswordTextField1: UITextField!
    
    @IBOutlet weak var boxConfirmPassword: UIView!
    @IBOutlet weak var PasswordTextField2: UITextField!
    
    @IBOutlet weak var errorTextField: UILabel!
    
    @IBOutlet weak var SignUpbutton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var borderTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        view.addGestureRecognizer(tap)
        
        // set UI
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
        
        boxNameUser.layer.cornerRadius = 20
        boxNameUser.layer.borderColor = UIColor.systemGray6.cgColor
        boxNameUser.layer.borderWidth = 2
        
        boxEmailUser.layer.cornerRadius = 20
        boxEmailUser.layer.borderColor = UIColor.systemGray6.cgColor
        boxEmailUser.layer.borderWidth = 2
        
        boxPassword.layer.cornerRadius = 20
        boxPassword.layer.borderColor = UIColor.systemGray6.cgColor
        boxPassword.layer.borderWidth = 2
        
        boxConfirmPassword.layer.cornerRadius = 20
        boxConfirmPassword.layer.borderColor = UIColor.systemGray6.cgColor
        boxConfirmPassword.layer.borderWidth = 2
        
        PasswordTextField1.isSecureTextEntry = true
        PasswordTextField2.isSecureTextEntry = true
        
        SignUpbutton.layer.cornerRadius = 20
        
        cancelButton.layer.cornerRadius = 20
        cancelButton.layer.borderColor = UIColor.systemGray6.cgColor
        cancelButton.layer.borderWidth = 2
    }
 //ตรวจสอบข้อมูล
    func vailDateFields() -> String? {
        if NameUserTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
             NameUserTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
             EmailUserTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
             PasswordTextField1.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
             PasswordTextField2.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
//            let cleanedPassword = PasswordTextField1.text!.trimmingCharacters(in: .whitespacesAndNewlines)
           
            let NameUserTextField = PasswordTextField1.text!
            let EmailUserTextField = PasswordTextField1.text!
            let cleanedPassword = PasswordTextField1.text!
            let cleanedPassword2 = PasswordTextField1.text!
            
            if NameUserTextField == "" || EmailUserTextField == "" || cleanedPassword == ""
            || cleanedPassword2 == ""
            {
                return "กรุณาใส่ข้อมูลให้ครบทุกช่อง"
            }
            if utilities.isPasswordValid(cleanedPassword) == false{
               // showAlert(message: "กรุณาเช็ครหัสผ่านของคุณ")
                return "กรุณาเช็ครหัสผ่านของคุณ"
            }
            if PasswordTextField1.text != PasswordTextField2.text {
                //showAlert(message: "รหัสผ่านคุณไม่เหมือนกัน")
                 return "รหัสผ่านคุณไม่เหมือนกัน"
            }
            
            return "กรุณาใส่ข้อมูลให้ครบทุกช่อง"
        }
        return nil
    }
    @IBAction func SignUpTapped(_ sender: Any) {
        guard let nameUser = NameUserTextField.text,let emailUser = EmailUserTextField.text,let passwoerUser =  PasswordTextField1.text else {return}

        let error = vailDateFields()
        if error != nil{
           showError(error!)

        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "InputDateByUserViewController") as! InputDateByUserViewController
            vc.userName = nameUser
            vc.userEmail = emailUser
            vc.userPassword = passwoerUser
            navigationController?.pushViewController(vc,
            animated: true)
            
            
          
            
//            let user1 = NameUserTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//            let email = (EmailUserTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines))
//            let password = PasswordTextField1.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//            //สร้าง user
//
//            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
//                // เช็คข้อผิดพลาด
//                if err != nil {
//                    //สร้างผู้ใช้ผิดพลาด
//                    self.showError("สร้างผู้ใช้ผิดพลาด")
//                }else{
//                    let db = Firestore.firestore()
//                    db.collection("users").addDocument(data: ["NameUser" : user1 ,"uid" : result!.user.uid]){(error) in
//
//                        if error != nil {
//                            self.showError("ผิดพลาดในการเซิฟลง database")
//                        }
//                    }
//
//                    self.TohomePage()
//                }
//            }
        }
        
    }

    func  showError(_ message:String) {
        errorTextField.text = message
        errorTextField.alpha = 1
    }
    @IBAction func backPage(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    func TohomePage() {
        let HomeViewController = storyboard?.instantiateViewController(identifier: "startapp")
        view.window?.rootViewController = HomeViewController
        view.window?.makeKeyAndVisible()
    }
    @objc func handleTap(sender: UITapGestureRecognizer){

        self.view.endEditing(true)
        
    }

    
}
