//
//  InfoDetailVC.swift
//  AllInOneInspections
//
//  Created by Ritesh Sinha on 02/05/21.
//

import UIKit

class ClientInfoDetailVC: UIViewController {

    @IBOutlet weak var headerText: UILabel!
    
    var inspectionId: String = String()
    var inspectionAddress: String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getClientInfoAPI()
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getClientInfoAPI() {
        if Reachability.isConnectedToNetwork() {
            showProgressOnView(appDelegateInstance.window!)
            
            let param:[String:String] = [:]
            let url = BASE_URL + PROJECT_URL.GET_CLIENT_INFO + "?inspection_id=\(self.inspectionId)"
            let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
            ServerClass.sharedInstance.getRequestWithUrlParameters(param, path: urlString, successBlock: { (json) in
                print(json)
                hideAllProgressOnView(appDelegateInstance.window!)
                let success = json["success"].boolValue
                if success {
//                    self.inspectionListArr.removeAll()
//                    for i in 0..<json["data"].count {
//                        let inspection_id = json["data"][i]["inspection_id"].stringValue
//                        let inspection_address_2 = json["data"][i]["inspection_address_2"].stringValue
//                        let time_of_inspection = json["data"][i]["time_of_inspection"].stringValue
//                        let is_agreement = json["data"][i]["is_agreement"].boolValue
//                        let inspection_country = json["data"][i]["inspection_country"].stringValue
//                        let date_of_inspection = json["data"][i]["date_of_inspection"].stringValue
//                        let client_name = json["data"][i]["client_name"].stringValue
//                        let inspection_name = json["data"][i]["inspection_name"].stringValue
//                        let inspection_address = json["data"][i]["inspection_address"].stringValue
//                        let inspection_state = json["data"][i]["inspection_state"].stringValue
//                        let inspection_zip = json["data"][i]["inspection_zip"].stringValue
//
//                        self.inspectionListArr.append(inspectionList_struct.init(inspection_id: inspection_id, inspection_address_2: inspection_address_2, time_of_inspection: time_of_inspection, is_agreement: is_agreement, inspection_country: inspection_country, date_of_inspection: date_of_inspection, client_name: client_name, inspection_name: inspection_name, inspection_address: inspection_address, inspection_state: inspection_state, inspection_zip: inspection_zip))
//                    }
//
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
                    
                }
                else {
                    UIAlertController.showInfoAlertWithTitle("Message", message: json["message"].stringValue, buttonTitle: "Okay")
                }
            }, errorBlock: { (NSError) in
                UIAlertController.showInfoAlertWithTitle("Alert", message: kUnexpectedErrorAlertString, buttonTitle: "Okay")
                hideAllProgressOnView(appDelegateInstance.window!)
            })
            
        }else{
            hideAllProgressOnView(appDelegateInstance.window!)
            UIAlertController.showInfoAlertWithTitle("Alert", message: "Please Check internet connection", buttonTitle: "Okay")
        }
    }
    
}
