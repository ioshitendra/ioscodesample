

import UIKit
import MBProgressHUD
class FilterTVC: UITableViewCell {
    
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var img: UIImageView!
}

class MovieFilterVC: BaseViewController {
    @IBOutlet weak var tblFilteView: UITableView!
    var arrOfDict = [[String :Any]]()
    var objMovieFilterGenre = [MovieFilterGenre]()
    var movieFilterModels = MovieFilterViewModel()
    var strCountryId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
          SetUpUI()
    }
}
extension MovieFilterVC {
    func SetUpUI(){
        strCountryId = Constants.APP_USER_DEFAULTS.string(forKey: "CountryId") ?? ""
        tblFilteView.tableFooterView = UIView()
        self.tblFilteView.register(UINib(nibName: XIBTableCell.qMovieFilterIMDBCell, bundle: nil), forCellReuseIdentifier: TableViewCellIdentifier.qMovieFilterIMDBCellIdentier)
        MovieFilterListApiCall()
        
    }
}

//MARK: Button Action Methods
extension MovieFilterVC {
    
    @IBAction func ApplyFilter(_ sender: Any) {
        print_QT4DebugMode()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ResetFilter(_ sender: Any) {
        print_QT4DebugMode()
        reset()
    }
    
    @IBAction func Cross(_ sender: Any) {
        print_QT4DebugMode()
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: Button Action Methods
extension MovieFilterVC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrOfDict.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = arrOfDict[section]
        let name = data["title"] as? String ?? ""
        if(name == "Imdb Rating"){
            return 1
        }else{
            objMovieFilterGenre = data["notesField"] as? [MovieFilterGenre]  ?? [MovieFilterGenre]()
            return objMovieFilterGenre.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let label = UILabel()
        label.frame = CGRect.init(x: 20, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.font = FontHelper.MontserratMediumFontWithSize(size: 14)
        let data = arrOfDict[section]
        let name = data["title"] as? String ?? ""
        if(name == "Imdb Rating"){
             label.text = name
        }else{
        label.text = (name).capitalizingFirstLetter()
        }
        label.textColor = UIColor.AppStatusBarColor()
        headerView.addSubview(label)
        headerView.backgroundColor = UIColor.ApptabelHederlDefaultColor()
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = arrOfDict[indexPath.section]
        let name = data["title"] as? String ?? ""
        if(name == "Imdb Rating"){
            return 60
        }else{
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = arrOfDict[indexPath.section]
        let name = data["title"] as? String ?? ""
        if(name == "Imdb Rating"){
            let cell = tblFilteView.dequeueReusableCell(withIdentifier: XIBTableCell.qMovieFilterIMDBCell, for: indexPath) as! IMDBFilterTVC
            return cell
        }else{
            
            let cell = tblFilteView.dequeueReusableCell(withIdentifier: XIBTableCell.qMovieFilterCell, for: indexPath) as! FilterTVC
            let data = arrOfDict[indexPath.section]
            let objMovieFilterGenre = data["notesField"] as? [MovieFilterGenre]  ?? [MovieFilterGenre]()
            cell.lbl.text = objMovieFilterGenre[indexPath.row].name
            cell.lbl.font = FontHelper.MontserratRegularFontWithSize(size: 13)
            cell.selectionStyle = .none
            let notesarray = data["notesField"] as? [MovieFilterGenre] ?? [MovieFilterGenre]()
            let noteOBj = notesarray[indexPath.row]
            
            if( noteOBj.isCheck == true)
            {
                cell.img.image = AssetsImages.qFilterCheck
                cell.lbl?.textColor = UIColor.AppFilterLabelSelectedColor()
            }
            else
            {
                cell.img.image = AssetsImages.qNone
                cell.lbl?.textColor = UIColor.AppFilterLabelUnselectedColor()
            }
            return cell
        }
    }
    
}

extension MovieFilterVC : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        reset(section: indexPath.section)
        var data = arrOfDict[indexPath.section]
        var notesarray = data["notesField"] as? [MovieFilterGenre] ?? [MovieFilterGenre]()
        var noteOBj = notesarray[indexPath.row]
        noteOBj.isCheck = true
        notesarray[indexPath.row] = noteOBj
        data["notesField"] = notesarray
        arrOfDict[indexPath.section] = data
        self.tblFilteView.reloadData()
    }
    
    func reset(section: Int){
        
        var data = arrOfDict[section]
        var filtersarray = data["notesField"] as? [MovieFilterGenre] ?? [MovieFilterGenre]()
        for i in 0..<filtersarray.count {
            filtersarray[i].isCheck = false
            data["notesField"] = filtersarray
        }
        arrOfDict[section] = data
    }
    
    func reset(){
        
        for i in 0..<arrOfDict.count{
        var data = arrOfDict[i]
        var filtersarray = data["notesField"] as? [MovieFilterGenre] ?? [MovieFilterGenre]()
        for j in 0..<filtersarray.count {
            filtersarray[j].isCheck = false
            data["notesField"] = filtersarray
        }
        arrOfDict[i] = data
        }
        self.tblFilteView.reloadData()
    }
    
    
}

extension MovieFilterVC {
    
    func MovieFilterListApiCall(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        print_QT4DebugMode()
        let MovieFiterUrl: String = "\( APIURL.BASE_URL + APIURL.MOVIE_FITER + "\(strCountryId)")"
        movieFilterModels.APICall(url: MovieFiterUrl ) { (responseArray) in
            self.arrOfDict = responseArray
            self.tblFilteView.reloadData()
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension MovieFilterVC {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
