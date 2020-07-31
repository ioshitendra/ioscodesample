

import UIKit
import Localize_Swift
class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting TabBar Properties
        self.tabBar.unselectedItemTintColor = UIColor.AppTabBarUnSelectedColor()
        tabBar.items?[0].title = "key_tab_home".localized()
        tabBar.items?[1].title = "key_buzz".localized()
        tabBar.items?[2].title = "key_tab_search".localized()
        tabBar.items?[3].title = "key_tab_account".localized()
        
        // Setting Status bar properties
        if #available(iOS 13.0, *) {
            let app = UIApplication.shared
            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
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
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = UIColor.AppStatusBarColor()
        }

    }

}

extension TabBarController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

