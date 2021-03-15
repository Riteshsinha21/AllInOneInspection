//
//  ForgotPasswordVC.swift
//  AllInOne
//
//  Created by Apple on 11/1/18.
//  Copyright © 2018 mac08. All rights reserved.
//

import UIKit
import MaterialComponents
import Alamofire
@available(iOS 10.0, *)
class ForgotPasswordVC: UIViewController {
    //Outlets $ Actios...
    @IBOutlet weak var txtUsername: MDCTextField!
    @IBOutlet weak var txtPassword: MDCTextField!
    //Variables...
    var request: Alamofire.Request? {
        didSet {
            //oldValue?.cancel()
        }
    }
    var usernameTextFieldController: MDCTextInputControllerUnderline!
    var passwordTextFieldController: MDCTextInputControllerUnderline!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        usernameTextFieldController = MDCTextInputControllerUnderline(textInput: txtUsername)
        usernameTextFieldController.textInputFont = MDCTypography.titleFont()
        usernameTextFieldController.textInputFont = MDCTypography.titleFont()
        txtUsername.delegate = self as? UITextFieldDelegate
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSignInClicked(_ sender: UIButton) {
        if txtUsername.text?.count==0
        {
            
            usernameTextFieldController.setErrorText("",
                                                     errorAccessibilityValue: nil)
        }
        else
        {
            loginAPI()
        }
    }
    func loginAPI()
    {
        
        let parameters: Parameters = ["email": txtUsername.text!]
        // Do any additional setup after loading the view, typically from a nib.
        let url = "http://allin1inspections.com/admin/Webservices/forgot_password"
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
                   
                    
                    //                    let success = dictionary["success"] as? NSString
                    //                    print("success =",success!)
                    if msg == "Your password is reset successfully. Please check your email"
                        
                    {
                        
                        let alertController = UIAlertController(title: "Login", message: "\(msg!)", preferredStyle: .alert)
                        
                        // Create the actions
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                            UIAlertAction in
                            let favourite = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")as! LoginVC
                            self.present(favourite, animated: false, completion: nil)
                            
                           
                            
                            self.present(alertController, animated: true, completion: nil)
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
                    else if msg == "Please enter your registered email"
                    {
                        
                        let alertController = UIAlertController(title: "Login", message: "\(msg!)", preferredStyle: .alert)
                        
                        // Create the actions
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                            UIAlertAction in
                            
                        }
                        
                        
                        // Add the actions
                        alertController.addAction(okAction)
                        
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
        let dashboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")as! LoginVC
        self.present(dashboard, animated: false, completion: nil)
        
    }
}
