

import UIKit
import JExpandableTableView

class FaqVC: BaseViewController {

    @IBOutlet weak var tblView: JExpandableTableView!
    var objfaqViewModel = FAQViewModel()
    var dataArray = [SectionInfo]()
    var faqArray = [Faq]()
    var faqEventsArray = [FaqEvents]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        setNavigationBarStyle(transparent: false, leftButton: true, rightButton: false, title:"FAQs")
        self.InitiaizeUI()
    }
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func InitiaizeUI() {
        FaqApiCall()
        tblView.disableCellSeparator = true
        tblView.keepPreviousCellExpanded = false
        tblView.backgroundColor = UIColor.white

        var celNib = UINib.init(nibName: "ImageCell", bundle: nil)
        tblView.register(celNib, forCellReuseIdentifier: "ImageCell")
        celNib = UINib.init(nibName: "TextCell", bundle: nil)
        tblView.register(celNib, forCellReuseIdentifier: "TextCell")
        
        let headerNib = UINib.init(nibName: "HeaderView", bundle: nil)
        tblView.register(headerNib, forHeaderFooterViewReuseIdentifier: "HeaderView")
        if faqArray.count > 0 {
            for i in faqArray{
                let question = i.question ?? ""
                let answer = i.answer ?? ""
                var cellInfo = CellInfo("Game of thrones",cellId: "TextCell")
                let sec2 = SectionInfo(question)
                cellInfo = CellInfo(answer,cellId: "TextCell")
                sec2.cells.append(cellInfo)
                self.dataArray.append(sec2)
            }
        } else {
            for i in faqEventsArray{
                let question = i.question ?? ""
                let answer = i.answer ?? ""
                var cellInfo = CellInfo("Game of thrones",cellId: "TextCell")
                let sec2 = SectionInfo(question)
                cellInfo = CellInfo(answer,cellId: "TextCell")
                sec2.cells.append(cellInfo)
                self.dataArray.append(sec2)
            }
        }
        tblView.delegate = self
        tblView.dataSource = self
        self.tblView.reloadData()

    }

}

extension FaqVC: JExpandableTableViewDataSource, JExpandableTableViewDelegate {
    func tableView(_ tableView: JExpandableTableView, numberOfRowsInSection section: Int, callback:  @escaping (Int) -> Void) {

        let sectionInfo = self.dataArray[section]
        if sectionInfo.cells.count != 0 {
            callback(sectionInfo.cells.count)
        }else{
            
            tableView.isUserInteractionEnabled = false
            
            DispatchQueue.global().async {
                
                Thread.sleep(forTimeInterval: 2)
                DispatchQueue.main.sync {
                    tableView.isUserInteractionEnabled = true
                    let sectionInfo = self.dataArray[section]
                    
                    callback(sectionInfo.cells.count)
                }
            }
        }
    }
    
    func tableView(_ tableView: JExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let section = self.dataArray[indexPath.section]
        let row = section.cells[indexPath.row]

        let cellId = row.cellId
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId!, for: indexPath)
        cell.selectionStyle = .none
        cell.contentView.backgroundColor = UIColor.white
        let label = cell.viewWithTag(11) as? UILabel
        label?.text = row.text
        
        return cell
    }
    
    func numberOfSections(in tableView: JExpandableTableView) -> Int {
        
        return dataArray.count
    }
    
    func tableView(_ tableView: JExpandableTableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: JExpandableTableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let section = self.dataArray[section]
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView")
        header?.contentView.backgroundColor = UIColor.white
        let label = header?.viewWithTag(11) as? UILabel
        label?.text = section.title
        let arrow = header?.viewWithTag(13) as? UIImageView
        arrow?.image = UIImage.init(named: "dropSelection")
        let myView = header?.viewWithTag(12)
        myView?.backgroundColor = UIColor.white
        return header
    }
    
    func tableView(_ tableView: JExpandableTableView, initialNumberOfRowsInSection section: Int) -> Int{
        return 0
    }
}


extension FaqVC {
    
    func FaqApiCall() {
        print_QT4DebugMode()
        Global.showLoadingSpinner()
        objfaqViewModel.APICall(url: APIURL.BASE_URL + APIURL.FAQ) { (responseArray) in
            Global.dismissLoadingSpinner()
            if(responseArray.statusCode == 200){
                let obj  = responseArray.response ?? [FaqResponse]()
                if(obj.count>0){
                self.faqArray = obj[0].response
                if self.faqArray.count > 0 {
                    for i in self.faqArray{
                                let question = i.question ?? ""
                                let answer = i.answer ?? ""
                                var cellInfo = CellInfo("Game of thrones",cellId: "TextCell")
                                let sec2 = SectionInfo(question)
                                cellInfo = CellInfo(answer,cellId: "TextCell")
                                sec2.cells.append(cellInfo)
                                self.dataArray.append(sec2)
                            }
                        }
                //        else {
                //            for i in faqEventsArray{
                //                let question = i.question ?? ""
                //                let answer = i.answer ?? ""
                //                var cellInfo = CellInfo("Game of thrones",cellId: "TextCell")
                //                let sec2 = SectionInfo(question)
                //                cellInfo = CellInfo(answer,cellId: "TextCell")
                //                sec2.cells.append(cellInfo)
                //                self.dataArray.append(sec2)
                //            }
                //        }
                self.tblView.delegate = self
                self.tblView.dataSource = self
                self.tblView.reloadData()
                }else{
                    Global.showAlertWithMessage(message: "Data not found.")
                }
                
            }else{
                Global.showAlertWithMessage(message: "Data not found.")
            }
        }
    }
    
}
