//
//  ViewController.swift
//  camera
//
//  Created by Natalia Terlecka on 10/10/14.
//  Copyright (c) 2014 Imaginary Cloud. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData
//import CameraManager

@available(iOS 11.0, *)
class ViewController: UIViewController {
    
    // MARK: - Constants
    
    let cameraManager = CameraManager()
    // var myImagesDecoded = [UIImage]()
    var instanceOfVCA:PicsVC?

    let catObj = CategoiesImageVC()
    
    // MARK: - @IBOutlets
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var flashModeImageView: UIImageView!
    @IBOutlet weak var outputImageView: UIImageView!
    @IBOutlet weak var cameraTypeImageView: UIImageView!
    @IBOutlet weak var qualityLabel: UILabel!
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var askForPermissionsLabel: UILabel!
    
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var cameraButton: UIButton!
    var data2 : NSData!
    let darkBlue = UIColor(red: 4/255, green: 14/255, blue: 26/255, alpha: 1)
    let lightBlue = UIColor(red: 24/255, green: 125/255, blue: 251/255, alpha: 1)
    let redColor = UIColor(red: 229/255, green: 77/255, blue: 67/255, alpha: 1)
    
    var fromwhere = ""
    var CatId = ""
    var CatName = ""
    var subCatId = ""
    var SubCatName = ""
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        navigationController?.navigationBar.isHidden = true
        //cameraManager.cameraOutputMode = ////
        
        askForPermissionsLabel.isHidden = true
        askForPermissionsLabel.backgroundColor = lightBlue
        askForPermissionsLabel.textColor = .white
        askForPermissionsLabel.isUserInteractionEnabled = true
        
        footerView.backgroundColor = darkBlue
        headerView.backgroundColor = darkBlue
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways, .authorizedWhenInUse:
                self.cameraManager.shouldUseLocationServices = true
            default:
                self.cameraManager.shouldUseLocationServices = false
            }
        }
            addCameraToView()
        flashModeImageView.image = UIImage(named: "flash_off")
        if cameraManager.hasFlash {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeFlashMode))
            flashModeImageView.addGestureRecognizer(tapGesture)
        }
        
        outputImageView.image = UIImage(named: "output_image")
        cameraTypeImageView.image = UIImage(named: "switch_camera")
        qualityLabel.isUserInteractionEnabled = true
    }
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
    }
    override func viewWillDisappear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)

    }
    
    // MARK: - ViewController
    fileprivate func addCameraToView()
    {
        //
    cameraManager.addPreviewLayerToView(cameraView, newCameraOutputMode: CameraOutputMode.stillImage)
        cameraManager.showErrorBlock = { [weak self] (erTitle: String, erMessage: String) -> Void in
            
            let alertController = UIAlertController(title: erTitle, message: erMessage, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (alertAction) -> Void in  }))
            
            self?.present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: - @IBActions
    
    @IBAction func changeFlashMode(_ sender: UIButton) {
        
        switch cameraManager.changeFlashMode() {
        case .off:
            flashModeImageView.image = UIImage(named: "flash_off")
        case .on:
            flashModeImageView.image = UIImage(named: "flash_on")
        case .auto:
            flashModeImageView.image = UIImage(named: "flash_auto")
        }
    }
    
    @IBAction func recordButtonTapped(_ sender: UIButton) {
        
        switch cameraManager.cameraOutputMode {
        case .stillImage:
            cameraManager.capturePictureWithCompletion({ (image, error) -> Void in
                if error != nil {
                    self.cameraManager.showErrorBlock("Error occurred", "Cannot save picture.")
                }
                else {
                  //  PicsVC.instance.str123 = "Adf"
                
                    var capturedImage = image
                    
                    var actualHeight: Float = Float(capturedImage!.size.height)
                    var actualWidth: Float = Float(capturedImage!.size.width)
                    let maxHeight: Float = 300.0
                    let maxWidth: Float = 400.0
                    var imgRatio: Float = actualWidth / actualHeight
                    let maxRatio: Float = maxWidth / maxHeight
                    let compressionQuality: Float = 0.5
                    //50 percent compression
                    
                    if actualHeight > maxHeight || actualWidth > maxWidth {
                        if imgRatio < maxRatio {
                            //adjust width according to maxHeight
                            imgRatio = maxHeight / actualHeight
                            actualWidth = imgRatio * actualWidth
                            actualHeight = maxHeight
                        }
                        else if imgRatio > maxRatio {
                            //adjust height according to maxWidth
                            imgRatio = maxWidth / actualWidth
                            actualHeight = imgRatio * actualHeight
                            actualWidth = maxWidth
                        }
                        else {
                            actualHeight = maxHeight
                            actualWidth = maxWidth
                        }
                    }
                    
                    let rect = CGRect(x: 0, y: 0, width: 1024, height: 1024)//100
                    UIGraphicsBeginImageContext(rect.size)
                    capturedImage!.draw(in: rect)
                    let img = UIGraphicsGetImageFromCurrentImageContext()
                     let imageData = UIImageJPEGRepresentation(img!,CGFloat(compressionQuality))
                    capturedImage = UIImage(data: imageData!)
                    UIGraphicsEndImageContext()
                    
                    if self.fromwhere == "categories"
                    {
                        let imagename = "tempImg\(Int64(NSDate().timeIntervalSince1970 * 1000)).jpg"
                        
                        self.saveimageinDic(numm: imagename, image: capturedImage!)
                        CategoiresImagesIDArray.append(imagename)
                        categoiresNewimagearray.append(img!)
                        print("imageUrlArray",CategoiresImagesIDArray.count)
                        
                    }
                    else{
                        if inspectionIdStr != nil
                        {
                            myImagesDecoded.append(img!)
                            myNewlyAddedImages.append(img!)
                            
                            
                           // print("arrayImg..",myNewlyAddedImages)
                            global = "A"
                            
                            let imagename = "tempImg\(Int64(NSDate().timeIntervalSince1970 * 1000)).jpg"
                            
                            self.saveimageinDic(numm: imagename, image: capturedImage!)
                            myImagesID.append(imagename)
                            print("imageUrlArray",imageUrlArray.count)
                            
                            
                        }
                    }


                    
                  
                }
                
            })

        }
    }
    
    func saveimageinDic(numm:String, image:UIImage){
        
        let document = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        print(document)
        let imgurl = document.appendingPathComponent(numm, isDirectory: true)
        print(imgurl)
        
        if !FileManager.default.fileExists(atPath: imgurl.path)
        {
            do{
                try UIImagePNGRepresentation(image)?.write(to: imgurl)
                print("images added")
            }catch{
                print("imaeg not added")
                
            }
        }
        if self.fromwhere == "categories"
        {
          
          categoiresimagarray.append(imgurl)
        }
        else{
            imageUrlArray.append(imgurl)
            myImagespath.append(imgurl)
        }
//        imageUrlArray.append(imgurl)
//        myImagespath.append(imgurl)
    }
    
   
    
   
    
    @IBAction func cancelBtn(_ sender: Any)
    {
        
        if self.fromwhere == "categories"
        {
//            catObj.catid = CatId
//            catObj.catName = CatName
//            catObj.subcatid = subCatId
//            catObj.subcatName = SubCatName
//            catObj.saveAssingPhotos()
//            catObj.savePhotos()
            // catid subcatid subcatName catName
        
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadcategoires"), object: nil)
            self.dismiss(animated: true, completion: nil)
            
        }
        else{
            let instance: InspectionsVC = InspectionsVC()
            instance.savePhotos()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            self.dismiss(animated: true, completion: nil)
        }

        
    }
    
    @IBAction func cancelBtn2(_ sender: Any)
    {
        ButtonClickcountPics = 0
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
