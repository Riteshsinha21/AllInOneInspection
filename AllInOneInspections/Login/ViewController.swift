//
//  ViewController.swift
//  AllInOneInspections
//
//  Created by Ritesh Sinha on 26/04/21.
//

import UIKit
import Toast_Swift

class ViewController: UIViewController {
    
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var mailTxt: UITextField!
    
    var inspectorDetailDic = inspectorDetail_struct()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func forgetPasswordAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgetPasswordVC") as! ForgetPasswordVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func loginApiCall() {
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
            
            let param:[String:Any] = ["email": self.mailTxt.text!,"password":self.passwordTxt.text!, "fcm_key": fcmKey,"device_type":"ios", "user_type":"Home Inspector", "device_id":UIDevice.current.identifierForVendor!.uuidString]
            ServerClass.sharedInstance.postRequestWithUrlParameters(param, path: BASE_URL + PROJECT_URL.LOGIN, successBlock: { (json) in
                print(json)
                hideAllProgressOnView(appDelegateInstance.window!)
                let success = json["success"].boolValue
                if success {
                    
                    UserDefaults.standard.setValue(json["token"].stringValue, forKey: USER_DEFAULTS_KEYS.LOGIN_TOKEN)
                    UserDefaults.standard.setValue(json["data"]["first_name"].stringValue, forKey: USER_DEFAULTS_KEYS.INSPECTOR_FIRST_NAME)
                    UserDefaults.standard.setValue(json["data"]["last_name"].stringValue, forKey: USER_DEFAULTS_KEYS.INSPECTOR_LAST_NAME)
                    UserDefaults.standard.setValue(json["data"]["email"].stringValue, forKey: USER_DEFAULTS_KEYS.INSPECTOR_EMAIL)
                    
                    self.view.makeToast(json["message"].stringValue)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        
                        guard let window = UIApplication.shared.delegate?.window else {
                            return
                        }
                        
                        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "tabBarcontroller") as! UITabBarController
                        
                        window!.rootViewController = viewController
                        let options: UIView.AnimationOptions = .transitionCrossDissolve
                        let duration: TimeInterval = 0.5
                        UIView.transition(with: window!, duration: duration, options: options, animations: {}, completion:
                                            { completed in
                                                window!.makeKeyAndVisible()
                                            })
                        }
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
    
    @IBAction func signInAction(_ sender: Any) {
        if self.mailTxt.text!.isEmpty {
            self.view.makeToast("Please Enter Email.")
            return
        } else if self.passwordTxt.text!.isEmpty {
            self.view.makeToast("Please Enter Password.")
            return
        }
        self.loginApiCall()
    }
    
    
}

