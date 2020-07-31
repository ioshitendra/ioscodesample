

import UIKit

public extension UIViewController {

    func setNavigationBarStyle(transparent: Bool? = false, leftButton: Bool? = false, rightButton: Bool? = false, title: String) {
        
        if transparent == true {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage =  UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.view.backgroundColor = UIColor.clear
        } else {
            let navLabel = UILabel()
            navLabel.frame = CGRect(x: 0, y: 0, width: 240, height: 44)
            navLabel.numberOfLines = 1
            navLabel.textAlignment = .left
            
            navLabel.textAlignment = .center
            let navTitle = NSMutableAttributedString(string: title, attributes:[
                NSAttributedString.Key.font: FontHelper.MontserratMediumFontWithSize(size: 19.0),
                NSAttributedString.Key.foregroundColor: UIColor.white])
            
            navLabel.attributedText = navTitle
            navigationItem.titleView = navLabel
            self.navigationController?.navigationBar.barTintColor = UIColor.AppStatusBarColor()
            self.navigationController?.navigationBar.isTranslucent = false
            
            if leftButton == true && rightButton == true {
                setLeftBarButton()
                setRightBarButton()
            } else if leftButton == true {
                setLeftBarButton()
            } else if rightButton == true {
                setRightBarButton()
            }
        }
    }
    
    func setLeftBarButton() {
        
        let navBtn = UIButton(type: .custom)
        navBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        navBtn.setImage(AssetsImages.qNavBarBack, for:.normal)
        navBtn.addTarget(self, action: #selector(clickBackButton), for: .touchUpInside)
        let sidebarButton = UIBarButtonItem(customView: navBtn)
        navigationItem.leftBarButtonItem = sidebarButton
    }
    
    @objc func clickBackButton() {
        navigationController?.popViewController(animated: true)
    }

    
    func setRightBarButton() {
        
       let navBtn = UIButton(type: .custom)
        navBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        navBtn.setImage(AssetsImages.qSearchWhite, for:.normal)
        navBtn.addTarget(self, action: #selector(serachAction), for:.touchUpInside)
        let sidebarButton = UIBarButtonItem(customView: navBtn)
        navigationItem.rightBarButtonItem = sidebarButton
    }
    
    func setStatusBar(){
        if #available(iOS 13.0, *) {
            let statusBarHeight: CGFloat = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
            let statusbarView = UIView()
            statusbarView.backgroundColor = UIColor.AppStatusBarColor()
            view.addSubview(statusbarView)
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
        } else {
          //  let statusBar1: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
          //  statusBar1.backgroundColor = UIColor.AppStatusBarColor()
        }
    }
    
    
     @objc func serachAction() {
    }


}

