//
//  Constants.swift
//  AllInOne
//
//  Created by Apple on 10/31/18.
//  Copyright © 2018 mac08. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

struct Candy {
    let category : String
    let name : String
}

let headers:HTTPHeaders=["Content-Type":"application/x-www-form-urlencoded"]
let SCREENWIDTH             = UIScreen.main.bounds.size.width

let SCREENHEIGHT             = UIScreen.main.bounds.size.height
var userDefault = UserDefaults.standard
//let url = "http://174.141.230.138/~allinoneinsp/Webservices/show_property"

//let url = "http://174.141.230.138/~allinoneinsp/Webservices/get_assigned_property"
//let urlAlphabate = "http://174.141.230.138/~allinoneinsp/webservices/show_property_name_asc"
//let urlSearch = "http://174.141.230.138/~allinoneinsp/webservices/search_in_property"
//let urlDate = "http://174.141.230.138/~allinoneinsp/webservices/show_property_date_asc"

let url = "http://allin1inspections.com/admin/Webservices/get_assigned_property"
let urlAlphabate = "http://allin1inspections.com/admin/webservices/show_property_name_asc"
let urlSearch = "http://allin1inspections.com/admin/webservices/search_in_property"
let urlDate = "http://allin1inspections.com/admin/webservices/show_property_date_asc"
@available(iOS 10.0, *)
var appDelegate = UIApplication.shared.delegate as! AppDelegate
@available(iOS 10.0, *)
var context = appDelegate.persistentContainer.viewContext
var request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
//var str = "Garage"
var fruitName = ""
var global1 : String? = ""
var global : String? = ""
var finalG : String? = ""
var finalG1 : String? = ""
var global2 : String? = ""
var question1 = "Yes"
var mainCutOfSwStr = "Yes"
var mainCutOfSwLocaionStr = "Yes"
var groundedStr = "Yes"
var serviceSizeMainPanelStr = "Yes"
var ampStr = "Yes"
var serviceConnectionStr = "Yes"
var serviceOnDuringInspectionStr = "Yes"
var typeOfWiringStr = "Yes"
var statusStr = "Yes"
var resultStr = "Yes"
//var firstName = ""
var firstNameStr: String? = ""
var consClientFname: String? = ""
var img_IdStr: String? = ""
var indexSec: NSNumber?
var indexSec4: NSNumber?
var lastNameStr = ""
var c_countryStr : String? = ""
//var phoneNo = "Phone No"
var phoneNoStr = String()
var address = ""
var cityStr = ""
var emailStr = ""
var c_zipStr : String? = ""
var c_add2Str : String? = ""
var c_StateStr : String? = ""
var btn1Title = "Minu"
//var buyerfirstName = "Buyer First Name"
var buyerfirstName : String? = ""
var buyerlastName : String? = ""
var buyerphoneNo: String? = ""
var buyerEmailStr : String? = ""
var buyerOffice : String? = ""
var listingFrstName: String? = ""
var listingLastName : String? = ""
var listingEmailStr : String? = ""
var listingOffice : String? = ""
var listingPhoneNo1 : String? = ""

var inspCountryStr : String? = ""
var inspAdd : String? = ""
var inspCity : String? = ""
var inspState: String? = ""
var inspZipStr : String? = ""
var inspectionTypestr : String? = ""
var insp_c_str : String? = ""
var insp_add_str : String? = ""

var invoice : String? = ""
var dateOfInspStr: String? = ""
var time : String? = ""
var inspFees : String? = ""
var addInspFees : String? = ""
var typeAddInspFees : String? = ""
var yearBuild : String? = ""
var estimatedSqft : String? = ""
var unitsInsp : String? = ""
var addInspUnits : String? = ""
var weather : String? = ""
var consType : String? = ""
var structure : String? = ""
var bedroom : String? = ""
//nilesh
var bathroomStr : String? = ""
var garageStr : String? = ""
var temptureStr : String? = ""
var paymentTypeStr : String? = ""
var taxInfoStr : String? = ""
var ispaymentdone : String? = ""
var noOfStoriesStr : String? = ""
var assingToStr : String? = ""
var userId : String = ""
var catIdStr : String? = ""
var subCatIdStr : String? = ""
var catNameStr : String? = ""
var subCatNameStr : String? = ""
var inspectionIdStr : String? = ""
var AddIndex : Int = 0
var AddIndex1 : Int = 0
var ButtonClickcountPics : Int = 0
var inspAdda2 : String? = ""
var inspCountry2 : String? = ""
var imageArray : NSData!

var picSelectionStr : String? = ""

var agentfname : String? = ""
var agentlname : String? = ""
var agentemail: String? = ""
var agentphone : String? = ""
var agentImage : String? = ""

//
var CategoiresImagesIDArray = [String]()
 var categoiresimagarray = [URL]()
var categoiresNewimagearray = [UIImage]()
//
var myImages2 = [UIImage]()
var selectedImage: UIImage = UIImage()
var singleImg: UIImage = UIImage()
var imgData: NSData? = nil
var imgStr : String? = ""
var myImages = [UIImage]()
var imgArray1 = [UIImage]()
var selectedImageArray = [UIImage]()

var selectedImagesID = [String]()
var myImagesDecoded = [UIImage]()
var myImagesDecodedLD = [UIImage]()
var myNewlyAddedImages = [UIImage]()
var myImagesID = [String]()
var myImagespath = [URL]()
var _selectedCells : NSMutableArray = []
var CDataArray = NSMutableArray();
var imageUrlArray = [URL]();
var catImgArray1 = NSMutableArray();
var uploadCDataArray = NSMutableArray();
var logoImage: NSMutableArray = []
var noStr : String? = ""
var yesStr : String? = ""
var data1: NSData?
var stringAsData : NSData?
var dataOfCatImgArray: NSData?
var clientNameArray = [String]()
var titleFirstLetter:[String]!

var questionArray = [String]()
var default_ansArray = [[String]]()
//var answerArray = [String]()
var answerArray : [[String]] = []
var answerArrayNew = [String]()


var default_ResultArray = [[String]]()
var default_StatusArray = [[String]]()
var default_CommentArray = [[String]]()
var commentsarray : [[String]] = []

@available(iOS 10.0, *)
var city:ExpandableCell=ExpandableCell()

var temp1 : String? = ""
var temp2 : String? = ""
var temp3 : String? = ""
var temp4 : String? = ""
var temp5 : String? = ""
var actInd : UIActivityIndicatorView = UIActivityIndicatorView()

func convertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}
let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 50, y: 20, width: 200, height: 100))

//// Category data...
  var catName: String? = ""
  var catId :  String? = ""

  var catIdArray = [String]()
  var catNameArray = [String]()
  var catinculdeInReport = [String]()
  var tempSection = ""


//niuelsj
var cat_name: String? = ""
var sub_catname: String? = ""
 var n_ans=[String:String]()
var mainsubCat=[Dictionary<String,AnyObject>]()

var subcatIdArray = [String]()
var subcatNameArray = [String]()
var subcatInculdeInreportArray = [String]()
var sub_catIdstr: String? = ""
var catIdstr: String? = ""

var subcatsummeryInreportArray = [String]()

var resultArray = [String]()
var statusArray = [String]()


var inspect_data : String = "";
var categoires_data : String = "";
var subCategoires_data : String = "";
var AssingImages_data : String = "";
var NewinspectionIdStr : String? = ""
var imageCount : Int = 1
var uploadedimageCount : Int = 0

