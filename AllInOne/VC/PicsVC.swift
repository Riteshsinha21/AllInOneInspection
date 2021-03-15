//
//  PicsVC.swift
//  AllInOne
//
//  Created by Apple on 11/2/18.
//  Copyright © 2018 mac08. All rights reserved.
//

import UIKit
import MaterialComponents
import CoreData
import Photos
import SVProgressHUD
import BSImagePicker
import Alamofire

import DLRadioButton


@available(iOS 11.0, *)

class PicsVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,NSFetchedResultsControllerDelegate
{
    
    @IBOutlet weak var expandView: UIView!
    @IBOutlet weak var expandImageView: UIImageView!
    @IBOutlet weak var lbl_assignInfo: UILabel!
   
    var islongPressActive = Bool()
    var isimagesaveorNot = Bool()
    var fromdb = Bool()
    
    var data=[Dictionary<String,AnyObject>]()
    var subCat3=[Dictionary<String,AnyObject>]()
    var qus=[Dictionary<String,AnyObject>]()
    var ans=[Dictionary<String,AnyObject>]()
    
    let fileManager = FileManager.default
    
    var dic : Dictionary<String,AnyObject>!
    var dic1: [String: [[String:Any]]] = [
        "items": []
    ]
    var subCat1 = Dictionary<String,AnyObject>()
    var qus2 = Dictionary<String,AnyObject>()
    var ans2 = Dictionary<String,AnyObject>()
    var str : String = ""
    var tempIndex : Int?
    
    //Outlets...
    @IBOutlet weak var assignBtnOut: UIButton!
    @IBOutlet weak var deleteBtnOut: UIButton!
    
    @IBOutlet weak var hideBtn: UIButton!
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var stackViewAssign: UIStackView!
    @IBOutlet weak var addBtnHide: MDCFloatingButton!
    @IBOutlet weak var cancelBtnOut: MDCFloatingButton!
    @IBOutlet weak var hideView1: UIView!
    @IBOutlet weak var pickerView1: UIPickerView!
    
    @IBOutlet weak var catBtn: UIButton!
    @IBOutlet weak var subCatBtn: UIButton!
   
    
    @IBOutlet weak var pickerView2: UIPickerView!
    @IBOutlet weak var okPikBtnOut: UIButton!
    @IBOutlet weak var subCatLbl: UILabel!
    
    @IBOutlet weak var subCatlbl: UILabel!
    @IBOutlet weak var okPikBtn2Out: UIButton!
    
    @IBOutlet weak var btn_assingoulet: UIButton!
    @IBOutlet weak var btn_CancleOulet: UIButton!
    
    @IBOutlet weak var lbl_catImage: UILabel!
    @IBOutlet weak var ibl_subcatImage: UILabel!
    //Variables...
    
    var myImagesCamera = [UIImage]()
    
    var _deselectedCells : NSMutableArray = []
    
    var deletedImgArray = [UIImage]()
    private let leftAndRightPaddings: CGFloat = 15.0
    private let numberOfItemsPerRow: CGFloat = 3.0
    var picker:UIImagePickerController?=UIImagePickerController()
    
    var yourArray = [String]()
    var assetCollection: PHAssetCollection!
    static let albumName = "Flashpod"
    var SelectedAssets = [PHAsset]()
    var catArray = [String]()
    var success1 : NSNumber?
    var subCatArray = [String]()
    var subCatArray3 = [Dictionary<String,AnyObject>?]()
    
    var catNameArray = [String]()
    var catIdArray = [String]()
    var subCatIdArray = [String]()
    
    
    var subCatArray2: [[String]] = []
    var dt11 : Dictionary<String,AnyObject>?
    var subCat: Dictionary<String,AnyObject>?
    var includeArray = [String]()
    
    var catName: String? = ""
    var catID: String? = ""
    var subCatName : String? = ""
    var subCatId : String? = ""
   
    
    
    class var instance: PicsVC {
        struct Static {
            static let instance: PicsVC = PicsVC()
        }
        return Static.instance
    }
    
    
    
    //MARK:- Load method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        UserDefaults.standard.set(1, forKey: "View")
        
        setheightToexpandView()
        self.btn_assingoulet.layer.cornerRadius = 5
        self.btn_assingoulet.layer.borderWidth = 1
        self.btn_assingoulet.layer.borderColor = UIColor.gray.withAlphaComponent(1.0).cgColor
        self.btn_assingoulet.clipsToBounds = true
        
        self.btn_CancleOulet.layer.cornerRadius = 5
        self.btn_CancleOulet.layer.borderWidth = 1
        self.btn_CancleOulet.layer.borderColor = UIColor.gray.withAlphaComponent(1.0).cgColor
        self.btn_CancleOulet.clipsToBounds = true
        
        
        self.catBtn.layer.cornerRadius = 5
        self.catBtn.layer.borderWidth = 1
        self.catBtn.layer.borderColor = UIColor.gray.withAlphaComponent(1.0).cgColor
        self.catBtn.clipsToBounds = true
        
        self.subCatBtn.layer.cornerRadius = 5
        self.subCatBtn.layer.borderWidth = 1
        self.subCatBtn.layer.borderColor = UIColor.gray.withAlphaComponent(1.0).cgColor
        self.subCatBtn.clipsToBounds = true
        
        self.hideView1.layer.cornerRadius=5
        self.hideView1.layer.shadowColor = UIColor.black.cgColor
        self.hideView1.layer.shadowOpacity = 0.7
        self.hideView1.layer.shadowOffset = CGSize.zero
        self.hideView1.layer.shadowRadius = 4
        self.hideView1.clipsToBounds = false
        self.hideView1.layer.masksToBounds = false;
        self.hideView1.isHidden = true
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        self.hideBtn.isHidden = true
        self.hideView1.isHidden = true
        self.okPikBtnOut.isHidden = true
        self.okPikBtn2Out.isHidden = true
        self.pickerView1.isHidden = true
        self.pickerView1.delegate = self
        self.pickerView1.dataSource = self
        self.pickerView2.isHidden = true
        self.pickerView2.delegate = self
        self.pickerView2.dataSource = self
        
        
        SelectedAssets.removeAll()
        // print("cddaraArray=",CDataArray)
        print("global..=",global1!)
        
        myImagesDecoded.removeAll()
        _selectedCells.removeAllObjects()
        self.collectionView1?.isPrefetchingEnabled = false
        self.collectionView1.delegate = self
        self.collectionView1.dataSource = self
        
        if inspectionIdStr != nil
        {
            
            fetchImagefromDB()
        }
        else
        {
            
        }
        
        
        picker?.delegate = self
        if UIDevice.current.userInterfaceIdiom == .phone
            
        {
            let bounds = UIScreen.main.bounds
            let width = (bounds.size.width - leftAndRightPaddings*(numberOfItemsPerRow-10)) / numberOfItemsPerRow//+1
            let layout = collectionView1.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = CGSize(width: width, height: width)
            collectionView1!.decelerationRate = UIScrollViewDecelerationRateFast
        }
        else
        {
            let bounds = UIScreen.main.bounds
            let width = (bounds.size.width - leftAndRightPaddings*(numberOfItemsPerRow+1)) / numberOfItemsPerRow//+1
            let layout = collectionView1.collectionViewLayout as? UICollectionViewFlowLayout
            layout?.itemSize = CGSize(width: width, height: width)
            collectionView1!.decelerationRate = UIScrollViewDecelerationRateFast
        }
        stackViewAssign.isHidden = true
        cancelBtnOut.isHidden = true
        
        self.collectionView1.allowsMultipleSelection=true //CollectionView is your CollectionView outlet
        
        if ConnectionCheck.isConnectedToNetwork()
        {
            
            self.getCategoies()
        }
        else
        {
            self.getCategoies()
            print("no internet")
        }
        DispatchQueue.main.async {
            self.collectionView1.reloadData()
        }
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(onLongPressGesture(sender:)))
        longPress.minimumPressDuration = 0.2 // optional
        collectionView1.addGestureRecognizer(longPress)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    func fetchImagefromDB()
    {
        CDataArray.removeAllObjects()
        myNewlyAddedImages.removeAll()
        myImagesDecoded.removeAll()
        myImagesDecodedLD.removeAll()
        imageUrlArray.removeAll()
        myImagesID.removeAll()
        myImagespath.removeAll()
        ButtonClickcountPics = 0
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Images")
        request.predicate =  NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            myImagesDecodedLD.removeAll()
            myImagespath.removeAll()
            myImagesID.removeAll()
            imageUrlArray.removeAll()
            myNewlyAddedImages.removeAll()
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                fromdb = true
                isimagesaveorNot = false
                
                if let imageurl = (data.value(forKey: "imagepath") as? String) {
                    myImagespath.append(URL(fileURLWithPath: imageurl as String))
                    myImagesID.append((data.value(forKey: "image_id") as! String))
                    imageUrlArray.append(URL(fileURLWithPath: imageurl as String))
                }
            }
            
        }
        catch {
            
            print("Failed")
        }
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            
            if UIDevice.current.userInterfaceIdiom == .phone
                
            {
                let bounds = UIScreen.main.bounds
                let width = (bounds.size.width - leftAndRightPaddings*(numberOfItemsPerRow-10)) / numberOfItemsPerRow//+1
                let layout = collectionView1.collectionViewLayout as! UICollectionViewFlowLayout
                layout.itemSize = CGSize(width: width, height: width)
                
            }
            else
            {
                let bounds = UIScreen.main.bounds
                let width = (bounds.size.width - leftAndRightPaddings*(numberOfItemsPerRow+1)) / numberOfItemsPerRow//+1
                let layout = collectionView1.collectionViewLayout as? UICollectionViewFlowLayout
                layout?.itemSize = CGSize(width: width, height: width)
            }
            
            
        } else {
            print("Portrait")
            if UIDevice.current.userInterfaceIdiom == .phone
                
            {
                let bounds = UIScreen.main.bounds
                let width = (bounds.size.width - leftAndRightPaddings*(numberOfItemsPerRow-10)) / numberOfItemsPerRow//+1
                let layout = collectionView1.collectionViewLayout as! UICollectionViewFlowLayout
                layout.itemSize = CGSize(width: width, height: width)
                
            }
            else
            {
                let bounds = UIScreen.main.bounds
                let width = (bounds.size.width - leftAndRightPaddings*(numberOfItemsPerRow+1)) / numberOfItemsPerRow//+1
                let layout = collectionView1.collectionViewLayout as? UICollectionViewFlowLayout
                layout?.itemSize = CGSize(width: width, height: width)
            }
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        // collectionView1.reloadData()
        
        print("inspectionIdStr",inspectionIdStr!)
        fromdb = true
        self.collectionView1.delegate = self
        self.collectionView1.dataSource = self
        
    }
    func setheightToexpandView(){
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            
            if DeviceType.iPhone4orLess{
                expandView.frame = CGRect(x: 0.0, y: 0.0, width:300.0 , height: 300.0 )
            }else if DeviceType.iPhone5orSE{
                expandView.frame = CGRect(x: 0.0, y: 0.0, width: 300.0, height:300.0 )
            }else if DeviceType.iPhone678{
                expandView.frame = CGRect(x: 0.0, y: 0.0, width: 350.0, height: 350.0)
            }else if DeviceType.iPhone678p{
                expandView.frame = CGRect(x: 0.0, y: 0.0, width: 370.0, height: 300.0)
            }else if DeviceType.iPhoneX{
                expandView.frame = CGRect(x: 0.0, y: 0.0, width: 370.0, height: 370.0)
            }else{
                expandView.frame = CGRect(x: 0.0, y: 0.0, width: 350.0, height: 350.0)
            }
            break
        case .pad:
            
            if DeviceType.IS_IPAD{
                
                expandView.frame = CGRect(x: 0.0, y: 0.0, width: 600.0, height: 600.0)
            }else if DeviceType.IS_IPAD_PRO{
                
                expandView.frame = CGRect(x: 0.0, y: 0.0, width: 600.0, height: 600.0)
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
    @objc func loadList(notification: NSNotification){
        
        
        print("Minhujkio")
        //str123 = "A"//
        isimagesaveorNot = false
        SelectedAssets.removeAll()
        _selectedCells.removeAllObjects()
        DispatchQueue.main.async {
            self.collectionView1.reloadData()
        }
        
    }
    @objc func onLongPressGesture(sender: UILongPressGestureRecognizer) {
        if (sender.state != UIGestureRecognizerState.ended) {
            return;
        }
        
        islongPressActive = true
        let locationInView = sender.location(in: collectionView1)
        let indexPath = collectionView1.indexPathForItem(at: locationInView)
        
        if (indexPath != nil) {
            tempIndex = indexPath!.row
            print("temp...",tempIndex!)
            if fromdb
            {
                
                if(isimagesaveorNot){
                    
                    selectedImagesID.removeAll()
                    selectedImageArray.removeAll()
                    
                    stackViewAssign.isHidden = false
                    cancelBtnOut.isHidden = false
                    assignBtnOut.isHidden = true
                    
                    catImgArray1.removeAllObjects()
                    addBtnHide.isHidden = true
                    print("didselectCell=",indexPath!.row)
                    _selectedCells.add(indexPath!.row)
                    print("selectedCells..",_selectedCells)
                    for i in 0 ..< _selectedCells.count{
                        let k = _selectedCells[i] as! Int
                        
                        selectedImagesID.append(myImagesID[k])
                    }
                    print("selectedImageArray..",selectedImageArray)
                    
                    for img in selectedImageArray{
                        let data : NSData = NSData(data: UIImagePNGRepresentation(img)!)
                        catImgArray1.add(data);
                    }
                    print("catImgArray1..=",catImgArray1.count)
                    DispatchQueue.main.async {
                        self.collectionView1.reloadItems(at: [indexPath!])
                    }
                    
                }else{
                    selectedImagesID.removeAll()
                    selectedImageArray.removeAll()
                    stackViewAssign.isHidden = false
                    cancelBtnOut.isHidden = false
                    addBtnHide.isHidden = true
                    assignBtnOut.isHidden = false
                    _selectedCells.add(indexPath!.row)
                    print("selectedCells..",_selectedCells)
                    
                    for i in 0 ..< _selectedCells.count{
                        let k = _selectedCells[i] as! Int
                        
                        selectedImagesID.append(myImagesID[k])
                    }
                    print("selectedImageArray..",selectedImageArray)
                    
                    for img in selectedImageArray{
                        let data : NSData = NSData(data: UIImagePNGRepresentation(img)!)
                        catImgArray1.add(data);
                    }
                    print("catImgArray1..=",catImgArray1.count)
                    DispatchQueue.main.async {
                        self.collectionView1.reloadItems(at: [indexPath!])
                    }
                }
            }
            else
            {
                selectedImagesID.removeAll()
                selectedImageArray.removeAll()
                stackViewAssign.isHidden = false
                cancelBtnOut.isHidden = false
                assignBtnOut.isHidden = true
                catImgArray1.removeAllObjects()
                addBtnHide.isHidden = true
                print("didselectCell=",indexPath!.row)
                _selectedCells.add(indexPath!.row)
                print("selectedCells..",_selectedCells)
                for i in 0 ..< _selectedCells.count{
                    let k = _selectedCells[i] as! Int
                    selectedImagesID.append(myImagesID[k])
                }
                print("selectedImageArray..",selectedImageArray)
                
                for img in selectedImageArray{
                    let data : NSData = NSData(data: UIImagePNGRepresentation(img)!)
                    catImgArray1.add(data);
                }
                print("catImgArray1..=",catImgArray1.count)
                DispatchQueue.main.async {
                    self.collectionView1.reloadItems(at: [indexPath!])
                }
            }
        }
        
    }
    
    //MARK:- Collection delegate Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        if fromdb
        {
            return myImagespath.count
        }
        return myImagespath.count
        
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        print("imgArray123=",myImagesID.count)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pics", for: indexPath) as? CollectionViewCellPics
            else{
                return UICollectionViewCell()
                
        }
        
        
        if finalG == "FG"
        {
            
            
            let paths1 = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(myImagesID[indexPath.row])
            
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
                collectionView1.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.top)
                tickImage?.isHidden=false
            }
            else{
                cell.isSelected=false
                cell.layer.borderWidth = 0
                cell.layer.borderColor = UIColor.clear.withAlphaComponent(1.0).cgColor
                cell.clipsToBounds = true
                tickImage?.isHidden=true
            }
        }
        else
        {
            if fromdb
            {
                
                
                var assingInfostring = ""
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AssingImages")
                let cat_type = NSPredicate(format: "image_id = %@",myImagesID[indexPath.row])
                let inspectionId = NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
                let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [cat_type, inspectionId])
                fetchRequest.predicate = andPredicate
                let res = try! context.fetch(fetchRequest)
                
                if(res.count>0)
                {
                    print("res.count",res.count)
                    for data in res as! [NSManagedObject] {
                        
                        let imageId = data.value(forKey: "image_id") as? String
                        let cat_type = data.value(forKey: "cat_type") as? String
                        let cat_name = data.value(forKey: "image_category_name") as? String
                        let subcat_name = data.value(forKey: "image_sub_category_name") as? String
                        
                        print(imageId!)
                        print(cat_type!)
                        if cat_type == "category"
                        {
                            if(assingInfostring == ""){
                                if(cat_name != nil && subcat_name != nil){
                                    assingInfostring = assingInfostring + " " + cat_name! + " --> " + subcat_name!
                                }
                                
                            }else{
                                if(cat_name != nil && subcat_name != nil){
                                    assingInfostring = assingInfostring + ", " + cat_name! + "-->" + subcat_name!
                                }
                            }
                            
                        }else
                        {
                            if(assingInfostring == ""){
                                assingInfostring = assingInfostring + " " + cat_type!
                            }else{
                                assingInfostring = assingInfostring + ", " + cat_type!
                            }
                        }
                        
                        
                    }
                }
                assingInfostring =  assingInfostring.replacingOccurrences(of: "_", with: " ")
                
                cell.lbl_AssingImagesInfo.text = assingInfostring
                let paths1 = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(myImagesID[indexPath.row])
                
                
                if fileManager.fileExists(atPath: paths1){
                    
                    cell.imageVIew1.image = UIImage(contentsOfFile: paths1)
                    
                }else{
                    
                    print("No Image")
                    
                }
                
                let tickImage = cell.viewWithTag(1) as? UIImageView
                
                print("gfyfbjafhj")
                if _selectedCells.contains(indexPath.row) {
                    cell.isSelected=true
                    cell.layer.borderWidth = 5
                    cell.layer.borderColor = UIColor.black.withAlphaComponent(1.0).cgColor
                    cell.clipsToBounds = true
                    collectionView1.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.top)
                    tickImage?.isHidden=false
                    
                }
                else{
                    cell.isSelected=false
                    cell.layer.borderWidth = 0
                    cell.layer.borderColor = UIColor.clear.withAlphaComponent(1.0).cgColor
                    cell.clipsToBounds = true
                    tickImage?.isHidden=true
                }
            }
            else
            {
                
                
                let paths1 = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(myImagesID[indexPath.row])
                
               
                
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
                    collectionView1.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.top)
                    tickImage?.isHidden=false
                }
                else{
                    cell.isSelected=false
                    cell.layer.borderWidth = 0
                    cell.layer.borderColor = UIColor.clear.withAlphaComponent(1.0).cgColor
                    cell.clipsToBounds = true
                    tickImage?.isHidden=true
                }
                
            }
            
        }
        
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        if(!islongPressActive)
        {
            
            if fromdb
            {
                
                
                let paths1 = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(myImagesID[indexPath.row])
                
                
                
                if fileManager.fileExists(atPath: paths1){
                    
                    expandImageView.image = UIImage(contentsOfFile: paths1)
                    
                    
                    
                    
                    KGModal.sharedInstance().show(withContentView: self.expandView, andAnimated: true)
                    KGModal.sharedInstance().closeButtonType = .left
                    KGModal.sharedInstance().tapOutsideToDismiss = true
                    KGModal.sharedInstance().modalBackgroundColor = UIColor.clear
                    
                }else{
                    
                    print("No Image")
                    
                }
            }else{
                
                
                let paths1 = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(myImagesID[indexPath.row])
                
                
                
                if fileManager.fileExists(atPath: paths1){
                    
                    expandImageView.image = UIImage(contentsOfFile: paths1)
                    KGModal.sharedInstance().show(withContentView: self.expandView, andAnimated: true)
                    KGModal.sharedInstance().closeButtonType = .left
                    KGModal.sharedInstance().tapOutsideToDismiss = true
                    KGModal.sharedInstance().modalBackgroundColor = UIColor.clear
                    
                }else{
                    
                    print("No Image")
                    
                }
            }
            
            
            
        }
        else{
            print("add images ")
            tempIndex = indexPath.row
            print("temp...",tempIndex!)
            if fromdb
            {
                
                if(isimagesaveorNot){
                    
                    selectedImagesID.removeAll()
                    selectedImageArray.removeAll()
                    
                    stackViewAssign.isHidden = false
                    cancelBtnOut.isHidden = false
                    assignBtnOut.isHidden = true
                    
                    catImgArray1.removeAllObjects()
                    addBtnHide.isHidden = true
                    print("didselectCell=",indexPath.row)
                    _selectedCells.add(indexPath.row)
                    print("selectedCells..",_selectedCells)
                    for i in 0 ..< _selectedCells.count{
                        let k = _selectedCells[i] as! Int
                   
                        selectedImagesID.append(myImagesID[k])
                    }
                    print("selectedImageArray..",selectedImageArray)
                    
                    for img in selectedImageArray{
                        let data : NSData = NSData(data: UIImagePNGRepresentation(img)!)
                        catImgArray1.add(data);
                    }
                    print("catImgArray1..=",catImgArray1.count)
                    collectionView1.reloadItems(at: [indexPath])
                    
                }else{
                    selectedImagesID.removeAll()
                    selectedImageArray.removeAll()
                    stackViewAssign.isHidden = false
                    cancelBtnOut.isHidden = false
                    addBtnHide.isHidden = true
                    assignBtnOut.isHidden = false
                    _selectedCells.add(indexPath.row)
                    print("selectedCells..",_selectedCells)
                    
                    for i in 0 ..< _selectedCells.count{
                        let k = _selectedCells[i] as! Int
                     
                        selectedImagesID.append(myImagesID[k])
                    }
                    print("selectedImageArray..",selectedImageArray)
                    
                    for img in selectedImageArray{
                        let data : NSData = NSData(data: UIImagePNGRepresentation(img)!)
                        catImgArray1.add(data);
                    }
                    print("catImgArray1..=",catImgArray1.count)
                    collectionView1.reloadItems(at: [indexPath])
                }
                
                
                
            }
            else
            {
                
                
                selectedImagesID.removeAll()
                selectedImageArray.removeAll()
                
                stackViewAssign.isHidden = false
                cancelBtnOut.isHidden = false
                assignBtnOut.isHidden = true
                
                catImgArray1.removeAllObjects()
                addBtnHide.isHidden = true
                print("didselectCell=",indexPath.row)
                _selectedCells.add(indexPath.row)
                print("selectedCells..",_selectedCells)
                for i in 0 ..< _selectedCells.count{
                    let k = _selectedCells[i] as! Int
                    selectedImagesID.append(myImagesID[k])
                }
                print("selectedImageArray..",selectedImageArray)
                
                for img in selectedImageArray{
                    let data : NSData = NSData(data: UIImagePNGRepresentation(img)!)
                    catImgArray1.add(data);
                }
                print("catImgArray1..=",catImgArray1.count)
                collectionView1.reloadItems(at: [indexPath])
            }
            
        }
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        print("didDeslectCell")
        selectedImageArray.removeAll()
        selectedImagesID.removeAll()
        
        _selectedCells.remove(indexPath.row)
        print("selectedCellsremove..",_selectedCells)
        
        print("deletedImageArray1..",deletedImgArray)
        
        for i in 0 ..< _selectedCells.count{
            let k = _selectedCells[i] as! Int
            if fromdb
            {
                selectedImagesID.append(myImagesID[k])
            }else{
                selectedImagesID.append(myImagesID[k])
            }
            
        }
        print("selectedImageArrayremove..",selectedImageArray)
        
        
        if _selectedCells.count == 0
        {
            stackViewAssign.isHidden = true
            cancelBtnOut.isHidden = true
            addBtnHide.isHidden = false
            islongPressActive = false
        }
        
        collectionView1.reloadItems(at: [indexPath])
    }
    //MARK:- button action
    
    @IBAction func addPhotosBtn(_ sender: Any)
    {
        let alertController = UIAlertController(title: "Choose Photo", message: "", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Take Photo", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.openCamera()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive ) {
            UIAlertAction in
            
        }
        let galleryAction = UIAlertAction(title: "Open Gallery", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.openGallary()
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(galleryAction)
        alertController.addAction(cancelAction)
        
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func okBtyn(_ sender: Any)
    {
        self.pickerView1.isHidden = true
        self.okPikBtnOut.isHidden = true
        
        if(catIdStr != ""){
            subCatBtn.isHidden = false
            subCatBtn.isHidden = false
            subCatLbl.isHidden = false
            subCatNameStr = ""
            subCatIdStr = ""
        }
    }
    @IBAction func assignBtn(_ sender: Any)
    {
        let brown = UIColor(rgb: 0x0A4773)
        let blue2 = UIColor(rgb: 0x3C78B7)
        assignBtnOut.backgroundColor = brown
        deleteBtnOut.backgroundColor = blue2
        self.hideBtn.isHidden = false
        self.hideView1.isHidden = false
        
        subCatLbl.isHidden = true
        subCatBtn.isHidden = true
        catBtn.isHidden = true
        subCatBtn.isHidden = true
        subCatlbl.isHidden = true
        lbl_catImage.isHidden = true
        ibl_subcatImage.isHidden = true
        self.pickerView2.isHidden = true
        self.pickerView1.isHidden = true
        self.okPikBtnOut.isHidden = true
        self.okPikBtn2Out.isHidden = true
        self.getCategoies()
        
    }
    @IBAction func deleteBtn(_ sender: Any)
    {
        stackViewAssign.isHidden = true
        cancelBtnOut.isHidden = true
        
        addBtnHide.isHidden  = false
        
        let brown1 = UIColor(rgb: 0x0A4773)
        let blue2 = UIColor(rgb: 0x3C78B7)
        deleteBtnOut.backgroundColor = brown1
        assignBtnOut.backgroundColor = blue2
        islongPressActive = false
        if selectedImagesID.count != 0
        {
            if(isimagesaveorNot)
            {
                for i in 0..<selectedImagesID.count
                {
                    
                    if let index = myImagesID.index(where: { $0 == selectedImagesID[i] }) {
                        myImagesID.remove(at: index)
                        imageUrlArray.remove(at: index)
                        myImagespath.remove(at: index)
                        
                        myNewlyAddedImages.remove(at: index)
                        if fromdb
                        {
                            
                        }else{
                            myImagesDecoded.remove(at: index)
                        }
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.collectionView1.reloadData()
                    }
                }
            }
            else
            {
                for i in 0..<selectedImagesID.count
                {
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Images")
                    let sub_catId = NSPredicate(format: "image_id = %@",selectedImagesID[i] )
                    let inspectionId = NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
                    let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [sub_catId, inspectionId])
                    fetchRequest.predicate = andPredicate
                    
                    let result = try! context.fetch(fetchRequest)
                    // let resultData = result
                    
                    if(result.count > 0){
                        let updateObject = result[0] as! NSManagedObject
                        context.delete(updateObject)
                    }
                    
                    do {
                        try context.save()
                        print("saved!")
                    } catch let error as NSError  {
                        print("Could not save \(error), \(error.userInfo)")
                    }
                }
                self.fetchImagefromDB()
                
                DispatchQueue.main.async {
                    self.collectionView1.reloadData()
                }
            }
        }
        else
        {
            myImagesDecoded = myImagesDecoded
                .enumerated()
                .filter { !_selectedCells.contains($0.offset) }
                .map { $0.element }
            
            print("arrayRemainingAnimals=",myImagesDecoded)
            catImgArray1.removeAllObjects()
            for img in myImagesDecoded{
                let data : NSData = NSData(data: UIImagePNGRepresentation(img)!)
                catImgArray1.add(data);
            }
            DispatchQueue.main.async {
                self.collectionView1.reloadData()
            }
        }
        _selectedCells.removeAllObjects()
        selectedImageArray.removeAll()
        selectedImagesID.removeAll()
    }
    func removeimagefromDB(imageid:String)
    {
        
    }
    func removeselection(){
        print("didDeslectCell")
        _selectedCells.removeAllObjects()
        selectedImageArray.removeAll()
        selectedImagesID.removeAll()
        subcatIdArray.removeAll()
        subcatNameArray.removeAll()
        print("selectedCellsremove1..",_selectedCells)
        
        if _selectedCells.count == 0
        {
            stackViewAssign.isHidden = true
            cancelBtnOut.isHidden = true
            
            addBtnHide.isHidden = false
        }
        islongPressActive = false
        DispatchQueue.main.async {
            self.collectionView1.reloadData()
        }
    }
    @IBAction func cancelBtnAction(_ sender: Any)
    {
        
        self.removeselection()
        
    }
    
    @objc @IBAction private func SelectedRadioButtonAction(radioButton : DLRadioButton)
    {
        if (radioButton.isMultipleSelectionEnabled)
        {
            for button in radioButton.selectedButtons()
            {
                print(String(format: "%@ is selected.\n", button.titleLabel!.text!));
            }
        }
        else
        {
            print(String(format: "%@ is selected.\n", radioButton.selected()!.titleLabel!.text!));
            picSelectionStr = radioButton.selected()!.titleLabel!.text!
            if radioButton.selected()!.titleLabel!.text! == "Category"{
                
                subCatlbl.text="Select category"
                catIdStr = ""
                catBtn.isHidden = false
                lbl_catImage.isHidden = false
                // subCatBtn.isHidden = true
                subCatBtn.isHidden = true
                subCatlbl.isHidden = false
                subCatLbl.isHidden = true
                
                ibl_subcatImage.isHidden = true
                
            }else{
                subCatLbl.isHidden = true
                subCatBtn.isHidden = true
                catBtn.isHidden = true
                subCatBtn.isHidden = true
                subCatlbl.isHidden = true
                lbl_catImage.isHidden = true
                ibl_subcatImage.isHidden = true
                self.pickerView2.isHidden = true
                self.pickerView1.isHidden = true
                self.okPikBtnOut.isHidden = true
                self.okPikBtn2Out.isHidden = true
                
            }
            
        }
    }
    @IBAction func btn_AssignInviewAction(_ sender: Any)
    {
        self.hideBtn.isHidden = true
        self.hideView1.isHidden = true
        self.pickerView2.isHidden = true
        self.pickerView1.isHidden = true
        self.okPikBtnOut.isHidden = true
        self.okPikBtn2Out.isHidden = true
        islongPressActive = false
        print("picSelectionStr",picSelectionStr!)
        if(picSelectionStr == "Category")
        {
            picSelectionStr = "category"
            print("catIdStr",catIdStr!)
            print("subCatIdStr",subCatIdStr!)
        }else{
            catIdStr = ""
            catNameStr = ""
            subCatIdStr = ""
            subCatNameStr = ""
        }
        if (picSelectionStr == "Client Cover"){
            picSelectionStr = "client_cover"
            
        }else if (picSelectionStr == "Client Page"){
            picSelectionStr = "client_page"
        }else if (picSelectionStr == "Additional Pictures"){
            picSelectionStr = "additional_pictures"
        }
        print("selectedImagesID",selectedImagesID)
        
        for img in 0 ..< selectedImagesID.count
        {
            if(picSelectionStr == "category")
            {
                if((subCatIdStr?.isEmpty)!)
                {
                    let alert = UIAlertController (title: "", message: "Please select sub categoires first", preferredStyle: .alert)
                    alert.addAction(UIAlertAction (title: "OK", style: .default, handler: nil)  )
                    self.present(alert, animated: true, completion: nil)
                    
                }
                else
                {
                    
                    // }
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AssingImages")
                    let sub_catId = NSPredicate(format: "image_id = %@",selectedImagesID[img])
                    let inspectionId = NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
                    let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [sub_catId, inspectionId])
                    fetchRequest.predicate = andPredicate
                    let res = try! context.fetch(fetchRequest)
                    
                    if(res.count>0)
                    {
                        for i in 0 ..< res.count
                        {
                            let updateObject = res[i] as! NSManagedObject
                            
                            let cattype = updateObject.value(forKey: "cat_type") as? String
                            if(cattype == "category")
                            {
                                updateObject.setValue(selectedImagesID[img], forKey: "image_id")
                                updateObject.setValue(picSelectionStr, forKey: "cat_type")
                                updateObject.setValue(catIdStr, forKey: "image_category_id")
                                updateObject.setValue(subCatIdStr, forKey: "image_sub_category_id")
                                
                                updateObject.setValue(catNameStr, forKey: "image_category_name")
                                updateObject.setValue(subCatNameStr, forKey: "image_sub_category_name")
                                
                                updateObject.setValue(inspectionIdStr, forKey: "inspectionId")
                                updateObject.setValue("server", forKey: "server_image_Id")
                                do{
                                    try context.save()
                                }catch{
                                    print(error)
                                }
                            }
                            else
                            {
                                
                                
                                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AssingImages")
                                let sub_catId = NSPredicate(format: "image_id = %@",selectedImagesID[img])
                                let inspectionId = NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
                                let cat_type = NSPredicate(format: "cat_type == %@", picSelectionStr!)
                                let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [sub_catId, inspectionId,cat_type])
                                fetchRequest.predicate = andPredicate
                                let res = try! context.fetch(fetchRequest)
                                if(res.count>0)
                                {
                                    
                                    
                                }else{
                                    let entity = NSEntityDescription.entity(forEntityName: "AssingImages", in: context)
                                    
                                    let assingImages = NSManagedObject(entity: entity!, insertInto: context)
                                    print(img)
                                    
                                    assingImages.setValue(selectedImagesID[img], forKey: "image_id")
                                    assingImages.setValue(picSelectionStr, forKey: "cat_type")
                                    assingImages.setValue(catIdStr, forKey: "image_category_id")
                                    assingImages.setValue(subCatIdStr, forKey: "image_sub_category_id")
                                    assingImages.setValue(catNameStr, forKey: "image_category_name")
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
                            }
                        }
                        
                    }
                    else
                    {
                        
                        
                        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AssingImages")
                        let sub_catId = NSPredicate(format: "image_id = %@",selectedImagesID[img])
                        let inspectionId = NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
                        let cat_type = NSPredicate(format: "cat_type == %@", picSelectionStr!)
                        let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [sub_catId, inspectionId,cat_type])
                        fetchRequest.predicate = andPredicate
                        let res = try! context.fetch(fetchRequest)
                        if(res.count>0)
                        {
                            
                            
                        }
                        else{
                            let entity = NSEntityDescription.entity(forEntityName: "AssingImages", in: context)
                            
                            let assingImages = NSManagedObject(entity: entity!, insertInto: context)
                            print(img)
                            
                            assingImages.setValue(selectedImagesID[img], forKey: "image_id")
                            assingImages.setValue(picSelectionStr, forKey: "cat_type")
                            assingImages.setValue(catIdStr, forKey: "image_category_id")
                            assingImages.setValue(subCatIdStr, forKey: "image_sub_category_id")
                            assingImages.setValue(catNameStr, forKey: "image_category_name")
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
                    }
                }
                
            }else{
                
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AssingImages")
                let sub_catId = NSPredicate(format: "image_id = %@",selectedImagesID[img])
                let inspectionId = NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
                let cat_type = NSPredicate(format: "cat_type == %@", picSelectionStr!)
                let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [sub_catId, inspectionId,cat_type])
                fetchRequest.predicate = andPredicate
                let res = try! context.fetch(fetchRequest)
                if(res.count>0)
                {
                    
                    
                }else{
                    let entity = NSEntityDescription.entity(forEntityName: "AssingImages", in: context)
                    
                    let assingImages = NSManagedObject(entity: entity!, insertInto: context)
                    print(img)
                    
                    assingImages.setValue(selectedImagesID[img], forKey: "image_id")
                    assingImages.setValue(picSelectionStr, forKey: "cat_type")
                    assingImages.setValue(catIdStr, forKey: "image_category_id")
                    assingImages.setValue(subCatIdStr, forKey: "image_sub_category_id")
                    assingImages.setValue(catNameStr, forKey: "image_category_name")
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
            }
            
            
            
        }
        
        self.removeselection()
        let alertController2 = UIAlertController(title: "", message: "Images Assigned Successfully!", preferredStyle: .alert)
        
        // Create the actions
        alertController2.addAction(UIKit.UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alertController2, animated: true, completion: nil)
        
        
    }
    @IBAction func btn_CancleInviewAction(_ sender: Any)
    {
        self.hideBtn.isHidden = true
        self.hideView1.isHidden = true
        self.pickerView2.isHidden = true
        self.pickerView1.isHidden = true
        self.okPikBtnOut.isHidden = true
        self.okPikBtn2Out.isHidden = true
    }
    @IBAction func hideBtnActn(_ sender: Any)
    {
        
    }
    @IBAction func catBtn(_ sender: Any)
    {
        self.pickerView1.isHidden = false
        self.okPikBtnOut.isHidden = false
        
        
        self.pickerView2.isHidden = true
        self.okPikBtn2Out.isHidden = true
        subCatLbl.text="Select Subcategory"
    }
    @IBAction func subCatBtn(_ sender: Any)
    {
        self.pickerView2.isHidden = false
        self.okPikBtn2Out.isHidden = false
        
        
        self.okPikBtnOut.isHidden = true
        self.pickerView1.isHidden = true
        
    }
    @IBAction func okPikBtn2(_ sender: Any)
    {
        self.pickerView2.isHidden = true
        self.okPikBtn2Out.isHidden = true
    }
    //MARK:- Open gallary and camera functions
    func openGallary()
    {
     
        
        let vc = BSImagePickerViewController()
        vc.maxNumberOfSelections = 20
        
        bs_presentImagePickerController(vc, animated: true,
                                        select: { (asset: PHAsset) -> Void in
                                            print("Selected: \(asset)")
        }, deselect: { (asset: PHAsset) -> Void in
            print("Deselected: \(asset)")
        }, cancel: { (assets: [PHAsset]) -> Void in
            print("Cancel: \(assets)")
        }, finish: { (assets: [PHAsset]) -> Void in
            print("Finish: \(assets)")
            print(assets.count)
            for i in 0..<assets.count {
                self.SelectedAssets.append(assets[i])
                
            }
            print("cisah",self.SelectedAssets)
            self .convertAssetToImages()
            
        }, completion: nil)
        
        
    }
    func convertAssetToImages() -> Void {
        SVProgressHUD.show(withStatus: "Please wait..")
        SVProgressHUD.setDefaultMaskType(.clear)
        if SelectedAssets.count != 0
        {
            if fromdb
            {
                CDataArray.removeAllObjects()
                myNewlyAddedImages.removeAll()
                myImagesDecodedLD.removeAll()
                imageUrlArray.removeAll()
                myImagesID.removeAll()
                myImagespath.removeAll()
                for i in 0..<SelectedAssets.count
                {
                    let manager = PHImageManager.default()
                    let option = PHImageRequestOptions()
                    var thumbnail = UIImage()
                    var imagename = ""
                    let index = i
                    option.isSynchronous = true
                    manager.requestImage(for: SelectedAssets[i], targetSize: CGSize(width: 1024, height: 1024), contentMode: .aspectFill, options: option) { (result, info) in
                        
                        if((result) != nil){
                            thumbnail = result!
                        }
                        
                        imagename = "tempImg\(Int(Date().timeIntervalSince1970))\(String(index)).jpg"
                       
                        
                    }
                    
                    let data  = UIImageJPEGRepresentation(thumbnail, 0.2)
                    if((data) != nil){
                        let newImage = UIImage(data: data!)
                        isimagesaveorNot = false
                        saveimageinDic(numm: imagename, image: newImage!)
                        myNewlyAddedImages.append(newImage! as UIImage)
                        myImagesID.append(imagename)
                    }
                }
            }
            else
            {
                CDataArray.removeAllObjects()
                myNewlyAddedImages.removeAll()
                myImagesDecoded.removeAll()
                imageUrlArray.removeAll()
                myImagesID.removeAll()
                myImagespath.removeAll()
                
                for i in 0..<SelectedAssets.count
                {
                    let manager = PHImageManager.default()
                    let option = PHImageRequestOptions()
                    var thumbnail = UIImage()
                    var imagename = ""
                    let index = i
                    option.isSynchronous = true
                    manager.requestImage(for: SelectedAssets[i], targetSize: CGSize(width: 1024, height: 1024), contentMode: .aspectFill, options: option) {
                        
                        (result, info) in
                        if((result) != nil){
                            thumbnail = result!
                        }
                        
                       
                        imagename = "tempImg\(Int(Date().timeIntervalSince1970))\(String(index)).jpg"
                    }
                    
                    let data  = UIImageJPEGRepresentation(thumbnail, 0.2)
                    if((data) != nil){
                        let newImage = UIImage(data: data!)
                        saveimageinDic(numm: imagename, image: newImage!)
                        isimagesaveorNot = false
                        myImagesID.append(imagename)
                        myNewlyAddedImages.append(newImage! as UIImage)
                    }
                }
                
            }
        }
        print("photoArray",myImagesDecoded)
        
        global1 = "A"
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            let instance: InspectionsVC = InspectionsVC()
            instance.savePhotos()
            self.SelectedAssets.removeAll()
            _selectedCells.removeAllObjects()
            self.collectionView1.reloadData()
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
        imageUrlArray.append(imgurl)
        myImagespath.append(imgurl)
    }
    
    
    func openCamera()
    {
        
        print("ButtonClickcountPics",ButtonClickcountPics)
        
        
        ButtonClickcountPics = ButtonClickcountPics + 1
        
        
        if(ButtonClickcountPics == 1)
        {
            CDataArray.removeAllObjects()
            myNewlyAddedImages.removeAll()
            myImagesDecoded.removeAll()
            myImagesDecodedLD.removeAll()
            imageUrlArray.removeAll()
            myImagesID.removeAll()
            myImagespath.removeAll()
            
        }
        else
        {
            
        }
        isimagesaveorNot = false
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")as! ViewController
        
        self.present(vc, animated: false, completion: nil)
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Picker view delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == self.pickerView2 {
            return 1
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.pickerView1
        {
            return catNameArray.count
            
        }
        else  if pickerView == self.pickerView2
        {        return subcatNameArray.count
            
        }
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
    {
        if pickerView == self.pickerView1
        {return 40
        }
        else  if pickerView == self.pickerView2
        {return 40
        }
        return 40
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
        
        if pickerView == self.pickerView1
        {
            
            self.getSubCategoies(catId: self.catIdArray[row])
            self.subCatlbl.text = self.catNameArray[row]
            
            catNameStr = self.catNameArray[row]
            
            catIdStr = self.catIdArray[row]
            print("catId..",catIdStr!)
            
            
            
            self.pickerView2.reloadAllComponents()
        }
        else if pickerView == self.pickerView2
            
        {
            
            self.subCatLbl.text = subcatNameArray[row]
            
            subCatNameStr = subcatNameArray[row]
            subCatIdStr = subcatIdArray[row]
            print("subCatIdStr..",subCatIdStr!)
            
            
        }
        else
        {
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        self.view.endEditing(true)
        if pickerView == self.pickerView1
        {
            return self.catNameArray[row]
        }
        else if pickerView == self.pickerView2
        {
            return subcatNameArray[row]
        }
        return subcatNameArray[row]
    }
    func getCategoies()
    {
        catNameArray.removeAll()
        catIdArray.removeAll()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MainCategories")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try! context.fetch(request)
            for data in result as! [NSManagedObject] {
                let catname = data.value(forKey: "cat_Name") as! String
                let catId = data.value(forKey: "cat_Id") as! String
                catNameArray.append(catname)
                catIdArray.append(catId)
                print(catNameArray.count)
                print(catIdArray.count)
                self.pickerView1.reloadAllComponents()
            }
        }
    }
    
    func getSubCategoies(catId: String)
    {
        
        subcatIdArray.removeAll()
        subcatNameArray.removeAll()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Subcategories")
        request.predicate =  NSPredicate(format: "cat_Id == %@",catId )
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try! context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                let subcatname = data.value(forKey: "sub_catname") as! String
                let subcatId = data.value(forKey: "sub_catId") as! String
                subcatIdArray.append(subcatId)
                subcatNameArray.append(subcatname)
                print(subcatIdArray.count)
                print(subcatIdArray.count)
                
            }
        }
    }
    
    
    func categoryListAPI2()
    {
        //let url=baseURl+CategoryList
        let url = "http://allin1inspections.com/admin/webservices/category_data"
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: headers).responseString{ response in
            //  let json = response.result.value
            
            if((response.result.value) != nil)
            {
                print("nielsh")
                
                
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
                    actInd.stopAnimating()
                    
                    self.data=dt0
                    
                    for  i in 0..<dt0.count{
                        //print(i)
                        self.dt11=dt0[i] as Dictionary<String,AnyObject>
                        // print("dt11",dt11["category_id"]!)
                        self.catName=(self.dt11!["cat_name"] as! String)//dt0.value(forKey: "category_id") as Any
                        self.catID=(self.dt11!["cat_id"] as! String)
                        print("cat_name",self.catName!)
                        self.catNameArray.append(self.catName!)
                        self.catIdArray.append(self.catID!)
                        
                        
                        
                    }
                    
                    print("catNameArray",self.catNameArray)
                    print("catIdArray",self.catIdArray)
                    
                    
                    
                    loadingIndicator.stopAnimating()
                    
                case .failure(_):
                    print("fail")
                    break
                }
                
                
            }
            else{
                print("check your net connection")
            }
            
            
            
        }
        
    }
}
extension UIViewController {
    struct ScreenSize {
        static let width = UIScreen.main.bounds.size.width
        static let height = UIScreen.main.bounds.size.height
        static let maxLength = max(ScreenSize.width, ScreenSize.height)
        static let minLength = min(ScreenSize.width, ScreenSize.height)
        static let frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
    }
    
    struct DeviceType {
        static let iPhone4orLess = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength < 568.0
        static let iPhone5orSE = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0
        static let iPhone678 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 667.0
        static let iPhone678p = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 736.0
        static let iPhoneX = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 812.0
        
        
        static let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.maxLength == 1024.0
        static let IS_IPAD_PRO = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.maxLength == 1366.0
        static let IS_IPAD_PRO105 = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.maxLength == 2224.0
    }
}
