//
//  ExpandableCell.swift
//  ExpandableCellsExample
//
//  Created by DC on 28.08.2016.
//  Copyright © 2016 Dawid Cedrych. All rights reserved.
//

import UIKit
import MaterialComponents
import SVProgressHUD
import CoreData
@available(iOS 10.0, *)
class ExpandableCell: UITableViewCell,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource
{
     @IBOutlet weak var img: UIImageView!
     @IBOutlet weak var lblTxt: UILabel!
     @IBOutlet weak var largeLblTxt: UILabel!
     @IBOutlet weak var tableVew1: UITableView!
     @IBOutlet weak var categoiresImagecollectionView: UICollectionView!
     @IBOutlet weak var imgHeightConstraint: NSLayoutConstraint!
     //AllBtns...
     @IBOutlet weak var btn1Out: UIButton!
     @IBOutlet weak var mainCutOfSwBtn: UIButton!
     @IBOutlet weak var mainCutOfSwLocationBtn: UIButton!
     @IBOutlet weak var groundedBtn: UIButton!
     @IBOutlet weak var servicePanelBtn: UIButton!
     @IBOutlet weak var ampBtn: UIButton!
     @IBOutlet weak var serviceConnectionBtn: UIButton!
     @IBOutlet weak var serviceDuringInsBtn: UIButton!
     @IBOutlet weak var typeOfWiringBtn: UIButton!
     @IBOutlet weak var statusBtn: UIButton!
     @IBOutlet weak var resultBtn: UIButton!
     
     //All LAbels...
     @IBOutlet weak var garageLbl: UILabel!
     @IBOutlet weak var mainCutOfSwLbl: UILabel!
     @IBOutlet weak var mainCutOfSwLocationLbl: UILabel!
     @IBOutlet weak var groundedLbl: UILabel!
     @IBOutlet weak var servicePanelLbl: UILabel!
     @IBOutlet weak var ampLbl: UILabel!
     @IBOutlet weak var serviceConnLbl: UILabel!
     @IBOutlet weak var serviceDuringInsLbl: UILabel!
     @IBOutlet weak var typeOfWiringLbl: UILabel!
     @IBOutlet weak var statusLbl: UILabel!
     @IBOutlet weak var resultLbl: UILabel!
     
      @IBOutlet weak var lbl_cellCheckUncheck: UILabel!
      @IBOutlet weak var btn_checkuncheck: UIButton!
     
     @IBOutlet weak var lbl_AddsummeryUncheck: UILabel!
     @IBOutlet weak var btn_addsummerycheckuncheck: UIButton!
     
     @IBOutlet weak var btn_picsOutlet: UIButton!
     @IBOutlet weak var btn_AssingpicsOutlet: UIButton!
     
     @IBOutlet weak var pickerView1: UIPickerView!
     @IBOutlet weak var mainView4: UIView!
    // @IBOutlet var view1: UIView!
     @IBOutlet weak var ques1Lbl: UILabel!
     @IBOutlet weak var ques2Lbl: UILabel!
     var qusArr = [String]()
     let tb1 = UITableView()
     var inputArray = [""]
     var indexPathNew : IndexPath = []
     
     var SearchFlag :Bool = false;
     var searchResultArr :[String] = []
     var NewStr:String = ""
     var fromcomment : String = ""
     
//     var ResultArray = ["Additional Inspection Needed","Attention Required","Fair","Correction Needed",
//          "Functional","Further Inspection is needed","Further Review from a qualified professional",
//          "Immediate Attention Required","Inaccessible or Obstructed Area(s)","Minor Cosmetic Repair",
//          "Minor Repair Needed" ,"Needs Servicing","None","Non-Functional","Non-Operational","Poor","Qualified Professional Needed","Qualified Professional Recommended","Recommend Repair","Recommend Replacement","Repair Needed","Satisfactory","Satisfactory / Fair","Unsatisfactory"]

//   //  var StatusArray = ["Inspected","Functional","Inspected - Appears Functional","Operational","Acceptable Condition","Not Inspected","Not Accessible","Limited Inspection","Not Visible",
//          "Inaccessible or Obstructed Area(s)","Not Present","Absent / None","Missing","Damaged / Repair Needed","Correction Needed","Non-Functional","Recommend Repairs","Repair or Replace",
//          "Monitor Conditions","Minor Repair Needed","Minor Repair, Cosmetic Only","Unacceptable",
//          "Unsatisfactory","Attention Recommended","Attention Required","Inoperable","Further Inspection Needed","Further Inspection Recommended","Further Evaluation Needed","Evaluate Further",
//          "Investigate Further","Defective","Immediate Attention Required","Recommend Maintenance",
//          "Safety Hazard","Safety Concern","Safety Issue","Danger - Qualified Professional Only",
//          "Dangerous","Major Defect"]
     @IBOutlet weak var tableViewRealtors: UITableView!
     var ansTextFieldController: MDCTextInputControllerUnderline!
     //      ansTextFieldController = MDCTextInputControllerUnderline(textInput: firstName)
     var isExpanded:Bool = false
     {
          didSet
          {
               if !isExpanded {
                    self.imgHeightConstraint.constant = 0.0
                    //self.mainView4.isHidden = true
                    tb1.isHidden = true
                   
               } else {
                   
                    if questionArray.count == 0
                    {
                         
                         self.imgHeightConstraint.constant = 0.0
                    }
                    else
                    {
                         print("questionarray count ",questionArray.count)
                         var height: CGFloat
                         height = CGFloat(questionArray.count + 3) * 110.0
                         print("height :---->",height)
                         self.imgHeightConstraint.constant = height + 80
                    }
               }
          }
     }
     var isExpanded1:Bool = false
     {
          didSet
          {
               if !isExpanded1 {
                    self.imgHeightConstraint.constant = 0.0
                    // self.mainView4.isHidden = true
               } else {
                    
                    if questionArray.count == 0
                    {
                         self.imgHeightConstraint.constant = 0.0
                    }
                    else
                    {
                         self.imgHeightConstraint.constant = 0.0
                    }
                    
               }
          }
     }
     var isExpanded2:Bool = false
     {
          didSet
          {
               if !isExpanded2 {
                    self.imgHeightConstraint.constant = 0.0
                    // self.mainView4.isHidden = true
                    
               } else {
                    
                    self.imgHeightConstraint.constant = 000.0
               }
          }
     }
     var isExpanded3:Bool = false
     {
          didSet
          {
               if !isExpanded3 {
                    self.imgHeightConstraint.constant = 0.0
                    // self.mainView4.isHidden = true
                    
                    
               } else {
                    if questionArray.count == 0
                    {
                         self.imgHeightConstraint.constant = 0.0
                    }
                    else
                    {
                         self.imgHeightConstraint.constant = 00.0
                    }
               }
          }
     }
     
     override func awakeFromNib() {
          super.awakeFromNib()
      //    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
          
          //view1.isHidden = true
//          self.tableViewRealtors.layer.cornerRadius = 5.0;
//          self.tableViewRealtors.layer.borderWidth = 1.0;
//          self.tableViewRealtors.layer.borderColor = UIColor.lightGray.cgColor
          self.img.layer.cornerRadius = 5.0;
          self.img.layer.borderWidth = 1.0;
          self.img.layer.borderColor = UIColor.lightGray.cgColor
          tableViewRealtors.delegate = self
          tableViewRealtors.dataSource = self
          tableViewRealtors.separatorStyle = UITableViewCellSeparatorStyle.singleLine
         //     print("minu3..",self.qusArr)
          self.pickerView1.isHidden = true
          
          
     }
      //MARK:- Collection delegate
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         
          if (categoiresimagarray.count > 0 ){
               return categoiresimagarray.count
          }else{
               return 1
          }
        //  return categoiresimagarray.count
         // return 15
          
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          
          SVProgressHUD.dismiss()
          guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pics", for: indexPath) as? CollectionViewCellPics
               else{
                    return UICollectionViewCell()
          }
          if (categoiresimagarray.count > 0 )
          {
               let imagename = CategoiresImagesIDArray[indexPath.row]
               let paths1 = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imagename)
               let fileManager = FileManager.default
               if fileManager.fileExists(atPath: paths1)
               {
                    cell.imageVIew1.image = UIImage(contentsOfFile: paths1)
                    
               }else
               {
                    print("No Image")
                    
               }
          }
          
          
          return cell
     }
     
     //MARK:- Tableview delegate
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
     {
          if tableView == tb1{
               //        return inputArray.count
               if(self.SearchFlag)
               {
                    return searchResultArr.count
               }
               else
               {
                    return inputArray.count
               }
          }else{
               
               //if(questionArray.count>0){
//                    questionArray.append("Status")
//                    questionArray.append("Result")
//                    questionArray.append("Comment")
               //}
               
               return questionArray.count
          }
          
          
          //  return questionArray.count
     }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
     {
          if(tableView == tb1){
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
               SVProgressHUD.dismiss()
               return cell
          }else
          {
                    tableViewRealtors.separatorStyle = .none
                    let cell:InsideRealtorsTableViewCell = tableViewRealtors.dequeueReusableCell(withIdentifier: "InsideRealtorsTableViewCell") as! InsideRealtorsTableViewCell
                    
                    cell.selectionStyle = .none
                   
                    // ansTextFieldController = MDCTextInputControllerUnderline(textInput: cell.TxtAns)
                    if questionArray.count > indexPath.row {
                         
                         let attributedString = NSMutableAttributedString(string: questionArray[indexPath.row])
                         attributedString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSRange(location: 0, length: attributedString.length))
                         
                         //Underline effect here
                         cell.mailLbl.attributedText = attributedString
                         
                        // cell.mailLbl.text = questionArray[indexPath.row]
                         
                         if default_ansArray.count <= indexPath.row
                         {
                             cell.mailLbl.font = cell.mailLbl.font.withSize(18)
                            //  cell.mailLbl.textColor = UIColor.orange
                              let tagnumber = indexPath.row - answerArray.count
                              if tagnumber == 0
                              {
                                 cell.TxtAns.text = default_StatusArray[0][0]
                              }else if tagnumber == 1
                              {
                                 cell.TxtAns.text = default_ResultArray[0][0]
                              }
                              else if tagnumber == 2
                              {
                                   
                                  // cell.TxtAns.text = default_CommentArray[0][0]
                                   let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsTableViewCell") as! CommentsTableViewCell
//                                   let bottomLine = CALayer()
//                                   bottomLine.frame = CGRect(x: 0, y: cell.txt_comments.frame.height - 1, width: cell.txt_comments.frame.width, height: 1)
//                                  // bottomLine.frame = CGRectMake(0.0, cell.txt_comments.frame.height - 1, cell.txt_comments.frame.width, 1.0)
//                                   bottomLine.backgroundColor = UIColor.lightGray.cgColor
//
//                                 //  cell.txt_comments.borderStyle = UITextBorderStyle.None
//                                   cell.txt_comments.layer.addSublayer(bottomLine)
                                   cell.txt_comments.text = default_CommentArray[0][0]
                                   return cell
                              }
                         }
                    }
                    if default_ansArray.count > indexPath.row
                    {
                         cell.TxtAns.text = default_ansArray[indexPath.row][0]
                    }
                    cell.mailLbl.numberOfLines = 2
                    cell.mainBtnOut.tag = indexPath.row
                    cell.TxtAns.tag = indexPath.row
                    cell.TxtAns.delegate = self
                    return cell
          }
          
     }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          if tableView == tb1{
               return 40;
               
          }else{
               return 120
          }
     }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
     {
          
          if(tableView == tb1)
          {
//               guard let cell = tableViewRealtors.cellForRow(at: indexPathNew) as? InsideRealtorsTableViewCell
//                    else { return }
//               print(inputArray[indexPath.row])
               
               if(fromcomment == "comment"){
                    guard let cell = tableViewRealtors.cellForRow(at: indexPathNew) as? CommentsTableViewCell
                         else{
                              return
                    }
                    var searchStr :String = "";
                    searchStr = cell.txt_comments.text!
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
                                   cell.txt_comments.text = NewStr + ", " + searchResultArr[indexPath.row]
                                   // cell.TxtAns.text = searchResultArr[indexPath.row];
                              }
                              else
                              {
                                   
                                   cell.txt_comments.text = searchResultArr[indexPath.row];
                              }
                              
                         }
                         else
                         {
                              if( NewStr != "")
                              {
                                   let lastChar = NewStr.last!
                                   if(lastChar == ",")
                                   {
                                        NewStr = String(NewStr.dropLast())
                                   }
                                   cell.txt_comments.text = NewStr + ", " + inputArray[indexPath.row]
                                   // cell.TxtAns.text = inputArray[indexPath.row];
                              }
                              else
                              {
                                   
                                   cell.txt_comments.text = inputArray[indexPath.row];
                              }
                         }
                         self.SearchFlag = false;
                    }
                    else
                    {
                         if(self.SearchFlag)
                         {
                              
                              cell.txt_comments.text = searchResultArr[indexPath.row];
                         }
                         else
                         {
                              
                              cell.txt_comments.text = inputArray[indexPath.row];
                         }
                         self.SearchFlag = false;
                    }
                    tb1.isHidden = true
                    self.SearchFlag = false;
               }else{
                    guard let cell = tableViewRealtors.cellForRow(at: indexPathNew) as? InsideRealtorsTableViewCell
                         else { return }
                    print(inputArray[indexPath.row])
                    if(self.SearchFlag)
                    {
                         cell.TxtAns.text = searchResultArr[indexPath.row];
                    }
                    else
                    {
                         cell.TxtAns.text = inputArray[indexPath.row];
                    }
                    tb1.isHidden = true
                    self.SearchFlag = false;
               }
               
              
               
               
               
//
          }else{
               
               if answerArray.count > indexPath.row
               {
                    print("a..",answerArray[indexPath.row])
                    var searchStr :String = "";
                    searchStr = answerArray[indexPath.row][0]
                    let keysArray :[String] = searchStr.components(separatedBy: ";")
                    print(keysArray)
               }
               else
               {
                    
               }
               
          }
     }
     @IBAction func hideBtnAction(_ sender: Any){
          
     }
     @IBAction func btn_picsAction(_ sender: Any)
     {
          print("Nilesh pics button clicked")
          print("catIdstr ",catIdstr!)
          print("subcatstr ",sub_catIdstr!)

     }
     @IBAction func nileshcheck(_ sender: Any)
     {
          
     }
     
     
     //MARK:- textfield delegate
     func textFieldDidBeginEditing(_ textField: UITextField)
     {
        
          print("Nilesh ",textField.tag);
          if answerArray.count > textField.tag
          {
               SVProgressHUD.show(withStatus: "Please wait..")
               SVProgressHUD.setDefaultMaskType(.clear)
              fromcomment = ""
               var searchStr :String = "";
               searchStr = answerArray[textField.tag][0]
               let keysArray :[String] = searchStr.components(separatedBy: ";")
               print(keysArray)
               indexPathNew = IndexPath(row: textField.tag, section: 0)
               guard let cell = tableViewRealtors.cellForRow(at: indexPathNew) as? InsideRealtorsTableViewCell
                    else
               {
                    return
                    
               }
               self.tb1.frame = CGRect(x: cell.frame.origin.x+21, y: cell.frame.origin.y+195, width: cell.frame.size.width-10, height: 160)
              
               self.tb1.dataSource = self
               self.tb1.delegate = self
                self.SearchFlag = false
               self.tb1.register(UITableViewCell.self, forCellReuseIdentifier: "cell11")
               self.tb1.setContentOffset(.zero, animated: false)
                self.SearchFlag = false
               self.inputArray = keysArray;
               self.tb1.reloadData()
              self.tb1.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
                self.tb1.layer.borderWidth = 2
                self.tb1.layer.borderColor = UIColor.gray.withAlphaComponent(1.0).cgColor
                self.tb1.layer.cornerRadius = 10
                self.tb1.clipsToBounds = true
               
               
               self.addSubview(self.tb1)
               tb1.isHidden = false
               tb1.delegate = self
          }else{
               
               indexPathNew = IndexPath(row: textField.tag, section: 0)
               guard let cell = tableViewRealtors.cellForRow(at: indexPathNew) as? InsideRealtorsTableViewCell
                    else
               {
                    return
                    
               }
               self.tb1.frame = CGRect(x: cell.frame.origin.x+21, y: cell.frame.origin.y+195, width: cell.frame.size.width-10, height: 160)
               self.tb1.dataSource = self
               self.tb1.delegate = self
               self.tb1.layer.borderWidth = 2
                self.tb1.layer.cornerRadius = 10
               self.tb1.layer.borderColor = UIColor.gray.withAlphaComponent(1.0).cgColor
              self.tb1.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
               self.tb1.clipsToBounds = true
               self.tb1.register(UITableViewCell.self, forCellReuseIdentifier: "cell11")
               self.tb1.setContentOffset(.zero, animated: false)
               let tagnumber = textField.tag - answerArray.count
               if tagnumber == 0
               {
                    fromcomment = ""
                    self.SearchFlag = false
                    self.inputArray = statusArray
                    self.tb1.reloadData()
                    self.addSubview(self.tb1)
                     tb1.isHidden = false
               }
               else if tagnumber == 1
               {
                    fromcomment = ""
                    self.SearchFlag = false
                   self.inputArray = resultArray
                    self.tb1.reloadData()
                    self.addSubview(self.tb1)
                     tb1.isHidden = false
               }else{
                  // tb1.isHidden = true
                    fromcomment = "comment"
                    var searchStr :String = "";
                    searchStr = commentsarray[0][0]
                    let keysArray :[String] = searchStr.components(separatedBy: ";")
                    print(keysArray)
                    indexPathNew = IndexPath(row: textField.tag, section: 0)
                    guard let cell = tableViewRealtors.cellForRow(at: indexPathNew) as? InsideRealtorsTableViewCell
                         else
                    {
                         return
                         
                    }
                    self.tb1.frame = CGRect(x: cell.frame.origin.x+21, y: cell.frame.origin.y+195, width: cell.frame.size.width-10, height: 130)
                    self.tb1.dataSource = self
                    self.tb1.delegate = self
                    self.tb1.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
                    self.tb1.layer.borderWidth = 2
                    self.tb1.layer.cornerRadius = 10
                    self.tb1.layer.borderColor = UIColor.gray.withAlphaComponent(1.0).cgColor
                    self.tb1.clipsToBounds = true
                    self.SearchFlag = false
                    self.tb1.register(UITableViewCell.self, forCellReuseIdentifier: "cell11")
                    self.tb1.setContentOffset(.zero, animated: false)
                    self.inputArray = keysArray;
                    self.tb1.reloadData()
                    self.addSubview(self.tb1)
                    self.bringSubview(toFront: self.tb1)
                    tb1.isHidden = false
                    tb1.delegate = self
               }
//               self.inputArray = StatusArray
//               self.tb1.reloadData()
//               self.addSubview(self.tb1)
//               tb1.isHidden = false
              
          }
         
     }
     func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
          print("done");
          tb1.isHidden = true
          let textTag = textField.tag
          
          print("repalce text ",textField.text!)
          print(textTag)
          print(sub_catIdstr!)
          
          if answerArray.count > textField.tag{
               
               let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "InspectedQA")
               let sub_catId = NSPredicate(format: "sub_catId = %@",sub_catIdstr! )
               let inspectionId = NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
               let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [sub_catId, inspectionId])
               fetchRequest.predicate = andPredicate
               do{
                    let res = try context.fetch(fetchRequest)
                    let updateObject = res[textTag] as! NSManagedObject
                    updateObject.setValue(textField.text, forKey: "defultAns")
                    do{
                         try context.save()
                    }catch{
                         print(error)
                    }
               }
               catch{
                    print(error)
               }
               
          }else{
               let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "InspectedQA")
               let sub_catId = NSPredicate(format: "sub_catId = %@",sub_catIdstr! )
               let inspectionId = NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
               let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [sub_catId, inspectionId])
               fetchRequest.predicate = andPredicate
               do{
                    //let res = try context.fetch(fetchRequest)
                    let tagnumber = textTag - answerArray.count
                    if tagnumber == 0
                    {
                        // cell.TxtAns.text = default_StatusArray[0][0]
                          let res = try context.fetch(fetchRequest)
                         let updateObject = res[tagnumber] as! NSManagedObject
                         updateObject.setValue(textField.text, forKey: "status")
                         do{
                              try context.save()
                         }catch{
                              print(error)
                         }
                         
                    }else if tagnumber == 1
                    {
                        // cell.TxtAns.text = default_ResultArray[0][0]
                         
                         let res = try context.fetch(fetchRequest)
                         let updateObject = res[0] as! NSManagedObject
                         updateObject.setValue(textField.text, forKey: "result")
                         do{
                              try context.save()
                         }catch{
                              print(error)
                         }
                         
//                         let updateObject = res[tagnumber] as! NSManagedObject
//                         updateObject.setValue(textField.text, forKey: "result")
                    }
                    else if tagnumber == 2
                    {
                        // cell.TxtAns.text = default_CommentArray[0][0]
//                         let updateObject = res[tagnumber] as! NSManagedObject
//                         updateObject.setValue(textField.text, forKey: "comment")
                         let res = try context.fetch(fetchRequest)
                         let updateObject = res[0] as! NSManagedObject
                         updateObject.setValue(textField.text, forKey: "comment")
                         do{
                              try context.save()
                         }catch{
                              print(error)
                         }
                         
                    }
                    
                   
                    do{
                         try context.save()
                    }catch{
                         print(error)
                    }
               }
               catch{
                    print(error)
               }
          }
          
          return true
     }
     
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
     {
          print("text = ",textField.text!)
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
               if(string == "") && textField.text?.count == 1{
                 SearchFlag = false;
               }else{
                   SearchFlag = true;
               }
              // SearchFlag = true;
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
          }
          return true
     }
      //MARK:- textView delegate
     
     public func textViewDidBeginEditing(_ textView: UITextView){
          fromcomment = "comment"
          var searchStr :String = "";
          searchStr = commentsarray[0][0]
          let keysArray :[String] = searchStr.components(separatedBy: ";")
          print(keysArray)
          indexPathNew = IndexPath(row: questionArray.count - 1, section: 0)
          guard let cell = tableViewRealtors.cellForRow(at: indexPathNew) as? CommentsTableViewCell
               else{
               return
          }
          self.tb1.frame = CGRect(x: cell.frame.origin.x+21, y: cell.frame.origin.y+200, width: cell.frame.size.width-10, height: 130)
          self.tb1.dataSource = self
          self.tb1.delegate = self
          self.tb1.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
          self.tb1.layer.borderWidth = 2
          self.tb1.layer.cornerRadius = 10
          self.tb1.layer.borderColor = UIColor.gray.withAlphaComponent(1.0).cgColor
          self.tb1.clipsToBounds = true
          self.SearchFlag = false
          self.tb1.register(UITableViewCell.self, forCellReuseIdentifier: "cell11")
          self.tb1.setContentOffset(.zero, animated: false)
          self.inputArray = keysArray;
          self.tb1.reloadData()
          self.addSubview(self.tb1)
          self.bringSubview(toFront: self.tb1)
          tb1.isHidden = false
          tb1.delegate = self
     }
     public func textViewShouldEndEditing(_ textView: UITextView) -> Bool{
          print("done");
          tb1.isHidden = true
      
          print("repalce text ",textView.text!)
         
          print(sub_catIdstr!)
          
          let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "InspectedQA")
          let sub_catId = NSPredicate(format: "sub_catId = %@",sub_catIdstr! )
          let inspectionId = NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
          let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [sub_catId, inspectionId])
          fetchRequest.predicate = andPredicate
          do{
               //let res = try context.fetch(fetchRequest)
               let tagnumber = 2
               if tagnumber == 2
               {
                    let res = try context.fetch(fetchRequest)
                    let updateObject = res[0] as! NSManagedObject
                    updateObject.setValue(textView.text, forKey: "comment")
                    do{
                         try context.save()
                    }catch{
                         print(error)
                    }
               }
               
          }catch
          {
               print(error)
          }
               
          return true
     }
     public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
          print("text = ",textView.text!)
          if(text == ",")
          {
               searchResultArr.removeAll()
               if(textView.text?.count == 0)
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
               if(text == "") && textView.text?.count == 1{
                    SearchFlag = false;
               }else{
                    SearchFlag = true;
               }
               // SearchFlag = true;
               var searchStr :String = "";
               searchStr = textView.text! + text;
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
          }
          return true
     }
}

