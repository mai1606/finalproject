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

    @IBOutlet weak var fourthStackView: UIStackView!
    @IBOutlet weak var thirdStackView: UIStackView!
    @IBOutlet weak var secondStackView: UIStackView!
    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var calendarCollectionview: UICollectionView!
    let dateFormatter = DateFormatter()
    let gregorian: Calendar = Calendar(identifier: .buddhist)
    
    var emotions: [Detail] = DetailPageConfigurator.getAll()
    var emotionsSelected: [Detail] = []
    var symptons: [Detail] = DetailPageConfigurator.getSymptons()
    var sexs: [Detail] = DetailPageConfigurator.getSex()
    var contents: [Detail] = DetailPageConfigurator.getContent()
    var leucorrhoeas: [Detail] = DetailPageConfigurator.getLeucorrhoea()
    var arrayDate: [String] = []
    var isPeriod: Bool = true
    var selectedDate: Date = Date()
    var periods: [Period] = []
    
    var periodsDayinYear : [String] = []
    var ovulationDayinYear : [String] = []
    var periodsNextMonth: String = ""
    var firstperiods :String = ""
    
    let db = Firestore.firestore()
    let user = Auth.auth().currentUser
    //var dayChoose = Date = Date()
    let dateFormat2 = DateFormatter()
    var toDay = Date.currentDate()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        setup()
        cDate()
        // Do any additional setup after loading the view.
       
       // arrayDate?.append(("a"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        cDate()
        calendarCollectionview.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
//        calendarCollectionview.reloadData()
//     db.collection("users").document(user!.uid).collection("date").document("\(dateFormatter.string(from: selectedDate))").updateData(["Detail\(emo)" : emo ])
        
    }
    
    
    @IBAction func ChooseDay(_ sender: Any) {
        
        periods = []
        calPeriod(firstDate: selectedDate, isFromClick: true)
       
        
        
    }
    func cDate() {
        dateFormat2.dateFormat = "YYYY"
//        dateFormat3.locale = Locale(identifier: "th_TH")
        let docRef = db.collection("users").document(user!.uid).collection("periods").document (dateFormat2.string(from: toDay))
        
        docRef.getDocument{ (document, error) in
            if let document = document, document.exists {
                let firstPeriod = document.data()!["firstPeriods"] as! String
                let Day =  self.dateFormatter.date(from: firstPeriod)
                self.calPeriod(firstDate: Day!, isFromClick: true)
               
            }else {
               print("ไม่มีข้อมูล")
            }
        }
        
    }
    func todate(){
        let db1 = Firestore.firestore()
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy"
        db1.collection("users").document(user!.uid).collection("periods").document("\(dateFormatter1.string(from:selectedDate))").setData(["periods":periodsDayinYear,"ovulationDay":ovulationDayinYear,"periodsNextMonth":periodsNextMonth,"firstPeriods":firstperiods])
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
        dateFormatter.dateFormat = "d MMM yyyy"
        calendar.delegate = self
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0;
        calendarCollectionview.register(UINib(nibName: "DetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailCollectionViewCell")
        calendarCollectionview.delegate = self
        calendarCollectionview.dataSource = self
        
        secondStackView.isHidden = false
        thirdStackView.isHidden = false
        fourthStackView.isHidden = false
        

    }
    
    
    func calPeriod(firstDate: Date = Date.currentDate(),isFromClick: Bool = false) {
        var period: Period = Period()
        period.firstDay = dateFormatter.string(from: firstDate)
        period.periodDays = getPeriod(date: firstDate)
        if let ovu = dateFormatter.string(for: gregorian.date(byAdding: .day, value: 14, to: firstDate)) {
            period.ovulationDay = ovu
        }
        if let nextDay = gregorian.date(byAdding: .day, value: 30, to: firstDate) {
            period.nextDays = getPeriod(date: nextDay)
            period.fisrtPredictPeriodDay = period.nextDays.first
        }
        
        if isFromClick {
           // dateFormatter.dateFormat = "MMM yyyy"
            firstperiods = dateFormatter.string(for: firstDate)!
            periodsDayinYear.append(contentsOf: getPeriod(date: firstDate))
            ovulationDayinYear.append((dateFormatter.string(for: gregorian.date(byAdding: .day, value: 14, to: firstDate)))!)
            periodsNextMonth = dateFormatter.string(for: gregorian.date(byAdding: .day, value: 30, to: firstDate))!
           
        }
        periods.append(period)
        
        if let nextpre = period.fisrtPredictPeriodDay, let nextDate = dateFormatter.date(from: nextpre) {
            let month = String(nextpre.split(separator: " ")[1])
            if month != "Dec" {
                calPeriod(firstDate: nextDate)
            } else {
                calendar.reloadData()
            }
        }
        todate()
    }
    
    func getPeriod(date: Date) -> [String] {
        var dates: [String] = []
        for i in 0...6 {
            guard let date = gregorian.date(byAdding: .day, value: i, to: date) else { continue }
            dates.append(dateFormatter.string(from: date))
        }
        return dates
        
    }
    
    
    @IBAction func bntCaledarTosave(_ sender: Any) {
      //  let cc = DetailPageViewController()
       performSegue(withIdentifier: "detailPageSegue", sender: nil)
      //  navigationController?.pushViewController(cc, animated: true)
    }
    
}

//ดึงข้อมูล อาการมาแสดง
extension CalendarPageViewController: FSCalendarDelegate, FSCalendarDelegateAppearance, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.selectedDate = date
        
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
               
                
                calendarCollectionview.reloadData()
              
            } else {
                print("ไม่มีข้อมูลมา ไม่พบข้อมูล")
                self.arrayDate = []
                
            
                calendarCollectionview.reloadData()
            }
            
            if !arrayDate.isEmpty {
                emotionsSelected = []
                for descr in arrayDate {

                    let emo = emotions.filter({ $0.descr == descr })
                    emotionsSelected.append(contentsOf: emo)
                }
                
               
            } else {

                setup()
                emotionsSelected = []
               
            }
            calendarCollectionview.reloadData()
        }

    }
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
      
        return 0
    }
    
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        
            return nil
        }
        
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
           
           
//            if periodsDayinYear == dateFormatter.string(from: date) {
//                return UIColor(named: "Color_main1")
//            }
           
            return appearance.selectionColor
        }
        
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
            for day in periodsDayinYear{
                if day == dateFormatter.string(from: date) {
                    return UIColor(named: "Color_main1")
                   
                }
            }
            return nil
        }
        
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderDefaultColorFor date: Date) -> UIColor? {
//            if periods.first(where: {$0.firstDay == dateFormatter.string(from: date)}) != nil {
//                return .black
//            } else if periods.first(where: {$0.periodDays.contains(dateFormatter.string(from: date))}) != nil {
//                return .purple}
            
            if periods.first(where: {$0.ovulationDay == dateFormatter.string(from: date)}) != nil
            {
                return .brown
            } else if periods.first(where: {$0.nextDays.contains(dateFormatter.string(from: date))}) != nil
            {
                return UIColor(named: "Color_main1")
            }
            for oday in ovulationDayinYear{
                if oday == dateFormatter.string(from: date) {
                    return UIColor(named: "Color_main3")
                   
                }
            }
            return appearance.borderDefaultColor
        }
        
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderSelectionColorFor date: Date) -> UIColor? {

            return appearance.borderSelectionColor
        }
        
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderRadiusFor date: Date) -> CGFloat {

            return 1.0
        }
}

extension CalendarPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print("------->",self.arrayDate?.count)
       // return details.count

        if emotionsSelected.count == 0 {
           // thirdStackView.isHidden = true
           // fourthStackView.isHidden = true
            return emotionsSelected.count
        }else{
          //  thirdStackView.isHidden = false
           // fourthStackView.isHidden = false
            return emotionsSelected.count
        }
      
        //return emotionsSelected.count
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
