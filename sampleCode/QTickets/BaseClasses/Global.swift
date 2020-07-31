
import UIKit
import CoreLocation
import MBProgressHUD
import Localize_Swift
import CoreData

public class Global : NSObject {
    
    typealias alertViewActionCompletionBlock = (Int) -> Void
    public static let shared = Global()
    
    /*******************************************************************************************************/
    //MARK:- Globlal Alert
    /******************************************************************************************************/
    public class func showAlertWithMessage(message: String, sender: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) {
        
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "key_alert_ok".localized(), style: UIAlertAction.Style.default, handler:nil))
        if sender != nil {
            sender!.present(alert, animated: true, completion: nil)
        }
    }
    
    
    class func showAlertViewController(withTitle titleString: String?, message messageString: String?, actions actionTitles: [Any]?, sender: UIViewController? = UIApplication.topViewController(), andActionCompletionBlock actionCompletionBlock: @escaping alertViewActionCompletionBlock) -> Void {
        
        
        let alertController = UIAlertController(title: titleString, message: messageString, preferredStyle: .alert)
        
        for indexOfAction in 0..<(actionTitles?.count ?? 0) {
            let actionTitle = actionTitles?[indexOfAction] as? String
            let action = UIAlertAction(title: actionTitle, style: .default, handler: { action in
                actionCompletionBlock(indexOfAction)
            })
            alertController.addAction(action)
        }
        if sender != nil {
            sender!.present(alertController, animated: true, completion: nil)
        }
    }
    
    /********************************************************************************************************/
    //MARK:- show/hide Global ProgressHUD
    /*****************************************************************************************************/
    
    @discardableResult public class func showLoadingSpinner(message: String? = "", sender: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> MBProgressHUD {
        
        //let window:UIWindow = UIApplication.sharedApplication().windows.last!
        var senderView = sender!.view
        if sender!.navigationController?.view != nil {
            senderView = sender!.navigationController?.view
        }
        let hud = MBProgressHUD.showAdded(to: senderView!, animated: true)
        if(message!.count > 0) {
            hud.label.text = message!;
        }
        hud.label.font = UIFont.systemFont(ofSize: 18)
        // hud.dimBackground = true;
        return hud
    }
    
    public class func dismissLoadingSpinner(sender: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> Void {
        //let window:UIWindow = UIApplication.sharedApplication().windows.last!
        var senderView = sender!.view
        if sender!.navigationController?.view != nil {
            senderView = sender!.navigationController?.view
        }
        MBProgressHUD.hide(for: senderView!, animated: true)
    }
    
    /********************************************************************************************************/
    //MARK:- App NSNull or nil clear
    /********************************************************************************************************/
    public class func getVal(param:AnyObject!) -> AnyObject {
        
        //print_debugMode("getVal = \(param)")
        
        if param == nil {
            return "" as AnyObject
        }
        else if param is NSNull {
            return "" as AnyObject
        }
            /*else if param is NSNumber {
             return "\(param)"
             }*/
        else {
            return param
        }
    }
    

    
    //MARK:- App Set UserDefaults Values
    /********************************************************************************************************/
    public class func setAppUserDefaultsValues(value:AnyObject,key:String) {
        Constants.APP_USER_DEFAULTS.set(value, forKey: key)
        Constants.APP_USER_DEFAULTS.synchronize()
    }
    
    /********************************************************************************************************/
    //MARK:- Get App UserDefaults Values
    /********************************************************************************************************/
    public class func getAppUserDefaults(key:String) -> String {
        Constants.APP_USER_DEFAULTS.synchronize()
        print(getVal(param: Constants.APP_USER_DEFAULTS.object(forKey: key) as AnyObject) as! String)
        return getVal(param: Constants.APP_USER_DEFAULTS.object(forKey: key) as AnyObject) as! String
    }
    
    /*********************************************************************************************************/
    //MARK:- Clear All UserDefaults Values
    /********************************************************************************************************/
    public class func clearAllAppUserDefaults() {
        
        for key in Constants.APP_USER_DEFAULTS.dictionaryRepresentation().keys {
            
            if  key != "LoftyToken" && key != "FatchBackup" {
                Constants.APP_USER_DEFAULTS.removeObject(forKey: key)
                
            }
        }
        Constants.APP_USER_DEFAULTS.synchronize()
    }
    /********************************************************************************************************/
    //MARK:- Print All User Defaults Values
    /********************************************************************************************************/
    public class func printAppAllUserDefaults() {
        
        Constants.APP_USER_DEFAULTS.synchronize()
        for elem in Constants.APP_USER_DEFAULTS.dictionaryRepresentation() {
            print_QT4DebugModeSimpleForm(items: "------------------------------")
            print_QT4DebugModeSimpleForm(items: "User defaults value::- [\(elem)]")
        }
    }
    
    
    //MARK:- open core database
    var context:NSManagedObjectContext!
    
    
    func openDatabse(combinedCode:String, countryAlpha2Code:String, countryAlpha3Code:String, countryName:String, id:String)
    {
        
        context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CountryTabel", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        saveData(UserDBObj: newUser, combinedCode: combinedCode, countryAlpha2Code: countryAlpha2Code, countryAlpha3Code: countryAlpha3Code, countryName: countryName, id: id)
    }
    
    //MARK:- save coutry list in database
    
    func saveData(UserDBObj:NSManagedObject, combinedCode:String, countryAlpha2Code:String, countryAlpha3Code:String, countryName:String, id:String)
    {
        UserDBObj.setValue(combinedCode, forKey: "combinedCode")
        UserDBObj.setValue(countryAlpha2Code, forKey: "countryAlpha2Code")
        UserDBObj.setValue(countryAlpha3Code, forKey: "countryAlpha3Code")
        UserDBObj.setValue(countryName, forKey: "countryName")
        UserDBObj.setValue(id, forKey: "id")
        
        print("Core data Storing Data..")
        do {
            try context.save()
        } catch {
            print("Core data Storing data Failed")
        }
        
        //  fetchData()
    }
    
    //MARK:- Retrive coutry list in database
    public class func fetchData()-> [NSManagedObject]?
    {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return nil}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "CountryTabel")
        do {
            
            let result = try manageContent.fetch(fetchData)
            //allData = result as! [NSManagedObject]
            print(result)
            
            if(result.count>0){
                
                //                for data in (result as! [NSManagedObject]) {
                //                    let itemAmount = data.value(forKey: "totalamount") as? String ?? ""
                //                    let itemCount = data.value(forKey: "item_count") as? String ?? ""
                //                    print("User Amount is : "+itemAmount+" and count is : "+itemCount)
                //                    strtotalPrice = Int(itemAmount)! + strtotalPrice
                //                    print(strtotalPrice)
                //                    strtotalCount = Int(itemCount)! + strtotalCount
                //                    print(strtotalCount)
                //                    }
                //
                return (result as! [NSManagedObject])
            }else{
                
            }
        }catch {
            print("err")
            
        }
        return nil
    }
    
}

