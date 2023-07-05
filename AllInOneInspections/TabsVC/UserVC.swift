//
//  UserVC.swift
//  AllInOneInspections
//
//  Created by Ritesh Sinha on 27/04/21.
//

import UIKit
import CropViewController

class UserVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CropViewControllerDelegate {

    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var userProfileImg: UIImageView!
    
    private var croppingStyle = CropViewCroppingStyle.default
    var imageData: Data = Data()
    private var croppedRect = CGRect.zero
    private var croppedAngle = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        self.firstNameTxt.isUserInteractionEnabled = false
//        self.lastNameTxt.isUserInteractionEnabled = false
//        self.updateBtn.isUserInteractionEnabled = false
//        self.updateBtn.alpha = 0.5
        self.firstNameTxt.text = UserDefaults.standard.value(forKey: USER_DEFAULTS_KEYS.INSPECTOR_FIRST_NAME) as? String
        self.lastNameTxt.text = UserDefaults.standard.value(forKey: USER_DEFAULTS_KEYS.INSPECTOR_LAST_NAME) as? String
    }
    
    @IBAction func updateAction(_ sender: Any) {
        
        self.updateProfileAPI()
    }
    
    func updateProfileAPI() {
        if Reachability.isConnectedToNetwork() {
            showProgressOnView(appDelegateInstance.window!)
            if let objFcmKey = UserDefaults.standard.object(forKey: "fcm_key") as? String
            {
                fcmKey = objFcmKey
            }
            else
            {
                fcmKey = "abcdef"
            }
            
            let param:[String:Any] = ["fname": self.firstNameTxt.text!,"lname":self.lastNameTxt.text!, "profile_image": ""]
            ServerClass.sharedInstance.postRequestWithUrlParameters(param, path: BASE_URL + PROJECT_URL.UPDATE_PROFILE, successBlock: { (json) in
                print(json)
                hideAllProgressOnView(appDelegateInstance.window!)
                let success = json["success"].boolValue
                if success {
                    
                    self.view.makeToast(json["msg"].stringValue)
                    
                    
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
    
    func uploadProfileImgAction() {
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))

        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))

        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            self.croppingStyle = .default
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            self.croppingStyle = .default
            
            let imagePicker = UIImagePickerController()
            imagePicker.modalPresentationStyle = .popover
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) else { return }
        
        let cropController = CropViewController(croppingStyle: croppingStyle, image: image)
        //cropController.modalPresentationStyle = .fullScreen
        cropController.delegate = self
        
        
        //If profile picture, push onto the same navigation stack
        if croppingStyle == .circular {
            if picker.sourceType == .camera {
                picker.dismiss(animated: true, completion: {
                    self.present(cropController, animated: true, completion: nil)
                })
            } else {
                picker.pushViewController(cropController, animated: true)
            }
        }
        else { //otherwise dismiss, and then present from the main controller
            picker.dismiss(animated: true, completion: {
                self.present(cropController, animated: true, completion: nil)
                //self.navigationController!.pushViewController(cropController, animated: true)
            })
        }
        
    }
    
    func presentCropViewController(_ image: UIImage) {
      //let image: UIImage = ... //Load an image

      let cropViewController = CropViewController(image: image)
      cropViewController.delegate = self
      present(cropViewController, animated: true, completion: nil)
    }

    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
            // 'image' is the newly cropped version of the original image

        self.imageData = image.jpegData(compressionQuality: 0.5)!
        //self.imageData = image.pngData()! as NSData
        DispatchQueue.main.async {
            self.userProfileImg.image = image
        }
        cropViewController.dismiss(animated: true, completion: nil)

        }



}
