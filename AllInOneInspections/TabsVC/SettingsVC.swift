//
//  SettingsVC.swift
//  AllInOneInspections
//
//  Created by Ritesh Sinha on 27/04/21.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var confirmNewPasswordTxt: UITextField!
    @IBOutlet weak var newPasswordTxt: UITextField!
    @IBOutlet weak var currentPasswordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func updateNowAction(_ sender: Any) {
        if self.currentPasswordTxt.text!.isEmpty {
            self.view.makeToast("Please Enter Current Password.")
            return
        } else if self.newPasswordTxt.text!.isEmpty {
            self.view.makeToast("Please Enter New Password.")
            return
        } else if self.confirmNewPasswordTxt.text!.isEmpty {
            self.view.makeToast("Please Confirm your Password")
            return
        } else if self.confirmNewPasswordTxt.text! != self.newPasswordTxt.text! {
            self.view.makeToast("Passwords not matched.")
            return
        }
        self.changePasswordAPI()
    }
    
    func changePasswordAPI() {
        if Reachability.isConnectedToNetwork() {
            showProgressOnView(appDelegateInstance.window!)
            if let objFcmKey = UserDefaults.standard.object(forKey: "fcm_key") as? String
            {
                fcmKey = objFcmKey
            }
            else
            {
                //                fcmKey = ""
                fcmKey = "abcdef"
            }
            
            let param:[String:Any] = ["current_password": self.currentPasswordTxt.text!,"new_password":self.confirmNewPasswordTxt.text!]
            ServerClass.sharedInstance.postRequestWithUrlParameters(param, path: BASE_URL + PROJECT_URL.CHANGE_PASSWORD, successBlock: { (json) in
                print(json)
                hideAllProgressOnView(appDelegateInstance.window!)
                let success = json["success"].boolValue
                if success {
                    
                    self.view.makeToast(json["message"].stringValue)
                    
                    self.confirmNewPasswordTxt.text = ""
                    self.newPasswordTxt.text = ""
                    self.currentPasswordTxt.text = ""
                    
                }
                else {
                    self.view.makeToast("\(json["error"].stringValue)")
                }
            }, errorBlock: { (NSError) in
                UIAlertController.showInfoAlertWithTitle("Alert", message: kUnexpectedErrorAlertString, buttonTitle: "Okay")
                hideAllProgressOnView(appDelegateInstance.window!)
            })
            
        }else{
            hideAllProgressOnView(appDelegateInstance.window!)
            UIAlertController.showInfoAlertWithTitle("Alert", message: "Please Check internet connection", buttonTitle: "Okay")
        }
    }

}
