//
//  AdditionaltabVC.swift
//  AllInOne
//
//  Created by Admin on 01/02/19.
//  Copyright © 2019 mac08. All rights reserved.
//

import UIKit
import CoreData

@available(iOS 11.0, *)
class AdditionaltabVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var expandView: UIView!
    @IBOutlet weak var expandImageView: UIImageView!
    var islongPressActive : Bool = false
    var tempIndex : Int?
    private let leftAndRightPaddings: CGFloat = 15.0
    private let numberOfItemsPerRow: CGFloat = 3.0
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var FirstView: UIView!
    @IBOutlet weak var addtionalbtnleading: NSLayoutConstraint!
    @IBOutlet weak var widthFirstView: NSLayoutConstraint!
    @IBOutlet weak var leadingFirstView: NSLayoutConstraint!
    var fromWhere = ""
    var imagarray = [URL]()
    var ImagesIDArray = [String]()
    var internalSelctionCell : NSMutableArray = []
    var internalSelectedImagesID = [String]()
    var internalSelectedImageArray = [UIImage]()
    @IBOutlet weak var btn_deleteOutlet: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        internalSelctionCell.removeAllObjects()
        
        // Do any additional setup after loading the view.
        if UIDevice.current.userInterfaceIdiom == .phone
            
        {
            let bounds = UIScreen.main.bounds
            let width = (bounds.size.width - leftAndRightPaddings*(numberOfItemsPerRow-10)) / numberOfItemsPerRow//+1
            let layout = collectionView1.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = CGSize(width: width, height: width)
            
            if DeviceType.iPhone4orLess{
                expandView.frame = CGRect(x: 0.0, y: 0.0, width:300.0 , height: 300.0 )
            }else if DeviceType.iPhone5orSE{
                expandView.frame = CGRect(x: 0.0, y: 0.0, width: 300.0, height:300.0 )
            }else if DeviceType.iPhone678{
                expandView.frame = CGRect(x: 0.0, y: 0.0, width: 350.0, height: 350.0)
            }else if DeviceType.iPhone678p{
                expandView.frame = CGRect(x: 0.0, y: 0.0, width: 370.0, height: 370.0)
            }else if DeviceType.iPhoneX{
                expandView.frame = CGRect(x: 0.0, y: 0.0, width: 350.0, height: 350.0)
            }
            
        }
        else
        {
            let bounds = UIScreen.main.bounds
            let width = (bounds.size.width - leftAndRightPaddings*(numberOfItemsPerRow+1)) / numberOfItemsPerRow//+1
            let layout = collectionView1.collectionViewLayout as? UICollectionViewFlowLayout
            layout?.itemSize = CGSize(width: width, height: width)
            
            if DeviceType.IS_IPAD{
                
                expandView.frame = CGRect(x: 0.0, y: 0.0, width: 600.0, height: 600.0)
            }else if DeviceType.IS_IPAD_PRO{
                
                expandView.frame = CGRect(x: 0.0, y: 0.0, width: 600.0, height: 600.0)
            }else{
                expandView.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: view.frame.size.height)
            }
        }
        
        self.collectionView1?.isPrefetchingEnabled = true
        self.collectionView1.allowsMultipleSelection=true
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(onLongPressGesture(sender:)))
        longPress.minimumPressDuration = 0.2 // optional
        collectionView1.addGestureRecognizer(longPress)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fromWhere = "client_cover"
        fetchAssingImage(cat_type1: fromWhere)
    }
    //MARK:- Longpress gesture methods
    
    @objc func onLongPressGesture(sender: UILongPressGestureRecognizer) {
        if (sender.state != UIGestureRecognizerState.ended) {
            return;
        }
        
        islongPressActive = true
        let locationInView = sender.location(in: collectionView1)
        let indexPath = collectionView1.indexPathForItem(at: locationInView)
        tempIndex = indexPath!.row
        print("temp...",tempIndex!)
        internalSelectedImagesID.removeAll()
        internalSelectedImageArray.removeAll()
        btn_deleteOutlet.isHidden = false
        //        stackViewAssign.isHidden = false
        //        cancelBtnOut.isHidden = false
        //        addBtnHide.isHidden = true
        //        assignBtnOut.isHidden = false
        internalSelctionCell.add(indexPath!.row)
        print("selectedCells..",internalSelctionCell)
        
        for i in 0 ..< internalSelctionCell.count{
            let k = internalSelctionCell[i] as! Int
            //  internalSelectedImageArray.append(myImagesDecodedLD[k])
             internalSelectedImagesID.append(ImagesIDArray[k])
        }
        print("internalSelectedImagesID..",internalSelectedImagesID)
        collectionView1.reloadItems(at: [indexPath!])
        
        
    }
    //MARK:- Button press method
    @IBAction func btnClientcoverTapped(_ sender: UIButton) {
        
        internalSelectedImageArray.removeAll()
        internalSelectedImagesID.removeAll()
        internalSelctionCell.removeAllObjects()
        islongPressActive = false
        
        FirstView.layer.cornerRadius = 1.0
        self.leadingFirstView.constant = 0.0
        UIView.animate(withDuration: 1, animations: {
            self.view.layoutIfNeeded()
            // self.FirstView.frame.origin.x = 0.0
        }, completion: nil)
         fromWhere = "client_cover"
        fetchAssingImage(cat_type1: fromWhere)
       
    }
    @IBAction func btnClientPageTapped(_ sender: Any) {
        
        internalSelectedImageArray.removeAll()
        internalSelectedImagesID.removeAll()
        internalSelctionCell.removeAllObjects()
        islongPressActive = false
        
        leadingFirstView.constant = self.view.frame.size.width / 3
        UIView.animate(withDuration: 1, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        fromWhere = "client_page"
        fetchAssingImage(cat_type1: fromWhere)
        
       
        
    }
    @IBAction func btnAdditionalphotoTapped(_ sender: Any) {
        
        internalSelectedImageArray.removeAll()
        internalSelectedImagesID.removeAll()
        internalSelctionCell.removeAllObjects()
        islongPressActive = false
        
        leadingFirstView.constant = (self.view.frame.size.width / 3) + self.view.frame.size.width / 3
        UIView.animate(withDuration: 1, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        fromWhere = "additional_pictures"
        fetchAssingImage(cat_type1: fromWhere)
        
        //fetchAssingImage(cat_type: "Additional Pictures")
    }
    
    @IBAction func deleteBtn(_ sender: Any)
    {
        btn_deleteOutlet.isHidden = true
        print(internalSelctionCell)
        for i in 0..<internalSelectedImagesID.count
        {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AssingImages")
            let sub_catId = NSPredicate(format: "image_id = %@",internalSelectedImagesID[i] )
            let inspectionId = NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
            let cattype = NSPredicate(format: "cat_type == %@", fromWhere)
            let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [sub_catId, inspectionId,cattype])
            fetchRequest.predicate = andPredicate
            
            let result = try! context.fetch(fetchRequest)
           
            
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
        let alertController = UIAlertController(title: "", message: "Image removed successfully!", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.islongPressActive = false
            self.internalSelctionCell.removeAllObjects()
            self.fetchAssingImage(cat_type1: self.fromWhere)
            
            DispatchQueue.main.async {
                self.collectionView1.reloadData()
            }
            
        }
        // Add the actions
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func fetchAssingImage(cat_type1: String)
    {
        print(cat_type1)
        self.imagarray.removeAll()
        ImagesIDArray.removeAll()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AssingImages")
        let cat_type = NSPredicate(format: "cat_type = %@",cat_type1)
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
                            self.imagarray.append(URL(fileURLWithPath: imageurl as String))
                            ImagesIDArray.append((data.value(forKey: "image_id") as! String))
                        }
                    }
                    
                }catch {
                    
                    print("Failed")
                }
            }
            collectionView1.reloadData()
        }else{
            print("No res.count")
            self.imagarray.removeAll()
            ImagesIDArray.removeAll()
            collectionView1.reloadData()
        }
    }
    //MARK:- Collection Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imagarray.count;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView1.dequeueReusableCell(withReuseIdentifier: "pics", for: indexPath as IndexPath) as! CollectionViewCellPics
        
        let imagename = ImagesIDArray[indexPath.row]
        
        let paths1 = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imagename)
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: paths1){
            cell.imageVIew1.image = UIImage(contentsOfFile: paths1)
        }else{
            
            print("No Image")
            
        }
        
        
        //  cell.imageVIew1.image = self.imagarray[indexPath.row]
        let tickImage = cell.viewWithTag(1) as? UIImageView
        
        if internalSelctionCell.contains(indexPath.row) {
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
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        
        if(islongPressActive)
        {
            internalSelectedImagesID.removeAll()
            internalSelectedImageArray.removeAll()
            btn_deleteOutlet.isHidden = false
            //            stackViewAssign.isHidden = false
            //            cancelBtnOut.isHidden = false
            //            addBtnHide.isHidden = true
            //            assignBtnOut.isHidden = false
            internalSelctionCell.add(indexPath.row)
            print("selectedCells..",internalSelctionCell)
            
            for i in 0 ..< internalSelctionCell.count{
                
                let k = internalSelctionCell[i] as! Int
                
                internalSelectedImagesID.append(ImagesIDArray[k])
            }
            collectionView1.reloadItems(at: [indexPath])
            print("internalSelectedImageArray..",internalSelectedImagesID)
        }
        else
        {
            
            let imagename = ImagesIDArray[indexPath.row]
            
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
        
        
        internalSelectedImagesID.removeAll()
        internalSelctionCell.remove(indexPath.row)
        
        for i in 0 ..< internalSelctionCell.count{
            let k = internalSelctionCell[i] as! Int
            internalSelectedImagesID.append(ImagesIDArray[k])
            
        }
        
        if internalSelctionCell.count == 0
        {
            btn_deleteOutlet.isHidden = false
            
            islongPressActive = false
        }
        
        collectionView1.reloadItems(at: [indexPath])
    }
    
}
