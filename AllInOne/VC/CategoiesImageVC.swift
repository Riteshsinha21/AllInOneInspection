//
//  CategoiesImageVC.swift
//  AllInOne
//
//  Created by Admin on 09/02/19.
//  Copyright © 2019 mac08. All rights reserved.
//

import UIKit
import Photos
import SVProgressHUD
import BSImagePicker
import CoreData
import DLRadioButton

@available(iOS 11.0, *)

class CategoiesImageVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource
{
    var SelectedAssets = [PHAsset]()
    @IBOutlet weak var CategoirescollectionView: UICollectionView?
    @IBOutlet weak var expandView: UIView?
    @IBOutlet weak var expandImageView: UIImageView!
    var piccatSelectionStr : String = ""
    var islongPressActive : Bool = false
    var tempIndex : Int?
    var imagearray = [UIImage]()

    var ImagesIDArray = [String]()
    private let leftAndRightPaddings: CGFloat = 15.0
    private let numberOfItemsPerRow: CGFloat = 3.0
    var catid : String = ""
    var subcatid : String = ""
    
    var catName : String = ""
    var subcatName : String = ""
    
     var isimagesaveorNot = Bool()
    
    var CatImageDataArray = NSMutableArray();
  
    var internalSelctionCell : NSMutableArray = []
    
    var catNameArrayin = [String]()
    var catIdArrayin = [String]()
    var subCatIdArrayin = [String]()
    var subCatnameArrayin: [String] = []
    
    var ButtonClickcount = 0
    
    var internalSelectedImagesID = [String]()
    
    @IBOutlet weak var assingView: UIView?
    @IBOutlet weak var pickerView1: UIPickerView?
    @IBOutlet weak var catBtn: UIButton!
    @IBOutlet weak var subCatBtn: UIButton!
    
    @IBOutlet weak var btn_assingOutlet: UIButton!
    @IBOutlet weak var btn_deleteOutlet: UIButton!
    
    @IBOutlet weak var lbl_cat: UILabel!
    @IBOutlet weak var lbl_subCat: UILabel!
    
    @IBOutlet weak var lbl_catImage: UILabel!
    @IBOutlet weak var lbl_subCatImage: UILabel!
    
    @IBOutlet weak var okPikBtnOut: UIButton!
    @IBOutlet weak var stackViewAssign: UIStackView!
    @IBOutlet weak var lbl_headerName: UILabel?
    @IBOutlet weak var btn_saveOutlet: UIButton!
    @IBOutlet weak var btn_AddImageOutlet: UIButton!
    
    var catIdStrIn = ""
    var subCatIdStrIn = ""
    var catNameStrIn = ""
    var subCatNameStrIn = ""
    var isfrom = ""
    var fromexisting : Bool = false
    
    //MARK:- Load method
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        SVProgressHUD.show(withStatus: "Please wait..")
        SVProgressHUD.setDefaultMaskType(.clear)
        categoiresimagarray.removeAll()
        CategoiresImagesIDArray.removeAll()
        SelectedAssets.removeAll()
        if UIDevice.current.userInterfaceIdiom == .phone
            
        {
            let bounds = UIScreen.main.bounds
            let width = (bounds.size.width - leftAndRightPaddings*(numberOfItemsPerRow-10)) / numberOfItemsPerRow//+1
            let layout = CategoirescollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = CGSize(width: width, height: width)
            
            if DeviceType.iPhone4orLess{
                expandView?.frame = CGRect(x: 0.0, y: 0.0, width:300.0 , height: 300.0 )
            }else if DeviceType.iPhone5orSE{
                expandView?.frame = CGRect(x: 0.0, y: 0.0, width: 300.0, height:300.0 )
            }else if DeviceType.iPhone678{
                expandView?.frame = CGRect(x: 0.0, y: 0.0, width: 350.0, height: 350.0)
            }else if DeviceType.iPhone678p{
                expandView?.frame = CGRect(x: 0.0, y: 0.0, width: 350.0, height: 350.0)
            }else if DeviceType.iPhoneX{
                expandView?.frame = CGRect(x: 0.0, y: 0.0, width: 350.0, height: 350.0)
            }
            
        }else{
            let bounds = UIScreen.main.bounds
            let width = (bounds.size.width - leftAndRightPaddings*(numberOfItemsPerRow+1)) / numberOfItemsPerRow//+1
            let layout = CategoirescollectionView?.collectionViewLayout as? UICollectionViewFlowLayout
            layout?.itemSize = CGSize(width: width, height: width)
            if DeviceType.IS_IPAD{
                
                expandView?.frame = CGRect(x: 0.0, y: 0.0, width: 600.0, height: 600.0)
            }else if DeviceType.IS_IPAD_PRO{
                
                expandView?.frame = CGRect(x: 0.0, y: 0.0, width: 600.0, height: 600.0)
            }else{
                expandView?.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: view.frame.size.height)
            }
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "loadcategoires"), object: nil)
        
        self.CategoirescollectionView?.isPrefetchingEnabled = false
        self.CategoirescollectionView?.allowsMultipleSelection=true
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(onLongPressGesture(sender:)))
        longPress.minimumPressDuration = 0.2 // optional
        CategoirescollectionView?.addGestureRecognizer(longPress)
        
        pickerView1?.delegate = self
        pickerView1?.dataSource = self
        
        setup()
        
        lbl_headerName?.text = catName + " ->" + subcatName
       self.opencategoiresImages()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        CategoirescollectionView?.delegate = self
        CategoirescollectionView?.dataSource = self
    }
    @objc func loadList(notification: NSNotification){
       isimagesaveorNot = false
        saveAssingPhotos()
        savePhotos()
        DispatchQueue.main.async {
            self.CategoirescollectionView?.reloadData()
        }
        
    }
    func setup()
    {
        self.assingView?.layer.cornerRadius=5
        self.assingView?.layer.shadowColor = UIColor.black.cgColor
        self.assingView?.layer.shadowOpacity = 0.7
        self.assingView?.layer.shadowOffset = CGSize.zero
        self.assingView?.layer.shadowRadius = 4
        self.assingView?.clipsToBounds = false
        self.assingView?.layer.masksToBounds = false;
        
        self.catBtn?.layer.cornerRadius = 5
        self.catBtn?.layer.borderWidth = 1
        self.catBtn?.layer.borderColor = UIColor.gray.withAlphaComponent(1.0).cgColor
        self.catBtn?.clipsToBounds = true
        
        self.subCatBtn?.layer.cornerRadius = 5
        self.subCatBtn?.layer.borderWidth = 1
        self.subCatBtn?.layer.borderColor = UIColor.gray.withAlphaComponent(1.0).cgColor
        self.subCatBtn?.clipsToBounds = true
        
        self.getCategoies()
        
        self.assingView?.isHidden = true
        self.stackViewAssign?.isHidden = true
        pickerView1?.isHidden = true
        okPikBtnOut?.isHidden = true
        
        catBtn?.isHidden = true
        lbl_catImage?.isHidden = true
        lbl_cat?.isHidden = true
        
        subCatBtn?.isHidden = true
        lbl_subCatImage?.isHidden = true
        lbl_subCat?.isHidden = true
        self.pickerView1?.isHidden = true
        self.okPikBtnOut?.isHidden = true
    }
    //MARK:- Longpress gesture methods
    @objc func onLongPressGesture(sender: UILongPressGestureRecognizer) {
        if (sender.state != UIGestureRecognizerState.ended) {
            return;
        }
        
        islongPressActive = true
        let locationInView = sender.location(in: CategoirescollectionView)
        let indexPath = CategoirescollectionView?.indexPathForItem(at: locationInView)
        
        if (indexPath != nil)
        {
            if(fromexisting)
            {
                internalSelectedImagesID.removeAll()
                
                stackViewAssign.isHidden = true
                btn_assingOutlet.isHidden = true
                internalSelctionCell.add(indexPath!.row)
                print("selectedCells..",internalSelctionCell)
                for i in 0 ..< internalSelctionCell.count{
                    let k = internalSelctionCell[i] as! Int
                    internalSelectedImagesID.append(myImagesID[k])
                }
                print("internalSelectedImagesID..",internalSelectedImagesID)
                CategoirescollectionView?.reloadItems(at: [indexPath!])
            }else
            {
                tempIndex = indexPath!.row
                if(isimagesaveorNot)
                {
                    internalSelectedImagesID.removeAll()
                    stackViewAssign.isHidden = false
                    btn_assingOutlet.isHidden = true
                    internalSelctionCell.add(indexPath!.row)
                    print("selectedCells..",internalSelctionCell)
                    for i in 0 ..< internalSelctionCell.count{
                        let k = internalSelctionCell[i] as! Int
                        internalSelectedImagesID.append(CategoiresImagesIDArray[k])
                    }
                    print("internalSelectedImagesID..",internalSelectedImagesID)
                    CategoirescollectionView?.reloadItems(at: [indexPath!])
                }else{
                    internalSelectedImagesID.removeAll()
                    stackViewAssign.isHidden = false
                    btn_assingOutlet.isHidden = false
                    internalSelctionCell.add(indexPath!.row)
                    print("selectedCells..",internalSelctionCell)
                    for i in 0 ..< internalSelctionCell.count{
                        let k = internalSelctionCell[i] as! Int
                        internalSelectedImagesID.append(CategoiresImagesIDArray[k])
                    }
                    print("internalSelectedImagesID..",internalSelectedImagesID)
                    CategoirescollectionView?.reloadItems(at: [indexPath!])
                }
            }
        }
        
        
        
        
    }
    //MARk:- Button Action
    @IBAction func btn_SaveAction(_ sender: Any)
    {
        if(fromexisting)
        {
            
            internalSelctionCell.removeAllObjects()
            for img in 0 ..< internalSelectedImagesID.count
            {
                
                let entity = NSEntityDescription.entity(forEntityName: "AssingImages", in: context)
                let assingImages = NSManagedObject(entity: entity!, insertInto: context)
                print(img)
                
                
                
                assingImages.setValue(internalSelectedImagesID[img], forKey: "image_id")
                assingImages.setValue("category", forKey: "cat_type")
                assingImages.setValue(catid, forKey: "image_category_id")
                assingImages.setValue(subcatid, forKey: "image_sub_category_id")
                assingImages.setValue(catName, forKey: "image_category_name")
                assingImages.setValue(subcatName, forKey: "image_sub_category_name")
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
            let alertController = UIAlertController(title: "", message: "Image Assing successfully!", preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                self.btn_AddImageOutlet.isHidden = false
                self.SelectedAssets.removeAll()
                self.internalSelctionCell.removeAllObjects()
                self.internalSelectedImagesID.removeAll()
                self.opencategoiresImages()
                
            }
            // Add the actions
            alertController.addAction(okAction)
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
            saveAssingPhotos()
            savePhotos()
            SelectedAssets.removeAll()
        }
        
    }
    
    @IBAction func btn_backAction(_ sender: Any)
    {
        let instance: PicsVC = PicsVC()
        instance.fetchImagefromDB()
       
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        SVProgressHUD.dismiss()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btn_AddPhoto(_ sender: Any)
    {
        let alertController = UIAlertController(title: "Choose Photo", message: "", preferredStyle: .alert)
        // Create the actions
        let okAction = UIAlertAction(title: "Take Photo", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.fromexisting = false
           self.btn_AddImageOutlet.isHidden = false
            self.openCamera()
            
        }
        let assingAction = UIAlertAction(title: "Pick from existing photos", style: UIAlertActionStyle.default ) {
            UIAlertAction in
          self.fromexisting = true
            self.btn_AddImageOutlet.isHidden = true
            self.btn_saveOutlet.isHidden = false
            self.CategoirescollectionView?.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive ) {
            UIAlertAction in
            self.fromexisting = false
            self.btn_AddImageOutlet.isHidden = false
            self.btn_saveOutlet.isHidden = true
        }
        let galleryAction = UIAlertAction(title: "Open Gallery", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.fromexisting = false
            self.btn_AddImageOutlet.isHidden = false
            self.openGallary()
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(assingAction)
        alertController.addAction(galleryAction)
        alertController.addAction(cancelAction)
        
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func Btn_CategoriesAction(_ sender: Any)
    {
        isfrom = "categories"
        self.pickerView1?.isHidden = false
        self.okPikBtnOut.isHidden = false
        pickerView1?.reloadAllComponents()
        
        
    }
    @IBAction func Btn_subCatAction(_ sender: Any)
    {
        
        isfrom = "subcategories"
        pickerView1?.reloadAllComponents()
        self.okPikBtnOut.isHidden = false
        self.pickerView1?.isHidden = false
        
    }
    @IBAction func okPikBtn2(_ sender: Any)
    {
        if isfrom == "categories"
        {
            self.getSubCategoies(catId: catIdStrIn)
            pickerView1?.isHidden = true
            okPikBtnOut.isHidden = true
            pickerView1?.reloadAllComponents()
            lbl_subCatImage.isHidden = false
            lbl_subCat.isHidden = false
            subCatBtn.isHidden = false
        }
        else
        {
            //self.getSubCategoies(catId: catIdStr!)
            pickerView1?.isHidden = true
            pickerView1?.reloadAllComponents()
            okPikBtnOut.isHidden = true
        }
        
    }
    @IBAction func btn_CancleAction(_ sender: Any)
    {
        self.assingView?.isHidden = true
        self.stackViewAssign.isHidden = true
        pickerView1?.isHidden = true
        okPikBtnOut.isHidden = true
    }
    @IBAction func btn_AssingInview(_ sender: Any)
    {
        self.assingView?.isHidden = true
        
        if(piccatSelectionStr == "Category")
        {
            piccatSelectionStr = "category"
            print("catIdStr",catIdStrIn)
            print("subCatIdStr",subCatIdStrIn)
        }else{
            catIdStrIn = ""
            subCatIdStrIn = ""
            catNameStrIn = ""
            subCatNameStrIn = ""
        }
        if (piccatSelectionStr == "Client Cover"){
            piccatSelectionStr = "client_cover"
            
        }else if (piccatSelectionStr == "Client Page"){
            piccatSelectionStr = "client_page"
        }else if (piccatSelectionStr == "Additional Pictures"){
            piccatSelectionStr = "additional_pictures"
        }
       
        
        for img in 0 ..< internalSelectedImagesID.count
        {
            if(piccatSelectionStr == "category")
            {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AssingImages")
                let sub_catId = NSPredicate(format: "image_id = %@",internalSelectedImagesID[img])
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
                            updateObject.setValue(internalSelectedImagesID[img], forKey: "image_id")
                            updateObject.setValue(piccatSelectionStr, forKey: "cat_type")
                            updateObject.setValue(catIdStrIn, forKey: "image_category_id")
                            updateObject.setValue(subCatIdStrIn, forKey: "image_sub_category_id")
                            updateObject.setValue(catNameStrIn, forKey: "image_category_name")
                            updateObject.setValue(subCatNameStrIn, forKey: "image_sub_category_name")
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
                            let sub_catId = NSPredicate(format: "image_id = %@",internalSelectedImagesID[img])
                            let inspectionId = NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
                            let cat_type = NSPredicate(format: "cat_type == %@", piccatSelectionStr)
                            let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [sub_catId, inspectionId,cat_type])
                            fetchRequest.predicate = andPredicate
                            let res = try! context.fetch(fetchRequest)
                            if(res.count>0)
                            {
                                //let updateObject = res[0] as! NSManagedObject
                                
                                
                            }else{
                                let entity = NSEntityDescription.entity(forEntityName: "AssingImages", in: context)
                                
                                let assingImages = NSManagedObject(entity: entity!, insertInto: context)
                                print(img)
                                
                                assingImages.setValue(internalSelectedImagesID[img], forKey: "image_id")
                                assingImages.setValue(piccatSelectionStr, forKey: "cat_type")
                                assingImages.setValue(catIdStrIn, forKey: "image_category_id")
                                assingImages.setValue(subCatIdStrIn, forKey: "image_sub_category_id")
                                
                                
                                
                                
                                
                                assingImages.setValue(catNameStrIn, forKey: "image_category_name")
                                assingImages.setValue(subCatNameStrIn, forKey: "image_sub_category_name")
                                
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
                    let sub_catId = NSPredicate(format: "image_id = %@",internalSelectedImagesID[img])
                    let inspectionId = NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
                    let cat_type = NSPredicate(format: "cat_type == %@", piccatSelectionStr)
                    let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [sub_catId, inspectionId,cat_type])
                    fetchRequest.predicate = andPredicate
                    let res = try! context.fetch(fetchRequest)
                    if(res.count>0)
                    {
                        //let updateObject = res[0] as! NSManagedObject
                    }else{
                        let entity = NSEntityDescription.entity(forEntityName: "AssingImages", in: context)
                        
                        let assingImages = NSManagedObject(entity: entity!, insertInto: context)
                        print(img)
                        
                        assingImages.setValue(internalSelectedImagesID[img], forKey: "image_id")
                        assingImages.setValue(piccatSelectionStr, forKey: "cat_type")
                        assingImages.setValue(catIdStrIn, forKey: "image_category_id")
                        assingImages.setValue(subCatIdStrIn, forKey: "image_sub_category_id")
                        
                       
                        
                        assingImages.setValue(catNameStrIn, forKey: "image_category_name")
                        assingImages.setValue(subCatNameStrIn, forKey: "image_sub_category_name")
                        
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
                
                
            }else{
                let entity = NSEntityDescription.entity(forEntityName: "AssingImages", in: context)
                let assingImages = NSManagedObject(entity: entity!, insertInto: context)
                print(img)
                
                assingImages.setValue(internalSelectedImagesID[img], forKey: "image_id")
                assingImages.setValue(piccatSelectionStr, forKey: "cat_type")
                assingImages.setValue(catIdStrIn, forKey: "image_category_id")
                assingImages.setValue(subCatIdStrIn, forKey: "image_sub_category_id")
                
                assingImages.setValue(catNameStrIn, forKey: "image_category_name")
                assingImages.setValue(subCatNameStrIn, forKey: "image_sub_category_name")
                
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
        
        self.removeselection()
//        let alertController2 = UIAlertController(title: "", message: "Images Assigned Successfully!", preferredStyle: .alert)
//
//        // Create the actions
//        alertController2.addAction(UIKit.UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
//
//        self.present(alertController2, animated: true, completion: nil)
        
        let alertController = UIAlertController(title: "", message: "Images Assigned Successfully!", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.opencategoiresImages()
            
        }
        // Add the actions
        alertController.addAction(okAction)
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func btn_deleteAction(_ sender: Any)
    {
        stackViewAssign.isHidden = true
     
        if(isimagesaveorNot)
        {
            
            for i in 0..<internalSelectedImagesID.count
            {
                
                if let index = CategoiresImagesIDArray.index(where: { $0 == internalSelectedImagesID[i] }) {
                    CategoiresImagesIDArray.remove(at: index)
                   categoiresNewimagearray.remove(at: index)
                    categoiresimagarray.remove(at: index)
                   // CatImageDataArray.remove(index)
                }
                DispatchQueue.main.async {
                    self.CategoirescollectionView?.reloadData()
                }
            }
            
            
        }else{
            for i in 0..<internalSelectedImagesID.count
            {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AssingImages")
                let sub_catId = NSPredicate(format: "image_id = %@",internalSelectedImagesID[i] )
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
            //self.fetchImagefromDB()
            self.opencategoiresImages()
            DispatchQueue.main.async {
                self.CategoirescollectionView?.reloadData()
            }
        }
        internalSelctionCell.removeAllObjects()
        internalSelectedImagesID.removeAll()
    }
    @IBAction func btn_openAssingview(_ sender: Any)
    {
        self.assingView?.isHidden = false
    }
    func removeselection(){
        print("didDeslectCell")
        internalSelctionCell.removeAllObjects()
        internalSelectedImagesID.removeAll()
        
        
        
        if internalSelctionCell.count == 0
        {
            stackViewAssign.isHidden = true
            
        }
        islongPressActive = false
        DispatchQueue.main.async {
            self.CategoirescollectionView?.reloadData()
        }
    }
    //MARK:- RadioButton Action
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
            piccatSelectionStr = radioButton.selected()!.titleLabel!.text!
            if radioButton.selected()!.titleLabel!.text! == "Category"
            {
                catBtn.isHidden = false
                lbl_catImage.isHidden = false
                lbl_cat.isHidden = false
                
                subCatBtn.isHidden = true
                lbl_subCatImage.isHidden = true
                lbl_subCat.isHidden = true
                pickerView1?.reloadAllComponents()
                
            }
            else
            {
                
                catBtn.isHidden = true
                lbl_catImage.isHidden = true
                lbl_cat.isHidden = true
                
                subCatBtn.isHidden = true
                lbl_subCatImage.isHidden = true
                lbl_subCat.isHidden = true
                self.pickerView1?.isHidden = true
                self.okPikBtnOut.isHidden = true
                
                
            }
        }
    }
    
    func openCamera()
    {
      //   self.btn_saveOutlet.isHidden = false
        ButtonClickcount =  1
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")as! ViewController
        vc.fromwhere = "categories"
       // catid subcatid subcatName catName
        vc.CatId = catid
        vc.CatName = catName
        vc.subCatId = subcatid
        vc.SubCatName = subcatName
        if(ButtonClickcount == 1){
            CategoiresImagesIDArray.removeAll()
            categoiresNewimagearray.removeAll()
             categoiresimagarray.removeAll()
        }else{
            
        }

        isimagesaveorNot = true
        self.present(vc, animated: false, completion: nil)
        
    }
    func openGallary()
    {
        SelectedAssets.removeAll()
         //self.btn_saveOutlet.isHidden = false
        let vc = BSImagePickerViewController()
        vc.maxNumberOfSelections = 15
        
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
            CategoiresImagesIDArray.removeAll()
          //  imagarray.removeAll()
            categoiresimagarray.removeAll()
            categoiresNewimagearray.removeAll()
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
                
               // imagearray.append(newImage! as UIImage)
                categoiresNewimagearray.append(newImage! as UIImage)
                CategoiresImagesIDArray.append(imagename)
                 isimagesaveorNot = true
                saveimageinDic(numm: imagename, image: newImage!)
            }
            
            }

            
        }
        
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            
            self.saveAssingPhotos()
            self.savePhotos()
            self.SelectedAssets.removeAll()
            
           // self.CategoirescollectionView?.reloadData()
        }
    }
    
    
    // func saveimageinDic(numm:Int){
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
        
      //  imagarray.append(imgurl)
        categoiresimagarray.append(imgurl)
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Picker view delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (isfrom == "categories")
        {
            return catNameArrayin.count
        }
        else
        {
            return subCatnameArrayin.count
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
    {
        if (isfrom == "categoires")
        {
            return 40
        }
        else
        {
            return 40
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if (isfrom == "categories"){
            
            self.lbl_cat.text = self.catNameArrayin[row]
            catIdStrIn = self.catIdArrayin[row]
            catNameStrIn = self.catNameArrayin[row]
            print("catId..",catIdStrIn)
            
        }
        else
        {
            self.lbl_subCat.text = subCatnameArrayin[row]
            
            subCatIdStrIn = subCatIdArrayin[row]
            subCatNameStrIn = subCatnameArrayin[row]
            
            print("subCatIdStr..",subCatIdStrIn)
        }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        self.view.endEditing(true)
        if(isfrom == "categories"){
            return self.catNameArrayin[row]
        }else{
            return subCatnameArrayin[row]
        }
        
    }
    func getCategoies()
    {
        catNameArrayin.removeAll()
        catIdArrayin.removeAll()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MainCategories")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try! context.fetch(request)
            for data in result as! [NSManagedObject] {
                let catname = data.value(forKey: "cat_Name") as! String
                let catId = data.value(forKey: "cat_Id") as! String
                catNameArrayin.append(catname)
                catIdArrayin.append(catId)
                print(catNameArrayin.count)
                print(catIdArrayin.count)
                
            }
        }
    }
    
    func getSubCategoies(catId: String)
    {
        
        subCatnameArrayin.removeAll()
        subCatIdArrayin.removeAll()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Subcategories")
        request.predicate =  NSPredicate(format: "cat_Id == %@",catId )
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try! context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                let subcatname = data.value(forKey: "sub_catname") as! String
                let subcatId = data.value(forKey: "sub_catId") as! String
                subCatIdArrayin.append(subcatId)
                subCatnameArrayin.append(subcatname)
                print(subCatIdArrayin.count)
                print(subCatnameArrayin.count)
                
            }
        }
    }
    
    
    
    //MARK:- Collection Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(fromexisting){
            return myImagespath.count
        }else{
            return categoiresimagarray.count
        }
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        SVProgressHUD.dismiss()
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pics", for: indexPath) as? CollectionViewCellPics
            else{
                return UICollectionViewCell()
                
        }
        
        if(fromexisting){
            
            
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
            
            let fileManager = FileManager.default
            
            if fileManager.fileExists(atPath: paths1){
                
                cell.imageVIew1.image = UIImage(contentsOfFile: paths1)
                
            }else{
                
                print("No Image")
                
            }
            let tickImage = cell.viewWithTag(1) as? UIImageView
            
            if internalSelctionCell.contains(indexPath.row) {
                cell.isSelected=true
                cell.layer.borderWidth = 5
                cell.layer.borderColor = UIColor.black.withAlphaComponent(1.0).cgColor
                cell.clipsToBounds = true
                CategoirescollectionView?.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.top)
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
        else
        {
             cell.lbl_AssingImagesInfo.text = ""
        let imagename = CategoiresImagesIDArray[indexPath.row]
        let paths1 = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imagename)
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: paths1){
            cell.imageVIew1.image = UIImage(contentsOfFile: paths1)
        }else{
            print("No Image")
        }
        
        let tickImage = cell.viewWithTag(1) as? UIImageView
        if internalSelctionCell.contains(indexPath.row) {
            cell.isSelected=true
            cell.layer.borderWidth = 5
            cell.layer.borderColor = UIColor.black.withAlphaComponent(1.0).cgColor
            cell.clipsToBounds = true
            CategoirescollectionView?.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.top)
            tickImage?.isHidden=false
        }
        else{
            cell.isSelected=false
            cell.layer.borderWidth = 0
            cell.layer.borderColor = UIColor.clear.withAlphaComponent(1.0).cgColor
            cell.clipsToBounds = true
            tickImage?.isHidden=true
        }
        return cell
    }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        
        if(islongPressActive)
        {
            
            if(fromexisting)
            {
                
                internalSelectedImagesID.removeAll()
                internalSelctionCell.add(indexPath.row)
                print("selectedCells..",internalSelctionCell)
                for i in 0 ..< internalSelctionCell.count{
                    let k = internalSelctionCell[i] as! Int
                    internalSelectedImagesID.append(myImagesID[k])
                }
                CategoirescollectionView?.reloadItems(at: [indexPath])
                print("internalSelectedImageArray..",internalSelectedImagesID)
            }
            else
            {
                internalSelectedImagesID.removeAll()
                internalSelctionCell.add(indexPath.row)
                print("selectedCells..",internalSelctionCell)
                
                for i in 0 ..< internalSelctionCell.count{
                    
                    let k = internalSelctionCell[i] as! Int
                    
                    internalSelectedImagesID.append(CategoiresImagesIDArray[k])
                }
                CategoirescollectionView?.reloadItems(at: [indexPath])
                print("internalSelectedImageArray..",internalSelectedImagesID)
            }
        }
        else
        {
            var imagename = ""
            if(fromexisting)
            {
                imagename = myImagesID[indexPath.row]
            }
            else
            {
                imagename = CategoiresImagesIDArray[indexPath.row]
                
            }
            
   

            let paths1 = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imagename)

            let fileManager = FileManager.default

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
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        
        if(fromexisting){
            internalSelectedImagesID.removeAll()
            internalSelctionCell.remove(indexPath.row)
            
            for i in 0 ..< internalSelctionCell.count{
                let k = internalSelctionCell[i] as! Int
                internalSelectedImagesID.append(myImagesID[k])
                
            }
            
            if internalSelctionCell.count == 0
            {
                
                islongPressActive = false
            }
            
            CategoirescollectionView?.reloadItems(at: [indexPath])
        }else{
        internalSelectedImagesID.removeAll()
        internalSelctionCell.remove(indexPath.row)
        
        for i in 0 ..< internalSelctionCell.count{
            let k = internalSelctionCell[i] as! Int
            internalSelectedImagesID.append(CategoiresImagesIDArray[k])
            
        }
        
        if internalSelctionCell.count == 0
        {
            
            islongPressActive = false
        }
        
        CategoirescollectionView?.reloadItems(at: [indexPath])
        }
    }
    
    func savePhotos()
    {
        // deleteAllRecords()
        
        
        for img in 0 ..< categoiresNewimagearray.count
        {
            let entity = NSEntityDescription.entity(forEntityName: "Images", in: context)
            let Images = NSManagedObject(entity: entity!, insertInto: context)
            print(img)
            
            Images.setValue(categoiresimagarray[img].path, forKey: "imagepath")
            // Images.setValue(CatImageDataArray[img], forKey: "image")
            Images.setValue("categories", forKey: "cat_type")
            Images.setValue(catid, forKey: "image_category")
            Images.setValue(subcatid, forKey: "image_sub_category")
            Images.setValue(CategoiresImagesIDArray[img], forKey: "image_id")
            Images.setValue(inspectionIdStr, forKey: "inspectionId")
            Images.setValue("No", forKey: "isUploadedToServer")
            do {
                try context.save()
                print(try! context.save())
                print(" Inspection images save")
                
                
            } catch {
                
                print("QA Failed saving")
            }
            
        }
         self.opencategoiresImages()
        let alertController = UIAlertController(title: "", message: "Image saved successfully!", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
           
            
        }
        // Add the actions
        alertController.addAction(okAction)
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    func saveAssingPhotos()
    {
       
       
        for img in 0 ..< categoiresNewimagearray.count
        {
            let entity = NSEntityDescription.entity(forEntityName: "AssingImages", in: context)
            let Images = NSManagedObject(entity: entity!, insertInto: context)
            Images.setValue("category", forKey: "cat_type")
            Images.setValue(catid, forKey: "image_category_id")
            Images.setValue(subcatid, forKey: "image_sub_category_id")
            Images.setValue(catName, forKey: "image_category_name")
            Images.setValue(subcatName, forKey: "image_sub_category_name")
            Images.setValue(CategoiresImagesIDArray[img], forKey: "image_id")
            Images.setValue(inspectionIdStr, forKey: "inspectionId")
            Images.setValue("server", forKey: "server_image_Id")
            do {
                try context.save()
                print(try! context.save())
                print(" assing images save")
                
                
            } catch {
                
                print("QA Failed saving")
            }
            
        }
        
    }
    func opencategoiresImages()
    {
        fromexisting = false
        categoiresNewimagearray.removeAll()
        ButtonClickcount = 0
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AssingImages")
        let sub_catId = NSPredicate(format: "image_sub_category_id = %@",subcatid)
        let inspectionId = NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
        let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [sub_catId, inspectionId])
        fetchRequest.predicate = andPredicate
        let res = try! context.fetch(fetchRequest)
        
        if(res.count>0)
        {
            self.imagearray.removeAll()
           categoiresimagarray.removeAll()
            categoiresimagarray.removeAll()
            CategoiresImagesIDArray.removeAll()
            print("res.count",res.count)
            for data in res as! [NSManagedObject] {
                
                let imageId = data.value(forKey: "image_id") as? String
              
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Images")
                let ImageId = NSPredicate(format: "image_id = %@",imageId! )
                let inspectionId = NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
                let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [ImageId, inspectionId])
                fetchRequest.predicate = andPredicate
                fetchRequest.returnsObjectsAsFaults = false
                do {
                     isimagesaveorNot = false
                    let result = try context.fetch(fetchRequest)
                    for data in result as! [NSManagedObject] {
                        if let imageurl = (data.value(forKey: "imagepath") as? String) {
                          
                             categoiresimagarray.append(URL(fileURLWithPath: imageurl as String))
                            CategoiresImagesIDArray.append((data.value(forKey: "image_id") as! String))
                            
                        }
                        
                    }
                    
                }catch {
                    
                    print("Failed")
                }
            }
           self.btn_saveOutlet?.isHidden = true
            CategoirescollectionView?.reloadData()
        }else{
            
            print("No res.count")
            self.imagearray.removeAll()
            categoiresimagarray.removeAll()
            categoiresimagarray.removeAll()
            CategoiresImagesIDArray.removeAll()
            self.btn_saveOutlet?.isHidden = true
            CategoirescollectionView?.reloadData()
        }
    }
    
}
