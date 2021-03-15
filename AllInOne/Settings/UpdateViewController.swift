//
//  UpdateViewController.swift
//  AllInOne
//
//  Created by Apple on 11/1/18.
//  Copyright © 2018 mac08. All rights reserved.
//

import UIKit
import MaterialComponents
import Alamofire

@available(iOS 10.0, *)
class UpdateViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    //Variables Define here...
    var picker:UIImagePickerController?=UIImagePickerController()
    var firstNameTextFieldController: MDCTextInputControllerUnderline!
    var lastNameTextFieldController: MDCTextInputControllerUnderline!
    var request: Alamofire.Request? {
        didSet {
            //oldValue?.cancel()
        }
    }
    var data2 : String = ""
    var first_name : String? = ""
    var last_name : String? = ""
    
    //Outlets Defined Here...
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var txtFirstName: MDCTextField!
    @IBOutlet weak var txtLastName: MDCTextField!
    @IBOutlet weak var profileBtnOut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        picker?.delegate = self
        firstNameTextFieldController = MDCTextInputControllerUnderline(textInput: txtFirstName)
        txtFirstName.delegate = self as? UITextFieldDelegate
        lastNameTextFieldController = MDCTextInputControllerUnderline(textInput: txtLastName)
        txtLastName.delegate = self as? UITextFieldDelegate
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone)
        {
        profileBtnOut.layer.cornerRadius = 50
        profileImageView.layer.cornerRadius = 50
        }
        else
        {
        profileBtnOut.layer.cornerRadius = 85
       profileImageView.layer.cornerRadius = 85
        }
        profileBtnOut.clipsToBounds = true
        profileBtnOut.layer.borderWidth = 2
        profileBtnOut.layer.borderColor = UIColor.blue.withAlphaComponent(1.0).cgColor
        profileImageView.clipsToBounds = true
        
        profileImageView.layer.borderColor = UIColor.white.withAlphaComponent(1.0).cgColor
        let defaults = UserDefaults.standard
        let first_name = defaults.string(forKey: "first_name")
        print("firstName",first_name!)
        let last_name = defaults.string(forKey: "last_name")
        txtFirstName.text = first_name
        txtLastName.text = last_name
        
         firstNameTextFieldController.textInputFont = MDCTypography.titleFont()
         lastNameTextFieldController.textInputFont = MDCTypography.titleFont()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSignInClicked(_ sender: UIButton) {
        if txtFirstName.text?.count==0
        {
            
            firstNameTextFieldController.setErrorText("",
                                                     errorAccessibilityValue: nil)
        }
            
       else if txtLastName.text?.count==0
        {
            
            lastNameTextFieldController.setErrorText("",
                                                      errorAccessibilityValue: nil)
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
        let image = UIImage (named: "logout")
        let jpegCompressionQuality: CGFloat = 0.2 // Set this to whatever suits your purpose
        let base64String = UIImageJPEGRepresentation(profileImageView.image!
            , jpegCompressionQuality)?.base64EncodedString()
        print("base64Str=",base64String)
        let parameters: Parameters = ["user_id": name!,"fname":(txtFirstName.text)!,"lname":(txtLastName.text)!,"profile_image":base64String!]
        
    print("ParametesUpdate",parameters)
    // Do any additional setup after loading the view, typically from a nib.
       // http://allin1inspections.com
    let url = "http://allin1inspections.com/admin/Webservices/updateProfile"
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
    
    // self.loginAPI2()
    if msg == "Login Successfully"
    
    {
    
    let alertController = UIAlertController(title: "Update Profile", message: "\(msg!)", preferredStyle: .alert)
    
    // Create the actions
    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
    UIAlertAction in
       
    let favourite = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Dashboard")as! Dashboard
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
    
    
    else
    
    {
    let alertController = UIAlertController(title: "Update Profile", message: "\(msg!)", preferredStyle: .alert)
    
    // Create the actions
    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
    {
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
    func loginAPI2()
    {
        let defaults = UserDefaults.standard
        let email = defaults.string(forKey: "email")
        print("email..",email!)
        let password_name = defaults.string(forKey: "password_name")
        let parameters: Parameters = ["email": email!,"password":password_name!]
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let url = "http://allin1inspections.com/admin/Webservices/signin_post"
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
                    
                    
                    if msg == "Login Successfully"
                        
                    {
                      
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
                            
//                            userDefault.set(self.txtUsername.text, forKey: "email")
//                            userDefault.set(self.txtPassword.text, forKey: "password_name")
                            userDefault.set(self.data2, forKey: "userid")
                            userDefault.set(self.first_name, forKey: "first_name")
                            userDefault.set(self.last_name, forKey: "last_name")
                            
                            userDefault.set("1", forKey: "isLogin")
                            print("defaults2=",userDefault)
                            self.present(favourite, animated: false, completion: nil)
                            
                            
                        
                        
                       
                    }
                    
                }
                catch{
                    
                }
            }
        }
        
    }
    @IBAction func takePhotoBtn(_ sender: Any)
    {
        let alertController = UIAlertController(title: "Choose Photo", message: "", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Take Photo", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.openCamera()
        }
        let cancelAction = UIAlertAction(title: "Open Gallery", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            self.openGallary()
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    func openGallary()
    {
        picker!.allowsEditing = false
        picker!.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(picker!, animated: true, completion: nil)
    }
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            picker!.allowsEditing = false
            picker!.sourceType = UIImagePickerControllerSourceType.camera
            picker!.cameraCaptureMode = .photo
            present(picker!, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        //profileImageView.contentMode = .scaleAspectFit
        profileImageView.image = chosenImage
        //self.performSegue(withIdentifier: "ShowEditView", sender: self)
        dismiss(animated: true, completion: nil)
    }

    @IBAction func backBtn(_ sender: Any)
    {
//        let dashboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Dashboard")as! Dashboard
//        self.present(dashboard, animated: false, completion: nil)
        dismiss(animated: true, completion: nil)
    }
}
