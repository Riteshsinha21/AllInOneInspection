//
//  InfoVC.swift
//  AllInOne
//
//  Created by Apple on 11/2/18.
//  Copyright © 2018 mac08. All rights reserved.
//

import UIKit
import Alamofire
import CoreData
import MaterialComponents
@available(iOS 10.0, *)
class InfoVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,PagerDataSource
{
    
    @IBOutlet weak var expandView: UIView!
    @IBOutlet weak var expandscollectionview: UICollectionView!
    
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    private let leftAndRightPaddings: CGFloat = 15.0
    private let numberOfItemsPerRow: CGFloat = 3.0
    var data=[Dictionary<String,AnyObject>]()
    var subCat3=[Dictionary<String,AnyObject>]()
    var qus=[Dictionary<String,AnyObject>]()
    var ans=[String:String]()
    
    var dic : Dictionary<String,AnyObject>!
    var dic1: [String: [[String:Any]]] = [
        "items": []
    ]
    var selectedIndexforAssingImage : Int = 0
    var selectedIndex : Int = 20
    var subCat1 = Dictionary<String,AnyObject>()
    var qus2 = Dictionary<String,AnyObject>()
    var ans2 = Dictionary<String,AnyObject>()
    
    @IBOutlet weak var lbl_categoiresCheckUncheck: UILabel!
    @IBOutlet weak var btn_checkuncheck: UIButton!
    
    
    //Variables...
    var infoArray = ["Client","Realtors","Inspections Info","Inspector"]
    var categoryListArray = ["ab","cd","ef","gh"]
    var expandedRows = Set<Int>()
    var request: Alamofire.Request? {
        didSet {
            
        }
    }
    var client_name = [String]()
    var property_name = [String]()
    var myUsers = [String]()
    var categorylist=[Category]()
    var subCatId : String? = ""
    var subCatName : String? = ""
    var subCatInclude : String? = ""
    var qusName : String? = ""
    var ansName : String = ""
    var yes : String=""
    
    var success1 : NSNumber?
    var subCatArray = [String]()
    var subCatID = [String]()
    var subCatArray3 = [Dictionary<String,AnyObject>?]()
    
    //var subCatArray2 = [String]()
    var subCatArray2: [[String]] = []
    var dt11 : Dictionary<String,AnyObject>?
    var subCat: Dictionary<String,AnyObject>?
    var includeArray = [String]()
    var data2 : NSData!
    var iscategoiresImages: Bool = false
    var ischeck: Bool = true
    var ischeckforquestions: Bool = true
    var ischeckforincludesummery: Bool = false
    
    //Outlets...
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var tableView2: UITableView!
    @IBOutlet weak var tableView4: UITableView!
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var includeBtn: UIButton!
    @IBOutlet weak var tpLbl: UILabel!
    @IBOutlet weak var hideView1: UIView!
    @IBOutlet weak var hideViewBtn1Outlet: UIButton!
    @IBOutlet weak var hideViewBtn4Outlet: UIButton!
    
    
    //MARK:- Load Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        includeArray = ["YES","NO"]
        DispatchQueue.main.async {
            
            
            self.tableView1.delegate = self
            self.tableView1.dataSource = self
            self.tableView1.rowHeight = UITableViewAutomaticDimension
            self.collectionView1.delegate = self
            self.collectionView1.dataSource = self
            self.tableView1.isHidden = true
            
            if ConnectionCheck.isConnectedToNetwork()
            {
                if finalG == "FG"
                {
                    
                    self.categoryListAPI2()
                }
                else
                {
                    if(userDefault.bool(forKey: "firstTime")){
                        self.categoryListAPI2()
                    }else{
                        self.getCategoies()
                        self.getStatusData()
                        self.getResultData()
                    }
                }
            }
            else
            {
                print("no internet")
                
                self.getStatusData()
                self.getResultData()
                if finalG == "FG"
                {
                    
                }else{
                    self.getCategoies()
                    self.getStatusData()
                    self.getResultData()
                }
            }
            
            
            self.includeBtn.isHidden = true
            self.lbl_categoiresCheckUncheck.isHidden = true
            
            
            
        }
        self.setheightToexpandView()
        
        if UIDevice.current.userInterfaceIdiom == .phone
            
        {
            
            let width = (expandView.frame.size.width ) / numberOfItemsPerRow//+1
            let layout = expandscollectionview.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = CGSize(width: width - 10 , height: width - 10)
            expandscollectionview!.decelerationRate = UIScrollViewDecelerationRateFast
        }
        else
        {
            
            let width = (expandView.frame.size.width ) / numberOfItemsPerRow//+1
            let layout = expandscollectionview.collectionViewLayout as? UICollectionViewFlowLayout
            layout?.itemSize = CGSize(width: width - 10, height: width - 10)
            expandscollectionview!.decelerationRate = UIScrollViewDecelerationRateFast
        }
        self.expandscollectionview?.isPrefetchingEnabled = false
        self.expandscollectionview.delegate = self
        self.expandscollectionview.dataSource = self
    }
    
    func setheightToexpandView(){
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            
            if DeviceType.iPhone4orLess{
                expandView.frame = CGRect(x: 0.0, y: 0.0, width:view.frame.size.width-50 , height: view.frame.size.height - 100 )
            }else if DeviceType.iPhone5orSE{
                expandView.frame = CGRect(x: 0.0, y: 0.0, width:view.frame.size.width - 50, height:view.frame.size.height - 100 )
            }else if DeviceType.iPhone678{
                expandView.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width - 50, height: view.frame.size.height - 100)
            }else if DeviceType.iPhone678p{
                expandView.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width - 50, height: view.frame.size.height - 100)
            }else if DeviceType.iPhoneX{
                expandView.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width - 50, height: view.frame.size.height - 100)
            }else{
                expandView.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width - 50, height: view.frame.size.height - 100)
            }
            break
        case .pad:
            
            if DeviceType.IS_IPAD{
                
                expandView.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width - 50, height: view.frame.size.height - 100)
            }else if DeviceType.IS_IPAD_PRO{
                
                expandView.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width - 50, height: view.frame.size.height - 100)
            }else{
                expandView.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: view.frame.size.height)
            }
            break
        case .unspecified:
            break
        case .tv:
            break
        case .carPlay:
            break
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.getCategoies()
        self.getStatusData()
        self.getResultData()
        
    }
    
    // MARK:- TableView DataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == tableView1
        {
            return 1
        }
            
        else
        {
            return 1
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if tableView == tableView1
        {
            return subcatNameArray.count
        }
        else
        {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView == tableView1
        {
            
            guard let cell:ExpandableCell = tableView1.dequeueReusableCell(withIdentifier: "ExpandableCell") as? ExpandableCell
                else{
                    return UITableViewCell()
                    
            }
            // let cell:ExpandableCell = tableView1.dequeueReusableCell(withIdentifier: "ExpandableCell") as! ExpandableCell
            cell.selectionStyle = .none
            tableView1.separatorStyle = .none
            cell.largeLblTxt.layer.cornerRadius = 5.0
            let color = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
            
            cell.largeLblTxt.backgroundColor = UIColor.clear
            cell.largeLblTxt.layer.borderColor = color.cgColor
            cell.largeLblTxt.layer.borderWidth = 1.0
            cell.largeLblTxt.clipsToBounds = true
            cell.img.layer.cornerRadius = 5.0;
            cell.img.layer.borderWidth = 1.0;
            cell.img.layer.borderColor = color.cgColor
            
            
            cell.btn1Out.layer.cornerRadius = 5.0
            cell.garageLbl.text = question1
            cell.mainCutOfSwLbl.text = "Yes"
            cell.mainCutOfSwLbl.text = mainCutOfSwStr
            cell.mainCutOfSwLocationLbl.text = "Yes"
            cell.mainCutOfSwLocationLbl.text = mainCutOfSwLocaionStr
            cell.groundedLbl.text = groundedStr
            cell.servicePanelLbl.text = serviceSizeMainPanelStr
            cell.ampLbl.text = ampStr
            cell.serviceConnLbl.text = serviceConnectionStr
            cell.serviceDuringInsLbl.text = serviceOnDuringInspectionStr
            cell.typeOfWiringLbl.text = typeOfWiringStr
            cell.statusLbl.text = statusStr
            cell.resultLbl.text = resultStr
            cell.isExpanded = self.expandedRows.contains(indexPath.row)
            cell.lblTxt.text = subcatNameArray[indexPath.section]
            cell.lblTxt.numberOfLines = 0 ;
            cell.btn_checkuncheck.tag = indexPath.section
            cell.btn_picsOutlet.tag = indexPath.section
            cell.btn_AssingpicsOutlet.tag = indexPath.section
            cell.btn_addsummerycheckuncheck.tag = indexPath.section
            //  cell.btn_checkuncheck.addTarget(self, action: #selector(btn_ExcludefromSummeryAction(sender:)), for: .touchUpInside)
            if #available(iOS 11.0, *) {
                cell.btn_picsOutlet.addTarget(self, action: #selector(photoPressed(sender:)), for: .touchUpInside)
                cell.btn_AssingpicsOutlet.addTarget(self, action: #selector(AssingphotoPressed(sender:)), for: .touchUpInside)
                cell.btn_checkuncheck.addTarget(self, action: #selector(btn_ExcludefromSummeryAction(sender:)), for: .touchUpInside)
                cell.btn_addsummerycheckuncheck.addTarget(self, action: #selector(btn_IncludeInsummeryAction(sender:)), for: .touchUpInside)
            } else {
                // Fallback on earlier versions
            }
            //            cell.btn_addsummerycheckuncheck.addTarget(self, action: #selector(btn_IncludeInsummeryAction(sender:)), for: .touchUpInside)
            
            if(subcatInculdeInreportArray[indexPath.section] == "0")
            {
                ischeckforquestions = false
                cell.btn_checkuncheck.setImage(UIImage(named:"checkbox_b_uncheck"), for: UIControlState.normal)
            }
            else
            {
                ischeckforquestions = true
                cell.btn_checkuncheck.setImage(UIImage(named:"check-box"), for: UIControlState.normal)
            }
            
            cell.btn_picsOutlet.isHidden = true
            cell.btn_AssingpicsOutlet.isHidden = true
            cell.categoiresImagecollectionView.isHidden = true
            
            
            
            cell.btn_addsummerycheckuncheck.isHidden = true
            cell.lbl_AddsummeryUncheck.isHidden = true
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if tableView == tableView1
        {
            return 700.0
        }
        
        return 300.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView == tableView1
        {
            self.view.endEditing(true)
            
            self.getSubCategoies(catId: catIdstr!)
            print("section ",indexPath.section)
            guard let cell = tableView.cellForRow(at: indexPath) as? ExpandableCell
                else { return }
            sub_catIdstr = subcatIdArray[indexPath.section]
            subCatNameStr =  subcatNameArray[indexPath.section]
            if finalG == "FG"
            {
                answerArray.removeAll()
                questionArray.removeAll()
                default_ansArray.removeAll()
                default_ResultArray.removeAll()
                default_StatusArray.removeAll()
                default_CommentArray.removeAll()
                //                if(ischeckforquestions)
                //                {
                //                    self.getQA(subcatId: subcatIdArray[indexPath.section])
                //                }
                
                if(subcatInculdeInreportArray[indexPath.section] == "0"){
                    ischeckforquestions = false
                    
                    
                }else{
                    ischeckforquestions = true
                    
                    self.getQA(subcatId: subcatIdArray[indexPath.section])
                }
                
                
                
            }
            else
            {
                answerArray.removeAll()
                questionArray.removeAll()
                default_ansArray.removeAll()
                default_ResultArray.removeAll()
                default_StatusArray.removeAll()
                default_CommentArray.removeAll()
                
                
            }
            DispatchQueue.main.async {
                cell.tableViewRealtors.reloadData()
                cell.categoiresImagecollectionView.reloadData()
            }
            if(subcatInculdeInreportArray[indexPath.section] == "0"){
                ischeckforquestions = false
            }else{
                ischeckforquestions = true
                self.getComments(subcatId: sub_catIdstr!)
                self.getInspQA(subcatId: sub_catIdstr!, inspectionID: inspectionIdStr!)
                self.opencategoiresImages(subcatId: sub_catIdstr!, inspectionID: inspectionIdStr!)
            }
            if(cell.isExpanded)
            {
                print("isexpand true")
            }
            else
            {
                print("isexpand False")
            }
            
            let gray1 = UIColor(rgb: 0xEAEAEA)
            cell.largeLblTxt.backgroundColor = gray1
            
            switch cell.isExpanded
            {
            case true:
                self.expandedRows.remove(indexPath.row)
            case false:
                self.expandedRows.insert(indexPath.row)
            }
            if(cell.isExpanded){
                print("Nilesh is didselect expand section",indexPath.section)
                print("Nilesh is didselect expand row",indexPath.section)
                if(ischeckforquestions){
                    
                    cell.btn_picsOutlet.isHidden = true
                    cell.btn_AssingpicsOutlet.isHidden = true
                    cell.categoiresImagecollectionView.isHidden = true
                    cell.btn_addsummerycheckuncheck.isHidden = true
                    cell.lbl_AddsummeryUncheck.isHidden = true
                    if (iscategoiresImages)
                    {
                        cell.btn_picsOutlet.backgroundColor = UIColor.green
                    }else{
                        cell.btn_picsOutlet.backgroundColor = UIColor.blue
                    }
                }
            }else{
                print("Nilesh is else didselect expand section",indexPath.section)
                print("Nilesh is else didselect expand row",indexPath.section)
                if(ischeckforquestions){
                    
                    
                    if(questionArray.count > 0 ){
                        cell.btn_picsOutlet.isHidden = false
                        cell.btn_AssingpicsOutlet.isHidden = true
                        cell.categoiresImagecollectionView.isHidden = false
                        cell.btn_addsummerycheckuncheck.isHidden = false
                        cell.lbl_AddsummeryUncheck.isHidden = false
                        
                    }else{
                        cell.btn_picsOutlet.isHidden = true
                        cell.btn_AssingpicsOutlet.isHidden = true
                        cell.categoiresImagecollectionView.isHidden = true
                        cell.btn_addsummerycheckuncheck.isHidden = true
                        cell.lbl_AddsummeryUncheck.isHidden = true
                        
                    }
                    if (subcatsummeryInreportArray.count > 0){
                        if(subcatsummeryInreportArray[indexPath.row] == "0"){
                            ischeckforquestions = false
                            cell.btn_addsummerycheckuncheck.setImage(UIImage(named:"checkbox_b_uncheck"), for: UIControlState.normal)
                        }else{
                            ischeckforquestions = true
                            cell.btn_addsummerycheckuncheck.setImage(UIImage(named:"check-box"), for: UIControlState.normal)
                        }
                    }
                    if (iscategoiresImages)
                    {
                        cell.btn_picsOutlet.backgroundColor = UIColor.green
                    }else{
                        cell.btn_picsOutlet.backgroundColor = UIColor.blue
                    }
                }
                
            }
            cell.isExpanded = !cell.isExpanded
            self.tableView1.beginUpdates()
            self.tableView1.endUpdates()
            switch cell.isExpanded1
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
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        if tableView == tableView1
        {
            guard let cell = tableView1.cellForRow(at: indexPath) as? ExpandableCell
                else { return }
            
            self.expandedRows.remove(indexPath.row)
            
            cell.isExpanded = false
            cell.btn_picsOutlet.isHidden = true
            cell.btn_AssingpicsOutlet.isHidden = true
            cell.categoiresImagecollectionView.isHidden = true
            if (iscategoiresImages)
            {
                cell.btn_picsOutlet.backgroundColor = UIColor.green
            }else{
                cell.btn_picsOutlet.backgroundColor = UIColor.blue
            }
            cell.btn_addsummerycheckuncheck.isHidden = true
            cell.lbl_AddsummeryUncheck.isHidden = true
            cell.largeLblTxt.backgroundColor = UIColor.clear
            self.tableView1.beginUpdates()
            self.tableView1.endUpdates()
            
        }
        else
        {
            
        }
    }
    
    
    //MARK:- Collectionview Methods..
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == collectionView1){
            return catNameArray.count
        }else if (collectionView == expandscollectionview){
            return  myImagespath.count
        }
        return catNameArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if(collectionView == collectionView1){
            guard let cell = collectionView1.dequeueReusableCell(withReuseIdentifier: "info", for: indexPath as IndexPath) as? CollectionViewCellInfo
                else{
                    return UICollectionViewCell()
                    
            }
            if selectedIndex == indexPath.row
            {
                cell.view1.backgroundColor = UIColor(red: 255.0/255.0, green: 212.0/255.0, blue: 121.0/255.0, alpha: 1.0)
                
            }
            else
            {
                cell.view1.backgroundColor = UIColor(red: 214.0/255.0, green: 214.0/255.0, blue: 214.0/255.0, alpha: 1.0)
            }
            cell.lblTxt.text = catNameArray [indexPath.row]
            cell.view1.layer.borderColor=UIColor.black.cgColor;
            cell.view1.layer.borderWidth = 0.7;
            cell.view1.layer.cornerRadius = 5.0;
            self.includeBtn.tag = indexPath.row
            return cell
        }
        else if (collectionView == expandscollectionview)
        {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pics", for: indexPath) as? CollectionViewCellPics
                else{
                    return UICollectionViewCell()
                    
            }
            
            
            let paths1 = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(myImagesID[indexPath.row])
            
            let fileManager = FileManager.default
            
            if fileManager.fileExists(atPath: paths1){
                
                cell.imageVIew1.image = UIImage(contentsOfFile: paths1)
                
            }else{
                
                print("No Image")
                
            }
            let tickImage = cell.viewWithTag(1) as? UIImageView
            
            if _selectedCells.contains(indexPath.row) {
                cell.isSelected=true
                cell.layer.borderWidth = 5
                cell.layer.borderColor = UIColor.black.withAlphaComponent(1.0).cgColor
                cell.clipsToBounds = true
                expandscollectionview.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.top)
                tickImage?.isHidden=false
            }
            else{
                cell.isSelected=false
                cell.layer.borderWidth = 0
                cell.layer.borderColor = UIColor.clear.withAlphaComponent(1.0).cgColor
                cell.clipsToBounds = true
                tickImage?.isHidden=true
            }
            
            cell.layoutIfNeeded()
            return cell
            
        }
        else{
            guard let cell = collectionView1.dequeueReusableCell(withReuseIdentifier: "info", for: indexPath as IndexPath) as? CollectionViewCellInfo
                else{
                    return UICollectionViewCell()
                    
            }
            if selectedIndex == indexPath.row
            {
                cell.view1.backgroundColor = UIColor(red: 255.0/255.0, green: 212.0/255.0, blue: 121.0/255.0, alpha: 1.0)
                
            }
            else
            {
                cell.view1.backgroundColor = UIColor(red: 214.0/255.0, green: 214.0/255.0, blue: 214.0/255.0, alpha: 1.0)
            }
            cell.lblTxt.text = catNameArray [indexPath.row]
            cell.view1.layer.borderColor=UIColor.black.cgColor;
            cell.view1.layer.borderWidth = 0.7;
            cell.view1.layer.cornerRadius = 5.0;
            self.includeBtn.tag = indexPath.row
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        if(collectionView == collectionView1){
            
            
            selectedIndex = indexPath.row
            
            self.collectionView1.reloadData()
            
            
            self.includeBtn.isHidden = false
            self.lbl_categoiresCheckUncheck.isHidden = false
            
            self.includeBtn.setImage(UIImage(named:"check-box"), for: UIControlState.normal)
            self.tableView1.isHidden = false
            let cat_id = catIdArray[indexPath.row]
            catIdstr = cat_id
            cat_name = catNameArray[indexPath.row]
            self.getCategoies()
            self.getSubCategoies(catId: cat_id)
            
            if(catinculdeInReport[indexPath.row] == "0"){
                ischeck = false
                self.tableView1.isHidden = true
                self.includeBtn.setImage(UIImage(named:"checkbox_b_uncheck"), for: UIControlState.normal)
            }else{
                ischeck = true
                self.tableView1.isHidden = false
                self.includeBtn.setImage(UIImage(named:"check-box"), for: UIControlState.normal)
            }
            
            DispatchQueue.main.async
                {
                    self.tableView1.reloadData()
            }
            cat_name = catNameArray [indexPath.row]
            print(catNameArray [indexPath.row])
        }
        else if(collectionView == expandscollectionview)
        {
            selectedImagesID.removeAll()
            
            
            if _selectedCells.contains(indexPath.row) {
                _selectedCells.remove(indexPath.row)
            }else{
                _selectedCells.add(indexPath.row)
            }
            
            //   _selectedCells.add(indexPath.row)
            print("selectedCells..",_selectedCells)
            
            for i in 0 ..< _selectedCells.count{
                let k = _selectedCells[i] as! Int
                
                selectedImagesID.append(myImagesID[k])
            }
            
            expandscollectionview.reloadItems(at: [indexPath])
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath)
    {
        if(collectionView == collectionView1){
            self.tableView1.isHidden = true
        }
        else if(collectionView == expandscollectionview)
        {
            
            
        }
    }
    @available(iOS 11.0, *)
    @IBAction func Btn_SubmitAction(_ sender: Any)
    {
        
        for img in 0 ..< selectedImagesID.count
        {
            
            let entity = NSEntityDescription.entity(forEntityName: "AssingImages", in: context)
            let assingImages = NSManagedObject(entity: entity!, insertInto: context)
            print(img)
            
            assingImages.setValue(selectedImagesID[img], forKey: "image_id")
            assingImages.setValue("category", forKey: "cat_type")
            assingImages.setValue(catIdstr, forKey: "image_category_id")
            assingImages.setValue(sub_catIdstr, forKey: "image_sub_category_id")
            assingImages.setValue(cat_name, forKey: "image_category_name")
            assingImages.setValue(subCatNameStr, forKey: "image_sub_category_name")
            assingImages.setValue(inspectionIdStr, forKey: "inspectionId")
            assingImages.setValue("server", forKey: "server_image_Id")
            do {
                try context.save()
                print(try! context.save())
                
                print("assing Inspection images save")
                
            } catch {
                
                print("QA Failed saving")
            }
            
        }
        
        _selectedCells.removeAllObjects()
        
        let section = selectedIndexforAssingImage
        let row = 0
        let indexPath = IndexPath(row: row, section: section)
        
        print(indexPath.row)
        guard let cell = tableView1.cellForRow(at: indexPath) as? ExpandableCell
            else { return }
        
        self.expandedRows.remove(indexPath.row)
        
        cell.isExpanded = false
        cell.btn_picsOutlet.isHidden = true
        cell.btn_AssingpicsOutlet.isHidden = true
        cell.categoiresImagecollectionView.isHidden = true
        if (iscategoiresImages)
        {
            cell.btn_picsOutlet.backgroundColor = UIColor.green
        }else{
            cell.btn_picsOutlet.backgroundColor = UIColor.blue
        }
        cell.btn_addsummerycheckuncheck.isHidden = true
        cell.lbl_AddsummeryUncheck.isHidden = true
        cell.largeLblTxt.backgroundColor = UIColor.clear
        self.tableView1.beginUpdates()
        self.tableView1.endUpdates()
        
        selectedImagesID.removeAll()
        let instance: PicsVC = PicsVC()
        instance.fetchImagefromDB()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        KGModal.sharedInstance()?.hide()
        
        
    }
    
    @IBAction func hideBtnAction(_ sender: Any)
    {
        var catIncludeStr = ""
        if(!ischeck)
        {
            print("Check")
            ischeck = true
            self.tableView1.isHidden = false
            catIncludeStr = "1"
            self.includeBtn.setImage(UIImage(named:"check-box"), for: UIControlState.normal)
        }else
        {
            ischeck = false
            print("unCheck")
            self.tableView1.isHidden = true
            catIncludeStr = "0"
            self.includeBtn.setImage(UIImage(named:"checkbox_b_uncheck"), for: UIControlState.normal)
        }
        print(catIncludeStr)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "InspectionCategoires")
        let catId = NSPredicate(format: "cat_Id = %@",catIdstr! )
        let inspectionId = NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
        let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [catId, inspectionId])
        fetchRequest.predicate = andPredicate
        do{
            let res = try context.fetch(fetchRequest)
            let updateObject = res[0] as! NSManagedObject
            updateObject.setValue(catIncludeStr, forKey: "include_in_report")
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
    @objc  func btn_ExcludefromSummeryAction(sender: UIButton)
    {
        let buttonTag = sender.tag
        print(buttonTag)
        var checkornot = ""
        if(!ischeckforquestions)
        {
            print("Check")
            checkornot = "1"
            ischeckforquestions = true
            sender.setImage(UIImage(named:"check-box"), for: UIControlState.normal)
            let section = sender.tag
            let row = 0
            let indexPath = IndexPath(row: row, section: section)
            
            // sub_catIdstr = subcatIdArray[buttonTag]
            
            if finalG == "FG"
            {
                answerArray.removeAll()
                questionArray.removeAll()
                default_ansArray.removeAll()
                default_ResultArray.removeAll()
                default_StatusArray.removeAll()
                default_CommentArray.removeAll()
                default_ResultArray.removeAll()
                default_StatusArray.removeAll()
                default_CommentArray.removeAll()
                self.getQA(subcatId: subcatIdArray[sender.tag])
            }
            else
            {
                answerArray.removeAll()
                questionArray.removeAll()
                default_ansArray.removeAll()
                default_ResultArray.removeAll()
                default_StatusArray.removeAll()
                default_CommentArray.removeAll()
                
                
            }
            
            
            print(indexPath.row)
            guard let cell = tableView1.cellForRow(at: indexPath) as? ExpandableCell
                else { return }
            DispatchQueue.main.async {
                cell.tableViewRealtors.reloadData()
                cell.categoiresImagecollectionView.reloadData()
            }
            
            
            if(subcatInculdeInreportArray[indexPath.section] == "0"){
                ischeckforquestions = false
            }else{
                ischeckforquestions = true
                self.getComments(subcatId: sub_catIdstr!)
                self.getInspQA(subcatId: sub_catIdstr!, inspectionID: inspectionIdStr!)
                self.opencategoiresImages(subcatId: sub_catIdstr!, inspectionID: inspectionIdStr!)
            }
            if(cell.isExpanded)
            {
                print("isexpand true")
            }
            else
            {
                print("isexpand False")
            }
            
            switch cell.isExpanded
            {
            case true:
                self.expandedRows.remove(indexPath.row)
            case false:
                self.expandedRows.insert(indexPath.row)
            }
            if(cell.isExpanded){
                print("Nilesh is didselect expand section",indexPath.section)
                print("Nilesh is didselect expand row",indexPath.section)
                if(ischeckforquestions){
                    
                    cell.btn_picsOutlet.isHidden = true
                    cell.btn_AssingpicsOutlet.isHidden = true
                    cell.categoiresImagecollectionView.isHidden = true
                    cell.btn_addsummerycheckuncheck.isHidden = true
                    cell.lbl_AddsummeryUncheck.isHidden = true
                    if (iscategoiresImages)
                    {
                        cell.btn_picsOutlet.backgroundColor = UIColor.green
                    }else{
                        cell.btn_picsOutlet.backgroundColor = UIColor.blue
                    }
                }
            }else{
                print("Nilesh is else didselect expand section",indexPath.section)
                print("Nilesh is else didselect expand row",indexPath.section)
                if(ischeckforquestions){
                    
                    
                    if(questionArray.count > 0 ){
                        cell.btn_picsOutlet.isHidden = false
                        cell.btn_AssingpicsOutlet.isHidden = true
                        cell.categoiresImagecollectionView.isHidden = false
                        cell.btn_addsummerycheckuncheck.isHidden = false
                        cell.lbl_AddsummeryUncheck.isHidden = false
                        
                    }else{
                        cell.btn_picsOutlet.isHidden = true
                        cell.btn_AssingpicsOutlet.isHidden = true
                        cell.categoiresImagecollectionView.isHidden = false
                        cell.btn_addsummerycheckuncheck.isHidden = true
                        cell.lbl_AddsummeryUncheck.isHidden = true
                        
                    }
                    if (subcatsummeryInreportArray.count > 0){
                        if(subcatsummeryInreportArray[indexPath.row] == "0"){
                            ischeckforquestions = false
                            cell.btn_addsummerycheckuncheck.setImage(UIImage(named:"checkbox_b_uncheck"), for: UIControlState.normal)
                        }else{
                            ischeckforquestions = true
                            cell.btn_addsummerycheckuncheck.setImage(UIImage(named:"check-box"), for: UIControlState.normal)
                        }
                    }
                    if (iscategoiresImages)
                    {
                        cell.btn_picsOutlet.backgroundColor = UIColor.green
                    }else{
                        cell.btn_picsOutlet.backgroundColor = UIColor.blue
                    }
                }
                
            }
            cell.isExpanded = !cell.isExpanded
            self.tableView1.beginUpdates()
            self.tableView1.endUpdates()
            switch cell.isExpanded1
            {
            case true:
                self.expandedRows.remove(indexPath.row)
            case false:
                self.expandedRows.remove(indexPath.row)
            }
            
        }else
        {
            ischeckforquestions = false
            print("unCheck")
            checkornot = "0"
            sender.setImage(UIImage(named:"checkbox_b_uncheck"), for: UIControlState.normal)
            
            let section = sender.tag
            let row = 0
            let indexPath = IndexPath(row: row, section: section)
            
            print(indexPath.row)
            guard let cell = tableView1.cellForRow(at: indexPath) as? ExpandableCell
                else { return }
            
            self.expandedRows.remove(indexPath.row)
            
            cell.isExpanded = false
            cell.btn_picsOutlet.isHidden = true
            cell.btn_AssingpicsOutlet.isHidden = true
            cell.categoiresImagecollectionView.isHidden = true
            if (iscategoiresImages)
            {
                cell.btn_picsOutlet.backgroundColor = UIColor.green
            }else{
                cell.btn_picsOutlet.backgroundColor = UIColor.blue
            }
            cell.btn_addsummerycheckuncheck.isHidden = true
            cell.lbl_AddsummeryUncheck.isHidden = true
            cell.largeLblTxt.backgroundColor = UIColor.clear
            self.tableView1.beginUpdates()
            self.tableView1.endUpdates()
            
        }
        sub_catIdstr = subcatIdArray[buttonTag]
        print("checkornot",checkornot)
        print("sub_catIdstr",sub_catIdstr!)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "InspectionSubCategoires")
        let catId = NSPredicate(format: "sub_catId = %@",sub_catIdstr! )
        let inspectionId = NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
        let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [catId, inspectionId])
        fetchRequest.predicate = andPredicate
        do{
            let res = try context.fetch(fetchRequest)
            if res.count>0{
                let updateObject = res[0] as! NSManagedObject
                updateObject.setValue(checkornot, forKey: "include_in_report")
                do{
                    try context.save()
                }catch{
                    print(error)
                }
            }
            
        }
        catch{
            print(error)
        }
        
    }
    @available(iOS 11.0, *)
    @objc  func photoPressed(sender: UIButton)
    {
        
        let buttonTag = sender.tag
        print("buttonTag",buttonTag)
        
        let CategoiesImageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CategoiesImageVC")as! CategoiesImageVC
        CategoiesImageVC.catid = catIdstr!
        CategoiesImageVC.subcatid = subcatIdArray[buttonTag]
        CategoiesImageVC.catName = cat_name!
        CategoiesImageVC.subcatName = subcatNameArray[buttonTag]
        self.present(CategoiesImageVC, animated: false, completion: nil)
        
    }
    @objc  func AssingphotoPressed(sender: UIButton)
    {
        self.selectedIndexforAssingImage = sender.tag
        
        _selectedCells.removeAllObjects()
        
        selectedImagesID.removeAll()
        expandscollectionview.reloadData()
        KGModal.sharedInstance().show(withContentView: self.expandView, andAnimated: true)
        KGModal.sharedInstance().closeButtonType = .left
        KGModal.sharedInstance().tapOutsideToDismiss = true
        KGModal.sharedInstance().modalBackgroundColor = UIColor.clear
    }
    @objc  func btn_IncludeInsummeryAction(sender: UIButton)
    {
        var includeOrNot = ""
        let buttonTag = sender.tag
        print("buttonTag ", sub_catIdstr!)
        if(!ischeckforincludesummery)
        {
            print("Check")
            includeOrNot = "1"
            ischeckforincludesummery = true
            sender.setImage(UIImage(named:"check-box"), for: UIControlState.normal)
        }else
        {
            includeOrNot = "0"
            ischeckforincludesummery = false
            print("unCheck")
            sender.setImage(UIImage(named:"checkbox_b_uncheck"), for: UIControlState.normal)
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "InspectedQA")
        let sub_catId = NSPredicate(format: "sub_catId = %@",sub_catIdstr!)
        let inspectionId = NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
        let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [sub_catId, inspectionId])
        
        fetchRequest.predicate = andPredicate
        do{
            
            let res = try context.fetch(fetchRequest)
            for Ins in 0 ..< res.count{
                
                let updateObject = res[Ins] as! NSManagedObject
                updateObject.setValue(includeOrNot, forKey: "add_to_report_summ")
                
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
    
    @IBAction func hideViewBtn1Action(_ sender: Any) {
        
        let section = 0
        let row = 0
        let indexPath = IndexPath(row: row, section: section)
        
        let cell:ExpandableCell = tableView1.dequeueReusableCell(withIdentifier: "ExpandableCell") as! ExpandableCell
        
        switch cell.isExpanded
        {
        case true:
            self.expandedRows.insert(indexPath.row)
        case false:
            self.expandedRows.insert(indexPath.row)
        }
        
        self.tableView1.reloadSections(IndexSet(integer: 0), with: .none)
        switch cell.isExpanded2
        {
        case true:
            self.expandedRows.remove(indexPath.row)
        case false:
            self.expandedRows.remove(indexPath.row)
        }
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
    //MARK:- API CALL
    func categoryListAPI2()
    {
        
        var synced_timeForCategoires = UserDefaults.standard.value(forKey: "synced_timeForCategoires") as? String
        if (synced_timeForCategoires == nil){
            synced_timeForCategoires = ""
            
        }
        
        let category_dataurl = "http://allin1inspections.com/admin/webservices/category_data"
        let params:Dictionary  = ["synced_time":""]
        
        // let category_dataurl = "http://allin1inspections.com/admin/webservices/category_data"
        
        Alamofire.request(category_dataurl, method: .post, parameters: params as Parameters, encoding: URLEncoding.default, headers: headers).responseString{ response in
            
            //        Alamofire.request(category_dataurl, method: .post, encoding: URLEncoding.default, headers: headers).responseString{ response in
            
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
                            let Questions = NSManagedObject(entity: entity!, insertInto: context)
                            
                            Questions.setValue(defaultcm, forKey: "default_comment")
                            Questions.setValue(comments, forKey: "comments")
                            Questions.setValue(subcatId, forKey: "scat_id")
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
                                
                                //   self.ans=self.qus2["answers"] as! [String : String]
                                
                                
                                //                                let q_id = (self.qus2["question_id"] as! String)
                                //                                let question = (self.qus2["question"] as! String)
                                //                                let a_id = [(self.ans["ans_id"])!][0]
                                //                                let answer = [(self.ans["ans"])!][0]
                                //                                let defaultans = [(self.ans["default_ans"])!][0]
                                //                                let catId = catIdArray[c]
                                //                                let subcatId = subcatIdArray[s]
                                //                                print("subcatId",subcatId)
                                //                                print("catId",catId)
                                //
                                //                                let entity = NSEntityDescription.entity(forEntityName: "Questions", in: context)
                                //                                let Questions = NSManagedObject(entity: entity!, insertInto: context)
                                //
                                //                                Questions.setValue(a_id, forKey: "ansId")
                                //                                Questions.setValue(answer, forKey: "answer")
                                //                                Questions.setValue(defaultans, forKey: "defultAns")
                                //                                Questions.setValue(defaultans, forKey: "tempdefaultans")
                                //                                Questions.setValue(q_id, forKey: "ques_id")
                                //                                Questions.setValue(question, forKey: "question")
                                //                                Questions.setValue(subcatId, forKey: "sub_catId")
                                //                                Questions.setValue(catId, forKey: "cat_id")
                                //                                Questions.setValue(inspectionIdStr, forKey: "inspectionId")
                                //
                                //
                                //                                do {
                                //
                                //                                    try context.save()
                                //                                    print(try! context.save())
                                //                                    print("questions and ans save")
                                //
                                //                                } catch {
                                //
                                //                                    print("QA Failed saving")
                                //                                }
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
                    if finalG == "FG"
                    {
                        
                    }else{
                        
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
    
    //MARK:- Data fetch method form db
    func getCategoies()
    {
        catNameArray.removeAll()
        catIdArray.removeAll()
        catinculdeInReport.removeAll()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "InspectionCategoires")
        request.predicate =  NSPredicate(format: "inspectionId == %@",inspectionIdStr! )
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try! context.fetch(request)
            for data in result as! [NSManagedObject] {
                let catname = data.value(forKey: "cat_Name") as! String
                let catId = data.value(forKey: "cat_Id") as! String
                let inculdeInReport = data.value(forKey: "include_in_report") as! String
                catNameArray.append(catname)
                catIdArray.append(catId)
                catinculdeInReport.append(inculdeInReport)
                print(catNameArray.count)
                print(catIdArray.count)
                print(catinculdeInReport.count)
            }
        }
    }
    
    func getResultData()
    {
        resultArray.removeAll()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ResultInfo")
        request.returnsObjectsAsFaults = false
        do {
            let result = try! context.fetch(request)
            for data in result as! [NSManagedObject] {
                let resultstr = data.value(forKey: "result") as! String
                resultArray.append(resultstr)
            }
        }
    }
    func getStatusData()
    {
        statusArray.removeAll()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "StatusInfo")
        request.returnsObjectsAsFaults = false
        do {
            let result = try! context.fetch(request)
            for data in result as! [NSManagedObject] {
                let statusstr = data.value(forKey: "status") as! String
                statusArray.append(statusstr)
            }
        }
    }
    
    func getSubCategoies(catId: String)
    {
        subcatIdArray.removeAll()
        subcatNameArray.removeAll()
        subcatInculdeInreportArray.removeAll()
        
        let sub_catId = NSPredicate(format: "cat_Id == %@", catId)
        let inspectionId = NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
        let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [sub_catId, inspectionId])
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "InspectionSubCategoires")
        request.predicate =  andPredicate
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try! context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                let subcatname = data.value(forKey: "sub_catname") as! String
                let subcatId = data.value(forKey: "sub_catId") as! String
                let subincludeInReport = data.value(forKey: "include_in_report") as! String
                subcatIdArray.append(subcatId)
                subcatNameArray.append(subcatname)
                subcatInculdeInreportArray.append(subincludeInReport)
                
                print(subcatIdArray.count)
                print(subcatInculdeInreportArray.count)
                
            }
        }
    }
    func getQA(subcatId: String)
    {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Questions")
        request.predicate =  NSPredicate(format: "sub_catId == %@",subcatId )
        request.returnsObjectsAsFaults = false
        do {
            let result = try! context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                let question = data.value(forKey: "question") as! String
                let ans = data.value(forKey: "answer") as! String
                let defaultans = data.value(forKey: "defultAns") as! String
                questionArray.append(question)
                answerArray.append([ans])
                default_ansArray.append([defaultans])
            }
        }
        if(questionArray.count > 0){
            questionArray.append("Status")
            questionArray.append("Result")
            questionArray.append("Comment")
        }
        
    }
    func getComments(subcatId: String)
    {
        default_CommentArray.removeAll()
        commentsarray.removeAll()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Comments")
        request.predicate =  NSPredicate(format: "scat_id == %@",subcatId )
        request.returnsObjectsAsFaults = false
        do {
            let result = try! context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                //  let default_Comment = data.value(forKey: "default_comment") as! String
                // let  = data.value(forKey: "comments") as! String
                if let comments = data.value(forKey: "comments") as? String {
                    commentsarray.append([comments])
                } else {
                    // the value of someOptional is not set (or nil).
                    commentsarray.append([""])
                }
                if let comments = data.value(forKey: "default_comment") as? String {
                    default_CommentArray.append([comments])
                } else {
                    // the value of someOptional is not set (or nil).
                    default_CommentArray.append([""])
                }
                //  default_CommentArray.append([default_Comment])///
                // commentsarray.append([comments])
                
            }
        }
    }
    func getInspQA(subcatId: String,inspectionID: String)
    {
        default_CommentArray.removeAll()
        subcatsummeryInreportArray.removeAll()
        let sub_catId = NSPredicate(format: "sub_catId == %@", subcatId)
        let inspectionId = NSPredicate(format: "inspectionId == %@", inspectionID)
        let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [sub_catId, inspectionId])
        
        //check here for the sender of the message
        let fetchRequestSender = NSFetchRequest<NSFetchRequestResult>(entityName: "InspectedQA")
        fetchRequestSender.predicate = andPredicate
        fetchRequestSender.returnsObjectsAsFaults = false
        do {
            let result = try! context.fetch(fetchRequestSender)
            for data in result as! [NSManagedObject] {
                
//                if(data.value(forKey: "cat_id") as! String == "13")
//                {
//                    let question = data.value(forKey: "question") as! String
//                    let ans = data.value(forKey: "answer") as! String
//                    let defaultans = data.value(forKey: "defultAns") as! String
//
////                    let defaultresult = data.value(forKey: "result") as! String
////                    let defaultstatus = data.value(forKey: "status") as! String
////                    let defaultcomment = data.value(forKey: "comment") as! String
//                    let add_to_report_summ = data.value(forKey: "add_to_report_summ") as! String
//                    questionArray.append(question)
//                    answerArray.append([ans])
//                    default_ansArray.append([defaultans])
//
////                    default_ResultArray.append([defaultresult])
////                    default_StatusArray.append([defaultstatus])
////                    default_CommentArray.append([defaultcomment])
//                    subcatsummeryInreportArray.append(add_to_report_summ)
//                }
//                else{
                    let question = data.value(forKey: "question") as! String
                    let ans = data.value(forKey: "answer") as! String
                    let defaultans = data.value(forKey: "defultAns") as! String
                    
                    let defaultresult = data.value(forKey: "result") as! String
                    let defaultstatus = data.value(forKey: "status") as! String
                    let defaultcomment = data.value(forKey: "comment") as! String
                    let add_to_report_summ = data.value(forKey: "add_to_report_summ") as! String
                    questionArray.append(question)
                    answerArray.append([ans])
                    default_ansArray.append([defaultans])
                    
                    default_ResultArray.append([defaultresult])
                    default_StatusArray.append([defaultstatus])
                    default_CommentArray.append([defaultcomment])
                    subcatsummeryInreportArray.append(add_to_report_summ)
                //}
                
                
            }
        }
        if(questionArray.count > 0){
            if catIdstr == "13"{

            }else{
            questionArray.append("Status")
            questionArray.append("Result")
            questionArray.append("Comment")
            }
        }
        
        
    }
    
    //  getInspQA(subcatId: String,inspectionID: String)
    func opencategoiresImages(subcatId: String,inspectionID: String){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AssingImages")
        let sub_catId = NSPredicate(format: "image_sub_category_id = %@",subcatId)
        let inspectionId = NSPredicate(format: "inspectionId == %@", inspectionID)
        let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [sub_catId, inspectionId])
        fetchRequest.predicate = andPredicate
        let res = try! context.fetch(fetchRequest)
        
        if(res.count>0)
        {
            print("images ahet")
            iscategoiresImages = true
            
            
            categoiresimagarray.removeAll()
            categoiresimagarray.removeAll()
            CategoiresImagesIDArray.removeAll()
            print("res.count",res.count)
            for data in res as! [NSManagedObject] {
                
                let imageId = data.value(forKey: "image_id") as? String
                let cat_type = data.value(forKey: "cat_type") as? String
                print(imageId!)
                print(cat_type!)
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Images")
                let ImageId = NSPredicate(format: "image_id = %@",imageId! )
                let inspectionId = NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
                let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [ImageId, inspectionId])
                fetchRequest.predicate = andPredicate
                fetchRequest.returnsObjectsAsFaults = false
                do {
                    
                    let result = try context.fetch(fetchRequest)
                    for data in result as! [NSManagedObject] {
                        if let imageurl = (data.value(forKey: "imagepath") as? String) {
                            //  self.imagarray.append(URL(fileURLWithPath: imageurl as String))
                            categoiresimagarray.append(URL(fileURLWithPath: imageurl as String))
                            CategoiresImagesIDArray.append((data.value(forKey: "image_id") as! String))
                            
                        }
                        
                    }
                    
                }catch {
                    
                    print("Failed")
                }
            }
        }
        else
        {
            print("images  nhi ahet")
            iscategoiresImages = false
            categoiresimagarray.removeAll()
            CategoiresImagesIDArray.removeAll()
        }
    }
    
    
}


@available(iOS 10.0, *)
extension InfoVC {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    
    
}
