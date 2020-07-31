

import UIKit
import Cosmos

protocol APReviewPopViewDelegate {
    func submitButtonClickWith(ratting: String, reviewMessage: String)
}

class APReviewPopView: UIView, UITextViewDelegate {
    @IBOutlet weak var rettingView: CosmosView!
    
    @IBOutlet weak var reviewHeaderLabel: UILabel!
    @IBOutlet weak var textViePlaceHolderLabel: UILabel!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    
    var reviewDelegate: APReviewPopViewDelegate?
    
    //MARK:- Initial
    func initialSetUpWith() {
        
        print_QT4DebugMode()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tap)
        
        submitButton.layer.cornerRadius = 4.0
        reviewTextView.layer.cornerRadius = 4.0
        reviewTextView.layer.borderWidth = 1.0
        reviewTextView.layer.borderColor = UIColor.reviewFillStarColor().cgColor
        reviewTextView.delegate = self
    }
    
    //MARK:- Helper methode
    
    func alertWith(message: String) {
        
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert + 1
        
        let alert = UIAlertController(title: "Alert".localized(), message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK".localized(), style: UIAlertAction.Style.default, handler:nil))
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- ButtonAction methode
    @IBAction func actionForSubmitButtonClick() {
        print_QT4DebugMode()
        
        if rettingView.rating == 0.0 {
            alertWith(message: "Please give rating".localized())
            
        } else {
            if reviewTextView.text.count > 0 {
                reviewDelegate?.submitButtonClickWith(ratting: String(rettingView!.rating), reviewMessage: reviewTextView.text)
                
            } else {
                alertWith(message: "Please write your review".localized())
            }
        }
        
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
    
    //MARK:- UITextview Delegate methode
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        textViePlaceHolderLabel.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.count > 0 {
            textViePlaceHolderLabel.isHidden = true
        } else {
            textViePlaceHolderLabel.isHidden = false
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
