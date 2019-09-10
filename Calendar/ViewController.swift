

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var showview: UIView!
    
//    var calendar : Calendarview!
    override func viewDidLoad() {
        super.viewDidLoad()
        let calendar  = Calendarview(frame: showview.bounds)
        showview.addSubview(calendar)
        
        
        
        // Do any additional setup after loading the view$
    }


}

extension Calendarview {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.colorForLabel == .red {
            self.colorForLabel = .gray
        }else{
            self.colorForLabel = .red
        }
        collectionView.reloadData()
        
    }
    
}

