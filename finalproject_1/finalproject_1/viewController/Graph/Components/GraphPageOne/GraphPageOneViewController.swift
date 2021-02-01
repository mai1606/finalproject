import UIKit
import MultiProgressView
import FirebaseAuth
import Foundation
import Firebase

class GraphPageOneViewController: UIViewController {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var janProgressView: MultiProgressView!
    @IBOutlet weak var febProgressView: MultiProgressView!
    @IBOutlet weak var periodStackView: UIStackView!
    let gregorian: Calendar = Calendar(identifier: .buddhist)
    let dateFormat1 = DateFormatter()
    let dateFormat2 = DateFormatter()
    let dateFormat3 = DateFormatter()
    var numCount = 0
    var period = true
    
    var janPeriodCount :Int = 0
    
    var toDay = Date.currentDate()
    var dayPeriods = Date.currentDate()
    let db = Firestore.firestore()
    let user = Auth.auth().currentUser
    var allPeriod: [[String:Any]] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.layer.cornerRadius = 20
        backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        setUpProgressView(janProgressView)
        setUpProgressView(febProgressView)
    }
    override func viewWillAppear(_ animated: Bool) {
        DataBase()
    }
    func setUp(){
        
    }
    func DataBase(){
        dateFormat1.dateFormat = "dd MMM yyyy"
        dateFormat2.dateFormat = "MMM YYYY"
        dateFormat3.dateFormat = "yyyy"
//        dateFormat3.locale = Locale(identifier: "th_TH")
       
        db.collection("users").document(user!.uid).collection("periods").getDocuments() {
            (data, error) in

            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                self.allPeriod.removeAll()
                for document in data.documents.reversed() {
                    var period: [String: Any] = [:]
                    period["month"] = document.documentID
                    period["firstPeriods"] = document.data()["firstPeriods"]
                    if let pp = document.data()["periods"] as? [String] {
                        period["periodCount"] = pp.count
                    }
                    period["nextCount"] = 0
                    self.allPeriod.append(period)
                }
                
                if self.allPeriod.count > 1 {
                    for (index,period) in self.allPeriod.enumerated() {
                        if index + 1 <= self.allPeriod.count - 1 {
                            let nextPeriod = self.allPeriod[index + 1]
                            if let p1 = period["firstPeriods"] as? String, let p2 = nextPeriod["firstPeriods"] as? String, let  d1 = self.dateFormat1.date(from: p1),let d2 = self.dateFormat1.date(from: p2) {
                                self.allPeriod[index]["nextCount"] = Calendar.current.dateComponents([.day], from: d1, to: d2).day!
                            }
                        }
                    }
                }
                self.setUpSection(self.janProgressView)
                
            }
            
//            if (errorr == nil){
//                var  datefirst :String = ""
//                var  dateNextM :String = ""
//                var  isPeriodDb :[String] = []
//                var dayPeriods2 :String = ""
//                for  document in data!.documents {
//
//                     datefirst = document.data()["firstPeriods"] as! String
//                     dateNextM = document.data()["periodsNextMonth"] as! String
//                     isPeriodDb = document.data()["periods"] as! [String]
//                    let dayPeriods2 = String(datefirst.split(separator: " ")[1]) + String(datefirst.split(separator: " ")[2])
//                    print("_+_+_+_+_+>>>",dayPeriods2)
//                    if  dayPeriods2 == "Jan" + String(datefirst.split(separator: " ")[2]) && String(datefirst.split(separator: " ")[2]) == self.dateFormat3.string(from: self.toDay){
//
//                        self.janPeriodCount = isPeriodDb.count
//                    }
//
//                  //  gregorian.date(byAdding: .day, value: 14, to: firstDate)
//                }
//
//            }else {
//                print("ไม่มีข้อมูล")
//
//            }
        }
    }
    
    func setUpSection(_ progressView: MultiProgressView) {
        progressView.dataSource = self
        progressView.setProgress(section: 0, to: 0.5)
        progressView.setProgress(section: 1, to: 0.5)
    }
    
    func setUpProgressView(_ progressView: MultiProgressView) {
        progressView.lineCap = .round
        progressView.layer.cornerRadius = 10
        progressView.layer.masksToBounds = true
    }
    
}

extension GraphPageOneViewController: MultiProgressViewDataSource {
    func numberOfSections(in progressView: MultiProgressView) -> Int {
        return 2
    }
    
    func progressView(_ progressView: MultiProgressView, viewForSection section: Int) -> ProgressViewSection {
        let pp = ProgressViewSection()
        if section == 0 {
            pp.backgroundColor = .blue
        } else {
            pp.backgroundColor = .gray
        }
        switch progressView {
            case janProgressView:
                if let month = self.allPeriod.first(where: {($0["month"] as? String ?? "").hasPrefix("Jan")}) , let periodCount = month["periodCount"] as? Int, let nextCount = month["nextCount"] as? Int{
                    if section == 0 {
                        pp.setTitle("\(periodCount)")
                    } else {
                        pp.setTitle("\(nextCount)")
                    }
                }
                
            default:
                break
        }
        
        
        return pp
    }
    
    
}


