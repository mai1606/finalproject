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
   
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.layer.cornerRadius = 20
        backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        janProgressView.dataSource = self
        febProgressView.dataSource = self
        janProgressView.setProgress(section: 0, to: 0.4)
        janProgressView.setProgress(section: 1, to: 0.4)
        febProgressView.setProgress(section: 0, to: 0.5)
        DataBase()
    }
    override func viewWillAppear(_ animated: Bool) {
        DataBase()
    }
    func setUp(){
        
    }
    func DataBase(){
        dateFormat1.dateFormat = "dd MMM YYYY"
        dateFormat2.dateFormat = "MMM YYYY"
        dateFormat3.dateFormat = "yyyy"
//        dateFormat3.locale = Locale(identifier: "th_TH")
       
        db.collection("users").document(user!.uid).collection("periods").getDocuments() {
            (data, errorr) in
            if (errorr == nil){
                var  datefirst :String = ""
                var  dateNextM :String = ""
                var  isPeriodDb :[String] = []
                var dayPeriods2 :String = ""
                for  document in data!.documents {
                    
                     datefirst = document.data()["firstPeriods"] as! String
                     dateNextM = document.data()["periodsNextMonth"] as! String
                     isPeriodDb = document.data()["periods"] as! [String]
                    let dayPeriods2 = String(datefirst.split(separator: " ")[1]) + String(datefirst.split(separator: " ")[2])
                    print("_+_+_+_+_+>>>",dayPeriods2)
                    if  dayPeriods2 == "Jan" + String(datefirst.split(separator: " ")[2]) && String(datefirst.split(separator: " ")[2]) == self.dateFormat3.string(from: self.toDay){
                        
                        self.janPeriodCount = isPeriodDb.count
                    }
                       
                  //  gregorian.date(byAdding: .day, value: 14, to: firstDate)
                }
                
            }else {
                print("ไม่มีข้อมูล")
            
            }
        }
    }
        
    
    

}

extension GraphPageOneViewController: MultiProgressViewDataSource {
    func numberOfSections(in progressView: MultiProgressView) -> Int {
        if progressView == janProgressView {
            janProgressView.cornerRadius = 10
            return 2
        } else if progressView == febProgressView {
            return 3
        } else {
            return 1
        }
       
    }
    
    func progressView(_ progressView: MultiProgressView, viewForSection section: Int) -> ProgressViewSection {
        let pp = ProgressViewSection()
        pp.setTitle("test")
        if section == 0 {
            pp.backgroundColor = .blue
        } else {
            pp.backgroundColor = .gray
        }
        
        return pp
    }
    
    
}


