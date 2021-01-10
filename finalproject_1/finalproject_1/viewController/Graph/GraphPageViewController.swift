//
//  GraphPageViewController.swift
//  finalproject_1
//
//  Created by Mai on 11/12/2563 BE.
//  Copyright © 2563 BE ICTSUIM. All rights reserved.
//

import UIKit
import Charts

class GraphPageViewController: UIViewController {
//    @IBOutlet weak var periodTimeHorizontalBarChartView: HorizontalBarChartView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerText: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var detailView: UIView!
    
    @IBOutlet weak var graphBtnPageOne: UIButton!
    @IBOutlet weak var graphBtnPageTwo: UIButton!
    @IBOutlet weak var graphBtnPageThree: UIButton!
    
    
    var graphPageOneViewController:GraphPageOneViewController!
    var graphPageTwoViewController:GraphPageTwoViewController!
    var graphPageThreeViewController:GraphPageThreeViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        graphBtnPageOne.setImage(UIImage(named: "gImage1_1.png"), for: .normal)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
       
        headerView.layer.cornerRadius = 20
        headerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        headerView.backgroundColor = UIColor.systemPink
        headerText.text = "การมีประจำเดือน"
        headerText.textColor = UIColor.white
        
        graphPageOneViewController = GraphPageOneViewController(nibName:"GraphPageOneViewController", bundle:nil)
        graphPageTwoViewController = GraphPageTwoViewController(nibName:"GraphPageTwoViewController", bundle:nil)
        graphPageThreeViewController = GraphPageThreeViewController(nibName:"GraphPageThreeViewController", bundle:nil)
        setCardView(viewController: graphPageOneViewController, show: false)
        setCardView(viewController: graphPageTwoViewController, show: true)
        setCardView(viewController: graphPageThreeViewController, show: true)
        
    }
    func setCardView(viewController: UIViewController, show: Bool) {
        self.addChild(viewController)
        detailView.addSubview(viewController.view)
        viewController.view.topAnchor.constraint(equalTo: detailView.topAnchor, constant: 0).isActive = true
        viewController.view.leadingAnchor.constraint(equalTo: detailView.leadingAnchor,constant: 0).isActive = true
        viewController.view.trailingAnchor.constraint(equalTo: detailView.trailingAnchor,constant: 0).isActive = true
        viewController.view.bottomAnchor.constraint(equalTo: detailView.bottomAnchor, constant: 0).isActive = true
        viewController.view.heightAnchor.constraint(equalToConstant: 550).isActive = true
        viewController.view.isHidden = show
    }
    
    
    @IBAction func changeCardView(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            headerView.backgroundColor = UIColor.systemPink
            headerText.text = "การมีประจำเดือน"
            graphPageOneViewController.view.isHidden = false
            graphPageTwoViewController.view.isHidden = true
            graphPageThreeViewController.view.isHidden = true
            graphBtnPageOne.setImage(UIImage(named: "gImage1_1.png"), for: .normal)
            graphBtnPageTwo.setImage(UIImage(named: "gImage2.png"), for: .normal)
            graphBtnPageThree.setImage(UIImage(named: "gImage3.png"), for: .normal)
            
        case 1:
            headerView.backgroundColor = UIColor.mainColorFemale
            headerText.text = "เพศสัมพันธ์"
            graphPageOneViewController.view.isHidden = true
            graphPageTwoViewController.view.isHidden = false
            graphPageThreeViewController.view.isHidden = true
            graphBtnPageOne.setImage(UIImage(named: "gImage1.png"), for: .normal)
            graphBtnPageTwo.setImage(UIImage(named: "gImage1_2.png"), for: .normal)
            graphBtnPageThree.setImage(UIImage(named: "gImage3.png"), for: .normal)
        case 2:
            headerView.backgroundColor = UIColor.systemBlue
            headerText.text = "การคาดการณ์"
            graphPageOneViewController.view.isHidden = true
            graphPageTwoViewController.view.isHidden = true
            graphPageThreeViewController.view.isHidden = false
           graphBtnPageThree.setImage(UIImage(named: "gImage1_3.png"), for: .normal)
           graphBtnPageOne.setImage(UIImage(named: "gImage1.png"), for: .normal)
           graphBtnPageTwo.setImage(UIImage(named: "gImage2.png"), for: .normal)
            
        default:
            break
        }
    }
    //    func setupChart() {
//        periodTimeHorizontalBarChartView.delegate = self
//        periodTimeHorizontalBarChartView.xAxis.drawGridLinesEnabled = false
//        periodTimeHorizontalBarChartView.leftAxis.drawGridLinesEnabled = false
//        periodTimeHorizontalBarChartView.rightAxis.drawGridLinesEnabled = false
//        periodTimeHorizontalBarChartView.xAxis.drawAxisLineEnabled = false
//        periodTimeHorizontalBarChartView.xAxis.drawLabelsEnabled = false
//        updateChartData()
//    }
//
//    func updateChartData() {
//
//
//            self.setDataCount(Int(2) + 1, range: UInt32(10))
//        }
//
//        func setDataCount(_ count: Int, range: UInt32) {
//            var xVal = 0.0
//            let yVals = (0..<count).map { (i) -> BarChartDataEntry in
//                let mult = range + 1
//                let val1 = Double(arc4random_uniform(mult) + mult / 3)
//                let val2 = Double(arc4random_uniform(mult) + mult / 3)
//                let val3 = Double(arc4random_uniform(mult) + mult / 3)
//                xVal = i == 0 ? xVal : xVal + 0.5
//                return BarChartDataEntry(x: xVal, yValues: [val1, val2, val3], icon: #imageLiteral(resourceName: "icon"))
//            }
//
//            let set = BarChartDataSet(entries: yVals, label: "Statistics Vienna 2014")
//            set.drawIconsEnabled = false
//            set.colors = [ChartColorTemplates.material()[0], ChartColorTemplates.material()[1], ChartColorTemplates.material()[2]]
//            set.stackLabels = ["Births", "Divorces", "Marriage"]
//
//
//            let data = BarChartData(dataSet: set)
//            data.setValueFont(.systemFont(ofSize: 7, weight: .light))
//                   // data.setValueFormatter(DefaultValueFormatter(formatter: formatter))
//            data.setValueTextColor(.white)
//            data.barWidth = 0.3
//
//            periodTimeHorizontalBarChartView.fitBars = true
//            periodTimeHorizontalBarChartView.data = data
//        }

}

extension GraphPageViewController: ChartViewDelegate {
    
}
