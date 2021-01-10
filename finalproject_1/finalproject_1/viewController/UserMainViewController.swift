//
//  UserMainViewController.swift
//  finalproject_1
//
//  Created by _maiWeb#15 on 10/23/20.
//  Copyright © 2020 ICTSUIM. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class UserMainViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    lazy var userName : String = UserDefaults.standard.string(forKey: "userName")!
    lazy var userEmail : String = UserDefaults.standard.string(forKey: "userEmail")!
    lazy var userNeed : String = UserDefaults.standard.string(forKey: "userNeed")!
    lazy var periodDay : String = UserDefaults.standard.string(forKey: "periodDay")!
    lazy var periodMonth : String = UserDefaults.standard.string(forKey: "periodMonth")!
    
    @IBOutlet weak var imageUerProfile: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameUserILabel: UILabel!
    @IBOutlet weak var emailUserLabel: UILabel!
    @IBOutlet weak var needUserLabel: UILabel!
    @IBOutlet weak var PeriodDayLabel: UILabel!
    @IBOutlet weak var preiodMonthLabel: UILabel!
    let user = Auth.auth().currentUser
    let userGender:String = "female"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let docRef = db.collection("users").document(user!.uid)
        

        // Force the SDK to fetch the document from the cache. Could also specify
        // FirestoreSource.server or FirestoreSource.default.
        docRef.getDocument(source: .cache) { (document, error) in
          if let document = document {
            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
            print("Cached document data: \(dataDescription)")
          } else {
            print("Document does not exist in cache")
          }
        }

        // Do any additional setup after loading the view.
        
        imageUerProfile.layer.borderWidth = 1
        imageUerProfile.layer.masksToBounds = false
        imageUerProfile.layer.borderColor = UIColor.black.cgColor
        imageUerProfile.layer.cornerRadius = imageUerProfile.frame.height/2
        imageUerProfile.clipsToBounds = true
       
        
        if(userGender == "female"){
            imageUerProfile.image = UIImage(named: "userw")
        }else
        {
            imageUerProfile.image = UIImage(named: "userm")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        nameUserILabel.text = userName
        emailUserLabel.text = userEmail
        needUserLabel.text = userNeed
        PeriodDayLabel.text = periodDay
        preiodMonthLabel.text = periodMonth
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func logOut(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
            do {
              try firebaseAuth.signOut()
            } catch let signOutError as NSError {
              print ("Error signing out: %@", signOutError)
            }
        
        UserDefaults.standard.removeObject(forKey: "userName")
        UserDefaults.standard.removeObject(forKey: "userEmail")
        UserDefaults.standard.removeObject(forKey: "userNeed")
        UserDefaults.standard.removeObject(forKey: "periodDay")
        UserDefaults.standard.removeObject(forKey: "periodMonth")
        UserDefaults.standard.removeObject(forKey: "userAge")
        UserDefaults.standard.removeObject(forKey: "userGender")
        
            let LoginViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginViewController) as? ViewController
                self.view.window?.rootViewController = UINavigationController(rootViewController: LoginViewController!)
                self.view.window?.makeKeyAndVisible()
            
        
    }
   
}
