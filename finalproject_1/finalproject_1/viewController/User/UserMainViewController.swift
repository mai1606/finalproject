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
import FirebaseFirestore
import CollectionPickerView

class UserMainViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    lazy var userName : String = UserDefaults.standard.string(forKey: "userName")!
    lazy var userEmail : String = UserDefaults.standard.string(forKey: "userEmail")!
    lazy var userNeed : String = UserDefaults.standard.string(forKey: "userNeed")!
    lazy var periodDay : String = UserDefaults.standard.string(forKey: "periodDay")!
    lazy var periodMonth : String = UserDefaults.standard.string(forKey: "periodMonth")!
    
    @IBOutlet weak var stackViewD: UIStackView!
    @IBOutlet weak var stackViewM: UIStackView!
    
    @IBOutlet weak var imageUerProfile: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameUserILabel: UILabel!
    @IBOutlet weak var emailUserLabel: UILabel!
    @IBOutlet weak var needUserLabel: UILabel!
    @IBOutlet weak var PeriodDayLabel: UILabel!
    @IBOutlet weak var preiodMonthLabel: UILabel!
    @IBOutlet weak var preiodUiPickerView: CollectionPickerView!
    @IBOutlet weak var preiodMUiPickerView: CollectionPickerView!
    let user = Auth.auth().currentUser
    let userGender:String = "female"
    var userDataName :String = ""
    var gender :String = ""
    var needUser :String = ""
    var email:String = ""
    var PeriodDay:String = ""
    var PeriodMonth:String = ""
    
    var PeriodDayArray :[String] = []
    var PeriodMonthArray :[String] = []
    var numSetUp1 = 10
    var numSetUp2 = 30
    var nameSync: String = ""
    var mailSync: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackViewD.isHidden = true
        stackViewM.isHidden = true
        PeriodDayArray.removeAll()
        PeriodMonthArray.removeAll()
        for a in 1...numSetUp1 {
            PeriodDayArray.append(String(a))
          
        }
        for b in 1...numSetUp2 {
            PeriodMonthArray.append(String(b))
        }
        preiodUiPickerView.delegate = self
        preiodUiPickerView.dataSource = self
        preiodUiPickerView.collectionView.register(
            CollectionPickerViewCell.self,
                   forCellWithReuseIdentifier: "CollectionPickerViewCell")
        preiodMUiPickerView.delegate = self
        preiodMUiPickerView.dataSource = self
        preiodMUiPickerView.collectionView.register(
            CollectionPickerViewCell.self,
                   forCellWithReuseIdentifier: "CollectionPickerViewCell")
        
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
       
    }
    override func viewWillAppear(_ animated: Bool) {
        setopData()
       
    }
    func setopData(){
            let docRef = db.collection("users").document(user!.uid)
            
            docRef.getDocument { [self] (document, error) in
                if let document = document, document.exists {
                    userDataName = document.data()!["NameUser"] as! String
                    gender = document.data()!["gender"] as! String
                    needUser = document.data()!["needUser"] as! String
                    PeriodDay = document.data()!["PeriodDay"] as? String ?? "6"
                    PeriodMonth = document.data()!["PeriodMonth"] as? String ?? "30"
                    nameUserILabel.text = userDataName
                    emailUserLabel.text = userEmail
                    needUserLabel.text = needUser
                    PeriodDayLabel.text = PeriodDay
                    preiodMonthLabel.text = PeriodMonth
                    
                    if(gender == "female"){
                        imageUerProfile.image = UIImage(named: "userw")
                    }else
                    {
                        imageUerProfile.image = UIImage(named: "userm")
                    }
                } else {
                    print("ไม่มีข้อมูลมา ไม่พบข้อมูล")
                   
                }
            }
    }
    
    
    @objc func syncData() {
        //var nameTextFields: String = ""
        self.nameSync = ""
        let alert = UIAlertController(title: Message.alert.title, message:  "", preferredStyle: .alert )
       
        let okAction = UIAlertAction(title: Message.button.ok, style: .default, handler: { [weak self] _ in
            guard let strongSelf = self else { return }
            if let textFields = alert.textFields {
                strongSelf.nameSync = textFields[0].text ?? ""
                strongSelf.mailSync = textFields[1].text ?? ""
                self!.db.collection("users").getDocuments()  {
                    (data, errorr) in
                    if (errorr == nil) {
                        var name :String = ""
                        var id :String = ""
                        for  document in data!.documents {
                            name = document.data()["NameUser"] as! String
                           
                            if name == self!.nameSync {
                                id = document.data()["uid"] as! String
                                self!.db.collection("users").document(id).collection("date").getDocuments() {
                                            (data,error) in
                                            if let error = error {
                                                print(error)
                                            } else {
                                                for datas in data!.documents{
                                                    self!.db.collection("users").document((self?.user!.uid)!).collection("date").document().setData(datas.data())
                                                 
                                                }
                                            }
                                        }
                                self!.db.collection("users").document(id).collection("periods").getDocuments() {
                                            (data,error) in
                                            if let error = error {
                                                print(error)
                                            } else {
                                                for datas in data!.documents{
                                                    self!.db.collection("users").document((self?.user!.uid)!).collection("periods").document().setData(datas.data())
                                                }
                                               print("เสร้จสิ้น")
                                            }
                                        }
                                self!.showAlert(message: "ซิงข้อมูลเสร็จสิ้น")
                            }else{
                                
                            }
                           
                        }
                    }

                }
            }
            
        })
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "name"
        })
        
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "email"
        })
        
        let cancelAction = UIAlertAction(title: Message.button.cancel, style: .default, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
          
        
    }
    

    @objc func logout() {
        showConfirm(message: "ออกจากระบบ", handler: { [weak self] _ in
            guard let strongSelf = self else { return }
            let firebaseAuth = Auth.auth()
                do {
                    try firebaseAuth.signOut()
                    UserDefaults.standard.removeObject(forKey: "userName")
                    UserDefaults.standard.removeObject(forKey: "userEmail")
                    UserDefaults.standard.removeObject(forKey: "userNeed")
                    UserDefaults.standard.removeObject(forKey: "periodDay")
                    UserDefaults.standard.removeObject(forKey: "periodMonth")
                    UserDefaults.standard.removeObject(forKey: "userAge")
                    UserDefaults.standard.removeObject(forKey: "userGender")
                    UserDefaults.standard.removeObject(forKey: "status")
                    UserDefaults.standard.removeObject(forKey: "dayFromHome")
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginVC")

                    strongSelf.view.window?.rootViewController = UINavigationController(rootViewController: loginViewController)
                    strongSelf.view.window?.makeKeyAndVisible()
                    
                    strongSelf.view.window?.makeKeyAndVisible()
                } catch let signOutError as NSError {
                  print ("Error signing out: %@", signOutError)
                }
        }, cancelHandler: nil)
        
    }
    
    @IBAction func logOut(_ sender: UIButton) {
       logout()
       // syncData()
    }
    
    @IBAction func btnMainUser(_ sender: Any)
    {
        if (sender as AnyObject).tag == 0 {
            stackViewD.isHidden = false
        }
        if (sender as AnyObject).tag == 1 {
            stackViewM.isHidden = false
        }
        if (sender as AnyObject).tag == 2 {
            syncData()
//            logout()
        }
    }
    
    @IBAction func btnSaveData(_ sender: Any) {
        if (sender as AnyObject).tag == 0 {
            //ยกเลิก
            stackViewD.isHidden = true
        }
        if (sender as AnyObject).tag == 1 {
            //เซิฟ
            stackViewD.isHidden = true
        }
        if (sender as AnyObject).tag == 2 {
            //ยกเลิก
            stackViewM.isHidden = true
        }
        if (sender as AnyObject).tag == 3 {
            //เซิฟ
            stackViewM.isHidden = true
        }
    }

    
    
}

extension UserMainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return PeriodDayArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionPickerViewCell", for: indexPath) as? CollectionPickerViewCell else { return UICollectionViewCell()}
        if collectionView.tag == 0 {
            cell.label.text = PeriodDayArray[indexPath.row]
        }
        if collectionView.tag == 1 {
            cell.label.text = PeriodMonthArray[indexPath.row]
        }
//        if collectionView == preiodMUiPickerView {
//           
//        }
//        if collectionView == preiodMUiPickerView as? UICollectionView{
//            cell.label.text = PeriodDayArray[indexPath.row]
//        }
//        if collectionView == preiodUiPickerView as? UICollectionView{
//            
//        }
////        if collectionView as? CollectionPickerView == preiodMUiPickerView{
////            cell.label.text = PeriodDayArray[indexPath.row]
////        }
////        if collectionView == preiodUiPickerView {
////            cell.label.text = PeriodMonthArray[indexPath.row]
////        }
//       

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        selectIndex = indexPath.row
        print("xxxxxx",indexPath.row)
    }
    
    
}
