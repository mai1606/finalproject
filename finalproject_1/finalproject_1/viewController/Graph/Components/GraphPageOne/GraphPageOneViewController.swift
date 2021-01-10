import UIKit

class GraphPageOneViewController: UIViewController {
    @IBOutlet weak var backgroundView: UIView!
    
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
       // view.addSubview(progressview)
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
