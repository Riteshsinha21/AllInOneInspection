//
//  ForgetPasswordVC.swift
//  AllInOneInspections
//
//  Created by Ritesh Sinha on 30/04/21.
//

import UIKit

class ForgetPasswordVC: UIViewController {

    @IBOutlet weak var mailTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendAction(_ sender: Any) {
        if self.mailTxt.text!.isEmpty {
            self.view.makeToast("Please enter your Email.")
            return
        }
        self.forgetPasswordApiCall()
    }
    
    func forgetPasswordApiCall() {
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
            
            let param:[String:Any] = ["email": self.mailTxt.text!]
            ServerClass.sharedInstance.postRequestWithUrlParameters(param, path: BASE_URL + PROJECT_URL.FORGET_PASSWORD, successBlock: { (json) in
                print(json)
                hideAllProgressOnView(appDelegateInstance.window!)
                let success = json["success"].boolValue
                if success {
                    
                    self.view.makeToast(json["message"].stringValue)
                }
                else {
                    self.view.makeToast("\(json["message"].stringValue)")
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
