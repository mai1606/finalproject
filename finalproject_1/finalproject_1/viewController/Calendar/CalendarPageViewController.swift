//
//  CalendarPageViewController.swift
//  finalproject_1
//
//  Created by Mai on 1/12/2563 BE.
//  Copyright © 2563 BE ICTSUIM. All rights reserved.
//

import UIKit
import FSCalendar
import Foundation
import Firebase
import FirebaseAuth

class CalendarPageViewController: UIViewController {


    @IBOutlet weak var thirdStackView: UIStackView!
    @IBOutlet weak var secondStackView: UIStackView!
    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var calendarCollectionview: UICollectionView!
    let dateFormatter = DateFormatter()
    
    var emotions: [Detail] = DetailPageConfigurator.getAll()
    var emotionsSelected: [Detail] = []
    var symptons: [Detail] = DetailPageConfigurator.getSymptons()
    var sexs: [Detail] = DetailPageConfigurator.getSex()
    var contents: [Detail] = DetailPageConfigurator.getContent()
    var leucorrhoeas: [Detail] = DetailPageConfigurator.getLeucorrhoea()
    var arrayDate: [String] = []
    var isPeriod: Bool = true
    var selectedDate: Date = Date()
    
    let db = Firestore.firestore()
    let user = Auth.auth().currentUser
   // var dataArray:[String]
   
    override func viewDidLoad() {
        super.viewDidLoad()
//        let docRef1 = db.collection("users").document(user!.uid).collection("date").document()
//        docRef1.getDocument{ (document, error) in
//            if let document = document, document.exists {
//                let  dataDescription = document.data()
//
//                print("----->",dataDescription )
//            }else {
//                print("----xxxxx-")
//            }
//        }
        
        setup()
        // Do any additional setup after loading the view.
       
       // arrayDate?.append(("a"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        calendarCollectionview.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        calendarCollectionview.reloadData()
//     db.collection("users").document(user!.uid).collection("date").document("\(dateFormatter.string(from: selectedDate))").updateData(["Detail\(emo)" : emo ])
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailPageSegue" {
            let detailPageViewController = segue.destination as? DetailPageViewController
            detailPageViewController?.selectedDate = self.selectedDate
        }
        let backButton = UIBarButtonItem()
        backButton.title = dateFormatter.string(from: selectedDate)
        navigationItem.backBarButtonItem = backButton
        
    }
    
    func setup() {
        calendar.delegate = self
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0;
        calendarCollectionview.register(UINib(nibName: "DetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailCollectionViewCell")
        calendarCollectionview.delegate = self
        calendarCollectionview.dataSource = self
        
//        firstStackView.isHidden = isPeriod
//        secondStackView.isHidden = !isPeriod
//        thirdStackView.isHidden = !isPeriod
    }
    
    
    @IBAction func bntCaledarTosave(_ sender: Any) {
      //  let cc = DetailPageViewController()
       performSegue(withIdentifier: "detailPageSegue", sender: nil)
      //  navigationController?.pushViewController(cc, animated: true)
    }
    
}


extension CalendarPageViewController: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.selectedDate = date
        dateFormatter.dateFormat = "d MMM yyyy"
        dateFormatter.string(from: selectedDate)
        let docRef = db.collection("users").document(user!.uid).collection("date").document (dateFormatter.string(from: selectedDate))
        
        docRef.getDocument { [self] (document, error) in
            if let document = document, document.exists {
                let  dataDescription = document.data()!["Detail"] as! [String]
                if  self.arrayDate.count == 0{
                    self.arrayDate = dataDescription
                   // print(self.arrayDate?.count)
                }else{
                    self.arrayDate = []
                    self.arrayDate = dataDescription
                    //print(self.arrayDate?.count)
                }
                
//                for a in arrayDate! {
//                  //  print("Document data: \(a)")
//
//                }
                calendarCollectionview.reloadData()
               // print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
                self.arrayDate = []
                //print(self.arrayDate?.count)
                calendarCollectionview.reloadData()
            }
            
            if !arrayDate.isEmpty {
                emotionsSelected = []
                for descr in arrayDate {
                    let emo = emotions.filter({ $0.descr == descr })
                    emotionsSelected.append(contentsOf: emo)
                }
            } else {
                emotionsSelected = []
            }
            calendarCollectionview.reloadData()
        }

    }
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
      
        return 0
    }
}

extension CalendarPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print("------->",self.arrayDate?.count)
       // return details.count
      
        return emotionsSelected.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCollectionViewCell", for: indexPath) as? DetailCollectionViewCell else { return UICollectionViewCell() }
        var detail: Detail?
        detail = emotionsSelected[indexPath.row]
        cell.setup(detail: detail)
        
       
    
//            for anarray in arrayDate!{
//                if let descr = detail.descr {
//
//                }
//                print("=====+++>" ,detail?.descr ,"+++",anarray)
//                if detail?.descr == anarray {
//                    print("=====+++>" ,anarray)
//                    cell.setupImage(detail: detail,X: anarray)
//                }else{
//                    //return null
//                }
               
        //}
        
        
        
      //  print(arrayDate?[indexPath.row])
      //  if detail1?.descr == arrayDate?[indexPath.row]{
    //        print(arrayDate?[indexPath.row])
    //        cell.setup(detail: detail1)
     //   }
      
  
        
        
        //cell.setup(detail: detail)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 70)
    }
}
