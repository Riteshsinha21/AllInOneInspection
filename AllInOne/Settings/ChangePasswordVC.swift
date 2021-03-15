//
//  ChangePasswordVC.swift
//  AllInOne
//
//  Created by Apple on 11/1/18.
//  Copyright © 2018 mac08. All rights reserved.
//

import UIKit
import MaterialComponents
import Alamofire
@available(iOS 10.0, *)
class ChangePasswordVC: UIViewController {

    //Outlets & Actions...
     @IBOutlet weak var txtNewPass: MDCTextField!
     @IBOutlet weak var txtOldPass: MDCTextField!
     @IBOutlet weak var txtConfirmPass: MDCTextField!
    
    //Declare Variables...
    var usernameTextFieldController: MDCTextInputControllerUnderline!
    var oldPassTextFieldController: MDCTextInputControllerUnderline!
    var newPassTextFieldController: MDCTextInputControllerUnderline!
    var request: Alamofire.Request? {
        didSet {
            //oldValue?.cancel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        oldPassTextFieldController = MDCTextInputControllerUnderline(textInput: txtOldPass)
        newPassTextFieldController = MDCTextInputControllerUnderline(textInput: txtNewPass)
        usernameTextFieldController = MDCTextInputControllerUnderline(textInput: txtConfirmPass)
        
        
    
      //  oldPassTextFieldController.inlinePlaceholderFont = MDCTypography.titleFont()
        oldPassTextFieldController.textInputFont = MDCTypography.titleFont()
        
       // newPassTextFieldController.inlinePlaceholderFont = MDCTypography.titleFont()
        newPassTextFieldController.textInputFont = MDCTypography.titleFont()
        
       // usernameTextFieldController.inlinePlaceholderFont = MDCTypography.titleFont()
        usernameTextFieldController.textInputFont = MDCTypography.titleFont()
        
        print("txtfont..",txtOldPass.placeholderLabel.font)
        txtOldPass.delegate = self as? UITextFieldDelegate
        txtNewPass.delegate = self as? UITextFieldDelegate
        txtConfirmPass.delegate = self as? UITextFieldDelegate
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnSignInClicked(_ sender: UIButton) {
        if txtOldPass.text?.count==0
        {
            
            oldPassTextFieldController.setErrorText("",
                                                     errorAccessibilityValue: nil)
        }
      else  if txtNewPass.text?.count==0
        {
            
            newPassTextFieldController.setErrorText("",
                                                     errorAccessibilityValue: nil)
        }
       else if txtConfirmPass.text?.count==0
        {
            
            usernameTextFieldController.setErrorText("",
                                                     errorAccessibilityValue: nil)
        }
            else if txtNewPass.text != txtConfirmPass.text
        {
            let alertController = UIAlertController(title: "Change Password", message: "Password not match", preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
            }
            
            
            // Add the actions
            alertController.addAction(okAction)
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
        }
            
        else
        {
            if ConnectionCheck.isConnectedToNetwork() {
                print("Connected")
                
                // self.activityIndicatorView.startAnimating()
                loginAPI()
            }
            else{
                let alert = UIAlertController(title: "", message: "Internet Not Available", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                print("disConnected")
            }
        }
    }
    func loginAPI()
    {
        let defaults = UserDefaults.standard
        let name = defaults.string(forKey: "userid")
        print("user_id...",name)
        let parameters: Parameters = ["user_id": name!,"current_password":txtOldPass.text!,"new_password":txtNewPass.text!]
        print("Parametes",parameters)
    // Do any additional setup after loading the view, typically from a nib.
    let url = "http://allin1inspections.com/admin/Webservices/changepassword"
    //let timeParameter =  self.getLastTimeStamp()
    self.request = Alamofire.request(url, method: .post, parameters:parameters)
    if let request = request as? DataRequest {
    request.responseString { response in
    //PKHUD.sharedHUD.hide()
    do{
    let dictionary = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
    print(dictionary)
    let msg = dictionary["msg"] as? NSString
    print("msg =",msg!)
   
    
    if msg == "Your current password is wrong"
    
    {
    
    let alertController = UIAlertController(title: "Chnage Password", message: "\(msg!)", preferredStyle: .alert)
    
    // Create the actions
    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
    UIAlertAction in
    
   
    }
    
   
    // Add the actions
    alertController.addAction(okAction)
    
    // Present the controller
    self.present(alertController, animated: true, completion: nil)
    
    
    }
   
    
        else
        
    {
        let alertController = UIAlertController(title: "Change Password", message: "\(msg!)", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            let dashboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Dashboard")as! Dashboard
            self.present(dashboard, animated: false, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
        }
    
    }catch{
    
    }
    }
    }
    
    }
    @IBAction func backBtn(_ sender: Any)
    {
        let dashboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Dashboard")as! Dashboard
        self.present(dashboard, animated: false, completion: nil)
        
    }
}
