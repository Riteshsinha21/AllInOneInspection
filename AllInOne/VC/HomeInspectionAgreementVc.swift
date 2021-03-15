//
//  HomeInspectionAgreementVc.swift
//  AllInOne
//
//  Created by Admin on 13/04/19.
//  Copyright © 2019 mac08. All rights reserved.
//

import UIKit
import EPSignature
import Alamofire
import CoreData
@available(iOS 10.0, *)
class HomeInspectionAgreementVc: UIViewController,EPSignatureDelegate {

    @IBOutlet weak var lbl_headerSection: UILabel!
    @IBOutlet weak var lbl_dated: UILabel!
    @IBOutlet weak var lbl_signheretext: UILabel!
    @IBOutlet weak var txt_InspectionMatter: UITextView!
    @IBOutlet weak var SignImage: UIImageView!
   //  let fileManager = FileManager.default
    @IBOutlet weak var heightofView: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        get_Agreement_DataAPI()
        fetchsign()
        let Tapgesture = UITapGestureRecognizer(target: self, action: #selector(self.openSignatureView))
        lbl_signheretext.isUserInteractionEnabled = true
        lbl_signheretext.addGestureRecognizer(Tapgesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle  = DateFormatter.Style.short
        dateFormatter.timeStyle  = DateFormatter.Style.none
        lbl_dated.text = "Dated: " +  dateFormatter.string(from: Date())
       
        let font = UIFont(name: "Times New Roman", size: 17)!
        let boldFont = UIFont(name: "HelveticaNeue-Bold", size: 17)!
        let address = inspAdd! + " " + insp_add_str! + " " + inspCity! + " " + inspState! + " " + inspZipStr!
        lbl_headerSection.attributedText = "The address of the property is \(address ) . Fee for the inspection is $\(inspFees  ?? "").  THIS AGREEMENT made on   \(dateOfInspStr ?? "") by and between Douglas Konschnik  (hereinafter “INSPECTOR”) and the undersigned (“CLIENT”), collectively referred to herein as “the parties.” The Parties understand and voluntarily agree as follow:".withBoldText(
            boldPartsOfString: [], font: font, boldFont: boldFont)
    }
    //MARK:- fetch sign from db
    func fetchsign()
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Signature")
        request.predicate =  NSPredicate(format: "inspectionId == %@", inspectionIdStr!)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if let imageurl = (data.value(forKey: "signImage_id") as? String)
                {
                    let paths1 = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageurl)
                     let fileManager = FileManager.default
                    if fileManager.fileExists(atPath: paths1)
                    {
                        SignImage.image = UIImage(contentsOfFile: paths1)
                        
                    }else{
                        print("No Image")
                    }
                }
            }
        }
        catch {
            print("Failed")
        }
    }
    //MARk:- Tap gesture method
    @objc
    func openSignatureView(sender:UITapGestureRecognizer) {
        let signatureVC = EPSignatureViewController(signatureDelegate: self, showsDate: true, showsSaveSignatureOption: true)
        signatureVC.subtitleText = ""
        signatureVC.title = firstNameStr ?? "" +  lastNameStr
        signatureVC.showsSaveSignatureOption = false
        let nav = UINavigationController(rootViewController: signatureVC)
        present(nav, animated: true, completion: nil)
    }
    @IBAction func btn_openSignatureView_Action(_ sender: Any)
    {
        let signatureVC = EPSignatureViewController(signatureDelegate: self, showsDate: true, showsSaveSignatureOption: true)
        signatureVC.subtitleText = ""
        signatureVC.title = firstNameStr ?? "" +  lastNameStr
        signatureVC.showsSaveSignatureOption = false
        let nav = UINavigationController(rootViewController: signatureVC)
        present(nav, animated: true, completion: nil)
    }
     //MARK:- delegate methode of signture view
    func epSignature(_: EPSignatureViewController, didCancel error : NSError) {
        print("User canceled")
    }
    
    func epSignature(_: EPSignatureViewController, didSign signatureImage : UIImage, boundingRect: CGRect)
    {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todaysDate = formatter.string(from: date)
        
        print(signatureImage)
        SignImage.image = signatureImage
        let imagename1 = "tempImg\(Int(Date().timeIntervalSince1970)).jpg"
        let document = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        print(document)
        let imgurl = document.appendingPathComponent(imagename1, isDirectory: true)
        print(imgurl)
        if !FileManager.default.fileExists(atPath: imgurl.path)
        {
            do{
                try UIImagePNGRepresentation(signatureImage)?.write(to: imgurl)
                print("images added")
            }catch{
                print("imaeg not added")
            }
        }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Signature")
        fetchRequest.predicate = NSPredicate(format: "inspectionId = %@",inspectionIdStr! )
        let res = try! context.fetch(fetchRequest)
        if(res.count>0)
        {
            for Ins in 0 ..< res.count
            {
                let updateObject = res[Ins] as! NSManagedObject
                 updateObject.setValue(imagename1, forKey: "signImage_id")
                updateObject.setValue(imgurl.path, forKey: "sign_image")
                updateObject.setValue(todaysDate, forKey: "signImageDate")
             
                do {
                    try context.save()
                    print(try! context.save())
                    print(" sign image updated sucessfully")
                    
                } catch {
                    
                    print("QA Failed saving")
                }
            }
        }
        else{
            let entity = NSEntityDescription.entity(forEntityName: "Signature", in: context)
            let newsign = NSManagedObject(entity: entity!, insertInto: context)
            newsign.setValue(inspectionIdStr, forKey: "inspectionId")
            newsign.setValue(imgurl.path , forKey: "sign_image")
            newsign.setValue(imagename1, forKey: "signImage_id")
            newsign.setValue(todaysDate, forKey: "signImageDate")
            do {
                try context.save()
                print(try! context.save())
                print(" sign image save")
                
            } catch {
                
                print("sign image not saving")
            }
        }
        
        
       
    }
    //MARK:- Service call
    func get_Agreement_DataAPI()
    {
        let category_dataurl = "http://allin1inspections.com/admin/webservices/get_agreement_data"
        Alamofire.request(category_dataurl, method: .post, parameters: nil, encoding: URLEncoding.default, headers: headers).responseString{ response in
            if((response.result.value) != nil)
            {
                print(response.result.value!)
                let dict = convertToDictionary(text: response.result.value!)
                print("dict123",dict!)
                let success1=(dict!["success"] as! NSNumber)
                print("success1",success1)
                switch(response.result){
                case .success(_):
                    print("sucess")
                    let message:String = dict!["data"] as! String
                    let aux = "<span style=\"font-family: Helvetica Neue; font-size: 20\">\(message)</span>"
                    let htmlData = NSString(string: aux).data(using: String.Encoding.unicode.rawValue)
                    let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
                    let attributedString = try! NSAttributedString(data: htmlData!, options: options, documentAttributes: nil)
                    self.txt_InspectionMatter.attributedText = attributedString
                    switch UIDevice.current.userInterfaceIdiom {
                    case .phone:
                        
                       self.heightofView.constant = self.txt_InspectionMatter.contentSize.height + 2200
                        break
                    case .pad:
                        self.heightofView.constant = self.txt_InspectionMatter.contentSize.height + 1200
                       
                        break
                    case .unspecified:
                        break
                    case .tv:
                        break
                    case .carPlay:
                        break
                    }
                   // self.heightofView.constant = self.txt_InspectionMatter.contentSize.height + 1200
                case .failure(_):
                    print("fail")
                    break
                }
            }else{
                
            }
            
        }
        
    }
    
    
}
extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedStringKey: Any] = [.font: UIFont(name: "HelveticaNeue-Bold", size: 18) as Any]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text)
        append(normal)
        
        return self
    }
}

extension String {
    func withBoldText(boldPartsOfString: Array<NSString>, font: UIFont!, boldFont: UIFont!) -> NSAttributedString {
        let nonBoldFontAttribute = [NSAttributedString.Key.font:font!]
        let boldFontAttribute = [NSAttributedString.Key.font:boldFont!]
        let boldString = NSMutableAttributedString(string: self as String, attributes:nonBoldFontAttribute)
        for i in 0 ..< boldPartsOfString.count {
            boldString.addAttributes(boldFontAttribute, range: (self as NSString).range(of: boldPartsOfString[i] as String))
        }
        return boldString
    }
}
