import UIKit
import MultiProgressView

class GraphPageOneViewController: UIViewController {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var janProgressView: MultiProgressView!
    
    @IBOutlet weak var febProgressView: MultiProgressView!
    @IBOutlet weak var periodStackView: UIStackView!
    
    //    private let progressview: UIProgressView = {
//        let progressview = UIProgressView(progressViewStyle: .bar)
//        progressview.trackTintColor = .gray
//        progressview.progressTintColor = .red
//        return progressview
//    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.layer.cornerRadius = 20
        backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        janProgressView.dataSource = self
        febProgressView.dataSource = self
        janProgressView.setProgress(section: 0, to: 0.4)
        janProgressView.setProgress(section: 1, to: 0.4)
        febProgressView.setProgress(section: 0, to: 0.5)
//        periodStackView.addArrangedSubview(progressView)
      
//        progressview.frame = CGRect(x: 30, y: 200, width: view.frame.size.width-60, height: 1
//        )
//        progressview.setProgress(0.5, animated: false)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension GraphPageOneViewController: MultiProgressViewDataSource {
    func numberOfSections(in progressView: MultiProgressView) -> Int {
        if progressView == janProgressView {
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


