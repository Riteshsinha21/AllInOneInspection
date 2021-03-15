//
//  ExpandableCell2.swift
//  AllInOne
//
//  Created by Apple on 11/13/18.
//  Copyright © 2018 mac08. All rights reserved.
//

import UIKit
import MaterialComponents
import Alamofire
class ExpandableCell2: UITableViewCell {
   

  /*  @objc func handleButtonClicked(_ sender: UIButton) {
        
        //Create index path...
         myIndexPath = NSIndexPath(row: sender.tag, section: 0)
   
       // let cell2:InsideRealtorsTableViewCell = tableViewRealtors.dequeueReusableCell(withIdentifier: "InsideRealtorsTableViewCell") as! InsideRealtorsTableViewCell
        guard let cell = tableViewRealtors.cellForRow(at: myIndexPath! as IndexPath) as? InsideRealtorsTableViewCell
            else { return }
        print("diddididi",(myIndexPath?.row)!)
        cell.view1.isHidden = false
       self.hideView.isHidden = false
        noStr = "A"
//        view2.isHidden = false
//      //  print("ans123=",answerArray[myIndexPath.row])
//        self.answerArray1 = answerArray[myIndexPath.row] as! [String]
//        print("answerArray123=",answerArray1)
//
//        yesBtnOut.titleLabel?.text = self.answerArray1[0]
//        noBtnOut.titleLabel?.text = self.answerArray1[1]
//        view2.isHidden = false
//        self.hideBtn.isHidden = false
        
    }
    
//varialbles..
    var expandedRows = Set<Int>()
    var indexesNeedPicker: [NSIndexPath]?
    var catimage : String? = ""
    var ans : String? = ""

    var success1 : NSNumber? 
    var questionArray = [String]()
    var answerArrayCell = [Array<Any>]()
    var myIndexPath: NSIndexPath?
    // Outlets...
    @IBOutlet var tableViewRealtors: UITableView!
    @IBOutlet weak var imgHeightConstraint: NSLayoutConstraint!
    @IBOutlet var yesBtnOut: UIButton!
     @IBOutlet var noBtnOut: UIButton!
    @IBOutlet var view2: UIView!
    @IBOutlet var pickerView1: UIPickerView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet var hideBtn: UIButton!
    @IBOutlet weak var hideView: UIView!
    @IBOutlet weak var hideBtnOut: UIButton!
    
    var firstNameTextFieldController: MDCTextInputControllerUnderline!
    var lastNameTextFieldController: MDCTextInputControllerUnderline!
    var phoneNoTextFieldController: MDCTextInputControllerUnderline!
    var addressTextFieldController: MDCTextInputControllerUnderline!
    var cityTextFieldController: MDCTextInputControllerUnderline!
    var stateTextFieldController: MDCTextInputControllerUnderline!
    var emailTextFieldController: MDCTextInputControllerUnderline!
    var isExpanded:Bool = false
    {
        didSet
        {
            if !isExpanded {
                self.imgHeightConstraint.constant = 0.0
                
            } else {
                self.imgHeightConstraint.constant = 600.0
            }
        }
    }

    @IBAction func btnActn(_ sender: Any){
       
        tableViewRealtors.reloadData()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.view2.layer.cornerRadius=5
//        self.view2.layer.shadowColor = UIColor.black.cgColor
//        self.view2.layer.shadowOpacity = 0.7
//        self.view2.layer.shadowOffset = CGSize.zero
//        self.view2.layer.shadowRadius = 4
//        self.view2.clipsToBounds = false
//        self.view2.layer.masksToBounds = false;
//        self.view2.isHidden = true;
        self.tableViewRealtors.layer.cornerRadius = 5.0;
        self.tableViewRealtors.layer.borderWidth = 1.0;
        self.tableViewRealtors.layer.borderColor = UIColor.lightGray.cgColor
        tableViewRealtors.delegate = self
        tableViewRealtors.dataSource = self
       
       // yesBtnOut.titleLabel?.text = ansStr0
        //categoryListAPI2()

   // pickerView1.delegate = self
        //pickerView1.dataSource = self
        // Initialization code
        self.questionArray = ["ques1","ques2"]
        self.answerArrayCell = [["true","false"],["true1","false1"]]
        
//                            self.answerArray1=(dt11["answers"] as! NSArray) as! [Array]
//                            print("answerArray",self.answerArray)
    }
//    override func layoutSubviews() {
//        yesBtnOut.titleLabel?.text = ansStr0
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        tableViewRealtors.separatorStyle = .none
        let cell:InsideRealtorsTableViewCell = tableViewRealtors.dequeueReusableCell(withIdentifier: "InsideRealtorsTableViewCell") as! InsideRealtorsTableViewCell
        
        cell.selectionStyle = .none
        
      
        self.hideView.isHidden = true
//        let newView = UIView(frame: CGRect(x: 210, y: 10, width: 110, height: 200))
//        newView.backgroundColor = UIColor.red.withAlphaComponent(0.9)
//        cell.contentView.addSubview(newView)

        cell.view1.isHidden = true
        cell.mainBtnOut.tag = indexPath.row
        cell.mailLbl.text = self.questionArray[indexPath.row]
      
//
        if noStr == "A"
        {
            let arry1 = self.answerArrayCell[(myIndexPath?.row)!]
            print("array1",arry1)
            cell.mainBtnOut.titleLabel?.text = arry1[(myIndexPath?.row)!] as? String
        }
        else{
            let arry1 = self.answerArrayCell[indexPath.row]
            print("array2",arry1)
            cell.mainBtnOut.titleLabel?.text = arry1[indexPath.row] as? String
        }
//        self.hideBtnOut.titleLabel?.text = arry1[(myIndexPath?.row)!] as? String
//        ans = self.hideBtnOut.titleLabel?.text
//        cell.mainBtnOut.titleLabel?.text = ans
        
        print("GHU",(cell.ansLbl.text)!)
        cell.mainBtnOut.addTarget(self, action:#selector(handleButtonClicked(_:)), for: .touchUpInside)
       
 
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 100
    }
   
    
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
//        print("diddididi",indexPath.row)
//        view2.isHidden = false
//        print("ans123=",answerArray[indexPath.row])
//        self.answerArray1 = answerArray[indexPath.row] as! [String]
//        print("answerArray123=",answerArray1)
//
//        yesBtnOut.titleLabel?.text = self.answerArray1[0]
//        noBtnOut.titleLabel?.text = self.answerArray1[1]
        
//        if indexesNeedPicker != nil {
//            if indexesNeedPicker!.contains(indexPath as NSIndexPath) == true {
//                //indexesNeedPicker!.removeAtIndex((indexesNeedPicker!.indexOf(indexPath))!)
//                return
//            }
//        }
//        indexesNeedPicker?.append(indexPath as NSIndexPath)
        
        //self.tableViewRealtors.deselectRow(at: indexPath, animated: true)
      
        
      // methodCall()
        
    
    }
    func methodCall()
    {
          print("ncej")
          let myIndexPath = NSIndexPath(row:tag, section: 0)
          let cell2:InsideRealtorsTableViewCell = tableViewRealtors.dequeueReusableCell(withIdentifier: "InsideRealtorsTableViewCell") as! InsideRealtorsTableViewCell
         print("123456",myIndexPath.row)
//        guard let cell = tableViewRealtors.cellForRow(at: IndexPath) as? InsideRealtorsTableViewCell
//            else { return }
       
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        guard let cell = tableViewRealtors.cellForRow(at: indexPath) as? InsideRealtorsTableViewCell
            else { return }
        cell.view1.isHidden = true
        
//        self.view2.isHidden = true
//        self.answerArray1 = answerArray[indexPath.row] as! [String]
//        yesBtnOut.titleLabel?.text = self.answerArray1[0]
//        noBtnOut.titleLabel?.text = self.answerArray1[1]
    }
   
    
    func categoryListAPI2()
    {
        //let url=baseURl+CategoryList
        let url = "http://allin1inspections.com/admin/webservices/category_data"
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: headers).responseString{ response in
            //  let json = response.result.value
            print(response.result.value!)
            
            
            let dict = convertToDictionary(text: response.result.value!)
            
            print("dict123",dict!)
            
            self.success1=(dict!["success"] as! NSNumber)
            print("success1",self.success1!)
            
            switch(response.result){
            case .success(_):
                print("sucess")
                
                let dt0=dict!["data"] as! [Dictionary<String,AnyObject>]
                
                print("dt0",dt0)
                
            
                
                for  i in 0..<dt0.count{
                    print(i)
                    var dt11=dt0[i] as Dictionary<String,AnyObject>
                    // print("dt11",dt11["category_id"]!)
                    self.catimage=(dt11["cat_image"] as! String)//dt0.value(forKey: "category_id") as Any
                    print("catimage",self.catimage!)
                    self.questionArray=(dt11["questions"] as! NSArray) as! [String]
                    print("dtQuestion",self.questionArray)
//                    self.answerArray=(dt11["answers"] as! NSArray) as! [Array]
//                    print("answerArray",self.answerArray)
                 
                    
                    
                }
                
                
                self.tableViewRealtors.reloadData()
                
                
                
                
                
                
            case .failure(_):
                print("fail")
                break
            }
            
            
        }
        
    }*/
}

    
    
    
        

