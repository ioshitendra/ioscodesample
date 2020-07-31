
import UIKit
import MBProgressHUD
class EventFilterVC: BaseViewController {
    
    @IBOutlet weak var tblView: UITableView!
    //    var eventCategoryListModel = EventCategoryViewModel()
    //    var valueListModel = GetVenuesViewModel()
    //    var eventCategoryListData = [EventCategoryDatum]()
    //    var valueListData = [GetVenuesDatum]()
    //    var catrgoryList = [String]()
    //    var venueList = [String]()
    //    var sections = [String]()
    //    var cellData = [String: [String]]()
    var arrOfDict = [[String :Any]]()
    var objEventFilterGenre = [EventFilterGenre]()
    var eventFilterModels = EventFilterViewModel()
    var strCountryId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        strCountryId = Constants.APP_USER_DEFAULTS.string(forKey: "CountryId") ?? ""
        tblView.tableFooterView = UIView()
        //  self.sections = ["Event Category", "Date", "Price Range", "Location"]
        self.tblView.register(UINib(nibName: XIBTableCell.qEventFilterHeaderCell, bundle: nil), forCellReuseIdentifier: TableViewCellIdentifier.qEventFilterHeaderCellIdentifier)
        self.tblView.register(UINib(nibName: XIBTableCell.qEventFilterCell, bundle: nil), forCellReuseIdentifier: TableViewCellIdentifier.qEventFilterCellIdentifier)
        self.tblView.register(UINib(nibName: XIBTableCell.qEventFilterPriceCell, bundle: nil), forCellReuseIdentifier: TableViewCellIdentifier.qEventFilterPriceCellIdentier)
        self.EventFilterListApiCall()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tblView.tableFooterView = UIView()
    }
    
}


//MARK: Button Action Methods
extension EventFilterVC {
    
    @IBAction func ApplyFilter(_ sender: Any) {
        print_QT4DebugMode()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ResetFilter(_ sender: Any) {
        print_QT4DebugMode()
         reset()
//        for cell in tblView.visibleCells {
//            cell.setSelected(false, animated: true)
//        }
//        tblView.reloadData()
    }
    
    @IBAction func Cross(_ sender: Any) {
        print_QT4DebugMode()
        
        self.dismiss(animated: true, completion: nil)
    }
}


extension EventFilterVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrOfDict.count
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          let data = arrOfDict[section]
          let name = data["title"] as? String ?? ""
          if(name == "priceRange"){
              return 1
          }else{
              objEventFilterGenre = data["notesField"] as? [EventFilterGenre]  ?? [EventFilterGenre]()
              return objEventFilterGenre.count
          }
      }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = arrOfDict[indexPath.section]
        let name = data["title"] as? String ?? ""
        if(name == "priceRange"){
             let cell: EventFilterPriceCell = self.tblView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.qEventFilterPriceCellIdentier, for: indexPath) as! EventFilterPriceCell
            let objEventFilterGenres = data["notesField"] as? [EventFilterGenre]  ?? [EventFilterGenre]()
            var strMinValue = 0
            var strMaxValue = 0
            for i in 0..<objEventFilterGenres.count {
                if(i == 0){
                    strMinValue = Int(Float(objEventFilterGenres[i].name ?? "0.0") ?? 0.0)
                }else{
    
                    strMaxValue = Int(Float(objEventFilterGenres[i].name ?? "0.0") ?? 0.0)
                    cell.lblMin.text = "\(strMinValue)" + " QAR"
                    cell.lblMax.text = "\(strMaxValue)" + " QAR"
                    cell.sliderView.minimumValue = Float(strMinValue)
                    cell.sliderView.maximumValue = Float(strMaxValue)
                }
            }
            return cell
        }else{
           let cell: EventFilterCell = self.tblView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.qEventFilterCellIdentifier, for: indexPath) as! EventFilterCell
            let data = arrOfDict[indexPath.section]
            let objEventFilterGenres = data["notesField"] as? [EventFilterGenre]  ?? [EventFilterGenre]()
            cell.lbl.text = objEventFilterGenres[indexPath.row].name
            cell.lbl.font = FontHelper.MontserratRegularFontWithSize(size: 13)
            cell.selectionStyle = .none
            let notesarray = data["notesField"] as? [EventFilterGenre] ?? [EventFilterGenre]()
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
    
//    {
//        //        if indexPath.section == 2 {
//        //            let cell: EventFilterPriceCell = self.tblView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.qEventFilterPriceCellIdentier, for: indexPath) as! EventFilterPriceCell
//        //
//        //            return cell
//        //        } else {
//        //            let cell: EventFilterCell = self.tblView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.qEventFilterCellIdentifier, for: indexPath) as! EventFilterCell
//        //            let arr: [String] = cellData[sections[indexPath.section]] ?? [String]()
//        //            cell.lblContent.text = arr[indexPath.row]
//        //            return cell
//        //        }
//    }
}

extension EventFilterVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let label = UILabel()
        label.frame = CGRect.init(x: 20, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.font = FontHelper.MontserratMediumFontWithSize(size: 14)
        let data = arrOfDict[section]
        let name = data["title"] as? String ?? ""
//        if(name == "priceRange"){
//            label.text = name
//        }else{
            label.text = (name).capitalizingFirstLetter()
     //   }
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
        if(name == "priceRange"){
            return 60
        }else{
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           reset(section: indexPath.section)
           var data = arrOfDict[indexPath.section]
           var notesarray = data["notesField"] as? [EventFilterGenre] ?? [EventFilterGenre]()
           var noteOBj = notesarray[indexPath.row]
           noteOBj.isCheck = true
           notesarray[indexPath.row] = noteOBj
           data["notesField"] = notesarray
           arrOfDict[indexPath.section] = data
           self.tblView.reloadData()
       }
       
       func reset(section: Int){
           var data = arrOfDict[section]
           var filtersarray = data["notesField"] as? [EventFilterGenre] ?? [EventFilterGenre]()
           for i in 0..<filtersarray.count {
               filtersarray[i].isCheck = false
               data["notesField"] = filtersarray
           }
           arrOfDict[section] = data
       }
       
       func reset(){
           for i in 0..<arrOfDict.count{
           var data = arrOfDict[i]
           var filtersarray = data["notesField"] as? [EventFilterGenre] ?? [EventFilterGenre]()
           for j in 0..<filtersarray.count {
               filtersarray[j].isCheck = false
               data["notesField"] = filtersarray
           }
           arrOfDict[i] = data
           }
           self.tblView.reloadData()
       }
       
    
}

extension EventFilterVC {
    
    func EventFilterListApiCall(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        print_QT4DebugMode()
        let EventFiterUrl: String = "\( APIURL.BASE_URL + APIURL.EVENT_FILTER + "\(strCountryId)")"
        eventFilterModels.APICall(url: EventFiterUrl ) { (responseArray) in
            self.arrOfDict = responseArray
            self.tblView.dataSource = self
            self.tblView.delegate = self
            self.tblView.reloadData()
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}


//extension EventFilterVC {
//
//    func EventCategoryApiCall(){
//           print_QT4DebugMode()
//        Global.showLoadingSpinner()
//           eventCategoryListModel.APICall(url: APIURL.BASE_URL + APIURL.EVENT_Categroy) { (responseArray) in
//               self.eventCategoryListData = responseArray
//            for i in self.eventCategoryListData {
//                self.catrgoryList.append(i.name)
//            }
//             self.cellData = ["Event Category": self.catrgoryList, "Date": ["Today", "Tomorrow", "Weekend", "Select Date Range"], "Price Range": [""], "Location": ["Katara Cultural Villege", "The Souq Waqif Town"]]
//            self.EventVanueApiCall()
//           }
//       }
//
//    func EventVanueApiCall(){
//              print_QT4DebugMode()
//             Global.showLoadingSpinner()
//              valueListModel.APICall(url: APIURL.BASE_URL + APIURL.EVENT_Vanue) { (responseArray) in
//                  self.valueListData = responseArray
//              for i in self.valueListData {
//                  self.venueList.append(i.name)
//              }
//                self.cellData = ["Event Category": self.catrgoryList, "Date": ["Today", "Tomorrow", "Weekend", "Select Date Range"], "Price Range": [""], "Location":  self.venueList]
//                Global.dismissLoadingSpinner()
//                self.tblView.dataSource = self
//                self.tblView.delegate = self
//                self.tblView.reloadData()
//              }
//          }
//
//}
