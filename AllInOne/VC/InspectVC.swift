//
//  InspectVC.swift
//  AllInOne
//
//  Created by Apple on 11/13/18.
//  Copyright © 2018 mac08. All rights reserved.
//

import UIKit
import CoreData
import SVProgressHUD
import EventKit
import InputMask

import FSCalendar

@available(iOS 10.0, *)
class InspectVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,CalendarViewDataSource, CalendarViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,FSCalendarDelegate,FSCalendarDataSource
{
    
    //Outlets...
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var tableView2: UITableView!
    @IBOutlet weak var hideViewCalender: UIView!
    @IBOutlet weak var calenderBtnHide: UIButton!
    @IBOutlet weak var calendarView: CalendarView!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var stateVIew: UIView!
    @IBOutlet weak var stateVIew2: UIView!
    
    @IBOutlet weak var viewForKgmodel: UIView!
    @IBOutlet weak var tableviewForKgmodel: UITableView!
    
    @IBOutlet weak var statePicker: UIPickerView!
    @IBOutlet weak var statePicker2: UIPickerView!
    
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var calender: FSCalendar!
    //Variables.
    
    let picker = UIPickerView()
    let tb1 = UITableView()
    var inspectArray = ["Client","Realtors","Inspections Info","Payment Information"]
    var weatherArray = ["Summer","Winter","Rainy","Structure3","Structure4"]
    var StructureArray = ["Structure1","Structure2","Structure3","Structure4"]
    var BedRoomsArray = ["1","2","3","4","5","6","7","8","9","10"]
    var ConstypeArray = ["Constype1","Constype2","Constype3","Constype4","Constype5","Constype6"]
    var inputArray = [""]
    
    var expandedRows = Set<Int>()
    var name = ""
    var FromWhere = ""
    var dateAndTimeStr = ""
    var activityIndicaor : UIActivityIndicatorView = UIActivityIndicatorView()
    var stateArray = [String]()
    var indexPatht = ""
    var add2 : String? = ""
    
    //MARK:- Picker delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == statePicker || pickerView == statePicker2
        {
            return 1
            
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == statePicker || pickerView == statePicker2
        {
            return stateArray.count
        }
        return inputArray.count
        
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
    {
        if pickerView == statePicker || pickerView == statePicker2
        {
            return 40
        }
        return 40
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if pickerView == statePicker || pickerView == statePicker2
        {
            return self.stateArray[row]
        }
        return self.inputArray[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
        if pickerView == statePicker
        {
            //finalG = "F"
            dateAndTimeStr = "B"
            inspState = self.stateArray[row]
            //self.tableView1.reloadData()
        }
        else if pickerView == statePicker2
        {
            // finalG = "F"
            dateAndTimeStr = "B"
            cityStr = self.stateArray[row]
            // self.tableView1.reloadData()
        }else{
            
            
        }
        //self.tableView1.reloadData()
        
    }
    
    //MARK:- DIDLOAD Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        FromWhere = ""
        if finalG == "FG"
        {
            address = ""
            c_zipStr=""
            c_add2Str=""
            c_countryStr=""
            cityStr = ""
        }
        print(finalG)
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        UserDefaults.standard.set(0, forKey: "View")
        
        self.statePicker.delegate = self
        self.statePicker.dataSource = self
        self.statePicker2.delegate = self
        self.statePicker2.dataSource = self
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MM/dd/yyyy"
        let result = formatter.string(from: date)
        self.dateLbl.text = result
        
        actInd.center = self.view.center
        actInd.hidesWhenStopped = true
        actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        actInd.color = .black
        //        view.addSubview(actInd)
        //        actInd.startAnimating()
        stateArray = ["AK","AL","AR","AZ","CA","CO","CT","DE","FL","FM","GA","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MH","MI","MN","MO","MS","MT","NC","ND","NE","NH","NJ","NM","NV","NY","OH","OK","OR","PA","RI","SD","TN","TX","UT","VA","VT","WA","WI","WV","WY"]
        
        
        DispatchQueue.main.async {
            self.hideViewCalender.isHidden = true
            self.calenderBtnHide.isHidden = true
            self.timePicker.backgroundColor = UIColor.white
            self.timeView.isHidden = true
            self.statePicker.backgroundColor = UIColor.white
            self.statePicker2.backgroundColor = UIColor.white
            self.stateVIew.isHidden = true
            self.stateVIew2.isHidden = true
            
        }
       
        viewHeight.constant = 1200
        print("viewHeight",viewHeight.constant)
        view.layoutIfNeeded()
        viewDidLayoutSubviews()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        let today = Date()
        
        var tomorrowComponents = DateComponents()
        tomorrowComponents.day = 1
        
    }
    
    @objc func loadList(notification: NSNotification){
        
        print("Ashore")
        
        let row = 0
        let indexPath = IndexPath(row: row, section:0)
        let indexPath1 = IndexPath(row: row, section:1)
        let indexPath2 = IndexPath(row: row, section:2)
        let indexPath3 = IndexPath(row: row, section:3)
        
        if tempSection == "0"
        {
            self.tableView(self.tableView1, didDeselectRowAt: indexPath)
        }
        else if tempSection == "1"
        {
            self.tableView(self.tableView1, didDeselectRowAt: indexPath1)
        }
        else if tempSection == "2"
        {
            self.tableView(self.tableView1, didDeselectRowAt: indexPath2)
        }
        else if tempSection == "3"
        {
            self.tableView(self.tableView1, didDeselectRowAt: indexPath3)
        }
        else
        {
            
        }
       
        
      self.ScrollView.setContentOffset(.zero, animated: true)
       
    }
    @objc func startTimeDiveChanged(sender: UIDatePicker) {
        
        dateAndTimeStr = "B"
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        time = formatter.string(from: sender.date)
        print("time1",time!)
        
    }
    
    @IBAction func datePicker(_ sender: Any) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.time
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss"
        print("gfahfj",dateFormatter.dateFormat)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                global = data.value(forKey: "global") as? String
            }
            
        } catch {
            
            print("Failed")
        }
        self.tableView1.delegate = self
        self.tableView1.dataSource = self
        self.tableView1.rowHeight = UITableViewAutomaticDimension
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        print("should retrun")
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        
    }
    func presentController(_ controller: UIViewController) {
        let ret = self.view.frame
        controller.view.frame.size.width = ret.size.width - ret.size.width/4
        controller.view.frame.size.height = ret.size.height/2
        
        
        
    }
    
    //Tableview Methods...
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(tableView == self.tableView1)
        {
            
            return 1
        }
        else
        {
            print("WatherTableview");
            return inputArray.count
        }
        // return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        
        if(tableView == self.tableView1)
        {
            
            return inspectArray.count
        }
        else
        {
            
            return 1
        }
        // return inspectArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        print("indexPath.row",indexPath.row);
        print("indexPath.section",indexPath.section);
        if(tableView == self.tableView1)
        {
            
            
            if indexPath.section == 0
            {
                let cell:ExpandableCellInspect1 = tableView1.dequeueReusableCell(withIdentifier: "ExpandableCellInspect1") as! ExpandableCellInspect1
                cell.largebl.layer.cornerRadius = 5.0;
                cell.largebl.layer.borderWidth = 1.0;
                let color = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
                cell.largebl.layer.borderColor = color.cgColor
                cell.largebl.clipsToBounds = true
                //            cell.view2.isHidden = true
                //            cell.view4.isHidden = true
                
                cell.selectionStyle = .none
                tableView1.separatorStyle = .none
                // cell.img.image = UIImage(named: imgs[indexPath.row])
                
                cell.lblTxt.text = "Client"
                
                cell.isExpanded = self.expandedRows.contains(indexPath.row)
                cell.img.layer.cornerRadius = 5.0;
                cell.img.layer.borderWidth = 1.0;
                cell.img.layer.borderColor = color.cgColor
                
                print("finalG",finalG as Any)
                if finalG == "FG"
                {
                    
                    firstNameStr = ""
                    
                    cell.firstName.text = ""
                    cell.lastName.text = ""
                    cell.phoneNo.text = ""
                    cell.address.text = ""
                    cell.city.text = "FL"
                    cell.email.text = ""
                    cell.c_cityTxt.text = ""
                    cell.c_zipTxt.text = ""
                    cell.address2.text = ""
                    cell.c_countryTxt.text = ""
                    // cell.city.text = ""
                    
                }
                    
                else
                {
                    if global1 == "G"
                    {
                        
                        cell.firstName.text = firstNameStr
                        cell.lastName.text = lastNameStr
                        cell.phoneNo.text = formattedNumber(number: phoneNoStr)
                        
                        cell.address.text = address
                        cell.city.text = c_StateStr
                        cell.email.text = emailStr
                        
                        cell.c_cityTxt.text = cityStr
                        cell.c_zipTxt.text = c_zipStr
                        cell.address2.text = c_add2Str
                        cell.c_countryTxt.text = c_countryStr
                        
                    }
                    
                    if global == "clear"
                    {
                        print("fir...=",firstNameStr!)
                        cell.firstName.text = firstNameStr
                        cell.lastName.text = lastNameStr
                        // cell.phoneNo.text = phoneNoStr
                        cell.phoneNo.text = formattedNumber(number: phoneNoStr)
                        cell.address.text = address
                        cell.city.text = c_StateStr
                        cell.email.text = emailStr
                        cell.c_cityTxt.text = cityStr
                        cell.c_zipTxt.text = c_zipStr
                        cell.address2.text = c_add2Str
                        cell.c_countryTxt.text = c_countryStr
                    }
                    
                    cell.firstName.text = firstNameStr
                    cell.lastName.text = lastNameStr
                    //   cell.phoneNo.text = phoneNoStr
                    cell.phoneNo.text = formattedNumber(number: phoneNoStr)
                    cell.address.text = address
                    cell.city.text = c_StateStr
                    cell.email.text = emailStr
                    cell.c_cityTxt.text = cityStr
                    cell.c_zipTxt.text = c_zipStr
                    cell.address2.text = c_add2Str
                    cell.c_countryTxt.text = c_countryStr
                }
                return cell
                
            }
            else if indexPath.section == 1 {
                
                
                let cell:ExpandableCellInspect1 = tableView1.dequeueReusableCell(withIdentifier: "ExpandableCellInspect1") as! ExpandableCellInspect1
                cell.largebl.layer.cornerRadius = 5.0;
                cell.largebl.layer.borderWidth = 1.0;
                
                let color = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
                cell.largebl.layer.borderColor = color.cgColor
                
                cell.largebl.clipsToBounds = true
                //            cell.view1.isHidden = true
                //            cell.view4.isHidden = true
                
                cell.selectionStyle = .none
                tableView1.separatorStyle = .none
                // cell.img.image = UIImage(named: imgs[indexPath.row])
                
                cell.lblTxt.text = "Realtors"
                cell.isExpanded2 = self.expandedRows.contains(indexPath.row)
                cell.img.layer.cornerRadius = 5.0;
                cell.img.layer.borderWidth = 1.0;
                cell.img.layer.borderColor = color.cgColor
                
                if finalG == "FG"
                {
                    
                    buyerfirstName=""
                    buyerlastName=""
                    buyerEmailStr=""
                    buyerOffice=""
                    buyerphoneNo=""
                    listingFrstName=""
                    listingLastName=""
                    listingEmailStr=""
                    listingOffice=""
                    listingPhoneNo1=""
                    
                    cell.buyerFirstName.text = ""
                    cell.buyerLastName.text = ""
                    cell.buyerPhoneNo.text = ""
                    cell.buyerEmail.text = ""
                    cell.buyerOffice.text = ""
                    
                    cell.listingFrstName.text = ""
                    cell.listingLastName.text = ""
                    cell.listingPhoneNo.text = ""
                    cell.listingEmail.text = ""
                    cell.listingOffice.text = ""
                }
                    
                else
                {
                    if global1 == "G"
                    {
                        
                        request.returnsObjectsAsFaults = false
                        
                        
                        
                        cell.buyerFirstName.text = buyerfirstName
                        cell.buyerLastName.text = buyerlastName
                        // cell.buyerPhoneNo.text = buyerphoneNo
                        cell.buyerPhoneNo.text = formattedNumber(number: buyerphoneNo!)
                        cell.buyerEmail.text = buyerEmailStr
                        cell.buyerOffice.text = buyerOffice
                        
                        cell.listingFrstName.text = listingFrstName
                        cell.listingLastName.text = listingLastName
                        //  cell.listingPhoneNo.text = listingPhoneNo
                        
                        
                        cell.listingPhoneNo.text = formattedNumber(number: listingPhoneNo1!)
                        cell.listingEmail.text = listingEmailStr
                        cell.listingOffice.text = listingOffice
                        // }
                        
                        //                } catch {
                        //
                        //                    print("Failed")
                        //                }
                    }
                    
                    if global == "clear"
                    {
                        cell.buyerFirstName.text = buyerfirstName
                        cell.buyerLastName.text = buyerlastName
                        // cell.buyerPhoneNo.text = buyerphoneNo
                        
                        
                        cell.buyerEmail.text = buyerEmailStr
                        cell.buyerOffice.text = buyerOffice
                        
                        cell.listingFrstName.text = listingFrstName
                        cell.listingLastName.text = listingLastName
                        //    cell.listingPhoneNo.text = listingPhoneNo
                        cell.buyerPhoneNo.text = formattedNumber(number: buyerphoneNo!)
                        cell.listingPhoneNo.text = formattedNumber(number: listingPhoneNo1!)
                        cell.listingEmail.text = listingEmailStr
                        cell.listingOffice.text = listingOffice
                    }
                    
                    
                    cell.buyerFirstName.text = buyerfirstName
                    cell.buyerLastName.text = buyerlastName
                    //cell.buyerPhoneNo.text = buyerphoneNo
                    cell.buyerEmail.text = buyerEmailStr
                    cell.buyerOffice.text = buyerOffice
                    
                    cell.listingFrstName.text = listingFrstName
                    cell.listingLastName.text = listingLastName
                    //  cell.listingPhoneNo.text = listingPhoneNo
                    cell.listingEmail.text = listingEmailStr
                    cell.listingOffice.text = listingOffice
                    
                    cell.buyerPhoneNo.text = formattedNumber(number: buyerphoneNo!)
                    cell.listingPhoneNo.text = formattedNumber(number: listingPhoneNo1!)
                    
                    
                }
                
                return cell
                
            }
            else if indexPath.section == 2 {
                
                
                let cell:ExpandableCellInspect1 = tableView1.dequeueReusableCell(withIdentifier: "ExpandableCellInspect1") as! ExpandableCellInspect1
                
                cell.largebl.layer.cornerRadius = 5.0;
                cell.largebl.layer.borderWidth = 1.0;
                let color = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
                cell.largebl.layer.borderColor = color.cgColor
                
                cell.largebl.clipsToBounds = true
                //            cell.view1.isHidden = true
                //            cell.view2.isHidden = true
                cell.selectionStyle = .none
                tableView1.separatorStyle = .none
                // cell.img.image = UIImage(named: imgs[indexPath.row])
                
                cell.lblTxt.text = "Inspection Info"
                cell.isExpanded3 = self.expandedRows.contains(indexPath.row)
                cell.img.layer.cornerRadius = 5.0;
                cell.img.layer.borderWidth = 1.0;
                cell.img.layer.borderColor = color.cgColor
                //set current time & date
                //            d
                //            let picker = UIPickerView()
                picker.dataSource = self
                picker.delegate = self;
                
                let toolBar = UIToolbar()
                toolBar.barStyle = UIBarStyle.default
                toolBar.isTranslucent = true
                toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
                toolBar.sizeToFit()
                
                
                let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.donePicker))
                
                
                toolBar.setItems([doneButton], animated: false)
                toolBar.isUserInteractionEnabled = true
                
                cell.weather.tag = 10
                cell.consType.tag = 11
                cell.stucture.tag = 12
                cell.bedroom.tag = 13
                
                
                cell.stucture.inputAccessoryView = toolBar
                cell.consType.inputAccessoryView = toolBar
                cell.bedroom.inputAccessoryView = toolBar
                
                
                
                
                if finalG == "FG"
                {
                    inspAdd=""
                    inspCity=""
                    inspState=""
                    inspZipStr=""
                    invoice=""
                    dateOfInspStr=""
                    time=""
                    inspFees=""
                    addInspFees=""
                    typeAddInspFees=""
                    yearBuild=""
                    estimatedSqft=""
                    unitsInsp="1"
                    addInspUnits=""
                    weather="Clear"
                    consType="CBS/Frame"
                    structure="Single family"
                    bedroom="3"
                    bathroomStr = "2"
                    garageStr = "2"
                    temptureStr = ""
                    noOfStoriesStr = ""
                    insp_c_str=""
                    insp_add_str=""
                    inspectionTypestr = "Home inspection"
                   
                    let date = Date()
                    let formatter = DateFormatter()
                    
                    
                    formatter.dateFormat = "MM/dd/yyyy"
                    
                    
                    let result = formatter.string(from: date)
                    
                    
                    cell.dateOfInsp.text = result
                    dateOfInspStr =  cell.dateOfInsp.text
                    formatter.timeStyle = .short
                    
                    cell.time.text = "\(formatter.string(from: date))"
                    
                    cell.inspAdd.text = inspAdd
                    print("cell123",cell.inspAdd.text!)
                    cell.inspCity.text = cityStr
                    cell.inspState.text = "FL"
                    cell.inspZip.text = c_zipStr
                    cell.txt_InspectionType.text = "Home inspection"
                    cell.invoice.text = ""
                    
                    cell.inspFees.text = ""
                    cell.addInspFees.text = ""
                    cell.typeOfAddInspFees.text = ""
                    cell.yearBuild.text = ""
                    cell.estimatedSqft.text = ""
                    cell.unitsOfInsp.text = "1"
                    cell.addUnitsOfInsp.text = ""
                    cell.weather.text = "Clear"
                    cell.consType.text = "CBS/Frame"
                    cell.stucture.text = "Single family"
                    cell.bedroom.text = "3"
                    cell.txt_bathroom.text = "2"
                    cell.txt_Garage.text = "2"
                    cell.txt_tempture.text = ""
                   cell.txt_noStories.text = ""
                    cell.inspAdd2.text = c_add2Str
                    cell.inspCountryTxt.text = ""
                }
                else
                {
                    if global1 == "G"
                    {
                        //Fetch core data...
                        request.returnsObjectsAsFaults = false
                        if finalG == "F"
                        {
                            cell.dateOfInsp.text = dateOfInspStr
                            print(dateOfInspStr!)
                            cell.time.text = time
                        }
                        else
                        {
                            cell.inspAdd.text = inspAdd
                            cell.inspCity.text = inspCity
                            cell.inspState.text = inspState
                            cell.inspZip.text = inspZipStr
                            cell.txt_InspectionType.text = inspectionTypestr
                            cell.inspCountryTxt.text = insp_c_str
                            cell.inspAdd2.text = insp_add_str
                            
                            cell.invoice.text = invoice
                            cell.dateOfInsp.text = dateOfInspStr
                            cell.time.text = time
                            
                            cell.invoice.text = invoice
                            cell.inspFees.text = inspFees
                            cell.addInspFees.text = addInspFees
                            cell.typeOfAddInspFees.text = typeAddInspFees
                            cell.yearBuild.text = yearBuild
                            cell.estimatedSqft.text = estimatedSqft
                            cell.unitsOfInsp.text = unitsInsp
                            cell.addUnitsOfInsp.text = addInspUnits
                            cell.weather.text = weather
                            cell.consType.text = consType
                            cell.stucture.text = structure
                            cell.bedroom.text = bedroom
                            cell.txt_bathroom.text = bathroomStr
                            cell.txt_Garage.text = garageStr
                             cell.txt_tempture.text = temptureStr
                            cell.txt_noStories.text = noOfStoriesStr
                        }
                    }
                    if global == "clear"
                    {
                        
                        cell.inspAdd.text = inspAdd
                        cell.inspCity.text = inspCity
                        cell.inspState.text = inspState
                        cell.inspZip.text = inspZipStr
                        cell.txt_InspectionType.text = inspectionTypestr
                        cell.inspCountryTxt.text = insp_c_str
                        cell.inspAdd2.text = insp_add_str
                        
                        cell.invoice.text = invoice
                        cell.dateOfInsp.text = dateOfInspStr
                        cell.time.text = time
                        cell.inspFees.text = inspFees
                        cell.addInspFees.text = addInspFees
                        cell.typeOfAddInspFees.text = typeAddInspFees
                        cell.yearBuild.text = yearBuild
                        cell.estimatedSqft.text = estimatedSqft
                        cell.unitsOfInsp.text = unitsInsp
                        cell.addUnitsOfInsp.text = addInspUnits
                        cell.weather.text = weather
                        cell.consType.text = consType
                        cell.stucture.text = structure
                        cell.bedroom.text = bedroom
                        cell.txt_bathroom.text = bathroomStr
                        cell.txt_Garage.text = garageStr
                        cell.txt_tempture.text = temptureStr
                        cell.txt_noStories.text = noOfStoriesStr
                    }
                    
                    cell.inspAdd.text = inspAdd
                    
                    cell.inspCity.text = inspCity
                    cell.inspState.text = inspState
                    cell.inspZip.text = inspZipStr
                    cell.txt_InspectionType.text = inspectionTypestr
                    cell.inspCountryTxt.text = insp_c_str
                    cell.inspAdd2.text = insp_add_str
                    
                    cell.invoice.text = invoice
                    cell.dateOfInsp.text = dateOfInspStr
                    cell.time.text = time
                    cell.inspFees.text = inspFees
                    cell.addInspFees.text = addInspFees
                    cell.typeOfAddInspFees.text = typeAddInspFees
                    cell.yearBuild.text = yearBuild
                    cell.estimatedSqft.text = estimatedSqft
                    cell.unitsOfInsp.text = unitsInsp
                    cell.addUnitsOfInsp.text = addInspUnits
                    cell.weather.text = weather
                    
                    cell.consType.text = consType
                    cell.stucture.text = structure
                    cell.bedroom.text = bedroom
                    cell.txt_bathroom.text = bathroomStr
                    cell.txt_Garage.text = garageStr
                    cell.txt_tempture.text = temptureStr
                    cell.txt_noStories.text = noOfStoriesStr
                    cell.weather.tag = 10
                    cell.consType.tag = 11
                    cell.stucture.tag = 12
                    cell.bedroom.tag = 13
                    
                   
                    
                }
                
                return cell
                
                
                
            }else //if indexPath.section == 3
            {
                
                
                let cell:ExpandableCellInspect1 = tableView1.dequeueReusableCell(withIdentifier: "ExpandableCellInspect1") as! ExpandableCellInspect1
                cell.largebl.layer.cornerRadius = 5.0;
                cell.largebl.layer.borderWidth = 1.0;
                let color = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
                cell.largebl.layer.borderColor = color.cgColor
                cell.largebl.clipsToBounds = true
                
                
                cell.selectionStyle = .none
                tableView1.separatorStyle = .none
                // cell.img.image = UIImage(named: imgs[indexPath.row])
                
                cell.lblTxt.text = "Payment Information"
                cell.isExpanded4 = self.expandedRows.contains(indexPath.row)
                cell.img.layer.cornerRadius = 5.0;
                cell.img.layer.borderWidth = 1.0;
                cell.img.layer.borderColor = color.cgColor
                
                
                
                if finalG == "FG"
                {
                    invoice = ""
                    inspFees = ""
                    addInspFees = ""
                    paymentTypeStr = ""
                    taxInfoStr = ""
                    ispaymentdone = "No"
                    cell.invoice.text = ""
                    cell.inspFees.text = ""
                    cell.addInspFees.text = ""
                   
                    cell.txtpaymentType.text = ""
                    cell.txt_TaxInfo.text = ""
                    cell.txt_Ispaymentdone.text = "No"
                    cell.txt_TaxInfo.isHidden = true
                    cell.txtpaymentType.isHidden = true
                    
                }
                    
                else
                {
                    if global1 == "G"
                    {
                        
                        cell.invoice.text = invoice
                        cell.inspFees.text = inspFees
                        cell.addInspFees.text = addInspFees
                      
                        cell.txtpaymentType.text = paymentTypeStr
                        cell.txt_TaxInfo.text = taxInfoStr
                        cell.txt_Ispaymentdone.text = ispaymentdone
                        if(cell.txt_Ispaymentdone.text == "No"){
                            cell.txt_TaxInfo.isHidden = true
                            cell.txtpaymentType.isHidden = true
                        }else{
                            cell.txt_TaxInfo.isHidden = false
                            cell.txtpaymentType.isHidden = false
                        }
                        
                        
                        
                    }
                    
                    if global == "clear"
                    {
                        cell.invoice.text = invoice
                        cell.inspFees.text = inspFees
                        cell.addInspFees.text = addInspFees
                       
                        cell.txtpaymentType.text = paymentTypeStr
                        cell.txt_TaxInfo.text = taxInfoStr
                        cell.txt_Ispaymentdone.text = ispaymentdone
                        if(cell.txt_Ispaymentdone.text == "No"){
                            cell.txt_TaxInfo.isHidden = true
                            cell.txtpaymentType.isHidden = true
                        }else{
                            cell.txt_TaxInfo.isHidden = false
                            cell.txtpaymentType.isHidden = false
                        }
                    }
                    
                    cell.invoice.text = invoice
                    cell.inspFees.text = inspFees
                    cell.addInspFees.text = addInspFees
                    
                    cell.txtpaymentType.text = paymentTypeStr
                    cell.txt_TaxInfo.text = taxInfoStr
                    cell.txt_Ispaymentdone.text = ispaymentdone
                    if(cell.txt_Ispaymentdone.text == "No"){
                        cell.txt_TaxInfo.isHidden = true
                        cell.txtpaymentType.isHidden = true
                    }else{
                        cell.txt_TaxInfo.isHidden = false
                        cell.txtpaymentType.isHidden = false
                    }
                }
                return cell
                
            }
           // return UITableViewCell ()
        }
        else
        {
//            print("indexPath.row",indexPath.row);
//            print("indexPath.section",indexPath.section);
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell11")
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell11", for: indexPath)
            
            cell.textLabel!.text = "\(inputArray[indexPath.row])"
            return cell
        }
        // return UITableViewCell ()
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        SVProgressHUD.dismiss()
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if tableView == tableView1{
            return 1500
        }
        return 0
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        if indexPath.section == 0
        {
            viewHeight.constant = 1200
            print("viewHeight",viewHeight.constant)
            view.layoutIfNeeded()
            viewDidLayoutSubviews()
            tempSection = "0"
            
            indexSec = indexPath.section as NSNumber
            print("indexSec4..",indexSec!)
            
            guard let cell = tableView1.cellForRow(at: indexPath) as? ExpandableCellInspect1
                else { return }
            let gray1 = UIColor(rgb: 0xEAEAEA)
            cell.largebl.backgroundColor = gray1
            //core Data Save into temp  string...
            if finalG == "FG"
            {
                finalG = "F"
            }
            else
            {
                
            }
            firstNameStr = cell.firstName.text!
            
            firstNameStr?.capitalizeFirstLetter()
            
            lastNameStr = cell.lastName.text!
            //phoneNoStr = cell.phoneNo.text!
            phoneNoStr =  formattedNumber(number: cell.phoneNo.text!)
            address = cell.address.text!
            c_StateStr = cell.city.text!
            emailStr = cell.email.text!
            cityStr = cell.c_cityTxt.text!
            c_zipStr = cell.c_zipTxt.text!
            c_add2Str = cell.address2.text!
            c_countryStr = cell.c_countryTxt.text!
            
            switch cell.isExpanded
            {
            case true:
                self.expandedRows.remove(indexPath.row)
            case false:
                self.expandedRows.insert(indexPath.row)
            }
            
            
            cell.isExpanded = !cell.isExpanded
            
            self.tableView1.beginUpdates()
            self.tableView1.endUpdates()
            
            
            cell.view2.isHidden = true
            cell.view4.isHidden = true
            cell.view3.isHidden = true
            cell.view1.isHidden = false
            
            
            
            switch cell.isExpanded2
            {
            case true:
                self.expandedRows.remove(indexPath.row)
            case false:
                self.expandedRows.remove(indexPath.row)
            }
            switch cell.isExpanded3
            {
            case true:
                self.expandedRows.remove(indexPath.row)
            case false:
                self.expandedRows.remove(indexPath.row)
            }
            switch cell.isExpanded4
            {
            case true:
                self.expandedRows.remove(indexPath.row)
            case false:
                self.expandedRows.remove(indexPath.row)
            }
            
        }
        if indexPath.section == 1
        {
            viewHeight.constant = 1200
            print("viewHeight",viewHeight.constant)
            view.layoutIfNeeded()
            viewDidLayoutSubviews()
            
            tempSection = "1"
            print("insexSec..",tempSection)
           
            guard let cell = tableView1.cellForRow(at: indexPath) as? ExpandableCellInspect1
                else { return }
            cell.view1.isHidden = true
            cell.view4.isHidden = true
            cell.view3.isHidden = true
            cell.view2.isHidden = false
            
            let gray1 = UIColor(rgb: 0xEAEAEA)
            cell.largebl.backgroundColor = gray1
            
            //core Data Save into temp  string...
            buyerfirstName = cell.buyerFirstName.text!
            buyerlastName = cell.buyerLastName.text!
            //  buyerphoneNo = cell.buyerPhoneNo.text!
            buyerphoneNo =  formattedNumber(number: cell.buyerPhoneNo.text!)
            buyerEmailStr = cell.buyerEmail.text!
            buyerOffice = cell.buyerOffice.text!
            listingFrstName = cell.listingFrstName.text!
            listingLastName = cell.listingLastName.text!
            listingEmailStr = cell.listingEmail.text!
            listingOffice = cell.listingOffice.text!
            listingPhoneNo1 =  formattedNumber(number: cell.listingPhoneNo.text!)
            //listingPhoneNo = cell.listingPhoneNo.text!
            
            switch cell.isExpanded2
            {
            case true:
                self.expandedRows.remove(indexPath.row)
            case false:
                self.expandedRows.insert(indexPath.row)
            }
            
            
            cell.isExpanded2 = !cell.isExpanded2
            
            self.tableView1.beginUpdates()
            self.tableView1.endUpdates()
            
            switch cell.isExpanded
            {
            case true:
                self.expandedRows.remove(indexPath.row)
            case false:
                self.expandedRows.remove(indexPath.row)
            }
            switch cell.isExpanded3
            {
            case true:
                self.expandedRows.remove(indexPath.row)
            case false:
                self.expandedRows.remove(indexPath.row)
            }
            switch cell.isExpanded4
            {
            case true:
                self.expandedRows.remove(indexPath.row)
            case false:
                self.expandedRows.remove(indexPath.row)
            }
        }
        if indexPath.section == 2
        {
//            if UIDevice.current.userInterfaceIdiom == .phone
//
//            {
//                    viewHeight.constant = 2200
//            }
//            else{
                viewHeight.constant = 2200
          //  }
            print("viewHeight",viewHeight.constant)
            view.layoutIfNeeded()
            viewDidLayoutSubviews()
            tempSection = "2"
            print("insexSec..",tempSection)
//             print("add..",address)
            indexSec = indexPath.section as NSNumber
            print("indexSec..",indexSec!)
            
            guard let cell = tableView1.cellForRow(at: indexPath) as? ExpandableCellInspect1
                else { return }
            cell.view1.isHidden = true
            cell.view2.isHidden = true
            cell.view4.isHidden = true
            cell.view3.isHidden = false
            
            let gray1 = UIColor(rgb: 0xEAEAEA)
            cell.largebl.backgroundColor = gray1
            
            // inspAdda2 = cell.inspAdd2.text!
           
            if((cell.inspAdd.text?.isEmpty)!)
            {
                 cell.inspAdd.text = address
            }
            if((cell.inspCity.text?.isEmpty)!)
            {
                cell.inspCity.text = cityStr
            }
            if((cell.inspZip.text?.isEmpty)!)
            {
                cell.inspZip.text = c_zipStr
            }
            if((cell.inspAdd2.text?.isEmpty)!)
            {
                cell.inspAdd2.text = c_add2Str
            }
            if((cell.inspState.text?.isEmpty)!)
            {
                cell.inspState.text = c_StateStr
            }
            if((cell.inspCountryTxt.text?.isEmpty)!)
            {
                cell.inspCountryTxt.text = c_countryStr
            }
            inspAdd = cell.inspAdd.text
            inspCity = cell.inspCity.text!
            inspState = cell.inspState.text!
            inspZipStr = cell.inspZip.text!
            
            insp_c_str = cell.inspCountryTxt.text!
            insp_add_str = cell.inspAdd2.text!
            inspectionTypestr = cell.txt_InspectionType.text!
            dateOfInspStr = cell.dateOfInsp.text!
            time = cell.time.text!
            
            yearBuild = cell.yearBuild.text!
            estimatedSqft = cell.estimatedSqft.text!
            unitsInsp = cell.unitsOfInsp.text!
            addInspUnits = cell.addUnitsOfInsp.text!
            weather = cell.weather.text!
            consType = cell.consType.text!
            structure = cell.stucture.text!
            bedroom = cell.bedroom.text!
            bathroomStr = cell.txt_bathroom.text!
            garageStr = cell.txt_Garage.text!
            temptureStr = cell.txt_tempture.text!
           noOfStoriesStr = cell.txt_noStories.text
            // inspCountryStr = cell.inspCountryTxt.text!
            switch cell.isExpanded3
            {
            case true:
                self.expandedRows.remove(indexPath.row)
            case false:
                self.expandedRows.insert(indexPath.row)
            }
            
            
            cell.isExpanded3 = !cell.isExpanded3
            
            self.tableView1.beginUpdates()
            self.tableView1.endUpdates()
            switch cell.isExpanded
            {
            case true:
                self.expandedRows.remove(indexPath.row)
            case false:
                self.expandedRows.remove(indexPath.row)
            }
            switch cell.isExpanded2
            {
            case true:
                self.expandedRows.remove(indexPath.row)
            case false:
                self.expandedRows.remove(indexPath.row)
            }
            switch cell.isExpanded4
            {
            case true:
                self.expandedRows.remove(indexPath.row)
            case false:
                self.expandedRows.remove(indexPath.row)
            }
            
        }
        if indexPath.section == 3
        {
                    viewHeight.constant = 1200
                    print("viewHeight",viewHeight.constant)
                    view.layoutIfNeeded()
                    viewDidLayoutSubviews()
            self.ScrollView.setContentOffset(.zero, animated: true)
            tempSection = "3"
            indexSec = indexPath.section as NSNumber
            print(indexPath.section)
            guard let cell = tableView1.cellForRow(at: indexPath) as? ExpandableCellInspect1
                else { return }
            cell.view1.isHidden = true
            cell.view2.isHidden = true
            cell.view3.isHidden = true
            cell.view4.isHidden = false
            let gray1 = UIColor(rgb: 0xEAEAEA)
            cell.largebl.backgroundColor = gray1
            
            
            invoice = cell.invoice.text!
            inspFees = cell.inspFees.text!
            addInspFees = cell.addInspFees.text!
            
            paymentTypeStr = cell.txtpaymentType.text!
            ispaymentdone =  cell.txt_Ispaymentdone.text!
            taxInfoStr = cell.txt_TaxInfo.text!
            
            // typeAddInspFees = cell.typeOfAddInspFees.text!
            
            switch cell.isExpanded4
            {
            case true:
                self.expandedRows.remove(indexPath.row)
            case false:
                self.expandedRows.insert(indexPath.row)
            }
            
            
            cell.isExpanded4 = !cell.isExpanded4
            
            self.tableView1.beginUpdates()
            self.tableView1.endUpdates()
            
            switch cell.isExpanded
            {
            case true:
                self.expandedRows.remove(indexPath.row)
            case false:
                self.expandedRows.remove(indexPath.row)
            }
            switch cell.isExpanded2
            {
            case true:
                self.expandedRows.remove(indexPath.row)
            case false:
                self.expandedRows.remove(indexPath.row)
            }
            switch cell.isExpanded3
            {
            case true:
                self.expandedRows.remove(indexPath.row)
            case false:
                self.expandedRows.remove(indexPath.row)
            }
            finalG=""
        }
        else
        {
            
        }
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return -20.0
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        if indexPath.section == 0
        {
            
            guard let cell = tableView1.cellForRow(at: indexPath) as? ExpandableCellInspect1
                else { return }
            //            cell.view2.isHidden = true
            //            cell.view4.isHidden = true
            self.expandedRows.remove(indexPath.row)
            cell.largebl.backgroundColor = UIColor.clear
            cell.isExpanded = false
            
            //core Data Save into temp  string...
            firstNameStr = cell.firstName.text!
            
            lastNameStr = cell.lastName.text!
            phoneNoStr = cell.phoneNo.text!
            address = cell.address.text!
            c_StateStr = cell.city.text!
            emailStr = cell.email.text!
            cityStr = cell.c_cityTxt.text!
            c_zipStr = cell.c_zipTxt.text!
            c_add2Str = cell.address2.text!
            c_countryStr = cell.c_countryTxt.text!
            
            self.tableView1.beginUpdates()
           // tableView.reloadSections(IndexSet(integer: 2), with: .none)
            self.tableView1.endUpdates()
        }else if indexPath.section == 1
        {
            
            guard let cell = tableView1.cellForRow(at: indexPath) as? ExpandableCellInspect1
                else { return }
            
            self.expandedRows.remove(indexPath.row)
            cell.largebl.backgroundColor = UIColor.clear
            cell.isExpanded2 = false
            
            //core Data Save into temp  string...
            buyerfirstName = cell.buyerFirstName.text!
            buyerlastName = cell.buyerLastName.text!
            buyerphoneNo = cell.buyerPhoneNo.text!
            buyerEmailStr = cell.buyerEmail.text!
            buyerOffice = cell.buyerOffice.text!
            listingFrstName = cell.listingFrstName.text!
            listingLastName = cell.listingLastName.text!
            listingEmailStr = cell.listingEmail.text!
            listingOffice = cell.listingOffice.text!
            listingPhoneNo1 = cell.listingPhoneNo.text!
            self.tableView1.beginUpdates()
            self.tableView1.endUpdates()
        }else if indexPath.section == 2
        {
            
            guard let cell = tableView1.cellForRow(at: indexPath) as? ExpandableCellInspect1
                else { return }
            
            self.expandedRows.remove(indexPath.row)
            cell.largebl.backgroundColor = UIColor.clear
            
            cell.isExpanded3 = false
            //core Data Save into temp  string...
            //inspAdda2 = cell.inspAdd2.text!
            inspAdd = cell.inspAdd.text!
            inspCity = cell.inspCity.text!
            inspState = cell.inspState.text!
            inspZipStr = cell.inspZip.text!
            inspectionTypestr = cell.txt_InspectionType.text!
            insp_c_str = cell.inspCountryTxt.text!
            insp_add_str = cell.inspAdd2.text!
            
             typeAddInspFees = cell.typeOfAddInspFees.text!
            dateOfInspStr = cell.dateOfInsp.text!
            time = cell.time.text!
            
            yearBuild = cell.yearBuild.text!
            estimatedSqft = cell.estimatedSqft.text!
            unitsInsp = cell.unitsOfInsp.text!
            addInspUnits = cell.addUnitsOfInsp.text!
            weather = cell.weather.text!
            consType = cell.consType.text!
            structure = cell.stucture.text!
            bedroom = cell.bedroom.text!
            bathroomStr = cell.txt_bathroom.text!
            garageStr = cell.txt_Garage.text!
            temptureStr = cell.txt_tempture.text!
            noOfStoriesStr = cell.txt_noStories.text
            // inspCountryStr = cell.inspCountryTxt.text!
            // calender.reloadData()
            self.tableView1.beginUpdates()
            self.tableView1.endUpdates()
        }
        else // if indexPath.section == 3
        {
            
            guard let cell = tableView1.cellForRow(at: indexPath) as? ExpandableCellInspect1
                else { return }
            
            self.expandedRows.remove(indexPath.row)
            cell.largebl.backgroundColor = UIColor.clear
            cell.isExpanded4 = false
            
            
            invoice = cell.invoice.text!
            inspFees = cell.inspFees.text!
            addInspFees = cell.addInspFees.text!
           
            paymentTypeStr = cell.txtpaymentType.text!
            ispaymentdone =  cell.txt_Ispaymentdone.text!
            taxInfoStr = cell.txt_TaxInfo.text!
            
            self.tableView1.beginUpdates()
            self.tableView1.endUpdates()
        }
//        else
//        {
//            print("bceyfhb")
//        }
    }
    
    // MARK : KDCalendarDelegate
    
    func calendar(_ calendar: CalendarView, didSelectDate date : Date, withEvents events: [CalendarEvent]) {
        print("date=",date)
        
        //finalG = "F"
        
        dateAndTimeStr = "B"
        // initially set the format based on your datepicker date / server String
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        
        let myString = formatter.string(from: date) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        
        formatter.dateFormat = "EEE, MMM dd"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        
        print("MyDate",myStringafd)
        
        
        let formatter1 = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter1.dateFormat = "MM/dd/yyyy HH:mm:ss"
        
        let myString1 = formatter1.string(from: date) // string purpose I add here
        // convert your string to date
        let yourDate1 = formatter1.date(from: myString1)
        //then again set the date format whhich type of output you need
        
        formatter1.dateFormat = "YYYY"
        // again convert your date to string
        let myStringafd1 = formatter1.string(from: yourDate1!)
        
        print("MyDate1",myStringafd1)
        
        let formatter2 = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter2.dateFormat = "MM/dd/yyyyHH:mm:ss"
        
        let myString2 = formatter2.string(from: date) // string purpose I add here
        // convert your string to date
        let yourDate2 = formatter2.date(from: myString2)
        //then again set the date format whhich type of output you need
        
        formatter2.dateFormat = "MM/dd/yyyy"
        // again convert your date to string
        dateOfInspStr = formatter2.string(from: yourDate2!)
        dateLbl.text = dateOfInspStr
        
        print("MyDate2",dateOfInspStr!)
        
        
        
        
        
        print("Did Select: \(date) with \(events.count) events")
        for event in events
        {
            print("\t\"\(event.title)\" - Starting at:\(event.startDate)")
        }
        
    }
    
    func calendar(_ calendar: CalendarView, didScrollToMonth date : Date) {
        
        print("scrollDate",date)
        // self.datePicker.setDate(date, animated: true)
    }
    
    
    func calendar(_ calendar: CalendarView, didLongPressDate date : Date) {
        
        let alert = UIAlertController(title: "Create New Event", message: "Message", preferredStyle: .alert)
        
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Event Title"
        }
        
        let addEventAction = UIAlertAction(title: "Create", style: .default, handler: { (action) -> Void in
            let title = alert.textFields?.first?.text
            self.calendarView.addEvent(title!, date: date)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(addEventAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // MARK : Events
    
    @IBAction func onValueChange(_ picker : UIDatePicker) {
        //self.calendarView.setDisplayDate(picker.date, animated: true)
    }
    
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    
    @IBAction func nexBtnClick(_ sender: Any)
    {
        print("nextBtn")
        self.calendarView.goToNextMonth()
    }
    @IBAction func previousBtn(_ sender: Any)
    {
        self.calendarView.goToPreviousMonth()
    }
    @IBAction func cancleBtn(_ sender: Any)
    {
        hideViewCalender.isHidden = true
        calenderBtnHide.isHidden = true
        
    }
    @IBAction func okBtn(_ sender: Any)
    {
        hideViewCalender.isHidden = true
        calenderBtnHide.isHidden = true
        dateOfInspStr = dateLbl.text
        // print("date=",dateOfInspStr!)
        
        if dateAndTimeStr == "B"
        { let row = 0
            let indexPath = IndexPath(row: row, section:2)
            print("indexpathOkBtn",indexSec!)
            
            guard let cell = tableView1.cellForRow(at: indexPath) as? ExpandableCellInspect1
                else { return }
            
            cell.dateOfInsp.text = dateOfInspStr
            
        }
        else
        {
            
            let cell:ExpandableCellInspect1 = self.tableView1.dequeueReusableCell(withIdentifier: "ExpandableCellInspect1") as! ExpandableCellInspect1
            
            if indexSec == 2
            {
                let row = 0
                let indexPath = IndexPath(row: row, section:2)
                print("indexpathOkBtn",indexSec!)
                
                switch cell.isExpanded3
                {
                case true:
                    self.expandedRows.remove(indexPath.row)
                case false:
                    self.expandedRows.insert(indexPath.row)
                }
                
                cell.isExpanded3 = !cell.isExpanded3
                //self.tableView1.reloadSections(IndexSet(integer: indexSec as! IndexSet.Element), with: .none)
                self.tableView1.beginUpdates()
                self.tableView1.endUpdates()
                switch cell.isExpanded
                {
                case true:
                    self.expandedRows.remove(indexPath.row)
                case false:
                    self.expandedRows.remove(indexPath.row)
                }
                
            }
            else
            {
                
            }
        }
        
        
        
        dateAndTimeStr = ""
        
    }
    @IBAction func okTimeBtn(_ sender: Any)
    {
        timeView.isHidden = true
        calenderBtnHide.isHidden = true
        
        if dateAndTimeStr == "B"
        {
            let row = 0
            let indexPath = IndexPath(row: row, section:2)
            print("indexpathOkBtn",indexSec!)
            guard let cell = tableView1.cellForRow(at: indexPath) as? ExpandableCellInspect1
                else { return }
            
            cell.time.text = time
            
        }
        else
        {
            
            let row = 0
            let indexPath = IndexPath(row: row, section:2)
            print("indexpathOkBtn",indexSec!)
            let cell:ExpandableCellInspect1 = self.tableView1.dequeueReusableCell(withIdentifier: "ExpandableCellInspect1") as! ExpandableCellInspect1
            
            
            if indexSec == 2
            {
                
                switch cell.isExpanded3
                {
                case true:
                    self.expandedRows.remove(indexPath.row)
                case false:
                    self.expandedRows.insert(indexPath.row)
                }
                
                
                cell.isExpanded3 = !cell.isExpanded3
                
                self.tableView1.beginUpdates()
                self.tableView1.endUpdates()
                switch cell.isExpanded
                {
                case true:
                    self.expandedRows.remove(indexPath.row)
                case false:
                    self.expandedRows.remove(indexPath.row)
                }
                
            }
            else
            {
                
            }
        }
        dateAndTimeStr = ""
    }
    
    
    @IBAction func dateBtnAction(_ sender: Any)
    {
        hideViewCalender.isHidden = false
        calenderBtnHide.isHidden = false
        
        calender.dataSource=self
        
        calender.delegate=self
        calender.reloadData()
        
        
        calender.appearance.selectionColor=UIColor.clear
        calender.appearance.titleDefaultColor=UIColor.black
        
        self.view.endEditing(true)
        
        
        
        print(dateOfInspStr!)
        
        let formatter2 = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter2.dateFormat = "MM/dd/yyyy"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
        
        let dt1=formatter2.date(from: dateOfInspStr!)
        
        
        let date0: String = dateFormatter.string(from: dt1!)
        print(date0)
        
        
        
        let dtstr:Date = dateFormatter.date(from: date0)!
        print(dtstr)
        
        calender.select(dtstr)
        calender.appearance.selectionColor=UIColor(red: 68/255, green: 142/255, blue: 243/255, alpha: 1)
       
        dateLbl.text = dateOfInspStr
        
        
    }
    @IBAction func timeBtnAction(_ sender: Any)
    {
         self.view.endEditing(true)
        timeView.isHidden = false
        calenderBtnHide.isHidden = false
        timePicker.datePickerMode = UIDatePickerMode.time
        
        timePicker.addTarget(self, action: #selector(InspectVC.startTimeDiveChanged), for: UIControlEvents.valueChanged)
    }
    
    @IBAction func dateActionTxt(_ sender: Any)
    {
        
    }
    @objc func donePicker() {
        
        print ("Done")
        
    }
    @IBAction func dateb(_ sender: Any) {
        print("vghyg")
        hideViewCalender.isHidden = false
        calenderBtnHide.isHidden = false
    }
    @IBAction func selectStateBtn(_ sender: Any)
    {
        stateVIew.isHidden = false
        calenderBtnHide.isHidden = false
    }
    @IBAction func selectStateBtn2(_ sender: Any)
    {
        stateVIew2.isHidden = false
        calenderBtnHide.isHidden = false
    }
    @IBAction func hideBtnAction(_ sender: Any)
    {
        calenderBtnHide.isHidden = true
        hideViewCalender.isHidden = true
        stateVIew.isHidden = true
        timeView.isHidden = true
        stateVIew2.isHidden = true
        
    }
    
    @IBAction func okBtnState(_ sender: Any)
    {
        stateVIew.isHidden = true
        calenderBtnHide.isHidden = true
        //  dateOfInspStr = dateLbl.text
        // print("date=",dateOfInspStr!)
        
        if dateAndTimeStr == "B"
        { let row = 0
            let indexPath = IndexPath(row: row, section:2)
            
            //tableView1.reloadRows(at: [indexPath], with: .top)
            // print("indexpathOkBtn",indexSec!)
            
            guard let cell = tableView1.cellForRow(at: indexPath) as? ExpandableCellInspect1
                else { return }
            
            cell.inspState.text = inspState
            
            
            
        }
        else
        {
            
            
        }
        
        dateAndTimeStr = ""
        
    }
    @IBAction func okBtnState2(_ sender: Any)
    {
        stateVIew2.isHidden = true
        calenderBtnHide.isHidden = true
        if dateAndTimeStr == "B"
        {
            let row = 0
            let indexPath = IndexPath(row: row, section:0)
            // print("indexpathOkBtn",indexSec!)
            
            guard let cell = tableView1.cellForRow(at: indexPath) as? ExpandableCellInspect1
                else { return }
            
            cell.city.text = cityStr
            
            
        }
        else
        {
            
            let cell:ExpandableCellInspect1 = self.tableView1.dequeueReusableCell(withIdentifier: "ExpandableCellInspect1") as! ExpandableCellInspect1
            
            if indexSec == 0
            {
                let row = 0
                let indexPath = IndexPath(row: row, section:0)
                
                
                switch cell.isExpanded
                {
                case true:
                    self.expandedRows.remove(indexPath.row)
                case false:
                    self.expandedRows.insert(indexPath.row)
                }
                
                cell.isExpanded = !cell.isExpanded
                //self.tableView1.reloadSections(IndexSet(integer: indexSec as! IndexSet.Element), with: .none)
                self.tableView1.beginUpdates()
                self.tableView1.endUpdates()
                switch cell.isExpanded2
                {
                case true:
                    self.expandedRows.remove(indexPath.row)
                case false:
                    self.expandedRows.remove(indexPath.row)
                }
                
            }
            else
            {
                
            }
        }
        
        dateAndTimeStr = ""
        
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        calender.appearance.selectionColor=UIColor(red: 68/255, green: 142/255, blue: 243/255, alpha: 1)
        calender.appearance.titleDefaultColor=UIColor.black
        
        
        print(date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        //   dateFormatter.timeZone = NSTimeZone(name: "UTC")
        let date0: String? = dateFormatter.string(from: date)
        print(date0)
        
        
        let formatter2 = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter2.dateFormat = "MM/dd/yyyy"
        
        let myString2 = formatter2.string(from: date) // string purpose I add here
        // convert your string to date
        let yourDate2 = formatter2.date(from: myString2)
        //then again set the date format whhich type of output you need
        
        
        print(myString2)
        formatter2.dateFormat = "MM/dd/yyyy"
        // again convert your date to string
        //    dateOfInspStr = formatter2.string(from: yourDate2!)
        dateLbl.text = formatter2.string(from: yourDate2!)
        
        print("MyDate2",dateOfInspStr!)
        
        dateAndTimeStr = "B"
    }
    
    func testFormat(sourcePhoneNumber: String) -> String {
        if let formattedPhoneNumber = format(phoneNumber: sourcePhoneNumber) {
            return "'\(sourcePhoneNumber)' => '\(formattedPhoneNumber)'"
        }
        else {
            return "'\(sourcePhoneNumber)' => nil"
        }
    }
    func format(phoneNumber sourcePhoneNumber: String) -> String? {
        
        // Remove any character that is not a number
        let numbersOnly = sourcePhoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let length = numbersOnly.characters.count
        let hasLeadingOne = numbersOnly.hasPrefix("1")
        
        // Check for supported phone number length
        guard length == 7 || length == 10 || (length == 11 && hasLeadingOne) else {
            return nil
        }
        
        let hasAreaCode = (length >= 10)
        var sourceIndex = 0
        
        // Leading 1
        var leadingOne = ""
        if hasLeadingOne {
            leadingOne = "1 "
            sourceIndex += 1
        }
        
        // Area code
        var areaCode = ""
        if hasAreaCode {
            let areaCodeLength = 3
            guard let areaCodeSubstring = numbersOnly.characters.substring(start: sourceIndex, offsetBy: areaCodeLength) else {
                return nil
            }
            areaCode = String(format: "(%@) ", areaCodeSubstring)
            sourceIndex += areaCodeLength
        }
        
        // Prefix, 3 characters
        let prefixLength = 3
        guard let prefix = numbersOnly.characters.substring(start: sourceIndex, offsetBy: prefixLength) else {
            return nil
        }
        sourceIndex += prefixLength
        
        // Suffix, 4 characters
        let suffixLength = 4
        guard let suffix = numbersOnly.characters.substring(start: sourceIndex, offsetBy: suffixLength) else {
            return nil
        }
        
        return leadingOne + areaCode + prefix + "-" + suffix
    }
    
    private func formattedNumber(number: String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "(XXX) XXX-XXXX"
        
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask {
            if index == cleanPhoneNumber.endIndex {
                break
            }
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}
extension String.CharacterView {
    /// This method makes it easier extract a substring by character index where a character is viewed as a human-readable character (grapheme cluster).
    internal func substring(start: Int, offsetBy: Int) -> String? {
        guard let substringStartIndex = self.index(startIndex, offsetBy: start, limitedBy: endIndex) else {
            return nil
        }
        
        guard let substringEndIndex = self.index(startIndex, offsetBy: start + offsetBy, limitedBy: endIndex) else {
            return nil
        }
        
        return String(self[substringStartIndex ..< substringEndIndex])
    }
}
@available(iOS 10.0, *)
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

