

import UIKit

class CienamCVC: UICollectionViewCell{
    
    @IBOutlet weak var viewDateSelection: UIView!
    @IBOutlet weak var lbl: UILabel!
    override var isSelected: Bool {
           didSet {
               if isSelected {
                   self.viewDateSelection.backgroundColor = UIColor.AppStatusBarColor()
                   self.lbl.textColor = UIColor.white
                 
               } else {
                   self.viewDateSelection.backgroundColor = UIColor.white
                   self.lbl.textColor = UIColor.ApptabelHederlcellColor()
                 
               }
           }
       }
       
       override func awakeFromNib() {
           super.awakeFromNib()
           
           self.viewDateSelection.layer.borderWidth = 1.0
           self.viewDateSelection.layer.borderColor =  UIColor.ApptabelHederlcellColor().cgColor
           self.viewDateSelection.layer.cornerRadius = 3.0
           self.viewDateSelection.clipsToBounds = true
       }
}

class MovieCinemaTVC: UITableViewCell {

    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var clcCinema: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        clcCinema.delegate = self
        clcCinema.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension MovieCinemaTVC: UICollectionViewDelegate {
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.selectedDate = self.dateArray[indexPath.row].date ?? ""
//        self.timeView.isHidden = false
//        moveScrollToCenter()
    }
}

extension MovieCinemaTVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = clcCinema.dequeueReusableCell(withReuseIdentifier: "CienamCVC", for: indexPath) as! CienamCVC
        return cell
    }
    
}

extension MovieCinemaTVC :UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 80, height: 36)
    }
    
}
