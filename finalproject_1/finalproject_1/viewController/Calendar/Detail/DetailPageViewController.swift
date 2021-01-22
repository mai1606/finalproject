//
//  DetailPageViewController.swift
//  finalproject_1
//
//  Created by Mai on 1/12/2563 BE.
//  Copyright © 2563 BE ICTSUIM. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import DropDown

class DetailPageViewController: UIViewController {

    @IBOutlet weak var emotionCollectionView: UICollectionView!
    @IBOutlet weak var symptonCollectionView: UICollectionView!
    @IBOutlet weak var sexsCollectionView: UICollectionView!
    @IBOutlet weak var contentCollectionView: UICollectionView!
    @IBOutlet weak var leucorrhoeaCollectionView: UICollectionView!
    
    @IBOutlet weak var waterStack: UIStackView!
    @IBOutlet weak var weightStack: UIStackView!
    
    @IBOutlet weak var btnWaterUI: UIButton!
    @IBOutlet weak var btnWeightUI: UIButton!
    
    @IBOutlet weak var DropDownBtnW: UIButton!
    @IBOutlet weak var DropDownBtnWater: UIButton!
    
    @IBOutlet weak var wUiLabel: UILabel!
    @IBOutlet weak var waterLabel: UILabel!
    
    
    var emotions: [Detail] = DetailPageConfigurator.getEmotion()
    var symptons: [Detail] = DetailPageConfigurator.getSymptons()
    var sexs: [Detail] = DetailPageConfigurator.getSex()
    var contents: [Detail] = DetailPageConfigurator.getContent()
    var leucorrhoeas: [Detail] = DetailPageConfigurator.getLeucorrhoea()
    var Alldate: [Detail] = DetailPageConfigurator.getAll()
    
    var selectEmotions: [String] = []
    var selectSymptons: [String] = []
    var selectSexs: [String] = []
    var selectContents: [String] = []
    var selectLeucorrhoeas: [String] = []
    var waterD : Int = 0
    var weight : Int = 50
    //date
    let db = Firestore.firestore()
    let user = Auth.auth().currentUser
    let dateFormatter = DateFormatter()
    var selectedDate: Date = Date()
    let menuW: DropDown = {
        let menu = DropDown()
        menu.dataSource = [
            "30" ,"31" ,"32" ,"33" ,"34" ,"35" ,"36" ,"37" ,"38" ,"39" ,
            "40" ,"41" ,"42" ,"43" ,"44" ,"45" ,"46" ,"47" ,"48" ,"49" ,
            "50" ,"51" ,"52" ,"53" ,"54" ,"55" ,"56" ,"57" ,"58" ,"59" ,
            "60" ,"61" ,"62" ,"63" ,"64" ,"65" ,"66" ,"67" ,"68" ,"69" ,
            "70" ,"71" ,"72" ,"73" ,"74" ,"75" ,"76" ,"77" ,"78" ,"79" ,
            "80" ,"81" ,"82" ,"83" ,"84" ,"85" ,"86" ,"87" ,"88" ,"89" ,
            "90" ,"91" ,"92" ,"93" ,"94" ,"95" ,"96" ,"97" ,"98" ,"99" ,
            
        ]
        return menu
    }()
    let menuH: DropDown = {
        let menu = DropDown()
        menu.dataSource = [
            "1" ,
            "2" ,
            "3" ,
            "4" ,
            "5" ,
            "6" ,
            "7" ,
            "8" ,
        ]
        return menu
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
        menuW.selectionAction = { index ,title in
         //  print("index\(index),Title\(title)")
             self.DropDownBtnW.setTitle(title, for: .normal)
            self.wUiLabel.font = UIFont(name: "Kanit-Light", size: UIFont.labelFontSize)
            self.waterLabel.font = UIFont(name: "Kanit-Light", size: UIFont.labelFontSize)
        }
        menuH.selectionAction = { index ,title in
         //  print("index\(index),Title\(title)")
             self.DropDownBtnWater.setTitle(title, for: .normal)
        
        }
        
    
    }
    func DbFirebase()  {
        let docRef = db.collection("users").document(user!.uid).collection("date").document (dateFormatter.string(from: selectedDate))
        
        docRef.getDocument { [self] (document, error) in
            if let document = document, document.exists {
                let  dataDescription = document.data()!["Detail"] as! [String]
//                for a in dataDescription {
//                    if Alldate.contains(where: a){
//                        
//                    }
//                }
            }
        }
    }
    @IBAction func btn(_ sender: Any){
        if (sender as AnyObject).tag == 0 {
            weight -= 1
            wUiLabel.text = String(weight)
        }
        else if (sender as AnyObject).tag == 1 {
            weight += 1
            wUiLabel.text = String(weight)
        }
        
       else  if (sender as AnyObject).tag == 2 {
            
            waterD -= 1
                if waterD < 0 {
                    waterD = 0
                }
            waterLabel.text = String(waterD)
        }
        
        else if (sender as AnyObject).tag == 3 {
            waterD += 1
            if waterD > 20 {
                waterD = 20
            }
            waterLabel.text = String(waterD)
        }
        
        
    }
    
    @IBAction func btnWater(_ sender: Any) {
        if (sender as AnyObject).tag == 1 {
            waterStack.isHidden = true
            weightStack.isHidden = false
        }else if (sender as AnyObject).tag == 0{
            waterStack.isHidden = false
            weightStack.isHidden = true
        }else if (sender as AnyObject).tag == 2{
//            dateFormatter.dateFormat = "d MMM yyyy"
//            dateFormatter.string(from: selectedDate)
//            var x = 0
            db.collection("users").document(user!.uid).collection("date").document("\(dateFormatter.string(from: selectedDate))").setData(["Detail":  selectEmotions,"Day":"\(dateFormatter.string(from: selectedDate))","weight":weight,"drinkWater":waterD])
         
            //performSegue(withIdentifier: "CalendarPageView", sender: )
        }
        
        
    }
    @IBAction func btnDopdown(_ sender: Any) {
        if (sender as AnyObject).tag == 0{
            menuW.show()
        }
        if (sender as AnyObject).tag == 1{
            menuH.show()
        }
        
    }
    
    
    
    
    func setup() {
        
        setupCollectionView(emotionCollectionView)
        setupCollectionView(symptonCollectionView)
        setupCollectionView(sexsCollectionView)
        setupCollectionView(contentCollectionView)
        setupCollectionView(leucorrhoeaCollectionView)
    }
    
    func setupCollectionView(_ collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: "DetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        
        
    }
    
//    func save() {
//        var descr: [String] = []
//        for emo in emotions {
//            if emo.isSelected {
//                descr.append(emo.descr ?? "")
//            }
//        }
//
//
//    }
}

extension DetailPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == emotionCollectionView {
            return emotions.count
        } else if collectionView == symptonCollectionView {
            return symptons.count
        }else if collectionView == sexsCollectionView {
            return sexs.count
        } else if collectionView == contentCollectionView {
            return contents.count
        } else if collectionView == leucorrhoeaCollectionView {
            return leucorrhoeas.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCollectionViewCell", for: indexPath) as? DetailCollectionViewCell else { return UICollectionViewCell() }
        var detail: Detail?
        if collectionView == emotionCollectionView {
            detail = emotions[indexPath.row]
        }else if collectionView == symptonCollectionView {
            detail = symptons[indexPath.row]
        }else if collectionView == sexsCollectionView {
            detail = sexs[indexPath.row]
        } else if collectionView == contentCollectionView {
            detail = contents[indexPath.row]
        } else if collectionView == leucorrhoeaCollectionView {
            detail = leucorrhoeas[indexPath.row]
        } else {
            return cell
        }
   
        cell.setup(detail: detail)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DetailCollectionViewCell else { return }
        var detail: Detail?
       
        if collectionView == emotionCollectionView {
            detail = emotions[indexPath.row]
            detail?.isSelected = true
            selectEmotions.append((detail?.descr)!)
            cell.setupSelected(detail: detail!)
        }else if collectionView == symptonCollectionView {
            detail = symptons[indexPath.row]
            detail?.isSelected = true
            selectEmotions.append((detail?.descr)!)
            cell.setupSelected(detail: detail!)
        }else if collectionView == sexsCollectionView {
            detail = sexs[indexPath.row]
            detail?.isSelected = true
            selectEmotions.append((detail?.descr)!)
            cell.setupSelected(detail: detail!)
        } else if collectionView == contentCollectionView {
            detail = contents[indexPath.row]
            selectEmotions.append((detail?.descr)!)
            detail?.isSelected = true
            cell.setupSelected(detail: detail!)
        } else if collectionView == leucorrhoeaCollectionView {
            detail = leucorrhoeas[indexPath.row]
            selectEmotions.append((detail?.descr)!)
            detail?.isSelected = true
            cell.setupSelected(detail: detail!)
        } else {
            return
        }
      
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DetailCollectionViewCell else { return }
        var detail: Detail?
        if collectionView == emotionCollectionView {
            detail = emotions[indexPath.row]
            detail?.isSelected = false
            selectEmotions = selectEmotions.filter(){$0 != (detail?.descr)!}
            cell.setupSelected(detail: detail!)
        }else if collectionView == symptonCollectionView {
            detail = symptons[indexPath.row]
            detail?.isSelected = false
            selectEmotions = selectEmotions.filter(){$0 != (detail?.descr)!}
            cell.setupSelected(detail: detail!)
        }else if collectionView == sexsCollectionView {
            detail = sexs[indexPath.row]
            detail?.isSelected = false
            selectEmotions = selectEmotions.filter(){$0 != (detail?.descr)!}
            cell.setupSelected(detail: detail!)
        } else if collectionView == contentCollectionView {
            detail = contents[indexPath.row]
            detail?.isSelected = false
            selectEmotions = selectEmotions.filter(){$0 != (detail?.descr)!}
            cell.setupSelected(detail: detail!)
        } else if collectionView == leucorrhoeaCollectionView {
            detail = leucorrhoeas[indexPath.row]
            detail?.isSelected = false
            selectEmotions = selectEmotions.filter(){$0 != (detail?.descr)!}
            cell.setupSelected(detail: detail!)
        } else {
            return
        }
      
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 70)
    }
}
