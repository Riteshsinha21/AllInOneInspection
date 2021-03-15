//
//  Dashboard.swift
//  AllInOne
//
//  Created by mac08 on 29/10/18.
//  Copyright © 2018 mac08. All rights reserved.
//

import UIKit
import MaterialComponents
import XLPagerTabStrip
import Alamofire
import CoreData
import SVProgressHUD

@available(iOS 10.0, *)
@available(iOS 10.0, *)
class Dashboard: UIViewController,UITableViewDataSource,UITableViewDelegate,IndicatorInfoProvider,UITextFieldDelegate,UISearchBarDelegate {
    //All Variables...
    let fileManager = FileManager.default
    var menuNameArray = ["Update Profile", "Change Password","Logout"]
    var menuImgArray = [UIImage (named: "home"),UIImage (named: "password"),UIImage (named: "logout")]
    var filterdata:[String]!
    var filterdataForPropertyName:[String]!
    var filterdataForAgentName:[String]!
    var sortedFirstLetters: [String] = []
    var dateObject: Date?
    var data=[Dictionary<String,AnyObject>]()
    var success1 : NSNumber?
    var dt11 : Dictionary<String,AnyObject>?
    var subCat1 = Dictionary<String,AnyObject>()
    var subCatArray = [String]()
    var subCatID = [String]()
    var subCatArray3 = [Dictionary<String,AnyObject>?]()
    var subCat3=[Dictionary<String,AnyObject>]()
    var subCatArray2: [[String]] = []
    var client_name = [String]()
    var property_name = [String]()
    var categorylist=[Category]()
    var subCatId : String? = ""
    var subCatName : String? = ""
    var subCatInclude : String? = ""
    var qusName : String? = ""
    var ansName : String = ""
    var yes : String=""
    var qus=[Dictionary<String,AnyObject>]()
    var ans=[String:String]()
    var qus2 = Dictionary<String,AnyObject>()
    var ans2 = Dictionary<String,AnyObject>()
    var showSection = [Section]()
    var sortedSection = [Section]()
    var sortFlag = false
    var item_details = [Item_details]()
    var selectIndexPath :IndexPath!
    var searchActive : Bool = false
    //  var client_name = [""]
    var client_fname = [String]()
    var client_lname = [String]()
    var client_address = [String]()
    var ins_IdArray = [String]()
    var agent_name = [String]()
    var phone_no = [String]()
    var added_date = [String]()
    var client_city = [String]()
    var client_country = [String]()
    var client_email = [String]()
    var client_addressa2 = [String]()
    var client_zip2 = [String]()
    var client_citya2 = [String]()
    var client_country2 = [String]()
    
    //Realotor info
    var buyer_agent_fname = [String]()
    var buyer_agent_lname = [String]()
    var buyer_agent_phoneNo = [String]()
    var buyer_agent_email = [String]()
    var buyer_agent_office = [String]()
    var listing_agent_fname = [String]()
    var listing_agent_lname = [String]()
    var listing_agent_phoneNo = [String]()
    var listing_agent_email = [String]()
    var listing_agent_office = [String]()
    
    //Realotor info
    var insp_add = [String]()
    var insp_city = [String]()
    var insp_state = [String]()
    var insp_zip = [String]()
    
    var insp_country_array = [String]()
    var insp_address_array = [String]()
    var assingTo = [String]()
    var invoice1 = [String]()
    var date_of_insp = [String]()
    var time1 = [String]()
    var insp_fees = [String]()
    var add_insp_fees = [String]()
    var type_add_insp_fees = [String]()
    var year_build = [String]()
    var estmated_sqft = [String]()
    var unit_insp = [String]()
    var add_insp = [String]()
    var weather1 = [String]()
    var cons_type = [String]()
    var structure1 = [String]()
    var bedroom1 = [String]()
    var bathroom1 = [String]()
    var garage1 = [String]()
    var temptureArray = [String]()
    var inspectiontype = [String]()
    var inspectionIDs  = [String]()
    var paymentType1 = [String]()
    var IspaymentDone1 = [String]()
    var taxInfo1 = [String]()
    
    var noOfStoriesArray = [String]()
    
    var inspCountry2 = [String]()
    var imageDataArray = [NSData]()
    
    
    //Agent info
    var agent_fname = [String]()
    var agent_lname = [String]()
    var agent_phoneNo = [String]()
    var agent_email = [String]()
    var agent_image = [String]()
    
    var request: Alamofire.Request? {
        didSet {
            
        }
    }
    var myUsers = [String]()
    
    //Outlets...
    @IBOutlet weak var txtSearchBar: MDCTextField!
    @IBOutlet weak var ubeView: UIView!
    @IBOutlet weak var tableViewFirst: UITableView!
    @IBOutlet weak var widthView: NSLayoutConstraint!
    @IBOutlet weak var leadingC: NSLayoutConstraint!
    @IBOutlet weak var btn2Out: UIButton!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var searchView: UISearchBar!
    @IBOutlet weak var nodataFoundLbl: UILabel!
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "DashboardCell"
    var searchBarTextFieldController: MDCTextInputControllerUnderline!
    var hamburgerMenuIsVisible = false
    
    var candies = [Candy]()
    var filteredCandies = [Candy]()
    let searchController = UISearchController(searchResultsController: nil)
    var insp_adda2 = [String]()
    
    @IBOutlet weak var tblVwListing: UITableView!
    
    //MARK:- LOAD Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actInd.center = self.view.center
        actInd.hidesWhenStopped = true
        
        self.searchView.delegate = self
        self.searchView.barTintColor = UIColor.white
        self.searchView.searchBarStyle = .minimal;
        self.view1.layer.cornerRadius=5
        self.view1.layer.shadowColor = UIColor.black.cgColor
        self.view1.layer.shadowOpacity = 0.7
        self.view1.layer.shadowOffset = CGSize.zero
        self.view1.layer.shadowRadius = 4
        self.view1.clipsToBounds = false
        self.view1.layer.masksToBounds = false;
        self.view1.isHidden = true
        
        tableViewFirst.delegate = self
        tableViewFirst.dataSource = self
        tblVwListing.delegate = self
        tblVwListing.dataSource = self
        txtSearchBar.delegate = self
        btn2Out.isHidden = true
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
        self.view1.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchdatabaseValues()
        prpertyListAPI()
        filterdata = self.client_fname
    }
    //MARK:- Search delegate method...
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if(searchBar.text!.isEmpty)
        {
            //fetch All Data From Db
            fetchdatabaseValues()
        }else
        {
            //fetch from db only name
            removeAllArrayData()
            methodSearchByKey(searchStr: searchBar.text!)
        }
        searchBar.resignFirstResponder()
    }
    
    //MARK:- Tableview delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == tableViewFirst
        {
            print("menuImgArray.count",menuImgArray.count)
            return menuImgArray.count
        }
        else
        {
            return client_fname.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tableViewFirst
        {
            tableViewFirst.separatorStyle = .none
            let cell:TableViewCellMenu = (tableViewFirst.dequeueReusableCell(withIdentifier: "cell") as! TableViewCellMenu)
            cell.selectionStyle = .none
            cell.nameLbl.text = self.menuNameArray[indexPath.row]
            cell.imgView.image = self.menuImgArray[indexPath.row]
            
            return cell
        }
        else
        {
            let cell:DashboardCell = (tblVwListing.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! DashboardCell)
            cell.bgView.layer.borderWidth=1;
            cell.bgView.layer.cornerRadius=5;
            cell.bgView.layer.borderColor=UIColor.darkGray.cgColor;
            if filterdata.count != 0
            {
                cell.clientName.text = (self.filterdata[indexPath.row] )
            }
            cell.clientName.text = (self.client_fname[indexPath.row] )
            cell.clientLastName.text = (self.client_lname[indexPath.row] )
            let address = (self.insp_add[indexPath.row] ) + " " + (self.insp_address_array[indexPath.row] ) + " " + (self.insp_city[indexPath.row] ) + " " + (self.insp_state[indexPath.row] ) + " " +  (self.insp_zip[indexPath.row] + " " + self.insp_country_array[indexPath.row] )
            
            cell.propertyName.text = address
            cell.lbl_InvoiceNo.text = (self.invoice1[indexPath.row] )
            cell.lbl_typesOfInspection.text = (self.inspectiontype[indexPath.row] )
            let defaults = UserDefaults.standard
            agentfname = defaults.string(forKey: "first_name")!
            print("agentfname..",agentfname!)
            cell.agentNameLbl.text = agentfname
            cell.dateLbl.text = (self.date_of_insp[indexPath.row])
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "MM/dd/yyyy HH:mm:ss"
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "MM/dd/yyyy"
            
            if let date = dateFormatterGet.date(from: (self.date_of_insp[indexPath.row] )) {
                print(dateFormatterPrint.string(from: date))
                cell.dateLbl.text = dateFormatterPrint.string(from: date)
            } else {
                print("There was an error decoding the string")
            }
            assingToStr = (self.assingTo[indexPath.row])
            if(assingToStr == "0"){
                cell.lbl_syncOrNot.isHidden = false
            }else
            {
                cell.lbl_syncOrNot.isHidden = true
            }
            return cell
        }
        
    }
    //Tablevie Delegate Method...
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        global = "clear"
        if tableView == tableViewFirst {
            if indexPath.row == 0
            {
                let updateProfile = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UpdateViewController")as! UpdateViewController
                self.present(updateProfile, animated: false, completion: nil)
                hideMenuView()
            }
            else  if indexPath.row == 1
            {
                let changePassVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangePasswordVC")as! ChangePasswordVC
                self.present(changePassVc, animated: false, completion: nil)
                hideMenuView()
            }
            else  if indexPath.row == 2
            {
                
                let alertController = UIAlertController(title: "", message: "Do you want to Exit?", preferredStyle: .alert)
                
                // Create the actions
                let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    userDefault.removeObject(forKey:"email")
                    userDefault.removeObject(forKey:"password")
                    userDefault.removeObject(forKey:"isLogin")
                    userDefault.removeObject(forKey:"synced_time")
                    
                    let loginVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")as! LoginVC
                    self.present(loginVc, animated: false, completion: nil)
                    
                    self.hideMenuView()
                }
                
                let okAction2 = UIAlertAction(title: "No", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    self.hideMenuView()
                }
                alertController.addAction(okAction)
                alertController.addAction(okAction2)
                self.present(alertController, animated: true, completion: nil)
            }
            
        }
        else if tableView == tblVwListing
        {
            
            SVProgressHUD.show(withStatus: "Please wait..")
            SVProgressHUD.setDefaultMaskType(.clear)
            
            if filterdata.count != 0
            {
                firstNameStr = (self.filterdata[indexPath.row])
            }
            
            firstNameStr = (self.client_fname[indexPath.row])
            lastNameStr = (self.client_lname[indexPath.row])
            address = (self.client_address[indexPath.row])
            phoneNoStr = (self.phone_no[indexPath.row])
            cityStr = (self.client_city[indexPath.row])
            
            if client_citya2.count > 0{
                c_StateStr = (self.client_citya2[indexPath.row])
            }
            emailStr = (self.client_email[indexPath.row])
            if client_addressa2.count > 0{
                c_add2Str = (self.client_addressa2[indexPath.row])
            }
            if client_zip2.count > 0{
                c_zipStr = (self.client_zip2[indexPath.row])
            }
            
            if client_country2.count > 0{
                c_countryStr = (self.client_country2[indexPath.row])
            }
            
            
            //Realotors Info...
            buyerfirstName = (self.buyer_agent_fname[indexPath.row])
            buyerlastName = (self.buyer_agent_lname[indexPath.row])
            buyerphoneNo = (self.buyer_agent_phoneNo[indexPath.row])
            buyerEmailStr = (self.buyer_agent_email[indexPath.row])
            buyerOffice = (self.buyer_agent_office[indexPath.row])
            // agentfname = (self.agent_fname[indexPath.row])
            listingLastName = (self.listing_agent_lname[indexPath.row])
            listingFrstName = (self.listing_agent_fname[indexPath.row])
            listingPhoneNo1 = (self.listing_agent_phoneNo[indexPath.row])
            listingEmailStr = (self.listing_agent_email[indexPath.row])
            listingOffice = (self.listing_agent_office[indexPath.row])
            
            //Inspection info..
            inspAdd = (self.insp_add[indexPath.row])
            inspCity = (self.insp_city[indexPath.row])
            buyerphoneNo = (self.buyer_agent_phoneNo[indexPath.row])
            inspState = (self.insp_state[indexPath.row])
            inspZipStr = (self.insp_zip[indexPath.row])
            
            insp_c_str = (self.insp_country_array[indexPath.row])
            insp_add_str = (self.insp_address_array[indexPath.row])
            
            
            
            invoice = (self.invoice1[indexPath.row])
            dateOfInspStr = (self.date_of_insp[indexPath.row])
            inspectionIdStr = (self.ins_IdArray[indexPath.row])
            time = (self.time1[indexPath.row])
            inspFees = (self.insp_fees[indexPath.row])
            addInspFees = (self.add_insp_fees[indexPath.row])
            
            inspectionTypestr = (self.inspectiontype[indexPath.row])
            typeAddInspFees = (self.type_add_insp_fees[indexPath.row])
            yearBuild = (self.year_build[indexPath.row])
            estimatedSqft = (self.estmated_sqft[indexPath.row])
            unitsInsp = (self.unit_insp[indexPath.row])
            addInspUnits = (self.add_insp[indexPath.row])
            weather = (self.weather1[indexPath.row])
            consType = (self.cons_type[indexPath.row])
            structure = (self.structure1[indexPath.row])
            bedroom = (self.bedroom1[indexPath.row])
            
            bathroomStr = (self.bathroom1[indexPath.row])
            garageStr = (self.garage1[indexPath.row])
            temptureStr = (self.temptureArray[indexPath.row])
            
            noOfStoriesStr = (self.noOfStoriesArray[indexPath.row])
            
            paymentTypeStr = (self.paymentType1[indexPath.row])
            taxInfoStr = (self.taxInfo1[indexPath.row])
            inspectionIdStr = (self.ins_IdArray[indexPath.row])
            ispaymentdone = (self.IspaymentDone1[indexPath.row])
            let assingToStr = (self.assingTo[indexPath.row])
            if(assingToStr == "0")
            {
                SVProgressHUD.dismiss()
                let alert = UIAlertController(title: "", message: "This property does not belongs to you ! You cannot edit this property.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            }
            else
            {
                let dashboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InspectionsVC")as! InspectionsVC
                dashboard.fromWhere = "editmode"
                self.present(dashboard, animated: false, completion: nil)
            }
            
        }
        else
        {
            
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            let alertController = UIAlertController(title: "", message: "Are you sure want to delete this property?", preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) {
                UIAlertAction in
                let  inspection_id = (self.ins_IdArray[indexPath.row])
                print("deleted inspection Id :->",inspection_id)
                self.deleteRecored(entityName: "Users", inspectionID: inspection_id)
                self.fetchandRemoveImagefromDB(inspectionID: inspection_id)
                
                self.deleteRecored(entityName: "Images", inspectionID: inspection_id)
                self.deleteRecored(entityName: "AssingImages", inspectionID: inspection_id)
                self.deleteRecored(entityName: "InspectedQA", inspectionID: inspection_id)
                self.deleteRecored(entityName: "InspectionCategoires", inspectionID: inspection_id)
                self.deleteRecored(entityName: "InspectionSubCategoires", inspectionID: inspection_id)
                
                DispatchQueue.main.async {
                    self.fetchdatabaseValues()
                }
            }
            let NOAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) {
                UIAlertAction in
            }
            // Add the actions
            
            alertController.addAction(NOAction)
            alertController.addAction(okAction)
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
            
            
        }
    }
    func fetchandRemoveImagefromDB(inspectionID : String)
    {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Images")
        request.predicate =  NSPredicate(format: "inspectionId == %@", inspectionID)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                if let imageurl = (data.value(forKey: "imagepath") as? String) {
                    
                    let paths1 = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent((data.value(forKey: "image_id") as! String))
                    if(fileManager .fileExists(atPath: paths1)){
                        
                        try fileManager.removeItem(atPath: paths1)
                        print("remove Image sucessfully",imageurl)
                    }else{
                        
                    }
                }
            }
            
        }
        catch {
            
            print("Failed")
        }
    }
    func hideMenuView()  {
        
        btn2Out.isHidden = true
        
        widthView.constant = 0
        
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("The animation is complete!")
        }
    }
    // method to run when table view cell is tapped
    
    //MARK:- pageview delegate method
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "child3")
    }
    
    func saveimageinDic(numm:String, image:UIImage){
        imageUrlArray.removeAll()
        myImagespath.removeAll()
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
        imageUrlArray.append(imgurl)
        myImagespath.append(imgurl)
    }
    
    func deleteRecored(entityName: String,inspectionID : String)
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let predicate = NSPredicate(format: "inspectionId == %@", inspectionID)
        fetchRequest.predicate = predicate
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
            print("deleted record from \(entityName)!")
            // Save Changes
            try context.save()
            
            
        } catch {
            // Error Handling
        }
        
        //        let result = try? context.fetch(fetchRequest)
        //        let resultData = result
        //
        //        for object in resultData! {
        //            context.delete(object as! NSManagedObject)
        //        }
        //        do {
        //            try context.save()
        //            print("deleted record from \(entityName)!")
        //        } catch let error as NSError  {
        //            print("Could not save \(error), \(error.userInfo)")
        //        }
        
    }
    func deleteSubCategoies(inspectionID : String)
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "InspectionSubCategoires")
        let predicate = NSPredicate(format: "inspectionId == %@", inspectionID)
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
    
    //MARK:- API Call..
    func prpertyListAPI()
    {
        
        if ConnectionCheck.isConnectedToNetwork()
        {
            var synced_time = UserDefaults.standard.value(forKey: "synced_time") as? String
            if (synced_time == nil){
                synced_time = " "
            }
            SVProgressHUD.show(withStatus: "Please wait..")
            SVProgressHUD.setDefaultMaskType(.clear)
            let inspection_ids = self.ins_IdArray.joined(separator: ", ")
            print("inspection_ids",inspection_ids)
            let params:Dictionary  = ["inspector_id":userDefault.value(forKey: "userid")as? String,
                                      "existing_inspection_ids":inspection_ids,
                                      "synced_time":synced_time]
            print(params)
            let manager = Alamofire.SessionManager.default
            // manager.session.configuration.timeoutIntervalForRequest = 300
            manager.request(url, method: .post, parameters: params as [String : AnyObject])
                .responseJSON {
                    response in
                    switch (response.result) {
                    case .success:
                        do {
                            SVProgressHUD.dismiss()
                            let dictionary = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                            print(dictionary)
                            let synced_time = dictionary["synced_time"] as? String
                            userDefault.set(synced_time, forKey: "synced_time")
                            let data1 = dictionary["data"] as? NSArray
                            if((data1) != nil)
                            {
                                for i in 0 ..< data1!.count
                                {
                                    let innerarray = (data1![i] as AnyObject).value(forKey: "info") as! NSDictionary
                                    print(innerarray["inspection_id"] as! String)
                                    let inspection_id = innerarray["inspection_id"] as! String
                                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
                                    fetchRequest.predicate = NSPredicate(format: "inspectionId = %@", innerarray["inspection_id"] as! String)
                                    let res = try! context.fetch(fetchRequest)
                                    userDefault.set(false, forKey: "firstTimeForProperty")
                                    if(res.count>0)
                                    {
                                        //update recordƒ
                                        for Ins in 0 ..< res.count{
                                            
                                            let updateObject = res[Ins] as! NSManagedObject
                                            updateObject.setValue(NewinspectionIdStr, forKey: "inspectionId")
                                            
                                            updateObject.setValue(innerarray["client_first_name"] as! String, forKey: "firstName")
                                            updateObject.setValue(innerarray["client_last_name"] as! String, forKey: "lastName")
                                            updateObject.setValue(innerarray["client_phone"] as! String, forKey: "phoneNo")
                                            updateObject.setValue(innerarray["client_address_1"] as! String, forKey: "address")
                                            updateObject.setValue(innerarray["client_city"] as! String, forKey: "city")
                                            updateObject.setValue(innerarray["client_email"] as! String, forKey: "email")
                                            updateObject.setValue(innerarray["client_zip"] as! String, forKey: "c_zip")
                                            updateObject.setValue(innerarray["client_country"] as! String, forKey: "c_country")
                                            updateObject.setValue(innerarray["client_address_2"] as! String, forKey: "c_add2")
                                            updateObject.setValue(innerarray["client_state"] as! String, forKey: "c_city")
                                            
                                            updateObject.setValue(innerarray["buyer_agent_first_name"] as! String, forKey: "buyerfistname")
                                            updateObject.setValue(innerarray["buyer_agent_last_name"] as! String, forKey: "buyerlastname")
                                            updateObject.setValue(innerarray["buyer_agent_phone"] as! String, forKey: "buyerphoneno")
                                            updateObject.setValue(innerarray["buyer_agent_email"] as! String, forKey: "buyeremail")
                                            updateObject.setValue(innerarray["buyer_agent_office"] as! String, forKey: "buyeroffice")
                                            updateObject.setValue(innerarray["listing_agent_first_name"] as! String, forKey: "listingfirstname")
                                            updateObject.setValue(innerarray["listing_agent_last_name"] as! String, forKey: "listinglastname")
                                            updateObject.setValue(innerarray["listing_agent_phone"] as! String, forKey: "listingphoneno")
                                            updateObject.setValue(innerarray["listing_agent_email"] as! String, forKey: "listingemail")
                                            updateObject.setValue(innerarray["listing_agent_office"] as! String, forKey: "listingoffice")
                                            
                                            updateObject.setValue(innerarray["assign_to"] as! String, forKey: "assignTo")
                                            updateObject.setValue(userDefault.value(forKey: "userid")as! String, forKey: "iduser")
                                            updateObject.setValue(innerarray["inspection_id"] as! String, forKey: "inspectionId")
                                            updateObject.setValue(innerarray["inspection_id"] as! String, forKey: "serverInspection_id")
                                            //  inspection info
                                            
                                            updateObject.setValue(innerarray["inspection_address"] as! String, forKey: "inspectionAddress")
                                            updateObject.setValue(innerarray["inspection_city"] as! String, forKey: "inspectionCity")
                                            updateObject.setValue(innerarray["inspection_state"] as! String, forKey: "inspectionState")
                                            updateObject.setValue(innerarray["inspection_zip"] as! String, forKey: "inspectionZip")
                                            updateObject.setValue(innerarray["invoice_no"] as! String, forKey: "invoice")
                                            updateObject.setValue(innerarray["date_of_inspection"] as! String, forKey: "dateOfInspection")
                                            updateObject.setValue(innerarray["time_of_inspection"] as! String, forKey: "time")
                                            updateObject.setValue(innerarray["inspection_fees"] as! String, forKey: "inspectonFess")
                                            updateObject.setValue(innerarray["addtional_inspection_fees"] as! String, forKey: "additionalInsfees")
                                            updateObject.setValue(innerarray["type_of_additional_inspection"] as! String, forKey: "typeOfAdditionalInsFees")
                                            updateObject.setValue(innerarray["year_build"] as! String, forKey: "yearBuild")
                                            updateObject.setValue(innerarray["estimated_sqft"] as! String, forKey: "estimatedSqft")
                                            updateObject.setValue(innerarray["no_of_units_inspected"] as! String, forKey: "ofUnitsInspected")
                                            updateObject.setValue(innerarray["no_of_additional_inspection"] as! String, forKey: "ofAdditionalIns")
                                            // ispaymentDone
                                            updateObject.setValue(innerarray["inspection_type"] as! String, forKey: "inspectiontype")
                                            updateObject.setValue(innerarray["weather"] as! String, forKey: "weather")
                                            updateObject.setValue(innerarray["construction_type"] as! String, forKey: "constructionType")
                                            updateObject.setValue(innerarray["structure"] as! String, forKey: "structure")
                                            updateObject.setValue(innerarray["no_of_bedrooms"] as! String, forKey: "bedroom")
                                            updateObject.setValue(innerarray["no_of_bath"] as! String, forKey: "bathroom")
                                            updateObject.setValue(innerarray["no_of_garage"] as! String, forKey: "garage")
                                            updateObject.setValue(innerarray["temprature"] as! String, forKey: "tempture")
                                            updateObject.setValue(innerarray["no_of_stories"] as! String, forKey: "noofstories")
                                            
                                            updateObject.setValue(innerarray["assign_to"] as! String, forKey: "assignTo")
                                            updateObject.setValue(innerarray["payment_method"] as! String, forKey: "paymentType")
                                            
                                            let paymentrecive = innerarray["payment_received"] as! String
                                            var ispayemntdone = ""
                                            if(paymentrecive == "0")
                                            {
                                                ispayemntdone = "No"
                                            }
                                            else{
                                                ispayemntdone = "Yes"
                                            }
                                            updateObject.setValue(ispayemntdone, forKey: "ispaymentDone")
                                            updateObject.setValue(innerarray["received_amount"] as! String, forKey: "taxInfo")
                                            updateObject.setValue(innerarray["inspection_country"] as! String, forKey: "insp_c")
                                            updateObject.setValue(innerarray["inspection_address_2"] as! String, forKey: "inspAdd2")
                                            
                                            let categoryarray = (data1![i] as AnyObject).value(forKey: "category") as! NSArray
                                            self.deleteRecored(entityName: "InspectionCategoires", inspectionID: inspection_id)
                                            for ai in 0 ..< categoryarray.count
                                            {
                                                let entity = NSEntityDescription.entity(forEntityName: "InspectionCategoires", in: context)
                                                let InspectionCategoires = NSManagedObject(entity: entity!, insertInto: context)
                                                InspectionCategoires.setValue( (categoryarray[ai]as AnyObject)["cat_id"] as! String, forKey: "cat_Id")
                                                InspectionCategoires.setValue((categoryarray[ai]as AnyObject)["cat_name"] as! String, forKey: "cat_Name")
                                                InspectionCategoires.setValue((categoryarray[ai]as AnyObject)["in_report"] as! String, forKey: "include_in_report")
                                                InspectionCategoires.setValue(inspection_id, forKey: "inspectionId")
                                                do {
                                                    try context.save()
                                                    print(try! context.save())
                                                    print(" Inspection questions and ans save")
                                                    
                                                } catch {
                                                    
                                                    print("QA Failed saving")
                                                }
                                            }
                                            let subcategoryarray = (data1![i] as AnyObject).value(forKey: "subcategory") as! NSArray
                                            self.deleteRecored(entityName: "InspectionSubCategoires", inspectionID: inspection_id)
                                            for ai in 0 ..< subcategoryarray.count
                                            {
                                                let entity = NSEntityDescription.entity(forEntityName: "InspectionSubCategoires", in: context)
                                                let subInspectionCategoires = NSManagedObject(entity: entity!, insertInto: context)
                                                subInspectionCategoires.setValue( (subcategoryarray[ai]as AnyObject)["cat_id"] as! String, forKey: "cat_Id")
                                                subInspectionCategoires.setValue((subcategoryarray[ai]as AnyObject)["scat_id"] as! String, forKey: "sub_catId")
                                                subInspectionCategoires.setValue((subcategoryarray[ai]as AnyObject)["in_report"] as! String, forKey: "include_in_report")
                                                subInspectionCategoires.setValue((subcategoryarray[ai]as AnyObject)["scat_name"] as! String, forKey: "sub_catname")
                                                subInspectionCategoires.setValue(inspection_id, forKey: "inspectionId")
                                                do {
                                                    try context.save()
                                                    print(try! context.save())
                                                    print(" Inspection questions and ans save")
                                                    
                                                } catch {
                                                    
                                                    print("QA Failed saving")
                                                }
                                            }
                                            let inspectionArray = (data1![i] as AnyObject).value(forKey: "inspection") as! NSArray
                                            self.deleteRecored(entityName: "InspectedQA", inspectionID: inspection_id)
                                            for Ins in 0 ..< inspectionArray.count
                                            {
                                                let entity = NSEntityDescription.entity(forEntityName: "InspectedQA", in: context)
                                                let Questions = NSManagedObject(entity: entity!, insertInto: context)
                                                var answerstr = ""
                                                if let ans = (inspectionArray[Ins]as AnyObject)["ans"] as? String
                                                {
                                                    answerstr = ans
                                                    
                                                }else{
                                                    answerstr = " "
                                                }
                                                print("answerstr",answerstr)
                                                
                                                Questions.setValue(answerstr, forKey: "answer")
                                                Questions.setValue((inspectionArray[Ins]as AnyObject)["ans_id"] as! String, forKey: "defultAns")
                                                Questions.setValue((inspectionArray[Ins]as AnyObject)["que_id"] as! String, forKey: "ques_id")
                                                Questions.setValue((inspectionArray[Ins]as AnyObject)["question"] as! String, forKey: "question")
                                                Questions.setValue((inspectionArray[Ins]as AnyObject)["sub_cat_id"] as! String, forKey: "sub_catId")
                                                Questions.setValue((inspectionArray[Ins]as AnyObject)["cat_id"] as! String, forKey: "cat_id")
                                                Questions.setValue((inspectionArray[Ins]as AnyObject)["inspection_id"] as! String, forKey: "inspectionId")
                                                Questions.setValue((inspectionArray[Ins]as AnyObject)["include_in_summary"] as! String, forKey: "add_to_report_summ")
                                                Questions.setValue((inspectionArray[Ins]as AnyObject)["status"] as! String, forKey: "status")
                                                Questions.setValue((inspectionArray[Ins]as AnyObject)["result"] as! String, forKey: "result")
                                                Questions.setValue((inspectionArray[Ins]as AnyObject)["comment"] as! String, forKey: "comment")
                                                do {
                                                    try context.save()
                                                    print(try! context.save())
                                                    print("questions and ans save")
                                                } catch {
                                                    print("QA Failed saving")
                                                }
                                            }
                                            let picsarray = (data1![i] as AnyObject).value(forKey: "pics") as! NSArray
                                            self.deleteRecored(entityName: "Images", inspectionID: inspection_id)
                                            for pa in 0 ..< picsarray.count
                                            {
                                                let url1:NSURL = NSURL(string: (picsarray[pa]as AnyObject)["image_url"] as! String)!
                                                if let data1 = try? Data(contentsOf: url1 as URL)
                                                {
                                                    let newImage = UIImage(data: data1)
                                                    self.saveimageinDic(numm: (picsarray[pa]as AnyObject)["image"] as! String, image: newImage!)
                                                }
                                                let entity = NSEntityDescription.entity(forEntityName: "Images", in: context)
                                                let Images = NSManagedObject(entity: entity!, insertInto: context)
                                                
                                                
                                                Images.setValue((picsarray[pa]as AnyObject)["image"] as! String, forKey: "image_id")
                                                Images.setValue((picsarray[pa]as AnyObject)["inspection_id"] as! String, forKey: "inspectionId")
                                                Images.setValue(imageUrlArray[0].path, forKey: "imagepath")
                                                let url:NSURL = NSURL(string: (picsarray[pa]as AnyObject)["image_url"] as! String)!
                                                if let data = try? Data(contentsOf: url as URL)
                                                {
                                                    Images.setValue(data, forKey: "image")
                                                }
                                                do {
                                                    try context.save()
                                                    print(try! context.save())
                                                    print("photo save")
                                                } catch {
                                                    print("QA Failed saving")
                                                }
                                            }
                                            let assingImage = (data1![i] as AnyObject).value(forKey: "assigned_pics") as! NSArray
                                            self.deleteRecored(entityName: "AssingImages", inspectionID: inspection_id)
                                            for ai in 0 ..< assingImage.count
                                            {
                                                
                                                let entity = NSEntityDescription.entity(forEntityName: "AssingImages", in: context)
                                                let assingImages = NSManagedObject(entity: entity!, insertInto: context)
                                                assingImages.setValue((assingImage[ai]as AnyObject)["image"] as! String, forKey: "image_id")
                                                assingImages.setValue((assingImage[ai]as AnyObject)["cat_type"] as! String, forKey: "cat_type")
                                                assingImages.setValue((assingImage[ai]as AnyObject)["image_category"] as! String, forKey: "image_category_id")
                                                
                                                assingImages.setValue((assingImage[ai]as AnyObject)["image_sub_category"] as! String, forKey: "image_sub_category_id")
                                                assingImages.setValue((assingImage[ai]as AnyObject)["categoty_name"] as! String, forKey: "image_category_name")
                                                assingImages.setValue((assingImage[ai]as AnyObject)["sub_category_name"] as! String, forKey: "image_sub_category_name")
                                                assingImages.setValue((assingImage[ai]as AnyObject)["inspection_id"] as! String, forKey: "inspectionId")
                                                
                                                do {
                                                    
                                                    try context.save()
                                                    print(try! context.save())
                                                    print("Assingphoto save")
                                                    
                                                } catch {
                                                    
                                                    print("QA Failed saving")
                                                }
                                                
                                            }
                                            
                                            do{
                                                try context.save()
                                            }catch{
                                                print(error)
                                            }
                                        }
                                        SVProgressHUD.dismiss()
                                        print("NEW DATA UPDATE");
                                    }else
                                    {
                                        //insert record
                                        print("NEW DATA INSERT");
                                        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
                                        let newUser = NSManagedObject(entity: entity!, insertInto: context)
                                        newUser.setValue(innerarray["client_first_name"] as! String, forKey: "firstName")
                                        newUser.setValue(innerarray["client_last_name"] as! String, forKey: "lastName")
                                        newUser.setValue(innerarray["client_phone"] as! String, forKey: "phoneNo")
                                        newUser.setValue(innerarray["client_address_1"] as! String, forKey: "address")
                                        newUser.setValue(innerarray["client_city"] as! String, forKey: "city")
                                        newUser.setValue(innerarray["client_email"] as! String, forKey: "email")
                                        newUser.setValue(innerarray["client_zip"] as! String, forKey: "c_zip")
                                        newUser.setValue(innerarray["client_country"] as! String, forKey: "c_country")
                                        newUser.setValue(innerarray["client_address_2"] as! String, forKey: "c_add2")
                                        newUser.setValue(innerarray["client_state"] as! String, forKey: "c_city")
                                        
                                        newUser.setValue(innerarray["buyer_agent_first_name"] as! String, forKey: "buyerfistname")
                                        newUser.setValue(innerarray["buyer_agent_last_name"] as! String, forKey: "buyerlastname")
                                        newUser.setValue(innerarray["buyer_agent_phone"] as! String, forKey: "buyerphoneno")
                                        newUser.setValue(innerarray["buyer_agent_email"] as! String, forKey: "buyeremail")
                                        newUser.setValue(innerarray["buyer_agent_office"] as! String, forKey: "buyeroffice")
                                        newUser.setValue(innerarray["listing_agent_first_name"] as! String, forKey: "listingfirstname")
                                        newUser.setValue(innerarray["listing_agent_last_name"] as! String, forKey: "listinglastname")
                                        newUser.setValue(innerarray["listing_agent_phone"] as! String, forKey: "listingphoneno")
                                        newUser.setValue(innerarray["listing_agent_email"] as! String, forKey: "listingemail")
                                        newUser.setValue(innerarray["listing_agent_office"] as! String, forKey: "listingoffice")
                                        
                                        newUser.setValue(innerarray["assign_to"] as! String, forKey: "assignTo")
                                        newUser.setValue(userDefault.value(forKey: "userid")as! String, forKey: "iduser")
                                        newUser.setValue(innerarray["inspection_id"] as! String, forKey: "inspectionId")
                                        newUser.setValue(innerarray["inspection_id"] as! String, forKey: "serverInspection_id")
                                        
                                        
                                        //  inspection info
                                        
                                        newUser.setValue(innerarray["inspection_address"] as! String, forKey: "inspectionAddress")
                                        newUser.setValue(innerarray["inspection_city"] as! String, forKey: "inspectionCity")
                                        newUser.setValue(innerarray["inspection_state"] as! String, forKey: "inspectionState")
                                        newUser.setValue(innerarray["inspection_zip"] as! String, forKey: "inspectionZip")
                                        newUser.setValue(innerarray["invoice_no"] as! String, forKey: "invoice")
                                        newUser.setValue(innerarray["date_of_inspection"] as! String, forKey: "dateOfInspection")
                                        newUser.setValue(innerarray["time_of_inspection"] as! String, forKey: "time")
                                        newUser.setValue(innerarray["inspection_fees"] as! String, forKey: "inspectonFess")
                                        newUser.setValue(innerarray["addtional_inspection_fees"] as! String, forKey: "additionalInsfees")
                                        newUser.setValue(innerarray["type_of_additional_inspection"] as! String, forKey: "typeOfAdditionalInsFees")
                                        newUser.setValue(innerarray["year_build"] as! String, forKey: "yearBuild")
                                        newUser.setValue(innerarray["estimated_sqft"] as! String, forKey: "estimatedSqft")
                                        newUser.setValue(innerarray["no_of_units_inspected"] as! String, forKey: "ofUnitsInspected")
                                        newUser.setValue(innerarray["no_of_additional_inspection"] as! String, forKey: "ofAdditionalIns")
                                        // ispaymentDone
                                        newUser.setValue(innerarray["inspection_type"] as! String, forKey: "inspectiontype")
                                        newUser.setValue(innerarray["weather"] as! String, forKey: "weather")
                                        newUser.setValue(innerarray["construction_type"] as! String, forKey: "constructionType")
                                        newUser.setValue(innerarray["structure"] as! String, forKey: "structure")
                                        newUser.setValue(innerarray["no_of_bedrooms"] as! String, forKey: "bedroom")
                                        newUser.setValue(innerarray["no_of_bath"] as! String, forKey: "bathroom")
                                        newUser.setValue(innerarray["no_of_garage"] as! String, forKey: "garage")
                                        newUser.setValue(innerarray["temprature"] as! String, forKey: "tempture")
                                        newUser.setValue(innerarray["no_of_stories"] as! String, forKey: "noofstories")
                                        newUser.setValue(innerarray["payment_method"] as! String, forKey: "paymentType")
                                        
                                        let paymentrecive = innerarray["payment_received"] as! String
                                        var ispayemntdone = ""
                                        if(paymentrecive == "0")
                                        {
                                            ispayemntdone = "No"
                                        }
                                        else{
                                            ispayemntdone = "Yes"
                                        }
                                        newUser.setValue(ispayemntdone, forKey: "ispaymentDone")
                                        newUser.setValue(innerarray["received_amount"] as! String, forKey: "taxInfo")
                                        
                                        ////bathroom garage taxInfo paymentType
                                        newUser.setValue(innerarray["inspection_country"] as! String, forKey: "insp_c")
                                        newUser.setValue(innerarray["inspection_address_2"] as! String, forKey: "inspAdd2")
                                        
                                        let categoryarray = (data1![i] as AnyObject).value(forKey: "category") as! NSArray
                                        for ai in 0 ..< categoryarray.count
                                        {
                                            let entity = NSEntityDescription.entity(forEntityName: "InspectionCategoires", in: context)
                                            let InspectionCategoires = NSManagedObject(entity: entity!, insertInto: context)
                                            
                                            InspectionCategoires.setValue( (categoryarray[ai]as AnyObject)["cat_id"] as! String, forKey: "cat_Id")
                                            InspectionCategoires.setValue((categoryarray[ai]as AnyObject)["cat_name"] as! String, forKey: "cat_Name")
                                            InspectionCategoires.setValue((categoryarray[ai]as AnyObject)["in_report"] as! String, forKey: "include_in_report")
                                            InspectionCategoires.setValue(inspection_id, forKey: "inspectionId")
                                            do {
                                                try context.save()
                                                print(try! context.save())
                                                print(" Inspection questions and ans save")
                                                
                                            } catch {
                                                
                                                print("QA Failed saving")
                                            }
                                        }
                                        let subcategoryarray = (data1![i] as AnyObject).value(forKey: "subcategory") as! NSArray
                                        for ai in 0 ..< subcategoryarray.count
                                        {
                                            let entity = NSEntityDescription.entity(forEntityName: "InspectionSubCategoires", in: context)
                                            let subInspectionCategoires = NSManagedObject(entity: entity!, insertInto: context)
                                            
                                            subInspectionCategoires.setValue( (subcategoryarray[ai]as AnyObject)["cat_id"] as! String, forKey: "cat_Id")
                                            subInspectionCategoires.setValue((subcategoryarray[ai]as AnyObject)["scat_id"] as! String, forKey: "sub_catId")
                                            subInspectionCategoires.setValue((subcategoryarray[ai]as AnyObject)["in_report"] as! String, forKey: "include_in_report")
                                            subInspectionCategoires.setValue((subcategoryarray[ai]as AnyObject)["scat_name"] as! String, forKey: "sub_catname")
                                            subInspectionCategoires.setValue(inspection_id, forKey: "inspectionId")
                                            do {
                                                try context.save()
                                                print(try! context.save())
                                                print(" Inspection questions and ans save")
                                                
                                            } catch {
                                                
                                                print("QA Failed saving")
                                            }
                                        }
                                        let inspectionArray = (data1![i] as AnyObject).value(forKey: "inspection") as! NSArray
                                        
                                        for Ins in 0 ..< inspectionArray.count
                                        {
                                            let entity = NSEntityDescription.entity(forEntityName: "InspectedQA", in: context)
                                            let Questions = NSManagedObject(entity: entity!, insertInto: context)
                                            var answerstr = ""
                                            if let ans = (inspectionArray[Ins]as AnyObject)["ans"] as? String
                                            {
                                                answerstr = ans
                                                
                                            }else{
                                                answerstr = " "
                                            }
                                            print("answerstr",answerstr)
                                            
                                            Questions.setValue(answerstr, forKey: "answer")
                                            Questions.setValue((inspectionArray[Ins]as AnyObject)["ans_id"] as! String, forKey: "defultAns")
                                            Questions.setValue((inspectionArray[Ins]as AnyObject)["que_id"] as! String, forKey: "ques_id")
                                            Questions.setValue((inspectionArray[Ins]as AnyObject)["question"] as! String, forKey: "question")
                                            Questions.setValue((inspectionArray[Ins]as AnyObject)["sub_cat_id"] as! String, forKey: "sub_catId")
                                            Questions.setValue((inspectionArray[Ins]as AnyObject)["cat_id"] as! String, forKey: "cat_id")
                                            Questions.setValue((inspectionArray[Ins]as AnyObject)["inspection_id"] as! String, forKey: "inspectionId")
                                            Questions.setValue((inspectionArray[Ins]as AnyObject)["include_in_summary"] as! String, forKey: "add_to_report_summ")
                                            
                                            Questions.setValue((inspectionArray[Ins]as AnyObject)["status"] as! String, forKey: "status")
                                            Questions.setValue((inspectionArray[Ins]as AnyObject)["result"] as! String, forKey: "result")
                                            Questions.setValue((inspectionArray[Ins]as AnyObject)["comment"] as! String, forKey: "comment")
                                            
                                            do {
                                                
                                                try context.save()
                                                print(try! context.save())
                                                print("questions and ans save")
                                                
                                            } catch {
                                                
                                                print("QA Failed saving")
                                            }
                                        }
                                        
                                        let picsarray = (data1![i] as AnyObject).value(forKey: "pics") as! NSArray
                                        for pa in 0 ..< picsarray.count
                                        {
                                            let url1:NSURL = NSURL(string: (picsarray[pa]as AnyObject)["image_url"] as! String)!
                                            if let data1 = try? Data(contentsOf: url1 as URL)
                                            {
                                                let newImage = UIImage(data: data1)
                                                self.saveimageinDic(numm: (picsarray[pa]as AnyObject)["image"] as! String, image: newImage!)
                                            }
                                            let entity = NSEntityDescription.entity(forEntityName: "Images", in: context)
                                            let Images = NSManagedObject(entity: entity!, insertInto: context)
                                            
                                            
                                            Images.setValue((picsarray[pa]as AnyObject)["image"] as! String, forKey: "image_id")
                                            Images.setValue((picsarray[pa]as AnyObject)["inspection_id"] as! String, forKey: "inspectionId")
                                            Images.setValue(imageUrlArray[0].path, forKey: "imagepath")
                                            let url:NSURL = NSURL(string: (picsarray[pa]as AnyObject)["image_url"] as! String)!
                                            if let data = try? Data(contentsOf: url as URL)
                                            {
                                                Images.setValue(data, forKey: "image")
                                            }
                                            
                                            do {
                                                try context.save()
                                                print(try! context.save())
                                                print("photo save")
                                            } catch {
                                                print("QA Failed saving")
                                            }
                                        }
                                        let assingImage = (data1![i] as AnyObject).value(forKey: "assigned_pics") as! NSArray
                                        for ai in 0 ..< assingImage.count
                                        {
                                            
                                            let entity = NSEntityDescription.entity(forEntityName: "AssingImages", in: context)
                                            let assingImages = NSManagedObject(entity: entity!, insertInto: context)
                                            
                                            assingImages.setValue((assingImage[ai]as AnyObject)["image"] as! String, forKey: "image_id")
                                            assingImages.setValue((assingImage[ai]as AnyObject)["cat_type"] as! String, forKey: "cat_type")
                                            assingImages.setValue((assingImage[ai]as AnyObject)["image_category"] as! String, forKey: "image_category_id")
                                            
                                            assingImages.setValue((assingImage[ai]as AnyObject)["image_sub_category"] as! String, forKey: "image_sub_category_id")
                                            
                                            assingImages.setValue((assingImage[ai]as AnyObject)["categoty_name"] as! String, forKey: "image_category_name")
                                            
                                            assingImages.setValue((assingImage[ai]as AnyObject)["sub_category_name"] as! String, forKey: "image_sub_category_name")
                                            
                                            assingImages.setValue((assingImage[ai]as AnyObject)["inspection_id"] as! String, forKey: "inspectionId")
                                            
                                            do {
                                                try context.save()
                                                print(try! context.save())
                                                print("Assingphoto save")
                                            } catch {
                                                print("QA Failed saving")
                                            }
                                        }
                                        do {
                                            try context.save()
                                            print(try! context.save())
                                            print("userdatasave")
                                        } catch {
                                            print("Failed saving")
                                        }
                                    }
                                }
                            }
                            SVProgressHUD.dismiss()
                            self.fetchdatabaseValues()
                        }catch{
                        }
                        break
                    case .failure(let error):
                        if error._code == NSURLErrorTimedOut {
                            //HANDLE TIMEOUT HERE
                            SVProgressHUD.dismiss()
                            let alertController = UIAlertController(title: "", message: "Something went wrong." , preferredStyle: .alert)
                            
                            let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
                                UIAlertAction in
                                
                            }
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                        print("\n\nAuth request failed with error:\n \(error)")
                        break
                    }
            }
            
            
        }
        else
        {
            fetchdatabaseValues()
        }
        
        
        
    }
    func prpertyListAPIAlphabate()
    {
        methodSortByAlphabate()
        
    }
    func prpertyListAPIDate()
    {
        methodSortByDate()
    }
    var user_id : String = ""
    func methodCall()
    {
        
    }
    
    func fetchdatabaseValues()
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.predicate =  NSPredicate(format: "iduser == %@", userDefault.value(forKey: "userid")as! String)
        
        request.returnsObjectsAsFaults = false
        
        do {
            removeAllArrayData()
            
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]
            {
                
                firstNameStr = data.value(forKey: "firstName") as? String
                self.client_fname.append(firstNameStr!)
                lastNameStr = (data.value(forKey: "lastName") as? String)!
                self.client_lname.append(lastNameStr)
                dateOfInspStr = data.value(forKey: "dateOfInspection") as? String
                self.date_of_insp.append(dateOfInspStr!)
                address = data.value(forKey: "address") as! String
                self.client_address.append(address)
                c_StateStr = data.value(forKey: "c_city") as? String
                if c_StateStr != nil{
                    self.client_citya2.append(c_StateStr!)
                }
                c_zipStr = data.value(forKey: "c_zip") as? String
                if c_zipStr != nil{
                    self.client_zip2.append(c_zipStr!)
                }
                c_add2Str = data.value(forKey: "c_add2") as? String
                if c_add2Str != nil{
                    self.client_addressa2.append(c_add2Str!)
                }
                c_countryStr = (data.value(forKey: "c_country") as? String)!
                if c_countryStr != nil{
                    self.client_country2.append(c_countryStr!)
                }
                cityStr = data.value(forKey: "city") as! String
                self.client_city.append(cityStr)
                emailStr = data.value(forKey: "email") as! String
                self.client_email.append(emailStr)
                phoneNoStr = data.value(forKey: "phoneNo") as! String
                self.phone_no.append(phoneNoStr)
                inspectionIdStr = data.value(forKey: "inspectionId") as? String
                self.ins_IdArray.append(inspectionIdStr!)
                print("self.ins_IdArray",self.ins_IdArray)
                
                buyerfirstName = data.value(forKey: "buyerfistname") as? String
                self.buyer_agent_fname.append(buyerfirstName!)
                buyerlastName = data.value(forKey: "buyerlastname") as? String
                self.buyer_agent_lname.append(buyerlastName!)
                buyerphoneNo = data.value(forKey: "buyerphoneno") as? String
                self.buyer_agent_phoneNo.append(buyerphoneNo!)
                buyerEmailStr = data.value(forKey: "buyeremail") as? String
                self.buyer_agent_email.append(buyerEmailStr!)
                buyerOffice = data.value(forKey: "buyeroffice") as? String
                self.buyer_agent_office.append(buyerOffice!)
                
                listingLastName = data.value(forKey: "listinglastname") as? String
                self.listing_agent_lname.append(listingLastName!)
                listingFrstName = data.value(forKey: "listingfirstname") as? String
                self.listing_agent_fname.append(listingFrstName!)
                listingPhoneNo1 = data.value(forKey: "listingphoneno") as? String
                self.listing_agent_phoneNo.append(listingPhoneNo1!)
                listingEmailStr = data.value(forKey: "listingemail") as? String
                self.listing_agent_email.append(listingEmailStr!)
                listingOffice = data.value(forKey: "listingoffice") as? String
                self.listing_agent_office.append(listingOffice!)
                
                
                inspAdd = data.value(forKey: "inspectionAddress") as? String
                self.insp_add.append(inspAdd!)
                inspCity = data.value(forKey: "inspectionCity") as? String
                self.insp_city.append(inspCity!)
                inspState = data.value(forKey: "inspectionState") as? String
                self.insp_state.append(inspState!)
                inspZipStr = data.value(forKey: "inspectionZip") as? String
                self.insp_zip.append(inspZipStr!)
                
                insp_c_str = data.value(forKey: "insp_c") as? String
                if insp_c_str != nil
                {
                    self.insp_country_array.append(insp_c_str!)
                }
                insp_add_str = data.value(forKey: "inspAdd2") as? String
                if insp_add_str != nil
                {
                    self.insp_address_array.append(insp_add_str!)
                }
                
                assingToStr = data.value(forKey: "assignTo") as? String
                if assingToStr != nil
                {
                    self.assingTo.append(assingToStr!)
                }
                invoice = data.value(forKey: "invoice") as? String
                self.invoice1.append(invoice!)
                
                inspectionTypestr = data.value(forKey: "inspectiontype") as? String
                if inspectionTypestr != nil
                {
                    self.inspectiontype.append(inspectionTypestr!)
                }
                
                
                time = data.value(forKey: "time") as? String
                self.time1.append(time!)
                inspFees = data.value(forKey: "inspectonFess") as? String
                self.insp_fees.append(inspFees!)
                addInspFees = data.value(forKey: "additionalInsfees") as? String
                self.add_insp_fees.append(addInspFees!)
                typeAddInspFees = data.value(forKey: "typeOfAdditionalInsFees") as? String
                self.type_add_insp_fees.append(typeAddInspFees!)
                yearBuild = data.value(forKey: "yearBuild") as? String
                self.year_build.append(yearBuild!)
                estimatedSqft = data.value(forKey: "estimatedSqft") as? String
                self.estmated_sqft.append(estimatedSqft!)
                unitsInsp = data.value(forKey: "ofUnitsInspected") as? String
                self.unit_insp.append(unitsInsp!)
                addInspUnits = data.value(forKey: "ofAdditionalIns") as? String
                self.add_insp.append(addInspUnits!)
                weather = data.value(forKey: "weather") as? String
                self.weather1.append(weather!)
                consType = data.value(forKey: "constructionType") as? String
                self.cons_type.append(consType!)
                structure = data.value(forKey: "structure") as? String
                self.structure1.append(structure!)
                bedroom = data.value(forKey: "bedroom") as? String
                self.bedroom1.append(bedroom!)
                
                inspectionIdStr = data.value(forKey: "inspectionId") as? String
                self.inspectionIDs.append(inspectionIdStr!)
                //bathroom garage taxInfo paymentType
                bathroomStr = data.value(forKey: "bathroom") as? String
                self.bathroom1.append(bathroomStr!)
                
                garageStr = data.value(forKey: "garage") as? String
                self.garage1.append(garageStr!)
                
                temptureStr = data.value(forKey: "tempture") as? String
                self.temptureArray.append(temptureStr!)
                
                noOfStoriesStr = data.value(forKey: "noofstories") as? String
                self.noOfStoriesArray.append(noOfStoriesStr!)
                
                taxInfoStr = data.value(forKey: "taxInfo") as? String
                self.taxInfo1.append(taxInfoStr!)
                
                ispaymentdone = data.value(forKey: "ispaymentDone") as? String
                self.IspaymentDone1.append(ispaymentdone!)
                
                paymentTypeStr = data.value(forKey: "paymentType") as? String
                self.paymentType1.append(paymentTypeStr!)
                
                imageArray = data.value(forKey: "dataArray") as? NSData
            }
            DispatchQueue.main.async {
                
                self.filterdata = self.client_fname
                self.tblVwListing.reloadData()
            }
        } catch {
            
            print("Failed")
        }
        
    }
    func methodSortByDate() {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.predicate =  NSPredicate(format: "iduser == %@", userDefault.value(forKey: "userid")as! String)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            let  dateCreated  = result as NSArray
            print("unsorted :-",dateCreated)
            let descriptor = NSSortDescriptor(key: "dateOfInspection", ascending: true)
            request.sortDescriptors = [descriptor]
            let sortedarray:[Any]
            sortedarray = dateCreated.sortedArray(using: [descriptor])
            
            print("Sorted :- ",sortedarray)
            for data in sortedarray as! [NSManagedObject] {
                
                firstNameStr = data.value(forKey: "firstName") as? String
                self.client_fname.append(firstNameStr!)
                lastNameStr = data.value(forKey: "lastName") as! String
                self.client_lname.append(lastNameStr)
                dateOfInspStr = data.value(forKey: "dateOfInspection") as? String
                self.date_of_insp.append(dateOfInspStr!)
                address = data.value(forKey: "address") as! String
                self.client_address.append(address)
                
                c_StateStr = data.value(forKey: "c_city") as? String
                self.client_citya2.append(c_StateStr!)
                c_zipStr = data.value(forKey: "c_zip") as? String
                self.client_zip2.append(c_zipStr!)
                c_add2Str = data.value(forKey: "c_add2") as? String
                self.client_addressa2.append(c_add2Str!)
                c_countryStr = (data.value(forKey: "c_country") as? String)!
                self.client_country2.append(c_countryStr!)
                
                cityStr = data.value(forKey: "city") as! String
                self.client_city.append(cityStr)
                emailStr = data.value(forKey: "email") as! String
                self.client_email.append(emailStr)
                phoneNoStr = data.value(forKey: "phoneNo") as! String
                self.phone_no.append(phoneNoStr)
                
                inspectionIdStr = data.value(forKey: "inspectionId") as? String
                self.ins_IdArray.append(inspectionIdStr!)
                
                buyerfirstName = data.value(forKey: "buyerfistname") as? String
                self.buyer_agent_fname.append(buyerfirstName!)
                buyerlastName = data.value(forKey: "buyerlastname") as? String
                self.buyer_agent_lname.append(buyerlastName!)
                buyerphoneNo = data.value(forKey: "buyerphoneno") as? String
                self.buyer_agent_phoneNo.append(buyerphoneNo!)
                buyerEmailStr = data.value(forKey: "buyeremail") as? String
                self.buyer_agent_email.append(buyerEmailStr!)
                buyerOffice = data.value(forKey: "buyeroffice") as? String
                self.buyer_agent_office.append(buyerOffice!)
                
                listingLastName = data.value(forKey: "listinglastname") as? String
                self.listing_agent_lname.append(listingLastName!)
                listingFrstName = data.value(forKey: "listingfirstname") as? String
                self.listing_agent_fname.append(listingFrstName!)
                listingPhoneNo1 = data.value(forKey: "listingphoneno") as? String
                self.listing_agent_phoneNo.append(listingPhoneNo1!)
                listingEmailStr = data.value(forKey: "listingemail") as? String
                self.listing_agent_email.append(listingEmailStr!)
                listingOffice = data.value(forKey: "listingoffice") as? String
                self.listing_agent_office.append(listingOffice!)
                
                inspAdda2 = data.value(forKey: "inspAdd2") as? String
                self.insp_adda2.append(inspAdda2!)
                
                inspAdd = data.value(forKey: "inspectionAddress") as? String
                self.insp_add.append(inspAdd!)
                inspCity = data.value(forKey: "inspectionCity") as? String
                self.insp_city.append(inspCity!)
                inspState = data.value(forKey: "inspectionState") as? String
                self.insp_state.append(inspState!)
                inspZipStr = data.value(forKey: "inspectionZip") as? String
                self.insp_zip.append(inspZipStr!)
                insp_c_str = data.value(forKey: "insp_c") as? String
                if insp_c_str != nil
                {
                    self.insp_country_array.append(insp_c_str!)
                }
                insp_add_str = data.value(forKey: "inspAdd2") as? String
                if insp_add_str != nil
                {
                    self.insp_address_array.append(insp_add_str!)
                }
                invoice = data.value(forKey: "invoice") as? String
                self.invoice1.append(invoice!)
                inspectionTypestr = data.value(forKey: "inspectiontype") as? String
                if inspectionTypestr != nil
                {
                    self.inspectiontype.append(inspectionTypestr!)
                }
                assingToStr = data.value(forKey: "assignTo") as? String
                if assingToStr != nil
                {
                    self.assingTo.append(assingToStr!)
                }
                
                
                time = data.value(forKey: "time") as? String
                self.time1.append(time!)
                inspFees = data.value(forKey: "inspectonFess") as? String
                self.insp_fees.append(inspFees!)
                addInspFees = data.value(forKey: "additionalInsfees") as? String
                self.add_insp_fees.append(addInspFees!)
                typeAddInspFees = data.value(forKey: "typeOfAdditionalInsFees") as? String
                self.type_add_insp_fees.append(typeAddInspFees!)
                yearBuild = data.value(forKey: "yearBuild") as? String
                self.year_build.append(yearBuild!)
                estimatedSqft = data.value(forKey: "estimatedSqft") as? String
                self.estmated_sqft.append(estimatedSqft!)
                unitsInsp = data.value(forKey: "ofUnitsInspected") as? String
                self.unit_insp.append(unitsInsp!)
                addInspUnits = data.value(forKey: "ofAdditionalIns") as? String
                self.add_insp.append(addInspUnits!)
                weather = data.value(forKey: "weather") as? String
                self.weather1.append(weather!)
                consType = data.value(forKey: "constructionType") as? String
                self.cons_type.append(consType!)
                structure = data.value(forKey: "structure") as? String
                self.structure1.append(structure!)
                bedroom = data.value(forKey: "bedroom") as? String
                self.bedroom1.append(bedroom!)
                
                inspectionIdStr = data.value(forKey: "inspectionId") as? String
                self.inspectionIDs.append(inspectionIdStr!)
                
                bathroomStr = data.value(forKey: "bathroom") as? String
                self.bathroom1.append(bathroomStr!)
                
                garageStr = data.value(forKey: "garage") as? String
                self.garage1.append(garageStr!)
                
                temptureStr = data.value(forKey: "tempture") as? String
                self.temptureArray.append(temptureStr!)
                
                noOfStoriesStr = data.value(forKey: "noofstories") as? String
                self.noOfStoriesArray.append(noOfStoriesStr!)
                
                taxInfoStr = data.value(forKey: "taxInfo") as? String
                self.taxInfo1.append(taxInfoStr!)
                
                ispaymentdone = data.value(forKey: "ispaymentDone") as? String
                self.IspaymentDone1.append(ispaymentdone!)
                
                paymentTypeStr = data.value(forKey: "paymentType") as? String
                self.paymentType1.append(paymentTypeStr!)
                
            }
            
            DispatchQueue.main.async {
                actInd.stopAnimating()
                self.tblVwListing.reloadData()
            }
        } catch {
            
            print("Failed")
        }
        
        
    }
    func methodSortByAlphabate()
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.predicate =  NSPredicate(format: "iduser == %@", userDefault.value(forKey: "userid")as! String)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            let  dateCreated  = result as NSArray
            print("unsorted :-",dateCreated)
            let descriptor = NSSortDescriptor(key: "firstName", ascending: true)
            request.sortDescriptors = [descriptor]
            print("123..",request.sortDescriptors!)
            let sortedarray:[Any]
            sortedarray = dateCreated.sortedArray(using: [descriptor])
            
            print("Sorted :- ",sortedarray)
            for data in sortedarray as! [NSManagedObject] {
                
                firstNameStr = data.value(forKey: "firstName") as? String
                self.client_fname.append(firstNameStr!)
                lastNameStr = data.value(forKey: "lastName") as! String
                self.client_lname.append(lastNameStr)
                dateOfInspStr = data.value(forKey: "dateOfInspection") as? String
                self.date_of_insp.append(dateOfInspStr!)
                address = data.value(forKey: "address") as! String
                self.client_address.append(address)
                
                c_StateStr = data.value(forKey: "c_city") as? String
                self.client_citya2.append(c_StateStr!)
                c_zipStr = data.value(forKey: "c_zip") as? String
                self.client_zip2.append(c_zipStr!)
                c_add2Str = data.value(forKey: "c_add2") as? String
                self.client_addressa2.append(c_add2Str!)
                
                cityStr = data.value(forKey: "city") as! String
                self.client_city.append(cityStr)
                emailStr = data.value(forKey: "email") as! String
                self.client_email.append(emailStr)
                phoneNoStr = data.value(forKey: "phoneNo") as! String
                self.phone_no.append(phoneNoStr)
                c_countryStr = (data.value(forKey: "c_country") as? String)!
                self.client_country2.append(c_countryStr!)
                
                
                inspectionIdStr = data.value(forKey: "inspectionId") as? String
                self.ins_IdArray.append(inspectionIdStr!)
                
                buyerfirstName = data.value(forKey: "buyerfistname") as? String
                self.buyer_agent_fname.append(buyerfirstName!)
                buyerlastName = data.value(forKey: "buyerlastname") as? String
                self.buyer_agent_lname.append(buyerlastName!)
                buyerphoneNo = data.value(forKey: "buyerphoneno") as? String
                self.buyer_agent_phoneNo.append(buyerphoneNo!)
                buyerEmailStr = data.value(forKey: "buyeremail") as? String
                self.buyer_agent_email.append(buyerEmailStr!)
                buyerOffice = data.value(forKey: "buyeroffice") as? String
                self.buyer_agent_office.append(buyerOffice!)
                
                listingLastName = data.value(forKey: "listinglastname") as? String
                self.listing_agent_lname.append(listingLastName!)
                listingFrstName = data.value(forKey: "listingfirstname") as? String
                self.listing_agent_fname.append(listingFrstName!)
                listingPhoneNo1 = data.value(forKey: "listingphoneno") as? String
                self.listing_agent_phoneNo.append(listingPhoneNo1!)
                listingEmailStr = data.value(forKey: "listingemail") as? String
                self.listing_agent_email.append(listingEmailStr!)
                listingOffice = data.value(forKey: "listingoffice") as? String
                self.listing_agent_office.append(listingOffice!)
                
                inspAdda2 = data.value(forKey: "inspAdd2") as? String
                self.insp_adda2.append(inspAdda2!)
                inspAdd = data.value(forKey: "inspectionAddress") as? String
                self.insp_add.append(inspAdd!)
                inspCity = data.value(forKey: "inspectionCity") as? String
                self.insp_city.append(inspCity!)
                inspState = data.value(forKey: "inspectionState") as? String
                self.insp_state.append(inspState!)
                inspZipStr = data.value(forKey: "inspectionZip") as? String
                self.insp_zip.append(inspZipStr!)
                insp_c_str = data.value(forKey: "insp_c") as? String
                if insp_c_str != nil
                {
                    self.insp_country_array.append(insp_c_str!)
                }
                insp_add_str = data.value(forKey: "inspAdd2") as? String
                if insp_add_str != nil
                {
                    self.insp_address_array.append(insp_add_str!)
                }
                invoice = data.value(forKey: "invoice") as? String
                self.invoice1.append(invoice!)
                inspectionTypestr = data.value(forKey: "inspectiontype") as? String
                if inspectionTypestr != nil
                {
                    self.inspectiontype.append(inspectionTypestr!)
                }
                assingToStr = data.value(forKey: "assignTo") as? String
                if assingToStr != nil
                {
                    self.assingTo.append(assingToStr!)
                }
                time = data.value(forKey: "time") as? String
                self.time1.append(time!)
                inspFees = data.value(forKey: "inspectonFess") as? String
                self.insp_fees.append(inspFees!)
                addInspFees = data.value(forKey: "additionalInsfees") as? String
                self.add_insp_fees.append(addInspFees!)
                typeAddInspFees = data.value(forKey: "typeOfAdditionalInsFees") as? String
                self.type_add_insp_fees.append(typeAddInspFees!)
                yearBuild = data.value(forKey: "yearBuild") as? String
                self.year_build.append(yearBuild!)
                estimatedSqft = data.value(forKey: "estimatedSqft") as? String
                self.estmated_sqft.append(estimatedSqft!)
                unitsInsp = data.value(forKey: "ofUnitsInspected") as? String
                self.unit_insp.append(unitsInsp!)
                addInspUnits = data.value(forKey: "ofAdditionalIns") as? String
                self.add_insp.append(addInspUnits!)
                weather = data.value(forKey: "weather") as? String
                self.weather1.append(weather!)
                consType = data.value(forKey: "constructionType") as? String
                self.cons_type.append(consType!)
                structure = data.value(forKey: "structure") as? String
                self.structure1.append(structure!)
                bedroom = data.value(forKey: "bedroom") as? String
                self.bedroom1.append(bedroom!)
                
                inspectionIdStr = data.value(forKey: "inspectionId") as? String
                self.inspectionIDs.append(inspectionIdStr!)
                
                bathroomStr = data.value(forKey: "bathroom") as? String
                self.bathroom1.append(bathroomStr!)
                
                garageStr = data.value(forKey: "garage") as? String
                self.garage1.append(garageStr!)
                
                temptureStr = data.value(forKey: "tempture") as? String
                self.temptureArray.append(temptureStr!)
                
                noOfStoriesStr = data.value(forKey: "noofstories") as? String
                self.noOfStoriesArray.append(noOfStoriesStr!)
                
                taxInfoStr = data.value(forKey: "taxInfo") as? String
                self.taxInfo1.append(taxInfoStr!)
                
                ispaymentdone = data.value(forKey: "ispaymentDone") as? String
                self.IspaymentDone1.append(ispaymentdone!)
                
                paymentTypeStr = data.value(forKey: "paymentType") as? String
                self.paymentType1.append(paymentTypeStr!)
                
            }
            print("client_lname..",self.client_lname)
            
            DispatchQueue.main.async {
                actInd.stopAnimating()
                self.tblVwListing.reloadData()
            }
        } catch {
            
            print("Failed")
        }
    }
    
    func methodSearchByKey(searchStr: String)
    {
        let SearchKey = NSPredicate(format: "firstName CONTAINS[cd] %@", searchStr)
        let lastNamekey = NSPredicate(format: "lastName CONTAINS[cd] %@", searchStr)
        let addresskey = NSPredicate(format: "address CONTAINS[cd] %@", searchStr)
        let orPredicate = NSCompoundPredicate(type: .or, subpredicates: [SearchKey, lastNamekey,addresskey])
        let inspectionId = NSPredicate(format: "iduser == %@", userDefault.value(forKey: "userid")as! String)
        let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [orPredicate, inspectionId])
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.predicate = andPredicate
        
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            let  dateCreated  = result as NSArray
            print("unsorted :-",dateCreated)
            let descriptor = NSSortDescriptor(key: "firstName", ascending: true)
            request.sortDescriptors = [descriptor]
            print("123..",request.sortDescriptors!)
            let sortedarray:[Any]
            sortedarray = dateCreated.sortedArray(using: [descriptor])
            
            print("Sorted :- ",sortedarray)
            for data in sortedarray as! [NSManagedObject] {
                
                firstNameStr = data.value(forKey: "firstName") as? String
                self.client_fname.append(firstNameStr!)
                lastNameStr = data.value(forKey: "lastName") as! String
                self.client_lname.append(lastNameStr)
                dateOfInspStr = data.value(forKey: "dateOfInspection") as? String
                self.date_of_insp.append(dateOfInspStr!)
                address = data.value(forKey: "address") as! String
                self.client_address.append(address)
                
                c_StateStr = data.value(forKey: "c_city") as? String
                self.client_citya2.append(c_StateStr!)
                c_zipStr = data.value(forKey: "c_zip") as? String
                self.client_zip2.append(c_zipStr!)
                c_add2Str = data.value(forKey: "c_add2") as? String
                self.client_addressa2.append(c_add2Str!)
                
                cityStr = data.value(forKey: "city") as! String
                self.client_city.append(cityStr)
                emailStr = data.value(forKey: "email") as! String
                self.client_email.append(emailStr)
                phoneNoStr = data.value(forKey: "phoneNo") as! String
                self.phone_no.append(phoneNoStr)
                c_countryStr = (data.value(forKey: "c_country") as? String)!
                self.client_country2.append(c_countryStr!)
                
                
                inspectionIdStr = data.value(forKey: "inspectionId") as? String
                self.ins_IdArray.append(inspectionIdStr!)
                
                buyerfirstName = data.value(forKey: "buyerfistname") as? String
                self.buyer_agent_fname.append(buyerfirstName!)
                buyerlastName = data.value(forKey: "buyerlastname") as? String
                self.buyer_agent_lname.append(buyerlastName!)
                buyerphoneNo = data.value(forKey: "buyerphoneno") as? String
                self.buyer_agent_phoneNo.append(buyerphoneNo!)
                buyerEmailStr = data.value(forKey: "buyeremail") as? String
                self.buyer_agent_email.append(buyerEmailStr!)
                buyerOffice = data.value(forKey: "buyeroffice") as? String
                self.buyer_agent_office.append(buyerOffice!)
                
                listingLastName = data.value(forKey: "listinglastname") as? String
                self.listing_agent_lname.append(listingLastName!)
                listingFrstName = data.value(forKey: "listingfirstname") as? String
                self.listing_agent_fname.append(listingFrstName!)
                listingPhoneNo1 = data.value(forKey: "listingphoneno") as? String
                self.listing_agent_phoneNo.append(listingPhoneNo1!)
                listingEmailStr = data.value(forKey: "listingemail") as? String
                self.listing_agent_email.append(listingEmailStr!)
                listingOffice = data.value(forKey: "listingoffice") as? String
                self.listing_agent_office.append(listingOffice!)
                
                inspAdda2 = data.value(forKey: "inspAdd2") as? String
                self.insp_adda2.append(inspAdda2!)
                inspAdd = data.value(forKey: "inspectionAddress") as? String
                self.insp_add.append(inspAdd!)
                inspCity = data.value(forKey: "inspectionCity") as? String
                self.insp_city.append(inspCity!)
                inspState = data.value(forKey: "inspectionState") as? String
                self.insp_state.append(inspState!)
                inspZipStr = data.value(forKey: "inspectionZip") as? String
                self.insp_zip.append(inspZipStr!)
                insp_c_str = data.value(forKey: "insp_c") as? String
                if insp_c_str != nil
                {
                    self.insp_country_array.append(insp_c_str!)
                }
                insp_add_str = data.value(forKey: "inspAdd2") as? String
                if insp_add_str != nil
                {
                    self.insp_address_array.append(insp_add_str!)
                }
                invoice = data.value(forKey: "invoice") as? String
                self.invoice1.append(invoice!)
                inspectionTypestr = data.value(forKey: "inspectiontype") as? String
                if inspectionTypestr != nil
                {
                    self.inspectiontype.append(inspectionTypestr!)
                }
                assingToStr = data.value(forKey: "assignTo") as? String
                if assingToStr != nil
                {
                    self.assingTo.append(assingToStr!)
                }
                time = data.value(forKey: "time") as? String
                self.time1.append(time!)
                inspFees = data.value(forKey: "inspectonFess") as? String
                self.insp_fees.append(inspFees!)
                addInspFees = data.value(forKey: "additionalInsfees") as? String
                self.add_insp_fees.append(addInspFees!)
                typeAddInspFees = data.value(forKey: "typeOfAdditionalInsFees") as? String
                self.type_add_insp_fees.append(typeAddInspFees!)
                yearBuild = data.value(forKey: "yearBuild") as? String
                self.year_build.append(yearBuild!)
                estimatedSqft = data.value(forKey: "estimatedSqft") as? String
                self.estmated_sqft.append(estimatedSqft!)
                unitsInsp = data.value(forKey: "ofUnitsInspected") as? String
                self.unit_insp.append(unitsInsp!)
                addInspUnits = data.value(forKey: "ofAdditionalIns") as? String
                self.add_insp.append(addInspUnits!)
                weather = data.value(forKey: "weather") as? String
                self.weather1.append(weather!)
                consType = data.value(forKey: "constructionType") as? String
                self.cons_type.append(consType!)
                structure = data.value(forKey: "structure") as? String
                self.structure1.append(structure!)
                bedroom = data.value(forKey: "bedroom") as? String
                self.bedroom1.append(bedroom!)
                
                inspectionIdStr = data.value(forKey: "inspectionId") as? String
                self.inspectionIDs.append(inspectionIdStr!)
                
                bathroomStr = data.value(forKey: "bathroom") as? String
                self.bathroom1.append(bathroomStr!)
                
                garageStr = data.value(forKey: "garage") as? String
                self.garage1.append(garageStr!)
                
                temptureStr = data.value(forKey: "tempture") as? String
                self.temptureArray.append(temptureStr!)
                
                noOfStoriesStr = data.value(forKey: "noofstories") as? String
                self.noOfStoriesArray.append(noOfStoriesStr!)
                
                
                taxInfoStr = data.value(forKey: "taxInfo") as? String
                self.taxInfo1.append(taxInfoStr!)
                
                ispaymentdone = data.value(forKey: "ispaymentDone") as? String
                self.IspaymentDone1.append(ispaymentdone!)
                
                paymentTypeStr = data.value(forKey: "paymentType") as? String
                self.paymentType1.append(paymentTypeStr!)
                
            }
            print("client_lname..",self.client_lname)
            
            DispatchQueue.main.async {
                actInd.stopAnimating()
                self.tblVwListing.reloadData()
            }
        } catch {
            
            print("Failed")
        }
        
        
    }
    func searchData() {
        
        print("search...")
        let parameters: Parameters = ["search": (self.searchView.text)!]
        print("prametrs..",parameters)
        self.request = Alamofire.request(urlSearch, method: .post, parameters:parameters)
        if let request = request as? DataRequest {
            request.responseString { response in
                //PKHUD.sharedHUD.hide()
                do{
                    let dictionary = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    print(dictionary)
                    let msg = dictionary["success"] as? String
                    print("msg=",msg as Any)
                    let data1 = dictionary["data"] as? NSArray
                    print("data =",data1!)
                    
                    
                    
                    if msg == "0" || msg == nil
                    {
                        print("no data")
                        
                    }
                    else
                    {
                        let data1 = dictionary["data"] as? NSArray
                        print("data =",data1!)
                        
                        self.client_fname = ((data1?.value(forKey: "client_name") as! NSArray) as! [String])
                        
                        self.added_date = ((data1?.value(forKey: "added_date") as! NSArray) as! [String])
                        print("added_date",self.added_date)
                        
                        
                        
                        
                    }
                }catch{
                }
                
            }
        }
    }
    
    @IBAction func btn(_ sender: Any)
    {
        btn2Out.isHidden = false
        if !hamburgerMenuIsVisible {
            
            if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone)
            {
                widthView.constant = self.view.frame.width-120
            }
            widthView.constant = 300
            hamburgerMenuIsVisible = false
        } else {
            
            leadingC.constant = 0
            widthView.constant = 0
            
            //2
            hamburgerMenuIsVisible = false
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("The animation is complete!")
        }
    }
    @IBAction func btn2(_ sender: Any)
    {
        hideMenuView()
    }
    @IBAction func addBtn(_ sender: Any)
    {
        CDataArray.removeAllObjects()
        myNewlyAddedImages.removeAll()
        finalG = "FG"
        
        inspectionIdStr = nil;
        AddIndex = userDefault.value(forKey:"AddIndex") as! Int
        let inspVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InspectionsVC")as! InspectionsVC
        inspVc.fromWhere = "Newmode"
        self.present(inspVc, animated: false, completion: nil)
        
        
        
    }
    
    @IBAction func filterButton(_ sender: Any)
    {
        self.view1.isHidden = false
        
    }
    @IBAction func sortByAlphabetButton(_ sender: Any)
    {
        self.view1.isHidden = true
        
        removeAllArrayData()
        prpertyListAPIAlphabate()
        DispatchQueue.main.async {
            self.tblVwListing.reloadData()
        }
    }
    @IBAction func sortByDateButton(_ sender: Any)
    {
        self.view1.isHidden = true
        removeAllArrayData()
        prpertyListAPIDate()
        DispatchQueue.main.async {
            self.tblVwListing.reloadData()
        }
    }
    func removeAllArrayData(){
        client_fname.removeAll()
        
        
        self.client_fname.removeAll()
        
        
        self.client_country2.removeAll()
        
        self.insp_country_array.removeAll()
        self.insp_address_array.removeAll()
        
        self.IspaymentDone1.removeAll()
        
        
        self.date_of_insp.removeAll()
        
        self.client_address.removeAll()
        
        self.agent_fname.removeAll()
        
        self.client_lname.removeAll()
        
        
        self.client_city.removeAll()
        
        self.client_email.removeAll()
        
        self.phone_no.removeAll()
        
        self.client_citya2.removeAll()
        self.client_zip2.removeAll()
        self.client_addressa2.removeAll()
        self.inspectiontype.removeAll()
        self.buyer_agent_fname.removeAll()
        
        self.buyer_agent_lname.removeAll()
        self.buyer_agent_phoneNo.removeAll()
        self.buyer_agent_email.removeAll()
        self.buyer_agent_office.removeAll()
        
        self.listing_agent_lname.removeAll()
        self.listing_agent_fname.removeAll()
        self.listing_agent_phoneNo.removeAll()
        self.listing_agent_email.removeAll()
        self.listing_agent_office.removeAll()
        
        
        self.insp_add.removeAll()
        self.insp_city.removeAll()
        self.insp_state.removeAll()
        self.insp_zip.removeAll()
        self.invoice1.removeAll()
        
        self.time1.removeAll()
        self.insp_fees.removeAll()
        self.add_insp_fees.removeAll()
        self.type_add_insp_fees.removeAll()
        self.year_build.removeAll()
        self.estmated_sqft.removeAll()
        self.unit_insp.removeAll()
        self.add_insp.removeAll()
        self.weather1.removeAll()
        self.cons_type.removeAll()
        self.structure1.removeAll()
        self.bedroom1.removeAll()
        self.ins_IdArray.removeAll()
        self.bathroom1.removeAll()
        self.garage1.removeAll()
        self.temptureArray.removeAll()
        self.paymentType1.removeAll()
        self.taxInfo1.removeAll()
        self.inspectionIDs.removeAll()
        self.assingTo.removeAll()
        self.noOfStoriesArray.removeAll()
    }
    
    func deleteRecored(entityName: String)
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let result = try? context.fetch(fetchRequest)
        let resultData = result
        
        for object in resultData! {
            context.delete(object as! NSManagedObject)
        }
        do {
            try context.save()
            print("deleted record from \(entityName)!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
    }
    func categoryListAPI2()
    {
        
        let url = "http://allin1inspections.com/admin/webservices/category_data"
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: headers).responseString{ response in
            
            if((response.result.value) != nil)
            {
                print(response.result.value!)
                let dict = convertToDictionary(text: response.result.value!)
                print("dict123",dict!)
                self.success1=(dict!["success"] as! NSNumber)
                print("success1",self.success1!)
                
                switch(response.result){
                    
                    
                case .success(_):
                    print("sucess")
                    userDefault.set(false, forKey: "firstTime")
                    let dt0=dict!["data"] as! [Dictionary<String,AnyObject>]
                    let statusDict = dict!["status_master"] as! [Dictionary<String,AnyObject>]
                    let ResultDict = dict!["result_master"] as! [Dictionary<String,AnyObject>]
                    // print("dt0",dt0)
                    actInd.stopAnimating()
                    self.deleteRecored(entityName: "Comments")
                    self.deleteRecored(entityName: "Questions")
                    self.deleteRecored(entityName: "Subcategories")
                    
                    self.deleteRecored(entityName: "MainCategories")
                    self.deleteRecored(entityName: "ResultInfo")
                    self.deleteRecored(entityName: "StatusInfo")
                    
                    
                    self.data=dt0
                    catNameArray.removeAll()
                    self.subCatArray2.removeAll()
                    resultArray.removeAll()
                    
                    for  i in 0..<statusDict.count
                    {
                        var temp = statusDict[i] as Dictionary<String,AnyObject>
                        let resultname = temp["name"] as? String
                        statusArray.append(resultname!)
                        
                    }
                    for  i in 0..<ResultDict.count
                    {
                        
                        var temp1 = ResultDict[i] as Dictionary<String,AnyObject>
                        let resultname = temp1["name"] as? String
                        resultArray.append(resultname!)
                    }
                    
                    
                    for  i in 0..<dt0.count
                    {
                        self.dt11=dt0[i] as Dictionary<String,AnyObject>
                        catName=(self.dt11!["cat_name"] as! String)
                        print("cat_name",catName!)
                        catNameArray.append(catName!)
                        self.subCat3 = self.dt11!["subcat"]as! [Dictionary<String,AnyObject>]
                        print("subcat..",self.subCat3.count)
                        self.subCatArray2.append(self.subCatArray)
                    }
                    
                    print("catNameArray",catNameArray)
                    print("subCatArray2",self.subCatArray2)
                    
                    catNameArray.removeAll()
                    catIdArray.removeAll()
                    catinculdeInReport.removeAll()
                    self.subCatArray.removeAll()
                    
                    for  c in 0..<dt0.count
                    {
                        
                        self.dt11=dt0[c] as Dictionary<String,AnyObject>
                        
                        catName=(self.dt11!["cat_name"] as! String)
                        catNameArray.append(catName!)
                        
                        catId=(self.dt11!["cat_id"] as! String)
                        catIdArray.append(catId!)
                        catinculdeInReport.append(self.dt11!["include_in_report"] as! String)
                        subcatNameArray.removeAll()
                        subcatIdArray.removeAll()
                        subcatInculdeInreportArray.removeAll()
                        self.subCat3 = self.dt11!["subcat"]as! [Dictionary<String,AnyObject>]
                        
                        //delete all data from questions
                        
                        for  s in 0..<self.subCat3.count
                        {
                            self.subCat1=self.subCat3[s]
                            self.subCatName=(self.subCat1["scat_name"] as! String)
                            self.subCatArray.append(self.subCatName!)
                            subcatNameArray.append(self.subCatName!)
                            self.subCatId=(self.subCat1["scat_id"] as! String)
                            self.subCatInclude=(self.subCat1["include_in_report"] as! String)
                            //self.subCatInclude=("0")
                            self.subCatID.append(self.subCatId!)
                            subcatIdArray.append(self.subCatId!)
                            subcatInculdeInreportArray.append(self.subCatInclude!)
                            
                            self.subCat1=self.subCat3[s]
                            
                            let comment = self.subCat1["comment"]
                            let defaultcm = [(comment!["default_comment"])!][0] as? String
                            let comments = [(comment!["comments"])!][0] as? String
                            let subcatId = subcatIdArray[s] as String
                            let entity = NSEntityDescription.entity(forEntityName: "Comments", in: context)
                            //comment save
                            let Comments = NSManagedObject(entity: entity!, insertInto: context)
                            
                            Comments.setValue(defaultcm, forKey: "default_comment")
                            Comments.setValue(comments, forKey: "comments")
                            Comments.setValue(subcatId, forKey: "scat_id")
                            do {
                                try context.save()
                                print(try! context.save())
                                print("Comments and ans save")
                            } catch {
                                print("QA Failed saving")
                            }
                            
                            self.qus = (self.subCat1 ["questions"]as? [Dictionary<String,AnyObject>] ?? nil)!
                            
                            self.ans.removeAll()
                            self.qus2.removeAll()
                            
                            for q in 0..<self.qus.count
                            {
                                //ques ans save
                                self.qus2=self.qus[q]
                                self.qusName=(self.qus2["question"] as! String)
                                print("qusName",self.qusName!)
                                
                                if let constantName = self.qus2["answers"] as? [String : String] {
                                    //statements using 'constantName'
                                    self.ans =   constantName
                                    
                                    let q_id = (self.qus2["question_id"] as! String)
                                    let question = (self.qus2["question"] as! String)
                                    let a_id = [(self.ans["ans_id"])!][0]
                                    let answer = [(self.ans["ans"])!][0]
                                    let defaultans = [(self.ans["default_ans"])!][0]
                                    let catId = catIdArray[c]
                                    let subcatId = subcatIdArray[s]
                                    print("subcatId",subcatId)
                                    print("catId",catId)
                                    
                                    let entity = NSEntityDescription.entity(forEntityName: "Questions", in: context)
                                    let Questions = NSManagedObject(entity: entity!, insertInto: context)
                                    
                                    Questions.setValue(a_id, forKey: "ansId")
                                    Questions.setValue(answer, forKey: "answer")
                                    Questions.setValue(defaultans, forKey: "defultAns")
                                    Questions.setValue(defaultans, forKey: "tempdefaultans")
                                    Questions.setValue(q_id, forKey: "ques_id")
                                    Questions.setValue(question, forKey: "question")
                                    Questions.setValue(subcatId, forKey: "sub_catId")
                                    Questions.setValue(catId, forKey: "cat_id")
                                    Questions.setValue(inspectionIdStr, forKey: "inspectionId")
                                    
                                    
                                    do {
                                        
                                        try context.save()
                                        print(try! context.save())
                                        print("questions and ans save")
                                        
                                    } catch {
                                        
                                        print("QA Failed saving")
                                    }
                                    
                                } else {
                                    // the value of someOptional is not set (or nil).
                                    print("nilesh",self.qus2["question"] as! String)
                                    let q_id = (self.qus2["question_id"] as! String)
                                    let question = (self.qus2["question"] as! String)
                                    let a_id = [""][0]
                                    let answer = [""][0]
                                    let defaultans = ""
                                    let catId = catIdArray[c]
                                    let subcatId = subcatIdArray[s]
                                    print("subcatId",subcatId)
                                    print("catId",catId)
                                    
                                    let entity = NSEntityDescription.entity(forEntityName: "Questions", in: context)
                                    let Questions = NSManagedObject(entity: entity!, insertInto: context)
                                    
                                    Questions.setValue(a_id, forKey: "ansId")
                                    Questions.setValue(answer, forKey: "answer")
                                    Questions.setValue(defaultans, forKey: "defultAns")
                                    Questions.setValue(defaultans, forKey: "tempdefaultans")
                                    Questions.setValue(q_id, forKey: "ques_id")
                                    Questions.setValue(question, forKey: "question")
                                    Questions.setValue(subcatId, forKey: "sub_catId")
                                    Questions.setValue(catId, forKey: "cat_id")
                                    Questions.setValue(inspectionIdStr, forKey: "inspectionId")
                                    
                                    
                                    do {
                                        
                                        try context.save()
                                        print(try! context.save())
                                        print("questions and ans save")
                                        print("nilesh",self.qus2["question"] as! String)
                                    } catch {
                                        
                                        print("QA Failed saving")
                                    }
                                }
                                
                                
                            }
                            
                            
                        }
                        
                        //add subcategies db
                        for ss in 0..<subcatNameArray.count
                        {
                            let entity = NSEntityDescription.entity(forEntityName: "Subcategories", in: context)
                            let Subcategories = NSManagedObject(entity: entity!, insertInto: context)
                            
                            Subcategories.setValue(catIdArray[c], forKey: "cat_Id")
                            Subcategories.setValue(subcatNameArray[ss], forKey: "sub_catname")
                            Subcategories.setValue(subcatIdArray[ss], forKey: "sub_catId")
                            Subcategories.setValue(subcatInculdeInreportArray[ss], forKey: "include_in_report")
                            do
                            {
                                try context.save()
                                print(try! context.save())
                                print("subcategories save")
                            } catch {
                                
                                print("subcategories Failed saving")
                            }
                        }
                        
                    }
                    
                    //add catagoies db
                    for b in 0..<catNameArray.count
                    {
                        let entity = NSEntityDescription.entity(forEntityName: "MainCategories", in: context)
                        let MainCategories = NSManagedObject(entity: entity!, insertInto: context)
                        
                        MainCategories.setValue(catIdArray[b], forKey: "cat_Id")
                        MainCategories.setValue(catNameArray[b], forKey: "cat_Name")
                        MainCategories.setValue(catinculdeInReport[b], forKey: "include_in_report")
                        
                        
                        do
                        {
                            print("Maincategories save")
                            try context.save()
                            print(try! context.save())
                            
                        } catch {
                            
                            print("Maincategories Failed saving")
                        }
                    }
                    
                    for re in 0..<resultArray.count
                    {
                        let entity = NSEntityDescription.entity(forEntityName: "ResultInfo", in: context)
                        let result = NSManagedObject(entity: entity!, insertInto: context)
                        
                        result.setValue(resultArray[re], forKey: "result")
                        
                        do
                        {
                            print("ResultInfo save")
                            try context.save()
                            print(try! context.save())
                            
                        } catch {
                            
                            print("Maincategories Failed saving")
                        }
                    }
                    for st in 0..<statusArray.count
                    {
                        let entity = NSEntityDescription.entity(forEntityName: "StatusInfo", in: context)
                        let Status = NSManagedObject(entity: entity!, insertInto: context)
                        
                        Status.setValue(statusArray[st], forKey: "status")
                        do
                        {
                            print("StatusInfo save")
                            try context.save()
                            print(try! context.save())
                        } catch {
                            
                            print("Maincategories Failed saving")
                        }
                    }
                    loadingIndicator.stopAnimating()
                    
                case .failure(_):
                    print("fail")
                    break
                }
            }else{
                
            }
            
        }
    }
}
