//
//  InspectionsVC.swift
//  AllInOne
//
//  Created by Apple on 11/2/18.
//  Copyright © 2018 mac08. All rights reserved.
//

import UIKit
import CoreData
import SVProgressHUD
import Alamofire
@available(iOS 10.0, *)
class InspectionsVC: PagerController,PagerDataSource {
    
    var request: Alamofire.Request? {
        didSet {
            //oldValue?.cancel()
        }
    }
    @IBOutlet weak var lbl_HeaderName: UILabel?
    @IBOutlet weak var lblpleseWait: UILabel!
    @IBOutlet weak var btnSaveOutlet: UIButton!
    var titles: [String] = []
    var assignStr : String = ""
    var fromWhere : String = ""
    
    //MARK:- Did Load method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("firstName....",firstNameStr!)
        uploadedimageCount = 0
        
        
        let defaults = UserDefaults.standard
        userId = defaults.string(forKey: "userid")!
        UserDefaults.standard.set(false, forKey: "SaveChangesOrNot")
        print("user_id..",userId)
        self.dataSource = self
        if (fromWhere == "Newmode")
        {
            lbl_HeaderName?.text = "New Inspection"
        }else
        {
            lbl_HeaderName?.text = inspAdd
        }
        // Instantiating Storyboard ViewControllers
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller1 = storyboard.instantiateViewController(withIdentifier: "firstView")
        controller1.loadViewIfNeeded()
        
        let controller2 = storyboard.instantiateViewController(withIdentifier: "secondView")
        controller2.loadViewIfNeeded()
        let controller3 = storyboard.instantiateViewController(withIdentifier: "thirdView")
        controller3.loadViewIfNeeded()
        let controller4 = storyboard.instantiateViewController(withIdentifier: "AdditionaltabVC")
        controller4.loadViewIfNeeded()
        let controller5 = storyboard.instantiateViewController(withIdentifier: "HomeInspectionAgreementVc")
        controller4.loadViewIfNeeded()
        
        
        // Setting up the PagerController with Name of the Tabs and their respective ViewControllers
        self.setupPager(
            tabNames: ["Info", "Pics","Inspect","Additional Photo","Home Agreement"],
            tabControllers: [controller3, controller2, controller1 , controller4, controller5])
        
        self.customizeTab()
        
        if let controller = controller2 as? GreyViewController {
            controller.didSelectRow = { [weak self] (text: String) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let detail = storyboard.instantiateViewController(withIdentifier: "greyTableDetail") as? GreyDetailViewController {
                    detail.text = text
                    detail.loadViewIfNeeded()
                    self?.navigationController?.pushViewController(detail, animated: false)
                }
            }
        }
        
    }
    
    
    //MARK: Customising the Tab's View
    func customizeTab() {
        indicatorColor = UIColor.white
        let color1 = hexStringToUIColor(hex: "#5E5E5E")
        
        tabsViewBackgroundColor = color1
        contentViewBackgroundColor = UIColor.gray.withAlphaComponent(0.32)
        
        startFromSecondTab = false
        centerCurrentTab = true
        tabLocation =   PagerTabLocation.top
        tabHeight = 50
        tabOffset = 36
        if UIDevice.current.userInterfaceIdiom == .phone
            
        {
            tabWidth = self.view.frame.size.width/3
        }else{
            tabWidth = self.view.frame.size.width/4
        }
        
        fixFormerTabsPositions = false
        fixLaterTabsPosition = false
        animation = PagerAnimation.none
        tabsTextFont = UIFont(name: "HelveticaNeue-Bold", size: 20)!
        
        
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    //MARK :- Button Action
    
    @IBAction func homeBtn(_ sender: Any)
    {
        finalG = ""
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func saveCoreData(_ sender: Any)
        
    {
        self.SaveData()
    }
    
    //MARK:- Saveing User data
    func SaveData()
    {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        
        if address == ""
        {
            let alertController = UIAlertController(title: "Please enter client address", message: "", preferredStyle: .alert)
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
            }
            // Add the actions
            alertController.addAction(okAction)
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
        }
        else if cityStr == ""
        {
            let alertController = UIAlertController(title: "Please enter client City", message: "", preferredStyle: .alert)
            
            
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
                
            }
            // Add the actions
            alertController.addAction(okAction)
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
        }
        else if c_zipStr == ""
        {
            let alertController = UIAlertController(title: "Please enter client Zip", message: "", preferredStyle: .alert)
            
            
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
                
            }
            // Add the actions
            alertController.addAction(okAction)
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
        }
        else if emailStr != "" && !isValidEmail(testStr: emailStr)
        {
            
            let alertController = UIAlertController(title: "Please enter correct Client Email address.", message: "", preferredStyle: .alert)
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
                
            }
            // Add the actions
            alertController.addAction(okAction)
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
            
            
        }
        else if buyerEmailStr != "" && !isValidEmail(testStr: buyerEmailStr)
        {
            
            let alertController = UIAlertController(title: "Please enter correct Buyer Agent Email address.", message: "", preferredStyle: .alert)
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
                
            }
            // Add the actions
            alertController.addAction(okAction)
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
            
            
        }
        else if listingEmailStr != "" && !isValidEmail(testStr: listingEmailStr)
        {
            
            let alertController = UIAlertController(title: "Please enter correct Listing Agent Email address.", message: "", preferredStyle: .alert)
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
            
            let alertController = UIAlertController(title: "", message: "Do you want to save data?", preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
                global1 = "G"
                
                firstNameStr?.capitalizeFirstLetter()
                clientNameArray.append(firstNameStr!)
                print("clientNameArray..",clientNameArray)
                print("catNameArray123..",catNameArray)
                
                if(inspAdd == "")
                {
                    inspAdd = address
                }
                if(inspCity == "")
                {
                    inspCity = cityStr
                }
                if(inspZipStr == "")
                {
                    inspZipStr = c_zipStr
                }
                if(insp_add_str == "")
                {
                    insp_add_str = c_add2Str
                }
                if(inspState == "")
                {
                    inspState = c_StateStr
                }
                if(insp_c_str == "")
                {
                    insp_c_str = c_countryStr
                }
                if((inspectionIdStr) != nil)
                {
                    print("update data")
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
                    fetchRequest.predicate = NSPredicate(format: "inspectionId = %@", inspectionIdStr!)
                    do{
                        //self.savePhotos()
                        let res = try! context.fetch(fetchRequest)
                        let newUser = res[0] as! NSManagedObject
                        newUser.setValue(img_IdStr, forKey: "img_id")
                        newUser.setValue(firstNameStr, forKey: "firstName")
                        newUser.setValue(lastNameStr, forKey: "lastName")
                        newUser.setValue(phoneNoStr, forKey: "phoneNo")
                        newUser.setValue(address, forKey: "address")
                        newUser.setValue(cityStr, forKey: "city")
                        newUser.setValue(emailStr, forKey: "email")
                        newUser.setValue(inspectionIdStr, forKey: "inspectionId")
                        newUser.setValue(buyerfirstName, forKey: "buyerfistname")
                        newUser.setValue(buyerlastName, forKey: "buyerlastname")
                        newUser.setValue(buyerphoneNo, forKey: "buyerphoneno")
                        newUser.setValue(buyerEmailStr, forKey: "buyeremail")
                        newUser.setValue(buyerOffice, forKey: "buyeroffice")
                        newUser.setValue(listingFrstName, forKey: "listingfirstname")
                        newUser.setValue(listingLastName, forKey: "listinglastname")
                        newUser.setValue(listingPhoneNo1, forKey: "listingphoneno")
                        newUser.setValue(listingEmailStr, forKey: "listingemail")
                        newUser.setValue(listingOffice, forKey: "listingoffice")
                        newUser.setValue(c_StateStr, forKey: "c_city")
                        newUser.setValue(c_add2Str, forKey: "c_add2")
                        newUser.setValue(c_zipStr, forKey: "c_zip")
                        newUser.setValue(c_countryStr, forKey: "c_country")
                        newUser.setValue(inspAdd, forKey: "inspectionAddress")
                        newUser.setValue(inspCity, forKey: "inspectionCity")
                        newUser.setValue(inspState, forKey: "inspectionState")
                        newUser.setValue(inspZipStr, forKey: "inspectionZip")
                        newUser.setValue(insp_c_str, forKey: "insp_c")
                        newUser.setValue(insp_add_str, forKey: "inspAdd2")
                        newUser.setValue(dateOfInspStr, forKey: "dateOfInspection")
                        newUser.setValue(time, forKey: "time")
                        newUser.setValue(yearBuild, forKey: "yearBuild")
                        newUser.setValue(estimatedSqft, forKey: "estimatedSqft")
                        newUser.setValue(unitsInsp, forKey: "ofUnitsInspected")
                        newUser.setValue(addInspUnits, forKey: "ofAdditionalIns")
                        newUser.setValue(weather, forKey: "weather")
                        newUser.setValue(consType, forKey: "constructionType")
                        newUser.setValue(structure, forKey: "structure")
                        newUser.setValue(bedroom, forKey: "bedroom")
                        newUser.setValue(agentfname, forKey: "agentfname")
                        newUser.setValue(subCatIdStr, forKey: "subCatId1")
                        
                        newUser.setValue(bathroomStr, forKey: "bathroom")
                        newUser.setValue(garageStr, forKey: "garage")
                        newUser.setValue(temptureStr, forKey: "tempture")
                        newUser.setValue(noOfStoriesStr, forKey: "noofstories")
                        newUser.setValue(invoice, forKey: "invoice")
                        newUser.setValue(inspFees, forKey: "inspectonFess")
                        newUser.setValue(addInspFees, forKey: "additionalInsfees")
                        newUser.setValue(typeAddInspFees, forKey: "typeOfAdditionalInsFees")
                        newUser.setValue(paymentTypeStr, forKey: "paymentType")
                        newUser.setValue(taxInfoStr, forKey: "taxInfo")
                        newUser.setValue(inspectionTypestr, forKey: "inspectiontype")
                        newUser.setValue(ispaymentdone, forKey: "ispaymentDone")
                        
                        newUser.setValue(userId, forKey: "assignTo")
                        newUser.setValue(imgStr, forKey: "imgStr")
                        newUser.setValue(userId, forKey: "iduser")
                        newUser.setValue(global, forKey: "global")
                        
                        
                        do {
                            
                            try context.save()
                            print(try! context.save())
                            
                            if #available(iOS 11.0, *) {
                                self.changeVC()
                            } else {
                                // Fallback on earlier versions
                            }
                            
                            
                            SVProgressHUD.dismiss()
                            //
                            // Present the controller
                            self.present(alertController, animated: true, completion: nil)
                            
                        } catch {
                            
                            print("Failed saving")
                        }
                    }
                    
                    
                }
                else{
                    
                    //  }
                    AddIndex = AddIndex+1
                    inspectionIdStr = "inspect"+String(AddIndex)
                   // self.savePhotos()
                    print("nilesh jadhav",inspectionIdStr!)
                    
                    userDefault.set(AddIndex, forKey: "AddIndex")
                    self.saveInspectionCategories()
                    self.saveInspectionMainSubCategories()
                    self.saveInspectionMainCategories()
                    let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
                    let newUser = NSManagedObject(entity: entity!, insertInto: context)
                    
                    newUser.setValue(img_IdStr, forKey: "img_id")
                    newUser.setValue(firstNameStr, forKey: "firstName")
                    newUser.setValue(lastNameStr, forKey: "lastName")
                    newUser.setValue(phoneNoStr, forKey: "phoneNo")
                    newUser.setValue(address, forKey: "address")
                    newUser.setValue(cityStr, forKey: "city")
                    newUser.setValue(emailStr, forKey: "email")
                    newUser.setValue(inspectionIdStr, forKey: "inspectionId")
                    newUser.setValue(buyerfirstName, forKey: "buyerfistname")
                    newUser.setValue(buyerlastName, forKey: "buyerlastname")
                    newUser.setValue(buyerphoneNo, forKey: "buyerphoneno")
                    newUser.setValue(buyerEmailStr, forKey: "buyeremail")
                    newUser.setValue(buyerOffice, forKey: "buyeroffice")
                    newUser.setValue(listingFrstName, forKey: "listingfirstname")
                    newUser.setValue(listingLastName, forKey: "listinglastname")
                    newUser.setValue(listingPhoneNo1, forKey: "listingphoneno")
                    newUser.setValue(listingEmailStr, forKey: "listingemail")
                    newUser.setValue(listingOffice, forKey: "listingoffice")
                    newUser.setValue(c_StateStr, forKey: "c_city")
                    newUser.setValue(c_add2Str, forKey: "c_add2")
                    newUser.setValue(c_countryStr, forKey: "c_country")
                    newUser.setValue(c_zipStr, forKey: "c_zip")
                    newUser.setValue(inspAdd, forKey: "inspectionAddress")
                    newUser.setValue(inspCity, forKey: "inspectionCity")
                    newUser.setValue(inspState, forKey: "inspectionState")
                    newUser.setValue(inspZipStr, forKey: "inspectionZip")
                    newUser.setValue(insp_c_str, forKey: "insp_c")
                    newUser.setValue(insp_add_str, forKey: "inspAdd2")
                    newUser.setValue(invoice, forKey: "invoice")
                    newUser.setValue(dateOfInspStr, forKey: "dateOfInspection")
                    newUser.setValue(time, forKey: "time")
                    newUser.setValue(inspFees, forKey: "inspectonFess")
                    newUser.setValue(addInspFees, forKey: "additionalInsfees")
                    newUser.setValue(typeAddInspFees, forKey: "typeOfAdditionalInsFees")
                    newUser.setValue(yearBuild, forKey: "yearBuild")
                    newUser.setValue(estimatedSqft, forKey: "estimatedSqft")
                    newUser.setValue(unitsInsp, forKey: "ofUnitsInspected")
                    newUser.setValue(addInspUnits, forKey: "ofAdditionalIns")
                    newUser.setValue(weather, forKey: "weather")
                    newUser.setValue(consType, forKey: "constructionType")
                    newUser.setValue(structure, forKey: "structure")
                    newUser.setValue(bedroom, forKey: "bedroom")
                    newUser.setValue(inspectionTypestr, forKey: "inspectiontype")
                    newUser.setValue(agentfname, forKey: "agentfname")
                    newUser.setValue(subCatIdStr, forKey: "subCatId1")
                    
                    newUser.setValue(bathroomStr, forKey: "bathroom")
                    newUser.setValue(garageStr, forKey: "garage")
                    newUser.setValue(temptureStr, forKey: "tempture")
                    newUser.setValue(noOfStoriesStr, forKey: "noofstories")
                    newUser.setValue(paymentTypeStr, forKey: "paymentType")
                    newUser.setValue(taxInfoStr, forKey: "taxInfo")
                    newUser.setValue(ispaymentdone, forKey: "ispaymentDone")
                    
                    newUser.setValue(userId, forKey: "assignTo")
                    newUser.setValue(imgStr, forKey: "imgStr")
                    newUser.setValue(userId, forKey: "iduser")
                    newUser.setValue(global, forKey: "global")
                    
                    
                    
                    do {
                        
                        try context.save()
                        print(try! context.save())
                        SVProgressHUD.dismiss()
                        if #available(iOS 11.0, *) {
                            self.changeVC()
                        } else {
                            // Fallback on earlier versions
                        }
                        
                        //
                        
                        
                    } catch {
                        
                        print("Failed saving")
                    }
                }
            }
            let noActuin = UIAlertAction(title: "No", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
            }
            
            // Add the actions
            alertController.addAction(okAction)
            alertController.addAction(noActuin)
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
            
            
        }
    }
    
    //MARK:- Validation method
    func isValidEmail(testStr:String?) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    @available(iOS 11.0, *)
    
    func changeVC ()
    {
        let alertController = UIAlertController(title: "", message: "Data saved successfully!", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            
            UserDefaults.standard.set(false, forKey: "SaveChangesOrNot")
            
            let instance: PicsVC = PicsVC()
            instance.isimagesaveorNot = false
            //  instance.ButtonClickcount = 0
            
            instance.fetchImagefromDB()
            
            self.lbl_HeaderName?.text = inspAdd
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            
            finalG = ""
            
            
        }
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK:- Inspection Question Answer saving db
    
    func saveInspectionCategories()
    {
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Questions")
        request.returnsObjectsAsFaults = false
        do {
            let result = try! context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                let question = data.value(forKey: "question") as! String
                let ans = data.value(forKey: "answer") as! String
                let defaultans = data.value(forKey: "defultAns") as! String
                let ques_id = data.value(forKey: "ques_id") as! String
                let ansId = data.value(forKey: "ansId") as! String
                let sub_catId = data.value(forKey: "sub_catId") as! String
                let cat_id = data.value(forKey: "cat_id") as! String
                
                let entity = NSEntityDescription.entity(forEntityName: "InspectedQA", in: context)
                let Questions = NSManagedObject(entity: entity!, insertInto: context)
                
                Questions.setValue(ansId, forKey: "ansId")
                Questions.setValue(ans, forKey: "answer")
                Questions.setValue(defaultans, forKey: "defultAns")
                
                Questions.setValue(ques_id, forKey: "ques_id")
                Questions.setValue(question, forKey: "question")
                Questions.setValue(sub_catId, forKey: "sub_catId")
                Questions.setValue(cat_id, forKey: "cat_id")
                
                Questions.setValue("0",forKey: "add_to_report_summ")
//                if(cat_id == "13"){
//
//                }else{
                    Questions.setValue("Inspected", forKey: "status")
                    Questions.setValue("Satisfactory", forKey: "result")
                    Questions.setValue("No concerns observed", forKey: "comment")
               // }
                Questions.setValue(inspectionIdStr, forKey: "inspectionId")
                
                do {
                    
                    try context.save()
                    print(try! context.save())
                    print(" Inspection questions and ans save")
                    
                } catch {
                    
                    print("QA Failed saving")
                }
                
                
            }
        }
        
    }
    //MARK:- saving subcate for inspection
    func saveInspectionMainSubCategories()
    {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Subcategories")
        request.returnsObjectsAsFaults = false
        do {
            let result = try! context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                let cat_Id = data.value(forKey: "cat_Id") as! String
                let sub_catId = data.value(forKey: "sub_catId") as! String
                let sub_catname = data.value(forKey: "sub_catname") as! String
                let include_in_report = data.value(forKey: "include_in_report") as! String
                
                
                let entity = NSEntityDescription.entity(forEntityName: "InspectionSubCategoires", in: context)
                let Questions = NSManagedObject(entity: entity!, insertInto: context)
                
                Questions.setValue(cat_Id, forKey: "cat_Id")
                Questions.setValue(sub_catId, forKey: "sub_catId")
                Questions.setValue(include_in_report, forKey: "include_in_report")
                Questions.setValue(sub_catname, forKey: "sub_catname")
                Questions.setValue(inspectionIdStr, forKey: "inspectionId")
                do {
                    try context.save()
                    print(try! context.save())
                    print(" Inspection questions and ans save")
                    
                } catch {
                    
                    print("QA Failed saving")
                }
                
                
            }
        }
        
    }
    //MARK:- saving category
    func saveInspectionMainCategories()
    {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MainCategories")
        request.returnsObjectsAsFaults = false
        do {
            let result = try! context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                let cat_Id = data.value(forKey: "cat_Id") as! String
                let cat_Name = data.value(forKey: "cat_Name") as! String
                let include_in_report = data.value(forKey: "include_in_report") as! String
                
                
                let entity = NSEntityDescription.entity(forEntityName: "InspectionCategoires", in: context)
                let Questions = NSManagedObject(entity: entity!, insertInto: context)
                
                Questions.setValue(cat_Id, forKey: "cat_Id")
                Questions.setValue(cat_Name, forKey: "cat_Name")
                Questions.setValue(include_in_report, forKey: "include_in_report")
                Questions.setValue(inspectionIdStr, forKey: "inspectionId")
                do {
                    try context.save()
                    print(try! context.save())
                    print(" Inspection questions and ans save")
                    
                } catch {
                    
                    print("QA Failed saving")
                }
                
                
            }
        }
        
    }
    //MARK:- delete images
    func deleteAllRecords() {
        //getting context from your Core Data Manager Class
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Images")
        let predicate = NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
        fetchRequest.predicate = predicate
        
        let result = try? context.fetch(fetchRequest)
        let resultData = result
        
        for object in resultData! {
            context.delete(object as! NSManagedObject)
        }
        
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
    }
    //MARK:- saving photos
    func savePhotos()
    {
        
        print("myNewlyAddedImages count",myNewlyAddedImages.count)
        for img in 0 ..< myNewlyAddedImages.count
        {
            let entity = NSEntityDescription.entity(forEntityName: "Images", in: context)
            let Images = NSManagedObject(entity: entity!, insertInto: context)
            print(img)
            
            Images.setValue("", forKey: "cat_type")
            Images.setValue("", forKey: "image_category")
            Images.setValue("", forKey: "image_sub_category")
            Images.setValue(myImagesID[img], forKey: "image_id")
            Images.setValue(inspectionIdStr, forKey: "inspectionId")
            Images.setValue(imageUrlArray[img].path, forKey: "imagepath")
            Images.setValue("No", forKey: "isUploadedToServer")
            do {
                try context.save()
                print(try! context.save())
                print(" Inspection images save")
                
            } catch {
                
                print("QA Failed saving")
            }
            
        }
        
        let alertController = UIAlertController(title: "", message: "Image saved successfully!", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            
          
            
            if #available(iOS 11.0, *) {
                let instance: PicsVC = PicsVC()
                instance.isimagesaveorNot = false
                instance.fetchImagefromDB()
              //  NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            } else {
                // Fallback on earlier versions
            }
//            instance.isimagesaveorNot = false
//            instance.fetchImagefromDB()
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
         
            
        }
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    
    //MARK:- sync btn action
    @IBAction func syncBtn(_ sender: Any)
    {
        let alertController = UIAlertController(title: "", message: "Are you sure to sync?", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
            UIAlertAction in
            
            self.getCategoiresdata()
            self.getSubCategoiresdata()
            self.getInspectiondata()
            
            
        }
        let okAction2 = UIAlertAction(title: "No", style: UIAlertActionStyle.default) {
            UIAlertAction in
            
        }
        alertController.addAction(okAction)
        alertController.addAction(okAction2)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func cancleSelectedImg(_ sender: Any)
    {
        
        _selectedCells.removeAllObjects()
        print("Cancel",_selectedCells)
    }
    func getSignimages()
    {
        let fileManager = FileManager.default
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Signature")
        request.predicate = NSPredicate(format: "inspectionId == %@", NewinspectionIdStr!)
        request.returnsObjectsAsFaults = false
        do{
            let res = try context.fetch(request)
            if(res.count > 0 ){
                for Ins in 0 ..< res.count
                {
                    
                
                    let updateObject = res[Ins] as! NSManagedObject
                    let image_id = updateObject.value(forKey: "signImage_id") as? String
                    let signImageDate = updateObject.value(forKey: "signImageDate") as? String
                    let paths1 = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(image_id!)
                    if fileManager.fileExists(atPath: paths1){
                        if let image =  UIImage(contentsOfFile: paths1){
                            let data : NSData = NSData(data: UIImageJPEGRepresentation(image, 0.5)!)
                            let parameters = ["assign_agent_id":userDefault.value(forKey: "userid")as? String,
                                              "inspection_id":NewinspectionIdStr  ,
                                              "local_img_id":image_id,
                                              "inspector_id":userDefault.value(forKey: "userid")as? String,
                                              "signed_date":signImageDate]
                            uploadSignImageWithData("http://allin1inspections.com/admin/webservices/upload_agreement", params: parameters as [String : AnyObject], multipleImageData: nil, imageData: data as Data, success: { (data) in
                                print(data)
                            }, failure: { (error) in
                                print(error)
                            })
                        }
                    }
                }
            }
            else{
               
            }
            
            
        }catch{
            
        }
        
    }
    //MARK:- get images
    func getimages()
    {
        let fileManager = FileManager.default
        let sub_catId = NSPredicate(format: "isUploadedToServer == %@", "No")
        let inspectionId = NSPredicate(format: "inspectionId == %@", NewinspectionIdStr!)
        let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [sub_catId, inspectionId])
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Images")
        request.predicate = andPredicate
        request.returnsObjectsAsFaults = false
        do{
            let res = try context.fetch(request)
            if(res.count > 0 ){
                for Ins in 0 ..< res.count
                {
                    imageCount = res.count
                    
                    let updateObject = res[Ins] as! NSManagedObject
                    
                    let image_id = updateObject.value(forKey: "image_id") as? String
                    let paths1 = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(image_id!)
                    
                    if fileManager.fileExists(atPath: paths1){
                        
                        if let image =  UIImage(contentsOfFile: paths1){
                            
                            let data : NSData = NSData(data: UIImageJPEGRepresentation(image, 0.5)!)
                            uploadCDataArray.add(data);
                            let parameters = ["assign_agent_id":userDefault.value(forKey: "userid")as? String,
                                              "inspection_id":NewinspectionIdStr  ,
                                              "local_img_id":image_id,
                                              "inspector_id":userDefault.value(forKey: "userid")as? String]
                            uploadImageWithData("http://allin1inspections.com/admin/Webservices/sync_pics", params: parameters as [String : AnyObject], multipleImageData: nil, imageData: data as Data, success: { (data) in
                                print(data)
                            }, failure: { (error) in
                                print(error)
                            })
                            
                        }
                        
                    }
                }
            }
            else{
                SVProgressHUD.dismiss()
                sleep(2)
                self.getAssingPhotos()
            }
            
            
        }catch{
            
        }
        
    }
    func syncApiCall()
    {
        if ConnectionCheck.isConnectedToNetwork()
        {
            SVProgressHUD.show(withStatus: "Syncing In process...")
            SVProgressHUD.setDefaultMaskType(.clear)
            //            //sync_inspection_info
            var paymentrecive = ""
            var paymentmethod = ""
            
            if ispaymentdone == "Yes"
            {
                paymentrecive = "1"
            }
            else
            {
                paymentrecive = "0"
            }
            
            if paymentTypeStr == "Cash"
            {
                paymentmethod = "cash"
            }
            else if paymentTypeStr == "Check"
            {
                paymentmethod = "check"
            }
            else if paymentTypeStr == "Credit card /Debit card"
            {
                paymentmethod = "card"
            }
            else if paymentTypeStr == "Money order"
            {
                paymentmethod = "money order"
            }
            
            let params:Dictionary  = ["assign_agent_id":userDefault.value(forKey: "userid")as? String,
                                      "inspection_id":inspectionIdStr  ,
                                      "inspector_id":userDefault.value(forKey: "userid")as? String,
                                      "property_id":"" ,
                                      "client_first_name":firstNameStr,
                                      "client_last_name":lastNameStr,
                                      "client_phone":phoneNoStr,
                                      "client_address_1":address,
                                      "client_address_2":c_add2Str,
                                      "client_state":c_StateStr,
                                      "client_city":cityStr,
                                      "client_zip":c_zipStr,
                                      "client_country":c_countryStr,
                                      "client_email":emailStr,
                                      
                                      "buyer_agent_first_name": buyerfirstName,
                                      "buyer_agent_last_name":buyerlastName,
                                      "buyer_agent_phone":buyerphoneNo,
                                      "buyer_agent_email":buyerEmailStr,
                                      "buyer_agent_office":buyerOffice,
                                      "listing_agent_first_name":listingFrstName,
                                      "listing_agent_last_name":listingLastName,
                                      "listing_agent_phone":listingPhoneNo1,
                                      "listing_agent_email":listingEmailStr,
                                      "listing_agent_office":listingOffice,
                                      
                                      "inspection_address":inspAdd,
                                      "inspection_address_2":insp_add_str,
                                      "inspection_city":inspCity,
                                      "inspection_state":inspState,
                                      "inspection_zip":inspZipStr,
                                      "inspection_country":insp_c_str,
                                      "date_of_inspection":dateOfInspStr,
                                      "time_of_inspection":time,
                                      
                                      "inspection_type":inspectionTypestr,
                                      "type_of_additional_inspection":typeAddInspFees,
                                      
                                      "year_build":yearBuild,
                                      "estimated_sqft":estimatedSqft,
                                      "no_of_units_inspected":unitsInsp,
                                      "no_of_additional_inspection":addInspUnits,
                                      "weather":weather,
                                      "temprature":temptureStr,
                                      "no_of_stories":noOfStoriesStr,
                                      "construction_type":consType,
                                      "structure":structure,
                                      "no_of_bedrooms":bedroom,
                                      "no_of_bath":bathroomStr,
                                      "no_of_garage":garageStr,
                                      
                                      
                                      "invoice_no": invoice,
                                      "inspection_fees":inspFees,
                                      "addtional_inspection_fees":addInspFees,
                                      "payment_received":paymentrecive,
                                      "payment_method":paymentmethod,
                                      "received_amount":taxInfoStr,
                                      "inspect_data":inspect_data,
                                      "category_data":categoires_data,
                                      "subcategory_data":subCategoires_data
                
                
            ]
            print("Parameters",params)
            let sync_url = "http://allin1inspections.com/admin/Webservices/sync_inspection_info"
            
            
            
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 240
            
            manager.request(sync_url, method: .post, parameters: params as [String : AnyObject])
                .responseJSON {
                    response in
                    switch (response.result) {
                    case .success:
                        do {
                            SVProgressHUD.dismiss()
                            let dictionary = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                            
                            
                            print(dictionary)
                            let sucess = dictionary.value(forKey: "success") as! Bool
                            if(sucess)
                            {
                                NewinspectionIdStr = (dictionary.value(forKey: "inspection_id") as! String)
                                print("New inspectionIdStr",NewinspectionIdStr!)
                                
                                self.updateImageInspectionId()
                                self.updateUserInspectionId()
                                self.updateAssingImageInspectionId()
                                self.updateInspectedQAInspectionId()
                                self.updateInspectedCategoiesInspectionId()
                                self.updateInspectionSubCategoiresInspectionId()
                                self.updateInspectedSignture()
                                SVProgressHUD.show(withStatus: "Info and Inspect Information Synced Successfully !")
                                SVProgressHUD.setDefaultMaskType(.clear)
                                sleep(2)
                                
                                self.getSignimages()
                                
                                self.getimages()
                                
                                
                                
                            }
                            else
                            {
                                let message = dictionary.value(forKey: "data")as! String
                                let alertController = UIAlertController(title: "", message: message , preferredStyle: .alert)
                                
                                let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
                                    UIAlertAction in
                                    
                                }
                                alertController.addAction(okAction)
                                self.present(alertController, animated: true, completion: nil)
                                
                            }
                            
                        }catch{
                        }
                        break
                    case .failure(let error):
                       // if error._code == NSURLErrorTimedOut {
                            //HANDLE TIMEOUT HERE
                            SVProgressHUD.dismiss()
                            let alertController = UIAlertController(title: "", message: "Something went wrong." , preferredStyle: .alert)
                            
                            let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
                                UIAlertAction in
                                
                            }
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)
                        //}
                        print("\n\nAuth request failed with error:\n \(error)")
                        break
                    }
            }
        }
        else
        {
            let alertController = UIAlertController(title: "", message: "Please check your internet connection.", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func syncAssingImages()
    {
        if ConnectionCheck.isConnectedToNetwork()
        {
            SVProgressHUD.show(withStatus: "Syncing Assinged Images...")
            SVProgressHUD.setDefaultMaskType(.clear)
            let params:Dictionary  = ["assign_agent_id":userDefault.value(forKey: "userid")as? String,
                                      "inspection_id":NewinspectionIdStr  ,
                                      "inspector_id":userDefault.value(forKey: "userid")as? String,
                                      "image_data":AssingImages_data
            ]
            
            let sync_url = "http://allin1inspections.com/admin/Webservices/sync_assigned_images"
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 240
            
            manager.request(sync_url, method: .post, parameters: params as [String : AnyObject])
                .responseJSON {
                    response in
                    switch (response.result) {
                    case .success:
                        do {
                            SVProgressHUD.dismiss()
                            let dictionary = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                            
                            
                            print(dictionary)
                            let sucess = dictionary.value(forKey: "success") as! Bool
                            if(sucess)
                            {
                                print("New inspectionIdStr")
                                
                                let alertController = UIAlertController(title: "", message: "Synced Successfully !" , preferredStyle: .alert)
                                
                                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) {
                                    UIAlertAction in
                                    
                                    
                                    finalG = ""
                                    self.updateUserAssingTo()
                                    self.dismiss(animated: true, completion: nil)
                                    // self.present(dashboard, animated: false, completion: nil)
                                    
                                }
                                alertController.addAction(okAction)
                                self.present(alertController, animated: true, completion: nil)
                            }
                            else
                            {
                                let message = dictionary.value(forKey: "data")as! String
                                let alertController = UIAlertController(title: "", message: message , preferredStyle: .alert)
                                
                                let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
                                    UIAlertAction in
                                    
                                }
                                alertController.addAction(okAction)
                                self.present(alertController, animated: true, completion: nil)
                                
                            }
                            
                            
                            
                            
                        }catch{
                        }
                        break
                    case .failure(let error):
                        if error._code == NSURLErrorTimedOut {
                            //HANDLE TIMEOUT HERE
                        }
                        print("\n\nAuth request failed with error:\n \(error)")
                        break
                    }
            }
           
        }
        else
        {
            let alertController = UIAlertController(title: "", message: "Please check your internet connection.", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func getCategoiresdata()
    {
        var Resultdic : Dictionary = [String: String]()
        let resultArry = NSMutableArray();
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "InspectionCategoires")
        fetchRequest.predicate = NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
        do{
            resultArry.removeAllObjects()
            let res = try context.fetch(fetchRequest)
            for Ins in 0 ..< res.count{
                
                let updateObject = res[Ins] as! NSManagedObject
                let cat_id = updateObject.value(forKey: "cat_Id") as? String
                let cat_Name = updateObject.value(forKey: "cat_Name") as? String
                let include_in_report = updateObject.value(forKey: "include_in_report") as? String
                let inspectionId = updateObject.value(forKey: "inspectionId") as? String
                
                Resultdic["cat_id"] = cat_id
                Resultdic["cat_Name"] = cat_Name
                Resultdic["in_report"] = include_in_report
                Resultdic["inspectionId"] = inspectionId
                
                resultArry.add(Resultdic)
                
                
            }
            print(resultArry.count)
            let jsonData = try JSONSerialization.data(withJSONObject: resultArry, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            //Convert back to string. Usually only do this for debugging
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                categoires_data = JSONString
                //  print(JSONString)
            }
            
            
            
        }catch{
            print(error)
        }
    }
    func getSubCategoiresdata()
    {
        var Resultdic : Dictionary = [String: String]()
        let resultArry = NSMutableArray();
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "InspectionSubCategoires")
        fetchRequest.predicate = NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
        do{
            resultArry.removeAllObjects()
            let res = try context.fetch(fetchRequest)
            for Ins in 0 ..< res.count{
                
                let updateObject = res[Ins] as! NSManagedObject
                let sub_catId = updateObject.value(forKey: "sub_catId") as? String
                let sub_catname = updateObject.value(forKey: "sub_catname") as? String
                let include_in_report = updateObject.value(forKey: "include_in_report") as? String
                let inspectionId = updateObject.value(forKey: "inspectionId") as? String
                
                Resultdic["sub_catId"] = sub_catId
                Resultdic["sub_catname"] = sub_catname
                Resultdic["in_report"] = include_in_report
                Resultdic["inspectionId"] = inspectionId
                
                resultArry.add(Resultdic)
                
                
            }
            print(resultArry.count)
            let jsonData = try JSONSerialization.data(withJSONObject: resultArry, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            //Convert back to string. Usually only do this for debugging
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                subCategoires_data = JSONString
                //  print(JSONString)
            }
            
            
            
        }catch{
            print(error)
        }
    }
    func getInspectiondata()
    {
        var Resultdic : Dictionary = [String: String]()
        let resultArry = NSMutableArray();
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "InspectedQA")
        fetchRequest.predicate = NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
        do{
            resultArry.removeAllObjects()
            let res = try context.fetch(fetchRequest)
            for Ins in 0 ..< res.count{
                
                let updateObject = res[Ins] as! NSManagedObject
                let cat_id = updateObject.value(forKey: "cat_id") as? String
                let sub_catId = updateObject.value(forKey: "sub_catId") as? String
                let inspectionId = updateObject.value(forKey: "inspectionId") as? String
                let question = updateObject.value(forKey: "question") as? String
                let ques_id = updateObject.value(forKey: "ques_id") as? String
                let ansId = updateObject.value(forKey: "ansId") as? String
                
                let answer = updateObject.value(forKey: "answer") as? String
                let defultAns = updateObject.value(forKey: "defultAns") as? String
                let status = updateObject.value(forKey: "status") as? String
                let result = updateObject.value(forKey: "result") as? String
                let comment = updateObject.value(forKey: "comment") as? String
                let add_to_report_summ = updateObject.value(forKey: "add_to_report_summ") as? String
                Resultdic["cat_id"] = cat_id
                Resultdic["sub_catId"] = sub_catId
                Resultdic["inspectionId"] = inspectionId
                Resultdic["question"] = question
                Resultdic["ques_id"] = ques_id
                Resultdic["ansId"] = ansId
                Resultdic["answer"] = answer
                Resultdic["defultAns"] = defultAns
                Resultdic["status"] = status
                Resultdic["result"] = result
                Resultdic["comment"] = comment
                Resultdic["include_in_summary"] = add_to_report_summ
                resultArry.add(Resultdic)
                
                
            }
            print(resultArry.count)
            let jsonData = try JSONSerialization.data(withJSONObject: resultArry, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            //Convert back to string. Usually only do this for debugging
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                inspect_data = JSONString
                print(JSONString)
            }
            
            syncApiCall()
            
        }catch{
            print(error)
        }
    }
    func updateInspectedSignture()
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Signature")
        fetchRequest.predicate = NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
        do{
            
            let res = try context.fetch(fetchRequest)
            for Ins in 0 ..< res.count{
                
                let updateObject = res[Ins] as! NSManagedObject
                updateObject.setValue(NewinspectionIdStr, forKey: "inspectionId")
                
                do{
                    try context.save()
                }catch{
                    print(error)
                }
            }
            print("Signature update")
        }catch{
            print(error)
        }
        
    }
    
    func updateInspectedQAInspectionId()
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "InspectedQA")
        fetchRequest.predicate = NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
        do{
            
            let res = try context.fetch(fetchRequest)
            for Ins in 0 ..< res.count{
                
                let updateObject = res[Ins] as! NSManagedObject
                updateObject.setValue(NewinspectionIdStr, forKey: "inspectionId")
                
                do{
                    try context.save()
                }catch{
                    print(error)
                }
            }
            print("InspectedQA update")
        }catch{
            print(error)
        }
        
    }
    func updateAssingImageInspectionId()
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AssingImages")
        fetchRequest.predicate = NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
        do{
            
            let res = try context.fetch(fetchRequest)
            for Ins in 0 ..< res.count{
                
                let updateObject = res[Ins] as! NSManagedObject
                updateObject.setValue(NewinspectionIdStr, forKey: "inspectionId")
                
                do{
                    try context.save()
                }catch{
                    print(error)
                }
            }
            print("AssingImages update")
        }catch{
            print(error)
        }
        
    }
    func updateImageInspectionId()
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Images")
        fetchRequest.predicate = NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
        do{
            
            let res = try context.fetch(fetchRequest)
            for Ins in 0 ..< res.count{
                
                let updateObject = res[Ins] as! NSManagedObject
                updateObject.setValue(NewinspectionIdStr, forKey: "inspectionId")
                
                do{
                    try context.save()
                }catch{
                    print(error)
                }
            }
            print("Images inspectio Id update")
        }catch{
            print(error)
        }
        
    }
    func updateInspectedCategoiesInspectionId()
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "InspectionCategoires")
        fetchRequest.predicate = NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
        do{
            
            let res = try context.fetch(fetchRequest)
            for Ins in 0 ..< res.count{
                
                let updateObject = res[Ins] as! NSManagedObject
                updateObject.setValue(NewinspectionIdStr, forKey: "inspectionId")
                
                do{
                    try context.save()
                }catch{
                    print(error)
                }
            }
            print("Categoires update")
        }catch{
            print(error)
        }
        
    }
    func updateInspectionSubCategoiresInspectionId()
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "InspectionSubCategoires")
        fetchRequest.predicate = NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
        do{
            
            let res = try context.fetch(fetchRequest)
            for Ins in 0 ..< res.count{
                
                let updateObject = res[Ins] as! NSManagedObject
                updateObject.setValue(NewinspectionIdStr, forKey: "inspectionId")
                
                do{
                    try context.save()
                }catch{
                    print(error)
                }
            }
            print("InspectionSubCategoires update")
            
        }catch{
            print(error)
        }
        
    }
    func updateUserInspectionId()
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        fetchRequest.predicate = NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
        do{
            
            let res = try context.fetch(fetchRequest)
            for Ins in 0 ..< res.count{
                
                let updateObject = res[Ins] as! NSManagedObject
                updateObject.setValue(NewinspectionIdStr, forKey: "inspectionId")
                
                do{
                    try context.save()
                }catch{
                    print(error)
                }
            }
            print("Users update")
            
        }catch{
            print(error)
        }
        
    }
    func updateUserAssingTo()
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        fetchRequest.predicate = NSPredicate(format: "inspectionId == %@", NewinspectionIdStr!)
        do{
            
            let res = try context.fetch(fetchRequest)
            for Ins in 0 ..< res.count{
                
                let updateObject = res[Ins] as! NSManagedObject
                updateObject.setValue("0", forKey: "assignTo")
                
                do{
                    try context.save()
                }catch{
                    print(error)
                }
            }
            print("Users update")
            
        }catch{
            print(error)
        }
        
    }
    func updateisUploadedToServerInPhotos(localID:String)
    {
        let imageId = NSPredicate(format: "image_id == %@", localID)
        let inspectionId = NSPredicate(format: "inspectionId == %@", NewinspectionIdStr!)
        let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [imageId, inspectionId])
        
        //check here for the sender of the message
        let fetchRequestSender = NSFetchRequest<NSFetchRequestResult>(entityName: "Images")
        fetchRequestSender.predicate = andPredicate
        fetchRequestSender.returnsObjectsAsFaults = false
        do{
            let res = try context.fetch(fetchRequestSender)
            for Ins in 0 ..< res.count{
                
                let updateObject = res[Ins] as! NSManagedObject
                updateObject.setValue("Yes", forKey: "isUploadedToServer")
                
                do{
                    try context.save()
                }catch{
                    print(error)
                }
            }
            print("Images update")
        }catch{
            print(error)
        }
    }
    func updateImageIdInAssingPhotos(localID:String,serverID:String)
    {
        let imageId = NSPredicate(format: "image_id == %@", localID)
        let inspectionId = NSPredicate(format: "inspectionId == %@", NewinspectionIdStr!)
        let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [imageId, inspectionId])
        
        //check here for the sender of the message
        let fetchRequestSender = NSFetchRequest<NSFetchRequestResult>(entityName: "AssingImages")
        fetchRequestSender.predicate = andPredicate
        fetchRequestSender.returnsObjectsAsFaults = false
        do{
            let res = try context.fetch(fetchRequestSender)
            for Ins in 0 ..< res.count{
                
                let updateObject = res[Ins] as! NSManagedObject
                updateObject.setValue(serverID, forKey: "server_image_Id")
                
                do{
                    try context.save()
                }catch{
                    print(error)
                }
            }
            print("Images update")
        }catch{
            print(error)
        }
        
    }
    
    func getAssingPhotos()
    {
        var Resultdic : Dictionary = [String: String]()
        let resultArry = NSMutableArray();
        
        let imageId = NSPredicate(format: "server_image_Id != %@","server")
        let inspectionId = NSPredicate(format: "inspectionId == %@", NewinspectionIdStr!)
        let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [imageId, inspectionId])
        
        //check here for the sender of the message
        let fetchRequestSender = NSFetchRequest<NSFetchRequestResult>(entityName: "AssingImages")
        fetchRequestSender.predicate = andPredicate
        fetchRequestSender.returnsObjectsAsFaults = false
        do{
            let res = try context.fetch(fetchRequestSender)
            for Ins in 0 ..< res.count{
                
                let updateObject = res[Ins] as! NSManagedObject
                
                
                
                
                let cat_type = updateObject.value(forKey: "cat_type") as? String
                let image_category_id = updateObject.value(forKey: "image_category_id") as? String
                let image_sub_category_id = updateObject.value(forKey: "image_sub_category_id") as? String
                let inspectionId = updateObject.value(forKey: "inspectionId") as? String
                let server_image_Id = updateObject.value(forKey: "server_image_Id") as? String
                
                
                
                
                Resultdic["image_id"] = server_image_Id
                Resultdic["inspectionId"] = inspectionId
                Resultdic["cat_type"] = cat_type
                Resultdic["image_category"] = image_category_id
                Resultdic["image_sub_category"] = image_sub_category_id
                resultArry.add(Resultdic)
            }
            print(resultArry.count)
            let jsonData = try JSONSerialization.data(withJSONObject: resultArry, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            //Convert back to string. Usually only do this for debugging
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                AssingImages_data = JSONString
                print("AssingImages_data",AssingImages_data)
            }
            print("Images update")
            self.syncAssingImages()
        }catch{
            print(error)
        }
        
    }
    
    //MARK:-uploading pics method
    public func uploadImageWithData(_ strUrl:String,params:[String:AnyObject]?,multipleImageData:[Data]?,imageData: Data?, success:@escaping (String) -> Void, failure:@escaping (Error) -> Void){
        if ConnectionCheck.isConnectedToNetwork() {
            SVProgressHUD.show(withStatus: "Uploading photos")
            SVProgressHUD.setDefaultMaskType(.clear)
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                
              
                if multipleImageData != nil{
                    var count = 1
                    for img in multipleImageData!{
                        
                        multipartFormData.append(img,withName: "inpsctn_img", fileName: "image.jpg", mimeType: "image/jpg")
                        count += 1
                    }
                }else if imageData != nil{
                    print("uploade")
                    
                    multipartFormData.append(imageData!,withName: "inpsctn_img", fileName: "image.png", mimeType: "image/png")
                }else{
                    print("success")
                }
                for(key,value) in params!{
                    multipartFormData.append(value.data(using:String.Encoding.utf8.rawValue)!, withName: key)
                }
            }, usingThreshold: UInt64.init(), to: strUrl, method: .post, headers:nil) { (result) in
                switch result{
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (progress) in
                        print("uploding: \(progress.fractionCompleted)")
                    })
                    upload.responseJSON { response in
                        if response.result.isSuccess {
                            SVProgressHUD.dismiss()
                            // let resJson = JSON(response.result.value!)
                            let dict :NSDictionary = response.result.value! as! NSDictionary
                            let sucess = dict.value(forKey: "success") as! Bool
                            //SVProgressHUD.dismiss()
                            if(sucess)
                            {
                                print("DATA UPLOAD SUCCESSFULLY",dict)
                                uploadedimageCount = uploadedimageCount + 1
                                SVProgressHUD.show(withStatus: "Uploading Images" + String(uploadedimageCount) + "/" + String(imageCount))
                                SVProgressHUD.setDefaultMaskType(.clear)
                                let serverId = dict.value(forKey: "image_id") as! String
                                let LocalId = dict.value(forKey: "local_img_id") as! String
                                self.updateImageIdInAssingPhotos(localID: LocalId, serverID: serverId)
                                self.updateisUploadedToServerInPhotos(localID: LocalId)
                                
                                if(uploadedimageCount == imageCount)
                                {
                                    SVProgressHUD.dismiss()
                                    sleep(2)
                                    self.getAssingPhotos()
                                }
                                
                            }else{
                                print("Not UPLOAD SUCCESSFULLY",dict)
                            }
                            success("resJson")
                        }
                    }
                case .failure(let error):
                    
                    print("Error in upload: \(error.localizedDescription)")
                    failure(error)
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        let alert = UIAlertController(title: "", message: "Server Failed", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                        alert.addAction(action)
                        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }else{
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                let alert = UIAlertController(title: "", message: "Please,check your internet connection", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(action)
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                
            }
            
        }
        
    }
    
    
    
    
    public func uploadSignImageWithData(_ strUrl:String,params:[String:AnyObject]?,multipleImageData:[Data]?,imageData: Data?, success:@escaping (String) -> Void, failure:@escaping (Error) -> Void){
        if ConnectionCheck.isConnectedToNetwork() {

            Alamofire.upload(multipartFormData: { (multipartFormData) in
                
                
                if multipleImageData != nil{
                   // var count = 1
                    for img in multipleImageData!{
                        
                        multipartFormData.append(img,withName: "signature_img", fileName: "image.jpg", mimeType: "image/jpg")
                       // count += 1
                    }
                }else if imageData != nil{
                    print("uploade sign")
                    
                    multipartFormData.append(imageData!,withName: "signature_img", fileName: "image.png", mimeType: "image/png")
                }else{
                    print("success")
                }
                for(key,value) in params!{
                    multipartFormData.append(value.data(using:String.Encoding.utf8.rawValue)!, withName: key)
                }
            }, usingThreshold: UInt64.init(), to: strUrl, method: .post, headers:nil) { (result) in
                switch result{
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (progress) in
                        print("uploding sign image: \(progress.fractionCompleted)")
                    })
                    upload.responseJSON { response in
                        if response.result.isSuccess {
                            SVProgressHUD.dismiss()
                            // let resJson = JSON(response.result.value!)
                            let dict :NSDictionary = response.result.value! as! NSDictionary
                            let sucess = dict.value(forKey: "success") as! Bool
                            //SVProgressHUD.dismiss()
                            if(sucess)
                            {
                                print("Sign Image UPLOAD SUCCESSFULLY",dict)
                                
                            }else{
                                print("Sign Image Not UPLOAD SUCCESSFULLY",dict)
                            }
                            success("resJson")
                        }
                    }
                case .failure(let error):
                    
                    print("Error in upload: \(error.localizedDescription)")
                    failure(error)
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        let alert = UIAlertController(title: "", message: "Server Failed", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                        alert.addAction(action)
                        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }else{
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                let alert = UIAlertController(title: "", message: "Please,check your internet connection", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(action)
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                
            }
            
        }
        
    }
    
}
