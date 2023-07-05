//
//  InfoDetailVC.swift
//  AllInOneInspections
//
//  Created by Ritesh Sinha on 04/05/21.
//

import UIKit

class InfoDetailVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var inspectionId: String = String()
    var inspectionAddress: String = String()
    var infoType: String = String()
    
    var clientInfoDetailArr = [clientInfo_struct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "InfoDetailTableCell", bundle: Bundle.main), forCellReuseIdentifier: "InfoDetailTableCell")
        
        
        tableView.estimatedRowHeight = 250
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.infoType == "Client" {
            self.getClientInfoAPI()
        } else if self.infoType == "Retalors" {
            self.getRetalorsInfoAPI()
        } else if self.infoType == "Inspection Info" {
            self.getInspectionInfoAPI()
        } else {
            
        }
        
        
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
                    self.clientInfoDetailArr.removeAll()
                    for i in 0..<json["data"].count {
                        let name = json["data"][i]["name"].stringValue
                        let value = json["data"][i]["value"].stringValue

                        self.clientInfoDetailArr.append(clientInfo_struct.init(name: name, value: value))
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }

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
    
    func getRetalorsInfoAPI() {
        if Reachability.isConnectedToNetwork() {
            showProgressOnView(appDelegateInstance.window!)
            
            let param:[String:String] = [:]
            let url = BASE_URL + PROJECT_URL.GET_RETALORS_INFO + "?inspection_id=\(self.inspectionId)"
            let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
            ServerClass.sharedInstance.getRequestWithUrlParameters(param, path: urlString, successBlock: { (json) in
                print(json)
                hideAllProgressOnView(appDelegateInstance.window!)
                let success = json["success"].boolValue
                if success {
                    self.clientInfoDetailArr.removeAll()
                    for i in 0..<json["data"].count {
                        let name = json["data"][i]["name"].stringValue
                        let value = json["data"][i]["value"].stringValue

                        self.clientInfoDetailArr.append(clientInfo_struct.init(name: name, value: value))
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
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
    
    func getInspectionInfoAPI() {
        if Reachability.isConnectedToNetwork() {
            showProgressOnView(appDelegateInstance.window!)
            
            let param:[String:String] = [:]
            let url = BASE_URL + PROJECT_URL.GET_INSPECTION_INFO + "?inspection_id=\(self.inspectionId)"
            let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
            ServerClass.sharedInstance.getRequestWithUrlParameters(param, path: urlString, successBlock: { (json) in
                print(json)
                hideAllProgressOnView(appDelegateInstance.window!)
                let success = json["success"].boolValue
                if success {
                    self.clientInfoDetailArr.removeAll()
                    for i in 0..<json["data"].count {
                        let name = json["data"][i]["name"].stringValue
                        let value = json["data"][i]["value"].stringValue

                        self.clientInfoDetailArr.append(clientInfo_struct.init(name: name, value: value))
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
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

extension InfoDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.clientInfoDetailArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nib = UINib(nibName: "InfoDetailTableCell", bundle: nil)
        let cell = nib.instantiate(withOwner: self, options: nil).last as! InfoDetailTableCell
        
        let info = self.clientInfoDetailArr[indexPath.row]
        cell.cellLbl.text = info.name
        cell.cellTxtField.text = info.value
        cell.cellTxtField.placeholder = "Enter \(info.name)"
        
        return cell
    }


}
