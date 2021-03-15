//
//  LoginVC.swift
//  AllInOne
//
//  Created by mac08 on 26/10/18.
//  Copyright © 2018 mac08. All rights reserved.
//

import UIKit
import MaterialComponents
import Alamofire
import EventKit
@available(iOS 10.0, *)
class LoginVC: UIViewController
{
    
    var request: Alamofire.Request? {
        didSet {
            //oldValue?.cancel()
        }
    }
    
    var activityIndicatorView: CustomActivityIndicatorView!
    var loginresponse=[String:Any]()
    var loginUrl = ""
    var data2 : String = ""
    var first_name : String? = ""
    var last_name : String? = ""
    var loginUrlWithParams = ""
    var user_id = [String]()
    let cameraManager = CameraManager()
    
    // MARK: - Declarations
    
    @IBOutlet weak var txtUsername: MDCTextField!
    @IBOutlet weak var txtPassword: MDCTextField!
    //TODO: Add text field controllers
    var usernameTextFieldController: MDCTextInputControllerUnderline!
    var passwordTextFieldController: MDCTextInputControllerUnderline!
    var isFirstTime = true
    
    
    // MARK: - IBActions
    
    @IBAction func btnSignInClicked(_ sender: UIButton)
    {
        if txtUsername.text?.count==0
        {
            
            usernameTextFieldController.setErrorText("",
                                                     errorAccessibilityValue: nil)
        }
        
        if txtPassword.text?.count==0
        {
            passwordTextFieldController.setErrorText("",
                                                     errorAccessibilityValue: nil)
        }
        else
        {
            
            checkConnection()
            
        }
    }
    @IBAction func btnForgotPasswordClicked(_ sender: UIButton)
    {
        let forgotPassVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ForgotPasswordVC")as! ForgotPasswordVC
        self.present(forgotPassVc, animated: false, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraManager.showAccessPermissionPopupAutomatically = false
        cameraManager.shouldEnableExposure = true
        
        cameraManager.shouldFlipFrontCameraImage = false
        
        self.activityIndicatorView = CustomActivityIndicatorView(title1: "loaf", center: CGPoint.init(x: view.bounds.width/2, y: view.bounds.height/2))
        
        let usernameView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20));
        let image = UIImage(named: "userb");
        usernameView.image = image;
        txtUsername.rightView = usernameView;
        txtUsername.rightViewMode = .always
        
        let passwordView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20));
        let passwordimage = UIImage(named: "passworad");
        passwordView.image = passwordimage;
        txtPassword.rightView = passwordView;
        txtPassword.rightViewMode = .always
        
        usernameTextFieldController = MDCTextInputControllerUnderline(textInput: txtUsername)
        passwordTextFieldController = MDCTextInputControllerUnderline(textInput: txtPassword)
        usernameTextFieldController.textInputFont = MDCTypography.titleFont()
        passwordTextFieldController.textInputFont = MDCTypography.titleFont()
        txtPassword.delegate = self
        txtPassword.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        cameraManager.resumeCaptureSession()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cameraManager.stopCaptureSession()
    }
    func checkConnection()
    {
        if ConnectionCheck.isConnectedToNetwork() {
            print("Connected")
            self.parent?.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())
            
            loginAPI()
        }
        else{
            let alert = UIAlertController(title: "", message: "Internet Not Available", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            print("disConnected")
        }
    }
    func textViewDidBeginEditing(textView: UITextView) {
        isFirstTime = false
        if txtUsername.text == "Enter Username" {
            txtUsername.text = ""
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if (txtUsername.text?.isEmpty)! {
            txtUsername.text = "Enter Username"
            isFirstTime = true
        }
    }
    func loginAPI()
    {
        
       
        let parameters: Parameters = ["email": txtUsername.text!,"password":txtPassword.text!]
        // Do any additional setup after loading the view, typically from a nib.
        let url = "http://allin1inspections.com/admin/Webservices/signin_post"
        self.request = Alamofire.request(url, method: .post, parameters:parameters)
        if let request = request as? DataRequest {
            request.responseString { response in
                do{
                    let dictionary = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    print(dictionary)
                    let msg = dictionary["msg"] as? NSString
                    print("msg =",msg!)
                    if msg == "Login Successfully"
                        
                    {
                        let alertController = UIAlertController(title: "Login", message: "\(msg!)", preferredStyle: .alert)
                        
                        // Create the actions
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                            UIAlertAction in
                            let favourite = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Dashboard")as! Dashboard
                            
                            
                            let data1 = dictionary["resultdata"] as? NSDictionary
                            print("data =",data1 as Any)
                            //                     self.user_id = ((data1?.value(forKey: "user_id") as! NSArray) as! [String])
                            //                    print("user_id =",self.user_id[0])
                            self.data2 = data1!["user_id"] as? NSString! as! String
                            print("user_id =",self.data2)
                            self.first_name = data1!["first_name"] as? NSString as! String
                            print("data2 =",self.first_name as Any)
                            self.last_name = data1!["last_name"] as? NSString as! String
                            print("data2 =",self.last_name as Any)
                            
                            //Set userDefaults Value...
                            
                            userDefault.set(self.txtUsername.text, forKey: "email")
                            userDefault.set(self.txtPassword.text, forKey: "password_name")
                            userDefault.set(self.data2, forKey: "userid")
                            userDefault.set(self.first_name, forKey: "first_name")
                            userDefault.set(self.last_name, forKey: "last_name")
                            
                            userDefault.set("1", forKey: "isLogin")
                            if(userDefault.value(forKey: "AddIndex") == nil){
                                userDefault.set(0, forKey: "AddIndex")
                            }
                            if(userDefault.value(forKey: "firstTimeForProperty") == nil){
                                userDefault.set(true, forKey: "firstTime")
                                userDefault.set(true, forKey: "firstTimeForProperty")
                            }
                            
                            print("defaults2=",userDefault)
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
                    else if msg == "Invalid login details"
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
                    else if msg == "Your Email is not registered with us."
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
}



// MARK: - UITextFieldDelegate
@available(iOS 10.0, *)
extension LoginVC: UITextFieldDelegate {
    
    //TODO: Add basic password field validation in the textFieldShouldReturn delegate function
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true
    }
}
