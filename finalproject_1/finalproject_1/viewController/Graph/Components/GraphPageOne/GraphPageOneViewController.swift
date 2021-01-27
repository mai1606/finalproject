import UIKit
import MultiProgressView
import FirebaseAuth
import Foundation
import Firebase

class GraphPageOneViewController: UIViewController {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var janProgressView: MultiProgressView!
    @IBOutlet weak var febProgressView: MultiProgressView!
    @IBOutlet weak var marProgressView: MultiProgressView!
    @IBOutlet weak var aprgressView: MultiProgressView!
    @IBOutlet weak var mayProgressView: MultiProgressView!
    @IBOutlet weak var junProgressView: MultiProgressView!
    @IBOutlet weak var julProgressView: MultiProgressView!
    @IBOutlet weak var augProgressView: MultiProgressView!
    @IBOutlet weak var sepProgressView: MultiProgressView!
    @IBOutlet weak var octProgressView: MultiProgressView!
    @IBOutlet weak var novProgressView: MultiProgressView!
    @IBOutlet weak var decgressView: MultiProgressView!
    
    @IBOutlet weak var janLabel: UILabel!
    @IBOutlet weak var febLabel: UILabel!
    @IBOutlet weak var marLabel: UILabel!
    @IBOutlet weak var aprLabel: UILabel!
    @IBOutlet weak var mayLabel: UILabel!
    @IBOutlet weak var junLabel: UILabel!
    @IBOutlet weak var julLabel: UILabel!
    @IBOutlet weak var augLabel: UILabel!
    @IBOutlet weak var sepLabel: UILabel!
    @IBOutlet weak var octLabel: UILabel!
    @IBOutlet weak var novLabel: UILabel!
    @IBOutlet weak var decLabel: UILabel!
    
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
        setUp()
        backgroundView.layer.cornerRadius = 20
        backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        setUpProgressView(janProgressView)
        setUpProgressView(febProgressView)
        setUpProgressView(marProgressView)
        setUpProgressView(aprgressView)
        setUpProgressView(mayProgressView)
        setUpProgressView(junProgressView)
        setUpProgressView(julProgressView)
        setUpProgressView(augProgressView)
        setUpProgressView(sepProgressView)
        setUpProgressView(octProgressView)
        setUpProgressView(novProgressView)
        setUpProgressView(decgressView)
    }
    override func viewWillAppear(_ animated: Bool) {
        DataBase()
    }
    func setUp(){
  
        janProgressView.isHidden = true
    febProgressView.isHidden = true
    marProgressView.isHidden = true
    aprgressView.isHidden = true
    mayProgressView.isHidden = true
    junProgressView.isHidden = true
    julProgressView.isHidden = true
    augProgressView.isHidden = true
    sepProgressView.isHidden = true
    octProgressView.isHidden = true
    novProgressView.isHidden = true
    decgressView.isHidden = true
        
        janLabel.isHidden = true
        febLabel.isHidden = true
        marLabel.isHidden = true
        aprLabel.isHidden = true
        mayLabel.isHidden = true
        junLabel.isHidden = true
        julLabel.isHidden = true
        augLabel.isHidden = true
        sepLabel.isHidden = true
        octLabel.isHidden = true
        novLabel.isHidden = true
        decLabel.isHidden = true
        
        
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
                self.setUpSection(self.febProgressView)
                self.setUpSection(self.marProgressView)
                self.setUpSection(self.aprgressView)
                self.setUpSection(self.mayProgressView)
                self.setUpSection(self.junProgressView)
                self.setUpSection(self.julProgressView)
                self.setUpSection(self.augProgressView)
                self.setUpSection(self.sepProgressView)
                self.setUpSection(self.octProgressView)
                self.setUpSection(self.novProgressView)
                self.setUpSection(self.decgressView)
                
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
        progressView.setProgress(section: 0, to: 0.2)
        progressView.setProgress(section: 1, to: 0.8)
    }
    func setCa(_ progressView: MultiProgressView , a : Int ,b : Int) {
        progressView.dataSource = self
        let a1 = Float((a/7))*0.2
        let b1 = Float((b/30))*0.8
        progressView.setProgress(section: 0, to: a1)
        progressView.setProgress(section: 1, to: b1)
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
            pp.backgroundColor = UIColor(named: "Color_main3")
        } else {
            pp.backgroundColor = UIColor(named: "Color_main4")
        }
        switch progressView {
            case janProgressView:
                if let month = self.allPeriod.first(where: {($0["month"] as? String ?? "").hasPrefix("Jan")}) , let periodCount = month["periodCount"] as? Int, let nextCount = month["nextCount"] as? Int{
                    janProgressView.isHidden = false
                    janLabel.isHidden = false
                    janLabel.text = month["month"] as? String
                   // setCa(janProgressView, a: periodCount, b: nextCount)
                    if section == 0 {
                        pp.setTitle("\(periodCount)")
                    } else {
                        pp.setTitle("\(nextCount)")
                    }
                }
        case febProgressView:
            if let month = self.allPeriod.first(where: {($0["month"] as? String ?? "").hasPrefix("Feb")}) , let periodCount = month["periodCount"] as? Int, let nextCount = month["nextCount"] as? Int{
                febProgressView.isHidden = false
                febLabel.isHidden = false
                febLabel.text = month["month"] as! String
               
                if section == 0 {
                    pp.setTitle("\(periodCount)")
                } else {
                    pp.setTitle("\(nextCount)")
                }
            }
        case marProgressView:
            if let month = self.allPeriod.first(where: {($0["month"] as? String ?? "").hasPrefix("Mar")}) , let periodCount = month["periodCount"] as? Int, let nextCount = month["nextCount"] as? Int{
                marProgressView.isHidden = false
                marLabel.isHidden = false
                marLabel.text = month["month"] as! String
               
                if section == 0 {
                    pp.setTitle("\(periodCount)")
                } else {
                    pp.setTitle("\(nextCount)")
                }
            }
        case aprgressView:
            if let month = self.allPeriod.first(where: {($0["month"] as? String ?? "").hasPrefix("Apr")}) , let periodCount = month["periodCount"] as? Int, let nextCount = month["nextCount"] as? Int{
                aprgressView.isHidden = false
                aprLabel.isHidden = false
                aprLabel.text = month["month"] as! String
                
                if section == 0 {
                    pp.setTitle("\(periodCount)")
                } else {
                    pp.setTitle("\(nextCount)")
                }
            }
        case mayProgressView:
            if let month = self.allPeriod.first(where: {($0["month"] as? String ?? "").hasPrefix("May")}) , let periodCount = month["periodCount"] as? Int, let nextCount = month["nextCount"] as? Int{
                mayProgressView.isHidden = false
                mayLabel.isHidden = false
                mayLabel.text = month["month"] as! String
               
                if section == 0 {
                    pp.setTitle("\(periodCount)")
                } else {
                    pp.setTitle("\(nextCount)")
                }
            }
        case junProgressView:
            if let month = self.allPeriod.first(where: {($0["month"] as? String ?? "").hasPrefix("Jun")}) , let periodCount = month["periodCount"] as? Int, let nextCount = month["nextCount"] as? Int{
                junProgressView.isHidden = false
                junLabel.isHidden = false
                junLabel.text = month["month"] as! String
               
                if section == 0 {
                    pp.setTitle("\(periodCount)")
                } else {
                    pp.setTitle("\(nextCount)")
                }
            }
        case julProgressView:
            if let month = self.allPeriod.first(where: {($0["month"] as? String ?? "").hasPrefix("Jul")}) , let periodCount = month["periodCount"] as? Int, let nextCount = month["nextCount"] as? Int{
                julProgressView.isHidden = false
                julLabel.isHidden = false
                julLabel.text = month["month"] as! String
               
                if section == 0 {
                    pp.setTitle("\(periodCount)")
                } else {
                    pp.setTitle("\(nextCount)")
                }
            }
        case augProgressView:
            if let month = self.allPeriod.first(where: {($0["month"] as? String ?? "").hasPrefix("Aug")}) , let periodCount = month["periodCount"] as? Int, let nextCount = month["nextCount"] as? Int{
                augProgressView.isHidden = false
                augLabel.isHidden = false
                augLabel.text = month["month"] as! String
                
                if section == 0 {
                    pp.setTitle("\(periodCount)")
                } else {
                    pp.setTitle("\(nextCount)")
                }
            }
        case sepProgressView:
            if let month = self.allPeriod.first(where: {($0["month"] as? String ?? "").hasPrefix("Sep")}) , let periodCount = month["periodCount"] as? Int, let nextCount = month["nextCount"] as? Int{
                sepProgressView.isHidden = false
                sepLabel.isHidden = false
                sepLabel.text = month["month"] as! String
               
                if section == 0 {
                    pp.setTitle("\(periodCount)")
                } else {
                    pp.setTitle("\(nextCount)")
                }
            }
        case octProgressView:
            if let month = self.allPeriod.first(where: {($0["month"] as? String ?? "").hasPrefix("Oct")}) , let periodCount = month["periodCount"] as? Int, let nextCount = month["nextCount"] as? Int{
                octProgressView.isHidden = false
                octLabel.isHidden = false
                octLabel.text = month["month"] as! String
                
                if section == 0 {
                    pp.setTitle("\(periodCount)")
                } else {
                    pp.setTitle("\(nextCount)")
                }
            }
        case novProgressView:
            if let month = self.allPeriod.first(where: {($0["month"] as? String ?? "").hasPrefix("Nov")}) , let periodCount = month["periodCount"] as? Int, let nextCount = month["nextCount"] as? Int{
                novProgressView.isHidden = false
                novLabel.isHidden = false
                novLabel.text = month["month"] as! String
               
                if section == 0 {
                    pp.setTitle("\(periodCount)")
                } else {
                    pp.setTitle("\(nextCount)")
                }
            }
        case decgressView:
            if let month = self.allPeriod.first(where: {($0["month"] as? String ?? "").hasPrefix("Dec")}) , let periodCount = month["periodCount"] as? Int, let nextCount = month["nextCount"] as? Int{
                decgressView.isHidden = false
                decLabel.isHidden = false
                decLabel.text = month["month"] as! String
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


