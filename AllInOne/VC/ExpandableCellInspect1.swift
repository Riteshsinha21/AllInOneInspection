//
//  ExpandableCellInspect1.swift
//  AllInOne
//
//  Created by Apple on 11/13/18.
//  Copyright © 2018 mac08. All rights reserved.
//

import UIKit
import MaterialComponents

class ExpandableCellInspect1: UITableViewCell,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource
{
    
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var firstName: MDCTextField!
    @IBOutlet weak var lastName: MDCTextField!
    @IBOutlet weak var phoneNo: MDCTextField!
    @IBOutlet weak var address: MDCTextField!
    @IBOutlet weak var city: MDCTextField!
    @IBOutlet weak var email: MDCTextField!
    @IBOutlet weak var lblTxt: UILabel!
    @IBOutlet weak var largebl: UILabel!
    @IBOutlet weak var buyerFirstName: MDCTextField!
    @IBOutlet weak var buyerLastName: MDCTextField!
    @IBOutlet weak var buyerPhoneNo: MDCTextField!
    @IBOutlet weak var buyerEmail: MDCTextField!
    @IBOutlet weak var buyerOffice: MDCTextField!
    @IBOutlet weak var listingFrstName: MDCTextField!
    @IBOutlet weak var listingLastName: MDCTextField!
    @IBOutlet weak var listingOffice: MDCTextField!
    @IBOutlet weak var listingEmail: MDCTextField!
    @IBOutlet weak var listingPhoneNo: MDCTextField!
    @IBOutlet weak var inspAdd: MDCTextField!
    @IBOutlet weak var inspCity: MDCTextField!
    @IBOutlet weak var inspState: MDCTextField!
    @IBOutlet weak var inspZip: MDCTextField!
    @IBOutlet weak var dateOfInsp: MDCTextField!
    @IBOutlet weak var time: MDCTextField!
   
    @IBOutlet weak var yearBuild: MDCTextField!
    @IBOutlet weak var estimatedSqft: MDCTextField!
    @IBOutlet weak var unitsOfInsp: MDCTextField!
    @IBOutlet weak var addUnitsOfInsp: MDCTextField!
    @IBOutlet weak var weather: MDCTextField!
    @IBOutlet weak var consType: MDCTextField!
    @IBOutlet weak var stucture: MDCTextField!
    @IBOutlet weak var bedroom: MDCTextField!
    @IBOutlet weak var inspBy: MDCTextField!
    @IBOutlet weak var yourCompPhnNo: MDCTextField!
    @IBOutlet weak var yourCompAdd: MDCTextField!
    @IBOutlet weak var address1: MDCTextField!
    @IBOutlet weak var yourCompEmail: MDCTextField!
    @IBOutlet weak var yourCompWebsite: MDCTextField!
    @IBOutlet weak var c_zipTxt: MDCTextField!
    @IBOutlet weak var c_cityTxt: MDCTextField!
    @IBOutlet weak var address2: MDCTextField!
    @IBOutlet weak var inspAdd2: MDCTextField!
    @IBOutlet weak var inspCountryTxt: MDCTextField!
    @IBOutlet weak var c_countryTxt: MDCTextField!
    @IBOutlet weak var txt_bathroom: MDCTextField!
    @IBOutlet weak var txt_Garage: MDCTextField!
     @IBOutlet weak var txt_tempture: MDCTextField!
    @IBOutlet weak var txt_InspectionType: MDCTextField!
    @IBOutlet weak var txt_Ispaymentdone: MDCTextField!
    
    @IBOutlet weak var txt_noStories: MDCTextField!
    
    @IBOutlet weak var invoice: MDCTextField!
    @IBOutlet weak var inspFees: MDCTextField!
    @IBOutlet weak var addInspFees: MDCTextField!
    @IBOutlet weak var typeOfAddInspFees: MDCTextField!
     @IBOutlet weak var txtpaymentType: MDCTextField!
     @IBOutlet weak var txt_TaxInfo: MDCTextField!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    let tb1 = UITableView()
    
    var FromWhere = ""
    var SearchFlag :Bool = false;
    var searchResultArr :[String] = []
    var NewStr:String = ""
    
    @IBOutlet weak var imgHeightConstraint: NSLayoutConstraint!
    
    var firstNameTextFieldController: MDCTextInputControllerUnderline!
    var lastNameTextFieldController: MDCTextInputControllerUnderline!
    var phoneNoTextFieldController: MDCTextInputControllerUnderline!
    var addressTextFieldController: MDCTextInputControllerUnderline!
    var cityTextFieldController: MDCTextInputControllerUnderline!
    var stateTextFieldController: MDCTextInputControllerUnderline!
    var emailTextFieldController: MDCTextInputControllerUnderline!
    var addressLine2: MDCTextInputControllerUnderline!
    var clienCity2: MDCTextInputControllerUnderline!
    var clientZip: MDCTextInputControllerUnderline!
    var clientCountry: MDCTextInputControllerUnderline!
  
    
    //view2..
    var buyerfname: MDCTextInputControllerUnderline!
    var buyerlname: MDCTextInputControllerUnderline!
    var buyeroff: MDCTextInputControllerUnderline!
    var listingemail: MDCTextInputControllerUnderline!
    var listingfname: MDCTextInputControllerUnderline!
    var listinglname: MDCTextInputControllerUnderline!
    var buyerphno: MDCTextInputControllerUnderline!
    var buyeremail: MDCTextInputControllerUnderline!
    var listingoff: MDCTextInputControllerUnderline!
    var listingphno: MDCTextInputControllerUnderline!
   
    //view3...
    var inspzip: MDCTextInputControllerUnderline!
    var inspcity: MDCTextInputControllerUnderline!
    var inspfees: MDCTextInputControllerUnderline!
    var invoice2: MDCTextInputControllerUnderline!
    var inspstate: MDCTextInputControllerUnderline!
    var inspadd: MDCTextInputControllerUnderline!
    var time2: MDCTextInputControllerUnderline!
    var addinspfees: MDCTextInputControllerUnderline!
    var typeofaddinspfees: MDCTextInputControllerUnderline!
    var yrbuild: MDCTextInputControllerUnderline!
    var essqft: MDCTextInputControllerUnderline!
    var addunitsinsp: MDCTextInputControllerUnderline!
    var date2: MDCTextInputControllerUnderline!
    var weather2: MDCTextInputControllerUnderline!
    var unitsinsp: MDCTextInputControllerUnderline!
    var constype2: MDCTextInputControllerUnderline!
    var structure2: MDCTextInputControllerUnderline!
    var bedroom2: MDCTextInputControllerUnderline!
    var bathrooms: MDCTextInputControllerUnderline!
    var garage: MDCTextInputControllerUnderline!
    var tempture: MDCTextInputControllerUnderline!
    var inspAddressLine2: MDCTextInputControllerUnderline!
    var inspCountry2: MDCTextInputControllerUnderline!
    
    var noOfstories: MDCTextInputControllerUnderline!
    
    var inspecttypeline: MDCTextInputControllerUnderline!
    var amountPaidline: MDCTextInputControllerUnderline!
    var paymentmethodLine: MDCTextInputControllerUnderline!
     var ispaymentdoneLine: MDCTextInputControllerUnderline!
    var taxLine: MDCTextInputControllerUnderline!
  
   var maxLength : Int = 13
    var InspectionTypeArray = ["Home inspection","Commercial Inspection","Warranty Inspection","WDO","Wind mitigation","4 point inspection","1 year warranty inspection","Thermal Imaging","Pre listing seller inspection","Shop and Talk inspection"]
    var weatherArray = ["Clear","Cloudy","Heavy Rain","Light Rain","Partly Cloudy","Rain","Snow"]
    var StructureArray = ["Manufactured Home","Modular Home","Single Family","Single Family/Condo","Single Family/Townhouse","Single Family/Two Story","Single Family/Single Story","Terraced Home (Townhouse)"]
    var BedRoomsArray = ["0","1","2","3","4","5","6","7","8","9","10"]
    var ConstypeArray = ["CBS/Frame","Frame","CBS"]
    var inputArray = [""]
    var paymentMethod = ["Check","Cash","Credit card /Debit card","Money order"]
    var ispaymentdone = ["Yes","No"]
    var tempArray = ["5 Degrees","50 Degrees","55 Degrees","60 Degrees","65 Degrees","70 Degrees","75 Degrees","80 Degrees","85 Degrees","90 Degrees","95 Degrees"]
    var isExpanded:Bool = false
    {
        didSet
        {
            if !isExpanded {
                self.imgHeightConstraint.constant = 0.0
                
            } else
            {
                
                self.imgHeightConstraint.constant = 750.0
            }
        }
    }
    var isExpanded2:Bool = false
    {
        didSet
        {
            if !isExpanded2 {
                self.imgHeightConstraint.constant = 0.0
                
            } else
            {
                
                self.imgHeightConstraint.constant = 720.0
            }
        }
    }
    var isExpanded3:Bool = false
    {
        didSet
        {
            if !isExpanded3 {
                self.imgHeightConstraint.constant = 0.0
                
            } else
            {
                if UIDevice.current.userInterfaceIdiom == .phone

                {
                   self.imgHeightConstraint.constant = 1650.0
                }
                else{
                    self.imgHeightConstraint.constant = 1760.0
                }
                
            }
        }
        
    }
    var isExpanded4:Bool = false
    {
        didSet
        {
            if !isExpanded4 {
                self.imgHeightConstraint.constant = 0.0
                
            } else
            {
                
                self.imgHeightConstraint.constant = 500
            }
        }
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        print("shouldChangeCharactersIn")
        //For mobile numer validation
        UserDefaults.standard.set(true, forKey: "SaveChangesOrNot")
        
        if textField == buyerPhoneNo   {
            
            
            if (buyerPhoneNo.text?.count)! <= 13
            {
                let allowedCharacters = CharacterSet(charactersIn:"+0123456789")//Here change this characters based on your requirement
                let characterSet = CharacterSet(charactersIn: string)
               buyerphoneNo = formattedNumber(number: buyerPhoneNo.text!)
                buyerPhoneNo.text = buyerphoneNo
                return allowedCharacters.isSuperset(of: characterSet)
                
                
                    // cell.listingPhoneNo.text = formattedNumber(number: listingPhoneNo!)
               
            }
            else
            {
                let currentString: NSString = buyerPhoneNo.text! as NSString
                let newString: NSString =
                    currentString.replacingCharacters(in: range, with: string) as NSString
                return newString.length <= maxLength
                
            }
            
        }else if textField == listingPhoneNo   {
            
            
            
            if (listingPhoneNo.text?.count)! <= 13
            {
                let allowedCharacters = CharacterSet(charactersIn:"+0123456789")//Here change this characters based on your requirement
                let characterSet = CharacterSet(charactersIn: string)
              listingPhoneNo1 = formattedNumber(number: listingPhoneNo.text!)
                  listingPhoneNo.text = listingPhoneNo1
                return allowedCharacters.isSuperset(of: characterSet)
                
                
                // cell.listingPhoneNo.text = formattedNumber(number: listingPhoneNo!)
                
            }
            else
            {
                let currentString: NSString = listingPhoneNo.text! as NSString
                let newString: NSString =
                    currentString.replacingCharacters(in: range, with: string) as NSString
                return newString.length <= maxLength
                
            }
            
        }else if textField == address
        {
            inspAdd.text = address.text
        }
        else if textField == phoneNo   {
            
            if (phoneNo.text?.count)! <= 13
            {
                
                let allowedCharacters = CharacterSet(charactersIn:"+0123456789")//Here change this characters based on your requirement
                let characterSet = CharacterSet(charactersIn: string)
              phoneNoStr = formattedNumber(number: phoneNo.text!)
                 phoneNo.text = phoneNoStr
                return allowedCharacters.isSuperset(of: characterSet)
            }
            else
            {
                let currentString: NSString = phoneNo.text! as NSString
                let newString: NSString =
                    currentString.replacingCharacters(in: range, with: string) as NSString
                return newString.length <= maxLength
            }
            

        }
        else if textField == email
        {
          
            let charset = CharacterSet(charactersIn: "@")
            
            if let _ = email.text!.rangeOfCharacter(from: charset, options: .caseInsensitive) {
                print("yes")
            }
            else {
                print("no")
            }
                // print("validate calendar: \(testStr)")
//                let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//
//                let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//                return emailTest.evaluate(with: email.text)
            
        }else if(textField == txt_InspectionType)
        {
            
            print(textField.text!)
            if(string == ",")
            {
                searchResultArr.removeAll()
                if(textField.text?.count == 0)
                {
                    tb1.isHidden = true;
                    SearchFlag = false;
                    tb1.reloadData()
                    return false;
                    
                }
                else
                {
                    tb1.isHidden = false;
                    SearchFlag = false;
                    tb1.reloadData()
                    return true;
                }
                
            }
            else
            {
                SearchFlag = true;
                var searchStr :String = "";
                searchStr = textField.text! + string;
                let keysArray :[String] = searchStr.components(separatedBy: ",")
                
                if(keysArray.count > 0)
                {
                    
                    searchStr = keysArray.last!
                }
                
                
                searchResultArr = inputArray.filter { item in
                    return item.lowercased().contains(searchStr.lowercased())
                }
                
                if searchResultArr.count == 0
                {
                    tb1.isHidden = true
                    print("hidden")
                }else{
                    tb1.isHidden = false
                    print(" Not hidden")
                }
                tb1.reloadData()
                print("djalj",inputArray)
                print("searchResultArr ",searchResultArr)
                // tb1.isHidden = true;
            }
        }
        else if(textField == weather)
        {
           
            print(textField.text!)
            if(string == ",")
            {
              searchResultArr.removeAll()
              if(textField.text?.count == 0)
              {
                tb1.isHidden = true;
                SearchFlag = false;
                tb1.reloadData()
                return false;
                
              }
              else
              {
                tb1.isHidden = false;
                SearchFlag = false;
                tb1.reloadData()
                return true;
              }
                
            }
            else
            {
                 SearchFlag = true;
                var searchStr :String = "";
                searchStr = textField.text! + string;
                let keysArray :[String] = searchStr.components(separatedBy: ",")

                if(keysArray.count > 0)
                {
                    
                    searchStr = keysArray.last!
                }
                
                
                searchResultArr = inputArray.filter { item in
                    return item.lowercased().contains(searchStr.lowercased())
                }
                
                if searchResultArr.count == 0
                {
                    tb1.isHidden = true
                    print("hidden")
                }else{
                    tb1.isHidden = false
                    print(" Not hidden")
                }
                tb1.reloadData()
                print("djalj",inputArray)
                print("searchResultArr ",searchResultArr)
               // tb1.isHidden = true;
            }
        }else if(textField == consType)
        {
            
            print(textField.text!)
            if(string == ",")
            {
                searchResultArr.removeAll()
                if(textField.text?.count == 0)
                {
                    tb1.isHidden = true;
                    SearchFlag = false;
                    tb1.reloadData()
                    return false;
                    
                }
                else
                {
                    tb1.isHidden = false;
                    SearchFlag = false;
                    tb1.reloadData()
                    return true;
                }
                
            }
            else
            {
                SearchFlag = true;
                var searchStr :String = "";
                searchStr = textField.text! + string;
                let keysArray :[String] = searchStr.components(separatedBy: ",")
                
                if(keysArray.count > 0)
                {
                    
                    searchStr = keysArray.last!
                }
                
                
                searchResultArr = inputArray.filter { item in
                    return item.lowercased().contains(searchStr.lowercased())
                }
                if searchResultArr.count == 0
                {
                    tb1.isHidden = true
                    print("hidden")
                }else{
                    tb1.isHidden = false
                    print(" Not hidden")
                }
                tb1.reloadData()
                print("djalj",inputArray)
                print("searchResultArr ",searchResultArr)
                // tb1.isHidden = true;
            }
        }else if(textField == stucture)
        {
            
            print(textField.text!)
            if(string == ",")
            {
                searchResultArr.removeAll()
                if(textField.text?.count == 0)
                {
                    tb1.isHidden = true;
                    SearchFlag = false;
                    tb1.reloadData()
                    return false;
                    
                }
                else
                {
                    tb1.isHidden = false;
                    SearchFlag = false;
                    tb1.reloadData()
                    return true;
                }
                
            }
            else
            {
                SearchFlag = true;
                var searchStr :String = "";
                searchStr = textField.text! + string;
                let keysArray :[String] = searchStr.components(separatedBy: ",")
                
                if(keysArray.count > 0)
                {
                    
                    searchStr = keysArray.last!
                }
                
                
                searchResultArr = inputArray.filter { item in
                    return item.lowercased().contains(searchStr.lowercased())
                }
                if searchResultArr.count == 0
                {
                    tb1.isHidden = true
                    print("hidden")
                }else{
                    tb1.isHidden = false
                    print(" Not hidden")
                }
                tb1.reloadData()
                print("djalj",inputArray)
                print("searchResultArr ",searchResultArr)
                // tb1.isHidden = true;
            }
        }
        else if(textField == bedroom)
        {
            
            print(textField.text!)
            if(string == ",")
            {
                searchResultArr.removeAll()
                if(textField.text?.count == 0)
                {
                    tb1.isHidden = true;
                    SearchFlag = false;
                    tb1.reloadData()
                    return false;
                    
                }
                else
                {
                    tb1.isHidden = false;
                    SearchFlag = false;
                    tb1.reloadData()
                    return true;
                }
            }
            else
            {
                SearchFlag = true;
                var searchStr :String = "";
                searchStr = textField.text! + string;
                let keysArray :[String] = searchStr.components(separatedBy: ",")
                
                if(keysArray.count > 0)
                {
                    
                    searchStr = keysArray.last!
                }
                
                
                searchResultArr = inputArray.filter { item in
                    return item.lowercased().contains(searchStr.lowercased())
                }
                if searchResultArr.count == 0
                {
                    tb1.isHidden = true
                    print("hidden")
                }else{
                    tb1.isHidden = false
                    print(" Not hidden")
                }
                tb1.reloadData()
                print("djalj",inputArray)
                print("searchResultArr ",searchResultArr)
                // tb1.isHidden = true;
            }
        }
        return true
    }
    @objc func tapEdit(recognizer: UITapGestureRecognizer)  {
        if recognizer.state == UIGestureRecognizerState.ended {
            let tapLocation = recognizer.location(in: self.tb1)
            if let tapIndexPath = self.tb1.indexPathForRow(at: tapLocation) {
                print(tapIndexPath)
                print(inputArray[tapIndexPath.row])
                if(FromWhere == "InspectionType")
                {
                    var searchStr :String = "";
                    searchStr = self.txt_InspectionType.text!
                    let keysArray :[String] = searchStr.components(separatedBy: ",")
                    if(keysArray.count > 0)
                    {
                        NewStr = ""
                        for i in 0..<(keysArray.count-1)
                        {
                            if( NewStr != "")
                            {
                                NewStr =  NewStr +  keysArray[i] + ","
                            }else{
                                NewStr =  keysArray[i] + ","
                            }
                            
                            print(i)
                        }
                        
                        
                        if(self.SearchFlag)
                        {
                            if( NewStr != "")
                            {
                                let lastChar = NewStr.last!
                                if(lastChar == ",")
                                {
                                    NewStr = String(NewStr.dropLast())
                                }
                                
                                self.txt_InspectionType.text = searchResultArr[tapIndexPath.row]
                            }
                            else
                            {
                              
                                self.txt_InspectionType.text =  searchResultArr[tapIndexPath.row]
                            }
                            
                        }
                        else
                        {
                            if( NewStr != "")
                            {
                                
                                self.txt_InspectionType.text = inputArray[tapIndexPath.row]
                            }
                            else
                            {
                               
                                self.txt_InspectionType.text =  inputArray[tapIndexPath.row]
                            }
                        }
                        self.SearchFlag = false;
                    }
                    else
                    {
                        if(self.SearchFlag)
                        {
                           
                            self.txt_InspectionType.text =  searchResultArr[tapIndexPath.row]
                        }
                        else
                        {
                            
                            self.txt_InspectionType.text =  inputArray[tapIndexPath.row]
                        }
                        self.SearchFlag = false;
                    }
                    
                   
                    tb1.isHidden = true
                    self.SearchFlag = false;
                    self.view3.endEditing(true)
                }
                
                else if(FromWhere == "weather")
                {
                    var searchStr :String = "";
                    searchStr = self.weather.text!
                    let keysArray :[String] = searchStr.components(separatedBy: ",")
                    if(keysArray.count > 0)
                    {
                        NewStr = ""
                            for i in 0..<(keysArray.count-1)
                            {
                                if( NewStr != "")
                                {
                                     NewStr =  NewStr +  keysArray[i] + ","
                                }else{
                                    NewStr =  keysArray[i] + ","
                                }

                                print(i)
                            }
                     
                        
                        if(self.SearchFlag)
                        {
                            if( NewStr != "")
                            {
                                let lastChar = NewStr.last!
                                if(lastChar == ",")
                                {
                                    NewStr = String(NewStr.dropLast())
                                }
                                //self.weather.text = NewStr + ", " + searchResultArr[tapIndexPath.row] + ","
                                self.weather.text = searchResultArr[tapIndexPath.row]
                            }
                            else
                            {
                               // self.weather.text =  searchResultArr[tapIndexPath.row] + ","
                                 self.weather.text =  searchResultArr[tapIndexPath.row]
                            }
                           
                        }
                        else
                        {
                            if( NewStr != "")
                            {
                               //self.weather.text = NewStr + inputArray[tapIndexPath.row] + ","
                                self.weather.text = inputArray[tapIndexPath.row]
                            }
                            else
                            {
                                 //self.weather.text =  inputArray[tapIndexPath.row] + ","
                                self.weather.text =  inputArray[tapIndexPath.row]
                            }
                        }
                        self.SearchFlag = false;
                    }
                    else
                    {
                        if(self.SearchFlag)
                        {
                            //self.weather.text =  searchResultArr[tapIndexPath.row]
                            self.weather.text =  searchResultArr[tapIndexPath.row]
                        }
                        else
                        {
                            //self.weather.text = inputArray[tapIndexPath.row]
                            self.weather.text =  inputArray[tapIndexPath.row]
                        }
                        self.SearchFlag = false;
                    }
                    
                   // self.weather.text = self.weather.text! + inputArray[tapIndexPath.row] + ","
                    tb1.isHidden = true
                    self.SearchFlag = false;
                    self.view3.endEditing(true)
                }else if(FromWhere == "consType")
                {
                    
                    var searchStr :String = "";
                    searchStr = self.consType.text!
                    let keysArray :[String] = searchStr.components(separatedBy: ",")
                    if(keysArray.count > 0)
                    {
                        NewStr = ""
                        for i in 0..<(keysArray.count-1)
                        {
                            if( NewStr != "")
                            {
                                NewStr =  NewStr +  keysArray[i] + ","
                            }else{
                                NewStr =  keysArray[i] + ","
                            }
                            
                            print(i)
                        }
                        
                        
                        if(self.SearchFlag)
                        {
                            if( NewStr != "")
                            {
                                let lastChar = NewStr.last!
                                if(lastChar == ",")
                                {
                                    NewStr = String(NewStr.dropLast())
                                }
                               // self.consType.text = NewStr + ", " + searchResultArr[tapIndexPath.row] + ","
                                 self.consType.text = searchResultArr[tapIndexPath.row]
                            }
                            else
                            {
                              //  self.consType.text =  searchResultArr[tapIndexPath.row] + ","
                                  self.consType.text =  searchResultArr[tapIndexPath.row]
                            }
                            
                        }
                        else
                        {
                            if( NewStr != "")
                            {
                                //self.consType.text = NewStr + inputArray[tapIndexPath.row] + ","
                                self.consType.text =  inputArray[tapIndexPath.row]
                            }
                            else
                            {
                                //self.consType.text =  inputArray[tapIndexPath.row] + ","
                                self.consType.text =  inputArray[tapIndexPath.row]
                            }
                        }
                        self.SearchFlag = false;
                    }
                    else
                    {
                        if(self.SearchFlag)
                        {
                            self.consType.text =  searchResultArr[tapIndexPath.row]
                        }
                        else
                        {
                            self.consType.text = inputArray[tapIndexPath.row]
                        }
                        self.SearchFlag = false;
                    }
                    
                    
                    tb1.isHidden = true
                    self.SearchFlag = false;
                    self.view3.endEditing(true)
                    
                    
                }else if(FromWhere == "stucture")
                {
                    var searchStr :String = "";
                    searchStr = self.stucture.text!
                    let keysArray :[String] = searchStr.components(separatedBy: ",")
                    if(keysArray.count > 0)
                    {
                        NewStr = ""
                        for i in 0..<(keysArray.count-1)
                        {
                            if( NewStr != "")
                            {
                                NewStr =  NewStr +  keysArray[i] + ","
                            }else{
                                NewStr =  keysArray[i] + ","
                            }
                            
                            print(i)
                        }
                        
                        
                        if(self.SearchFlag)
                        {
                            if( NewStr != "")
                            {
                                let lastChar = NewStr.last!
                                if(lastChar == ",")
                                {
                                    NewStr = String(NewStr.dropLast())
                                }
                                //self.stucture.text = NewStr + ", " + searchResultArr[tapIndexPath.row] + ","
                                self.stucture.text =  searchResultArr[tapIndexPath.row]
                            }
                            else
                            {
                                //self.stucture.text =  searchResultArr[tapIndexPath.row] + ","
                                self.stucture.text =  searchResultArr[tapIndexPath.row]
                            }
                            
                        }
                        else
                        {
                            if( NewStr != "")
                            {
                                //self.stucture.text = NewStr + inputArray[tapIndexPath.row] + ","
                                self.stucture.text =  inputArray[tapIndexPath.row]
                            }
                            else
                            {
                                //self.stucture.text =  inputArray[tapIndexPath.row] + ","
                                self.stucture.text =  inputArray[tapIndexPath.row]
                            }
                        }
                        self.SearchFlag = false;
                    }
                    else
                    {
                        if(self.SearchFlag)
                        {
                            self.stucture.text =  searchResultArr[tapIndexPath.row]
                        }
                        else
                        {
                            self.stucture.text = inputArray[tapIndexPath.row]
                        }
                        self.SearchFlag = false;
                    }
                    
                    
                    tb1.isHidden = true
                    self.SearchFlag = false;
                    self.view3.endEditing(true)
                }
                else if(FromWhere == "bedroom")
                {
                    
                    var searchStr :String = "";
                    searchStr = self.bedroom.text!
                    let keysArray :[String] = searchStr.components(separatedBy: ",")
                    if(keysArray.count > 0)
                    {
                        NewStr = ""
                        for i in 0..<(keysArray.count-1)
                        {
                            if( NewStr != "")
                            {
                                NewStr =  NewStr +  keysArray[i] + ","
                            }else{
                                NewStr =  keysArray[i] + ","
                            }
                            
                            print(i)
                        }
                        
                        
                        if(self.SearchFlag)
                        {
                            if( NewStr != "")
                            {
                                let lastChar = NewStr.last!
                                if(lastChar == ",")
                                {
                                    NewStr = String(NewStr.dropLast())
                                }
                                //self.bedroom.text = NewStr + ", " + searchResultArr[tapIndexPath.row] + ","
                                self.bedroom.text =  searchResultArr[tapIndexPath.row]
                            }
                            else
                            {
                              //  self.bedroom.text =  searchResultArr[tapIndexPath.row] + ","
                                 self.bedroom.text =  searchResultArr[tapIndexPath.row]
                            }
                            
                        }
                        else
                        {
                            if( NewStr != "")
                            {
                                //self.bedroom.text = NewStr + inputArray[tapIndexPath.row] + ","
                                 self.bedroom.text =  inputArray[tapIndexPath.row]
                            }
                            else
                            {
                                //self.bedroom.text =  inputArray[tapIndexPath.row] + ","
                                self.bedroom.text =  inputArray[tapIndexPath.row]
                            }
                        }
                        self.SearchFlag = false;
                    }
                    else
                    {
                        if(self.SearchFlag)
                        {
                            self.bedroom.text =  searchResultArr[tapIndexPath.row]
                        }
                        else
                        {
                            self.bedroom.text = inputArray[tapIndexPath.row]
                        }
                        self.SearchFlag = false;
                    }
                    
                    
                    tb1.isHidden = true
                    self.SearchFlag = false;
                    self.view3.endEditing(true)
                }
                else if(FromWhere == "Tempture")
                {
                    
                    var searchStr :String = "";
                    searchStr = self.txt_tempture.text!
                    let keysArray :[String] = searchStr.components(separatedBy: ",")
                    if(keysArray.count > 0)
                    {
                        NewStr = ""
                        for i in 0..<(keysArray.count-1)
                        {
                            if( NewStr != "")
                            {
                                NewStr =  NewStr +  keysArray[i] + ","
                            }else{
                                NewStr =  keysArray[i] + ","
                            }
                            
                            print(i)
                        }
                        
                        
                        if(self.SearchFlag)
                        {
                            if( NewStr != "")
                            {
                                let lastChar = NewStr.last!
                                if(lastChar == ",")
                                {
                                    NewStr = String(NewStr.dropLast())
                                }
                                //self.bedroom.text = NewStr + ", " + searchResultArr[tapIndexPath.row] + ","
                                self.txt_tempture.text =  searchResultArr[tapIndexPath.row]
                            }
                            else
                            {
                                //  self.bedroom.text =  searchResultArr[tapIndexPath.row] + ","
                                self.txt_tempture.text  =  searchResultArr[tapIndexPath.row]
                            }
                            
                        }
                        else
                        {
                            if( NewStr != "")
                            {
                                //self.bedroom.text = NewStr + inputArray[tapIndexPath.row] + ","
                                self.txt_tempture.text  =  inputArray[tapIndexPath.row]
                            }
                            else
                            {
                                //self.bedroom.text =  inputArray[tapIndexPath.row] + ","
                                self.txt_tempture.text  =  inputArray[tapIndexPath.row]
                            }
                        }
                        self.SearchFlag = false;
                    }
                    else
                    {
                        if(self.SearchFlag)
                        {
                            self.txt_tempture.text  =  searchResultArr[tapIndexPath.row]
                        }
                        else
                        {
                            self.txt_tempture.text  = inputArray[tapIndexPath.row]
                        }
                        self.SearchFlag = false;
                    }
                    
                    
                    tb1.isHidden = true
                    self.SearchFlag = false;
                    self.view3.endEditing(true)
                }
                else if(FromWhere == "Garage")
                {
                    
                    var searchStr :String = "";
                    searchStr = self.txt_Garage.text!
                    let keysArray :[String] = searchStr.components(separatedBy: ",")
                    if(keysArray.count > 0)
                    {
                        NewStr = ""
                        for i in 0..<(keysArray.count-1)
                        {
                            if( NewStr != "")
                            {
                                NewStr =  NewStr +  keysArray[i] + ","
                            }else{
                                NewStr =  keysArray[i] + ","
                            }
                            
                            print(i)
                        }
                        
                        
                        if(self.SearchFlag)
                        {
                            if( NewStr != "")
                            {
                                let lastChar = NewStr.last!
                                if(lastChar == ",")
                                {
                                    NewStr = String(NewStr.dropLast())
                                }
                                //self.bedroom.text = NewStr + ", " + searchResultArr[tapIndexPath.row] + ","
                                self.txt_Garage.text =  searchResultArr[tapIndexPath.row]
                            }
                            else
                            {
                                //  self.bedroom.text =  searchResultArr[tapIndexPath.row] + ","
                                self.txt_Garage.text =  searchResultArr[tapIndexPath.row]
                            }
                            
                        }
                        else
                        {
                            if( NewStr != "")
                            {
                                //self.bedroom.text = NewStr + inputArray[tapIndexPath.row] + ","
                                self.txt_Garage.text =  inputArray[tapIndexPath.row]
                            }
                            else
                            {
                                //self.bedroom.text =  inputArray[tapIndexPath.row] + ","
                                self.txt_Garage.text =  inputArray[tapIndexPath.row]
                            }
                        }
                        self.SearchFlag = false;
                    }
                    else
                    {
                        if(self.SearchFlag)
                        {
                            self.txt_Garage.text =  searchResultArr[tapIndexPath.row]
                        }
                        else
                        {
                            self.txt_Garage.text = inputArray[tapIndexPath.row]
                        }
                        self.SearchFlag = false;
                    }
                    
                    
                    tb1.isHidden = true
                    self.SearchFlag = false;
                    self.view3.endEditing(true)
                }
                else if(FromWhere == "bathroom")
                {
                    
                    var searchStr :String = "";
                    searchStr = self.txt_bathroom.text!
                    let keysArray :[String] = searchStr.components(separatedBy: ",")
                    if(keysArray.count > 0)
                    {
                        NewStr = ""
                        for i in 0..<(keysArray.count-1)
                        {
                            if( NewStr != "")
                            {
                                NewStr =  NewStr +  keysArray[i] + ","
                            }else{
                                NewStr =  keysArray[i] + ","
                            }
                            
                            print(i)
                        }
                        
                        
                        if(self.SearchFlag)
                        {
                            if( NewStr != "")
                            {
                                let lastChar = NewStr.last!
                                if(lastChar == ",")
                                {
                                    NewStr = String(NewStr.dropLast())
                                }
                                //self.bedroom.text = NewStr + ", " + searchResultArr[tapIndexPath.row] + ","
                                self.txt_bathroom.text =  searchResultArr[tapIndexPath.row]
                            }
                            else
                            {
                                //  self.bedroom.text =  searchResultArr[tapIndexPath.row] + ","
                                self.txt_bathroom.text =  searchResultArr[tapIndexPath.row]
                            }
                            
                        }
                        else
                        {
                            if( NewStr != "")
                            {
                                //self.bedroom.text = NewStr + inputArray[tapIndexPath.row] + ","
                                self.txt_bathroom.text =  inputArray[tapIndexPath.row]
                            }
                            else
                            {
                                //self.bedroom.text =  inputArray[tapIndexPath.row] + ","
                                self.txt_bathroom.text =  inputArray[tapIndexPath.row]
                            }
                        }
                        self.SearchFlag = false;
                    }
                    else
                    {
                        if(self.SearchFlag)
                        {
                            self.txt_bathroom.text =  searchResultArr[tapIndexPath.row]
                        }
                        else
                        {
                            self.txt_bathroom.text = inputArray[tapIndexPath.row]
                        }
                        self.SearchFlag = false;
                    }
                    
                    
                    tb1.isHidden = true
                    self.SearchFlag = false;
                    self.view3.endEditing(true)
                }
                else if(FromWhere == "ispaymentdone")
                {
                    
                    var searchStr :String = "";
                    searchStr = self.txt_Ispaymentdone.text!
                    let keysArray :[String] = searchStr.components(separatedBy: ",")
                    if(keysArray.count > 0)
                    {
                        NewStr = ""
                        for i in 0..<(keysArray.count-1)
                        {
                            if( NewStr != "")
                            {
                                NewStr =  NewStr +  keysArray[i] + ","
                            }else{
                                NewStr =  keysArray[i] + ","
                            }
                            
                            print(i)
                        }
                        
                        
                        if(self.SearchFlag)
                        {
                            if( NewStr != "")
                            {
                                let lastChar = NewStr.last!
                                if(lastChar == ",")
                                {
                                    NewStr = String(NewStr.dropLast())
                                }
                                //self.bedroom.text = NewStr + ", " + searchResultArr[tapIndexPath.row] + ","
                                self.txt_Ispaymentdone.text =  searchResultArr[tapIndexPath.row]
                            }
                            else
                            {
                                //  self.bedroom.text =  searchResultArr[tapIndexPath.row] + ","
                                self.txt_Ispaymentdone.text =  searchResultArr[tapIndexPath.row]
                            }
                            
                        }
                        else
                        {
                            if( NewStr != "")
                            {
                                //self.bedroom.text = NewStr + inputArray[tapIndexPath.row] + ","
                                self.txt_Ispaymentdone.text =  inputArray[tapIndexPath.row]
                            }
                            else
                            {
                                //self.bedroom.text =  inputArray[tapIndexPath.row] + ","
                                self.txt_Ispaymentdone.text =  inputArray[tapIndexPath.row]
                            }
                        }
                        self.SearchFlag = false;
                    }
                    else
                    {
                        if(self.SearchFlag)
                        {
                            self.txt_Ispaymentdone.text =  searchResultArr[tapIndexPath.row]
                        }
                        else
                        {
                            self.txt_Ispaymentdone.text = inputArray[tapIndexPath.row]
                        }
                        self.SearchFlag = false;
                    }
                    
                    
                    if(txt_Ispaymentdone.text == "Yes")
                    {
                        
                        txt_TaxInfo.isHidden = false
                        txtpaymentType.isHidden = false
                        txtpaymentType.placeholder = "Payment Method"
                    }
                    else
                    {
                        txt_TaxInfo.isHidden = true
                        txt_TaxInfo.isHidden = true
                        txtpaymentType.isHidden = true
                    }
                    tb1.isHidden = true
                    self.SearchFlag = false;
                    self.view3.endEditing(true)
                }
                else if(FromWhere == "paymentype")
                {
                    
                    var searchStr :String = "";
                    searchStr = self.txtpaymentType.text!
                    let keysArray :[String] = searchStr.components(separatedBy: ",")
                    if(keysArray.count > 0)
                    {
                        NewStr = ""
                        for i in 0..<(keysArray.count-1)
                        {
                            if( NewStr != "")
                            {
                                NewStr =  NewStr +  keysArray[i] + ","
                            }else{
                                NewStr =  keysArray[i] + ","
                            }
                            
                            print(i)
                        }
                        
                        
                        if(self.SearchFlag)
                        {
                            if( NewStr != "")
                            {
                                let lastChar = NewStr.last!
                                if(lastChar == ",")
                                {
                                    NewStr = String(NewStr.dropLast())
                                }
                                //self.bedroom.text = NewStr + ", " + searchResultArr[tapIndexPath.row] + ","
                                self.txtpaymentType.text =  searchResultArr[tapIndexPath.row]
                            }
                            else
                            {
                                //  self.bedroom.text =  searchResultArr[tapIndexPath.row] + ","
                                self.txtpaymentType.text =  searchResultArr[tapIndexPath.row]
                            }
                            
                        }
                        else
                        {
                            if( NewStr != "")
                            {
                                //self.bedroom.text = NewStr + inputArray[tapIndexPath.row] + ","
                                self.txtpaymentType.text =  inputArray[tapIndexPath.row]
                            }
                            else
                            {
                                //self.bedroom.text =  inputArray[tapIndexPath.row] + ","
                                self.txtpaymentType.text =  inputArray[tapIndexPath.row]
                            }
                        }
                        self.SearchFlag = false;
                    }
                    else
                    {
                        if(self.SearchFlag)
                        {
                            self.txtpaymentType.text =  searchResultArr[tapIndexPath.row]
                        }
                        else
                        {
                            self.txtpaymentType.text = inputArray[tapIndexPath.row]
                        }
                        self.SearchFlag = false;
                    }
                    
                    
                    tb1.isHidden = true
                    self.SearchFlag = false;
                    self.view3.endEditing(true)
                }
            }
        }
    }
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50) )
        doneToolbar.barStyle = UIBarStyle.blackTranslucent
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action:#selector(self.doneButtonAction))
        
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        self.txt_noStories.inputAccessoryView = doneToolbar
        self.yearBuild.inputAccessoryView = doneToolbar
        self.addUnitsOfInsp.inputAccessoryView = doneToolbar
        self.estimatedSqft.inputAccessoryView = doneToolbar
       self.unitsOfInsp.inputAccessoryView = doneToolbar
       self.addUnitsOfInsp.inputAccessoryView = doneToolbar
       self.inspFees.inputAccessoryView = doneToolbar
        self.addInspFees.inputAccessoryView = doneToolbar
        self.txt_TaxInfo.inputAccessoryView = doneToolbar
        
    }
    
    @objc func doneButtonAction()
    {
        self.txt_noStories.resignFirstResponder()
        self.yearBuild.resignFirstResponder()
        self.addUnitsOfInsp.resignFirstResponder()
        self.estimatedSqft.resignFirstResponder()
        self.unitsOfInsp.resignFirstResponder()
        self.addUnitsOfInsp.resignFirstResponder()
        self.inspFees.resignFirstResponder()
        self.addInspFees.resignFirstResponder()
        self.txt_TaxInfo.resignFirstResponder()
    }
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if(textField == txt_noStories || textField == yearBuild  || textField == estimatedSqft || textField == unitsOfInsp || textField == addUnitsOfInsp || textField == inspFees || textField == addInspFees || textField == txt_TaxInfo)
        {
            self.addDoneButtonOnKeyboard()
        }
        if(textField == txt_InspectionType)
        {
            print("txt_InspectionType textfeild")
            FromWhere = "InspectionType"
            self.SearchFlag = false;
            self.tb1.frame = CGRect(x: self.txt_InspectionType.frame.origin.x, y: self.txt_InspectionType.frame.origin.y+55, width: self.txt_InspectionType.frame.size.width, height: 160)

            self.tb1.dataSource = self
            self.tb1.delegate = self
            self.tb1.clipsToBounds = true
            self.tb1.layer.borderWidth = 2
             self.tb1.layer.cornerRadius = 10
            self.tb1.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
            self.tb1.layer.borderColor = UIColor.gray.withAlphaComponent(1.0).cgColor
            self.tb1.register(UITableViewCell.self, forCellReuseIdentifier: "cell11")
            self.tb1.setContentOffset(.zero, animated: false)
            self.inputArray = self.InspectionTypeArray;
            self.tb1.reloadData()
            self.view3?.addSubview(self.tb1)
            self.view3?.bringSubview(toFront: self.tb1)
            tb1.isHidden = false
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapEdit))
            tb1.addGestureRecognizer(tapGesture)
            tb1.delegate = self
            
            //add toolbar done button
            let toolBar = UIToolbar()
            toolBar.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
            toolBar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.donePicker))
            toolBar.setItems([doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            self.weather.inputAccessoryView = toolBar
        }
        else if(textField == weather)
        {
           print("weather textfeild")
           FromWhere = "weather"
           self.SearchFlag = false;
            self.tb1.frame = CGRect(x: self.weather.frame.origin.x, y: self.weather.frame.origin.y+55, width: self.weather.frame.size.width, height: 160)
            self.tb1.dataSource = self
            self.tb1.delegate = self
            self.tb1.clipsToBounds = true
            self.tb1.layer.borderWidth = 2
             self.tb1.layer.cornerRadius = 10
            self.tb1.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
            self.tb1.layer.borderColor = UIColor.gray.withAlphaComponent(1.0).cgColor
            self.tb1.register(UITableViewCell.self, forCellReuseIdentifier: "cell11")
            self.tb1.setContentOffset(.zero, animated: false)
            self.inputArray = self.weatherArray;
            self.tb1.reloadData()
            self.view3?.addSubview(self.tb1)
            self.view3?.bringSubview(toFront: self.tb1)
            tb1.isHidden = false
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapEdit))
            tb1.addGestureRecognizer(tapGesture)
            tb1.delegate = self
            
            //add toolbar done button
            let toolBar = UIToolbar()
            toolBar.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
            toolBar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.donePicker))
            toolBar.setItems([doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
           self.weather.inputAccessoryView = toolBar
        }
        else if(textField == consType){
            
            
            print("Constype textfeild")
             FromWhere = "consType"
            self.SearchFlag = false;
            self.tb1.frame = CGRect(x: self.consType.frame.origin.x, y: self.consType.frame.origin.y+55, width: self.consType.frame.size.width, height: 160)
            self.tb1.dataSource = self
            self.tb1.clipsToBounds = true
            self.tb1.layer.borderWidth = 2
            self.tb1.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
             self.tb1.layer.cornerRadius = 10
            
            self.tb1.layer.borderColor = UIColor.gray.withAlphaComponent(1.0).cgColor
            self.tb1.delegate = self
            self.tb1.allowsSelection = true
            
         self.tb1.register(UITableViewCell.self, forCellReuseIdentifier: "cell11")
            self.tb1.setContentOffset(.zero, animated: false)
            self.inputArray = self.ConstypeArray;
            self.tb1.reloadData()
            self.view3.addSubview(tb1)
            tb1.isHidden = false
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapEdit))
            tb1.addGestureRecognizer(tapGesture)
            tb1.delegate = self
            
            let toolBar = UIToolbar()
            toolBar.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
            toolBar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.donePicker))
            toolBar.setItems([doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            self.consType.inputAccessoryView = toolBar
            
        }
        else if(textField == stucture){
            
            self.SearchFlag = false;
            print("Struct textfeild")
            FromWhere = "stucture"
            self.tb1.frame = CGRect(x: self.stucture.frame.origin.x, y: self.stucture.frame.origin.y+55, width: self.stucture.frame.size.width, height: 160)
            self.tb1.dataSource = self
            self.tb1.clipsToBounds = true
            self.tb1.layer.borderWidth = 2
             self.tb1.layer.cornerRadius = 10
            self.tb1.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
            self.tb1.layer.borderColor = UIColor.gray.withAlphaComponent(1.0).cgColor
            self.tb1.delegate = self
            self.tb1.allowsSelection = true
            self.tb1.register(UITableViewCell.self, forCellReuseIdentifier: "cell11")
            self.tb1.setContentOffset(.zero, animated: false)
            self.inputArray = self.StructureArray;
            self.tb1.reloadData()
            self.view3.addSubview(tb1)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapEdit))
            tb1.addGestureRecognizer(tapGesture)
            tb1.delegate = self
            tb1.isHidden = false
            let toolBar = UIToolbar()
            toolBar.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
            toolBar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.donePicker))
            toolBar.setItems([doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            self.stucture.inputAccessoryView = toolBar
            
        }
        else if(textField == bedroom){
            self.view3.endEditing(true)
            self.SearchFlag = false;
            print("weather textfeild")
            FromWhere = "bedroom"
            self.tb1.frame = CGRect(x: self.bedroom.frame.origin.x, y: self.bedroom.frame.origin.y+55, width: self.bedroom.frame.size.width, height: 160)
            self.tb1.dataSource = self
            self.tb1.clipsToBounds = true
            self.tb1.layer.borderWidth = 2
             self.tb1.layer.cornerRadius = 10
            self.tb1.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
            self.tb1.layer.borderColor = UIColor.gray.withAlphaComponent(1.0).cgColor
            self.tb1.delegate = self
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapEdit))
            tb1.addGestureRecognizer(tapGesture)
            tb1.delegate = self
            self.tb1.register(UITableViewCell.self, forCellReuseIdentifier: "cell11")
            self.tb1.setContentOffset(.zero, animated: false)
            self.inputArray = self.BedRoomsArray;
            self.tb1.reloadData()
            self.view3.addSubview(tb1)
            tb1.isHidden = false
            let toolBar = UIToolbar()
            toolBar.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
            toolBar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.donePicker))
            toolBar.setItems([doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            self.bedroom.inputAccessoryView = toolBar
        }else if(textField == txt_bathroom){
            
            self.view3.endEditing(true)
            self.SearchFlag = false;
            print("bathroom textfeild")
            FromWhere = "bathroom"
            self.tb1.frame = CGRect(x: self.txt_bathroom.frame.origin.x, y: self.txt_bathroom.frame.origin.y+55, width: self.txt_bathroom.frame.size.width, height: 160)
            self.tb1.dataSource = self
            self.tb1.clipsToBounds = true
            self.tb1.layer.borderWidth = 2
             self.tb1.layer.cornerRadius = 10
            self.tb1.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
            self.tb1.layer.borderColor = UIColor.gray.withAlphaComponent(1.0).cgColor
            self.tb1.delegate = self
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapEdit))
            tb1.addGestureRecognizer(tapGesture)
            tb1.delegate = self
            self.tb1.register(UITableViewCell.self, forCellReuseIdentifier: "cell11")
            self.tb1.setContentOffset(.zero, animated: false)
            self.inputArray = self.BedRoomsArray;
            self.tb1.reloadData()
            self.view3.addSubview(tb1)
            tb1.isHidden = false
            let toolBar = UIToolbar()
            toolBar.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
            toolBar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.donePicker))
            toolBar.setItems([doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            self.txt_bathroom.inputAccessoryView = toolBar
        }
        else if(textField == txt_tempture){
            self.view3.endEditing(true)
            self.SearchFlag = false;
            print("tempture textfeild")
            FromWhere = "Tempture"
            self.tb1.frame = CGRect(x: self.txt_tempture.frame.origin.x, y: self.txt_tempture.frame.origin.y+55, width: self.txt_tempture.frame.size.width, height: 160)
            
            self.tb1.dataSource = self
            self.tb1.delegate = self
            self.tb1.clipsToBounds = true
            self.tb1.layer.borderWidth = 2
            self.tb1.layer.cornerRadius = 10
            self.tb1.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
            self.tb1.layer.borderColor = UIColor.gray.withAlphaComponent(1.0).cgColor
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapEdit))
            tb1.addGestureRecognizer(tapGesture)
            tb1.delegate = self
            self.tb1.register(UITableViewCell.self, forCellReuseIdentifier: "cell11")
            self.tb1.setContentOffset(.zero, animated: false)
            self.inputArray = self.tempArray;
            self.tb1.reloadData()
            self.view3.addSubview(tb1)
            tb1.bringSubview(toFront: self.view3)
            tb1.isHidden = false
            let toolBar = UIToolbar()
            toolBar.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
            toolBar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.donePicker))
            toolBar.setItems([doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            self.txt_tempture.inputAccessoryView = toolBar
        }
        //
        else if(textField == txt_Garage){
            self.view3.endEditing(true)
            self.SearchFlag = false;
            print("Garage textfeild")
            FromWhere = "Garage"
            self.tb1.frame = CGRect(x: self.txt_Garage.frame.origin.x, y: self.txt_Garage.frame.origin.y+48, width: self.txt_Garage.frame.size.width, height: 160)
            
            self.tb1.dataSource = self
            self.tb1.delegate = self
            self.tb1.clipsToBounds = true
            self.tb1.layer.borderWidth = 2
             self.tb1.layer.cornerRadius = 10
            self.tb1.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
            self.tb1.layer.borderColor = UIColor.gray.withAlphaComponent(1.0).cgColor
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapEdit))
            tb1.addGestureRecognizer(tapGesture)
            tb1.delegate = self
            self.tb1.register(UITableViewCell.self, forCellReuseIdentifier: "cell11")
            self.tb1.setContentOffset(.zero, animated: false)
            self.inputArray = self.BedRoomsArray;
            self.tb1.reloadData()
            self.view3.addSubview(tb1)
            tb1.bringSubview(toFront: self.view3)
            tb1.isHidden = false
            let toolBar = UIToolbar()
            toolBar.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
            toolBar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.donePicker))
            toolBar.setItems([doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            self.txt_Garage.inputAccessoryView = toolBar
        }
        else if(textField == txtpaymentType){
            self.view3.endEditing(true)
            self.SearchFlag = false;
            print("payment textfeild")
            FromWhere = "paymentype"
            self.tb1.frame = CGRect(x: self.txtpaymentType.frame.origin.x, y: self.txtpaymentType.frame.origin.y+55, width: self.txtpaymentType.frame.size.width, height: 160)
            self.tb1.dataSource = self
            self.tb1.clipsToBounds = true
            self.tb1.layer.borderWidth = 2
             self.tb1.layer.cornerRadius = 10
            self.tb1.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
            self.tb1.layer.borderColor = UIColor.gray.withAlphaComponent(1.0).cgColor
            self.tb1.delegate = self
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapEdit))
            tb1.addGestureRecognizer(tapGesture)
            tb1.delegate = self
            self.tb1.register(UITableViewCell.self, forCellReuseIdentifier: "cell11")
            self.tb1.setContentOffset(.zero, animated: false)
            self.inputArray = self.paymentMethod;
            self.tb1.reloadData()
            self.view4.addSubview(tb1)
            tb1.isHidden = false
            let toolBar = UIToolbar()
            toolBar.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
            toolBar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.donePicker))
            toolBar.setItems([doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            self.txtpaymentType.inputAccessoryView = toolBar
        }
        else if(textField == txt_Ispaymentdone){
            self.view3.endEditing(true)
            self.SearchFlag = false;
            print("payment textfeild")
            FromWhere = "ispaymentdone"
            self.tb1.frame = CGRect(x: self.txt_Ispaymentdone.frame.origin.x, y: self.txt_Ispaymentdone.frame.origin.y+55, width: self.txt_Ispaymentdone.frame.size.width, height: 160)
            self.tb1.dataSource = self
            self.tb1.clipsToBounds = true
            self.tb1.layer.borderWidth = 2
             self.tb1.layer.cornerRadius = 10
            self.tb1.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
            self.tb1.layer.borderColor = UIColor.gray.withAlphaComponent(1.0).cgColor
            self.tb1.delegate = self
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapEdit))
            tb1.addGestureRecognizer(tapGesture)
            tb1.delegate = self
            self.tb1.register(UITableViewCell.self, forCellReuseIdentifier: "cell11")
            self.tb1.setContentOffset(.zero, animated: false)
            self.inputArray = self.ispaymentdone;
            self.tb1.reloadData()
            self.view4.addSubview(tb1)
            tb1.isHidden = false
            let toolBar = UIToolbar()
            toolBar.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
            toolBar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.donePicker))
            toolBar.setItems([doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            self.txt_Ispaymentdone.inputAccessoryView = toolBar
        }
        else{
            tb1.isHidden = true
        }
    }
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder();
          return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        print("textFieldShouldEndEditing")
        tb1.isHidden = true
        if(textField == address)
        {
         inspAdd.text = address.text
         
        }
        return true
    }
   
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(self.SearchFlag)
        {
            return searchResultArr.count
        }
        else
        {
            return inputArray.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell11")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell11", for: indexPath)
        
        if(self.SearchFlag)
        {
            cell.textLabel!.text = "\(searchResultArr[indexPath.row])"
        }
        else
        {
            cell.textLabel!.text = "\(inputArray[indexPath.row])"
        }
         cell.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        return cell
    }
   
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(tableView == tb1){
            return 40;
            
        }else{
            return tableView.rowHeight
        }
    }

    override func awakeFromNib()
    {
        
        //Add tap to uiview
        
          buyerPhoneNo.delegate = self
        phoneNo.delegate = self
        listingPhoneNo.delegate = self
        let gesture = UITapGestureRecognizer(target: self, action: #selector(ExpandableCellInspect1.someAction(_:)))
        
        _ = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
        self.view1.addGestureRecognizer(gesture)
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(ExpandableCellInspect1.someAction2(_:)))
       
        _ = UITapGestureRecognizer(target: self, action:  #selector (self.someAction2 (_:)))
        self.view2.addGestureRecognizer(gesture2)
        let gesture3 = UITapGestureRecognizer(target: self, action: #selector(ExpandableCellInspect1.someAction3(_:)))
       
        _ = UITapGestureRecognizer(target: self, action:  #selector (self.someAction3 (_:)))
        self.view3.addGestureRecognizer(gesture3)
        
        let gesture4 = UITapGestureRecognizer(target: self, action: #selector(ExpandableCellInspect1.someAction3(_:)))
        
        _ = UITapGestureRecognizer(target: self, action:  #selector (self.someAction3 (_:)))
        self.view4.addGestureRecognizer(gesture4)
        
        //client..
        firstNameTextFieldController = MDCTextInputControllerUnderline(textInput: firstName)
        lastNameTextFieldController = MDCTextInputControllerUnderline(textInput: lastName)
        phoneNoTextFieldController = MDCTextInputControllerUnderline(textInput: phoneNo)
        addressTextFieldController = MDCTextInputControllerUnderline(textInput: address)
        addressLine2 = MDCTextInputControllerUnderline(textInput: address2)
        cityTextFieldController = MDCTextInputControllerUnderline(textInput: city)
        clienCity2 = MDCTextInputControllerUnderline(textInput: c_cityTxt)
        clientZip = MDCTextInputControllerUnderline(textInput: c_zipTxt)
        clientCountry = MDCTextInputControllerUnderline(textInput: c_countryTxt)
        emailTextFieldController = MDCTextInputControllerUnderline(textInput: email)
        
       
        
        
        //Realotors...
        buyerfname = MDCTextInputControllerUnderline(textInput: buyerFirstName)
        buyerlname = MDCTextInputControllerUnderline(textInput: buyerLastName)
        buyerphno = MDCTextInputControllerUnderline(textInput: buyerPhoneNo)
        buyeremail = MDCTextInputControllerUnderline(textInput: buyerEmail)
        buyeroff = MDCTextInputControllerUnderline(textInput: buyerOffice)
        
        listingfname = MDCTextInputControllerUnderline(textInput: listingFrstName)
        listinglname = MDCTextInputControllerUnderline(textInput: listingLastName)
        listingoff = MDCTextInputControllerUnderline(textInput: listingOffice)
        listingemail = MDCTextInputControllerUnderline(textInput: listingEmail)
        listingphno = MDCTextInputControllerUnderline(textInput: listingPhoneNo)
        
     
        
        //Insp info...
        inspzip = MDCTextInputControllerUnderline(textInput: inspZip)
        inspcity = MDCTextInputControllerUnderline(textInput: inspCity)
        inspfees = MDCTextInputControllerUnderline(textInput: inspFees)
        invoice2 = MDCTextInputControllerUnderline(textInput: invoice)
        inspstate = MDCTextInputControllerUnderline(textInput: inspState)
        inspadd = MDCTextInputControllerUnderline(textInput: inspAdd)
        time2 = MDCTextInputControllerUnderline(textInput: time)
        addinspfees = MDCTextInputControllerUnderline(textInput: addInspFees)
        typeofaddinspfees = MDCTextInputControllerUnderline(textInput: typeOfAddInspFees)
        yrbuild = MDCTextInputControllerUnderline(textInput: yearBuild)
        essqft = MDCTextInputControllerUnderline(textInput: estimatedSqft)
        addunitsinsp = MDCTextInputControllerUnderline(textInput: addUnitsOfInsp)
        date2 = MDCTextInputControllerUnderline(textInput: dateOfInsp)
        weather2 = MDCTextInputControllerUnderline(textInput: weather)
        unitsinsp = MDCTextInputControllerUnderline(textInput: unitsOfInsp)
        constype2 = MDCTextInputControllerUnderline(textInput: consType)
        structure2 = MDCTextInputControllerUnderline(textInput: stucture)
        bedroom2 = MDCTextInputControllerUnderline(textInput: bedroom)
        bathrooms = MDCTextInputControllerUnderline(textInput: txt_bathroom)
        garage = MDCTextInputControllerUnderline(textInput: txt_Garage)
        tempture = MDCTextInputControllerUnderline(textInput: txt_tempture)
        inspCountry2 = MDCTextInputControllerUnderline(textInput: inspCountryTxt)
        inspAddressLine2 = MDCTextInputControllerUnderline(textInput: inspAdd2)
        inspzip = MDCTextInputControllerUnderline(textInput: inspZip)
        inspCountry2 = MDCTextInputControllerUnderline(textInput: inspCountryTxt)
        
        noOfstories = MDCTextInputControllerUnderline(textInput: txt_noStories)
        
        inspecttypeline = MDCTextInputControllerUnderline(textInput: txt_InspectionType)
        amountPaidline = MDCTextInputControllerUnderline(textInput: inspCountryTxt)
        paymentmethodLine = MDCTextInputControllerUnderline(textInput: txtpaymentType)
        ispaymentdoneLine = MDCTextInputControllerUnderline(textInput: txt_Ispaymentdone)
        
        taxLine = MDCTextInputControllerUnderline(textInput: txt_TaxInfo)
        
       
        
        if UIDevice.current.userInterfaceIdiom == .phone
            
        {
            
            firstNameTextFieldController.textInputFont = MDCTypography.subheadFont()
            lastNameTextFieldController.textInputFont = MDCTypography.subheadFont()
            phoneNoTextFieldController.textInputFont = MDCTypography.subheadFont()
            addressTextFieldController.textInputFont = MDCTypography.subheadFont()
            addressLine2.textInputFont = MDCTypography.subheadFont()
            cityTextFieldController.textInputFont = MDCTypography.subheadFont()
            clienCity2.textInputFont = MDCTypography.subheadFont()
            clientZip.textInputFont = MDCTypography.subheadFont()
            clientCountry.textInputFont = MDCTypography.subheadFont()
            emailTextFieldController.textInputFont = MDCTypography.subheadFont()
            
            
            buyerfname.textInputFont = MDCTypography.subheadFont()
            buyerlname.textInputFont = MDCTypography.subheadFont()
            buyerphno.textInputFont = MDCTypography.subheadFont()
            buyeremail.textInputFont = MDCTypography.subheadFont()
            buyeroff.textInputFont = MDCTypography.subheadFont()
            
            listingfname.textInputFont = MDCTypography.subheadFont()
            listinglname.textInputFont = MDCTypography.subheadFont()
            listingoff.textInputFont = MDCTypography.subheadFont()
            listingemail.textInputFont = MDCTypography.subheadFont()
            listingphno.textInputFont = MDCTypography.subheadFont()
            
            
            inspzip.textInputFont = MDCTypography.subheadFont()
            inspcity.textInputFont = MDCTypography.subheadFont()
            inspfees.textInputFont = MDCTypography.subheadFont()
            invoice2.textInputFont = MDCTypography.subheadFont()
            inspstate.textInputFont = MDCTypography.subheadFont()
            inspadd.textInputFont = MDCTypography.subheadFont()
            time2.textInputFont = MDCTypography.subheadFont()
            addinspfees.textInputFont = MDCTypography.subheadFont()
            
            typeofaddinspfees.textInputFont = MDCTypography.subheadFont()
            yrbuild.textInputFont = MDCTypography.subheadFont()
            essqft.textInputFont = MDCTypography.subheadFont()
            addunitsinsp.textInputFont = MDCTypography.subheadFont()
            
            date2.textInputFont = MDCTypography.subheadFont()
            weather2.textInputFont = MDCTypography.subheadFont()
            unitsinsp.textInputFont = MDCTypography.subheadFont()
            constype2.textInputFont = MDCTypography.subheadFont()
            structure2.textInputFont = MDCTypography.subheadFont()
            bedroom2.textInputFont = MDCTypography.subheadFont()
            bathrooms.textInputFont = MDCTypography.subheadFont()
            garage.textInputFont = MDCTypography.subheadFont()
            tempture.textInputFont = MDCTypography.subheadFont()
            inspCountry2.textInputFont = MDCTypography.subheadFont()
            inspAddressLine2.textInputFont = MDCTypography.subheadFont()
            inspzip.textInputFont = MDCTypography.subheadFont()
            inspCountry2.textInputFont = MDCTypography.subheadFont()
            inspecttypeline.textInputFont = MDCTypography.subheadFont()
            amountPaidline.textInputFont = MDCTypography.subheadFont()
            paymentmethodLine.textInputFont = MDCTypography.subheadFont()
            ispaymentdoneLine.textInputFont = MDCTypography.subheadFont()
            taxLine.textInputFont = MDCTypography.subheadFont()
            
        }else{
            
            firstNameTextFieldController.textInputFont = MDCTypography.titleFont()
            lastNameTextFieldController.textInputFont = MDCTypography.titleFont()
            phoneNoTextFieldController.textInputFont = MDCTypography.titleFont()
            addressTextFieldController.textInputFont = MDCTypography.titleFont()
            addressLine2.textInputFont = MDCTypography.titleFont()
            cityTextFieldController.textInputFont = MDCTypography.titleFont()
            clienCity2.textInputFont = MDCTypography.titleFont()
            clientZip.textInputFont = MDCTypography.titleFont()
            clientCountry.textInputFont = MDCTypography.titleFont()
            emailTextFieldController.textInputFont = MDCTypography.titleFont()
            
            
            buyerfname.textInputFont = MDCTypography.titleFont()
            buyerlname.textInputFont = MDCTypography.titleFont()
            buyerphno.textInputFont = MDCTypography.titleFont()
            buyeremail.textInputFont = MDCTypography.titleFont()
            buyeroff.textInputFont = MDCTypography.titleFont()
            
            listingfname.textInputFont = MDCTypography.titleFont()
            listinglname.textInputFont = MDCTypography.titleFont()
            listingoff.textInputFont = MDCTypography.titleFont()
            listingemail.textInputFont = MDCTypography.titleFont()
            listingphno.textInputFont = MDCTypography.titleFont()
            
            
            inspzip.textInputFont = MDCTypography.titleFont()
            inspcity.textInputFont = MDCTypography.titleFont()
            inspfees.textInputFont = MDCTypography.titleFont()
            invoice2.textInputFont = MDCTypography.titleFont()
            inspstate.textInputFont = MDCTypography.titleFont()
            inspadd.textInputFont = MDCTypography.titleFont()
            time2.textInputFont = MDCTypography.titleFont()
            addinspfees.textInputFont = MDCTypography.titleFont()
            
            typeofaddinspfees.textInputFont = MDCTypography.titleFont()
            yrbuild.textInputFont = MDCTypography.titleFont()
            essqft.textInputFont = MDCTypography.titleFont()
            addunitsinsp.textInputFont = MDCTypography.titleFont()
            
            date2.textInputFont = MDCTypography.titleFont()
            weather2.textInputFont = MDCTypography.titleFont()
            unitsinsp.textInputFont = MDCTypography.titleFont()
            constype2.textInputFont = MDCTypography.titleFont()
            structure2.textInputFont = MDCTypography.titleFont()
            bedroom2.textInputFont = MDCTypography.titleFont()
            bathrooms.textInputFont = MDCTypography.titleFont()
            garage.textInputFont = MDCTypography.titleFont()
            tempture.textInputFont = MDCTypography.titleFont()
            inspCountry2.textInputFont = MDCTypography.titleFont()
            inspAddressLine2.textInputFont = MDCTypography.titleFont()
            inspzip.textInputFont = MDCTypography.titleFont()
            inspCountry2.textInputFont = MDCTypography.titleFont()
            inspecttypeline.textInputFont = MDCTypography.titleFont()
            amountPaidline.textInputFont = MDCTypography.titleFont()
            paymentmethodLine.textInputFont = MDCTypography.titleFont()
            ispaymentdoneLine.textInputFont = MDCTypography.titleFont()
            taxLine.textInputFont = MDCTypography.titleFont()
        }
        
        //inspZip.addTarget(self, action: Selector("didChangeText:"), for: .editingChanged)
       firstName .addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
       listingEmail.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        buyerEmail.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
         email.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        
      /*lastName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        phoneNo.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        address.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        city.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        email.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        buyerFirstName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        buyerLastName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        buyerPhoneNo.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        buyerEmail.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        buyerOffice.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        listingFrstName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        listingLastName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        listingOffice.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        listingEmail.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        listingPhoneNo.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        inspAdd.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        
        inspCity.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        inspState.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        inspZip.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        invoice.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        inspFees.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        addInspFees.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)

        typeOfAddInspFees.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        yearBuild.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        estimatedSqft.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        unitsOfInsp.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        addUnitsOfInsp.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        weather.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        consType.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        stucture.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        bedroom.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)*/
        inspZip.addTarget(self, action: #selector(textFieldDidChange2(_:)), for: UIControlEvents.editingChanged)
        let date = Date()
        let formatter = DateFormatter()
        
        
        formatter.dateFormat = "MM/dd/yyyy"
        
    
        formatter.timeStyle = .medium
        
       self.time.text = "\(formatter.string(from: date))"
        

    }
    @objc func someAction(_ sender:UITapGestureRecognizer){
       
         print("MinuB1")
    }
    @objc func someAction2(_ sender:UITapGestureRecognizer){
        print("MinuB2")
    }
    @objc func someAction3(_ sender:UITapGestureRecognizer){
        
       
    }
    @objc func textFieldDidChange2(_ textField:UITextField) {
         print("MinuB3")
        inspZipStr = inspZip.text
    }
    @objc func donePicker() {
        
        print ("Done")
        tb1.isHidden = true
        self.view3.endEditing(true)
    }
    @objc func textFieldDidChange(_ textField:UITextField) {
        // your code here
       
    
//        temp1 = inspZip.text
//        inspZipStr = temp1
        if textField == firstName {
            temp2 = firstName.text
            firstNameStr = temp2
        }
        
        if textField == email {
            temp3 = email.text
            emailStr = temp3!
        }
        if textField == buyerEmail {
           buyerEmailStr = buyerEmail.text
        }
        if textField == listingEmail {
            listingEmailStr = listingEmail.text
        }
     
       // buyerEmailStr = buyerEmail.text?
//       
//        
     //   listingEmail = listingEmail.text?
        
      
//        lastNameStr = lastName.text!
        
       // dateOfInspStr = dateOfInsp.text
       
       
//        inspAdd = inspAdd.text
//        inspCity = inspCity.text
//        inspState = inspState.text
//        inspZipStr = inspZip.text
//        invoice = invoice.text
//        dateOfInspStr = dateOfInsp.text
//        time = time.text
//        inspFees = inspFees.text
//        addInspFees = addInspFees.text
//        typeAddInspFees = typeOfAddInspFees.text
//        yearBuild = yearBuild.text!
//        estimatedSqft = estimatedSqft.text!
//        unitsInsp = unitsOfInsp.text!
//        addInspUnits = addUnitsOfInsp.text!
//        weather = weather.text!
//        consType = consType.text!
//        structure = stucture.text!
//        bedroom = bedroom.text!
        
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
