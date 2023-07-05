//
//  HomeVC.swift
//  AllInOneInspections
//
//  Created by Ritesh Sinha on 27/04/21.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var inspectorImage: UIImageView!
    @IBOutlet weak var inspectorName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var inspectionListArr = [inspectionList_struct]()
    var pageNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "HomeInspectionListCell", bundle: Bundle.main), forCellReuseIdentifier: "HomeInspectionListCell")
        
        
        tableView.estimatedRowHeight = 250
        //tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.inspectorName.text = "\(UserDefaults.standard.value(forKey: USER_DEFAULTS_KEYS.INSPECTOR_FIRST_NAME) as! String) \(UserDefaults.standard.value(forKey: USER_DEFAULTS_KEYS.INSPECTOR_LAST_NAME) as! String)"
        self.navigationController?.navigationBar.isHidden = true
        self.getInspectionList()
    }
    
    @IBAction func logOutAction(_ sender: Any) {
        let logOutAlert = UIAlertController(title: "Log Out", message: "Do you wish to logout from the app?", preferredStyle: UIAlertController.Style.alert)

        logOutAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
          print("Handle Ok logic here")
          }))

        logOutAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
          print("Handle Cancel Logic here")
          }))

        present(logOutAlert, animated: true, completion: nil)
    }
        
    func getInspectionList() {
        if Reachability.isConnectedToNetwork() {
            showProgressOnView(appDelegateInstance.window!)
            
            let param:[String:String] = [:]
            let url = BASE_URL + PROJECT_URL.GET_INSPECTION_LIST + "?page=\(self.pageNumber)"
            let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
            ServerClass.sharedInstance.getRequestWithUrlParameters(param, path: urlString, successBlock: { (json) in
                print(json)
                hideAllProgressOnView(appDelegateInstance.window!)
                let success = json["success"].boolValue
                if success {
                    self.inspectionListArr.removeAll()
                    for i in 0..<json["data"].count {
                        let inspection_id = json["data"][i]["inspection_id"].stringValue
                        let inspection_address_2 = json["data"][i]["inspection_address_2"].stringValue
                        let time_of_inspection = json["data"][i]["time_of_inspection"].stringValue
                        let is_agreement = json["data"][i]["is_agreement"].boolValue
                        let inspection_country = json["data"][i]["inspection_country"].stringValue
                        let date_of_inspection = json["data"][i]["date_of_inspection"].stringValue
                        let client_name = json["data"][i]["client_name"].stringValue
                        let inspection_name = json["data"][i]["inspection_name"].stringValue
                        let inspection_address = json["data"][i]["inspection_address"].stringValue
                        let inspection_state = json["data"][i]["inspection_state"].stringValue
                        let inspection_zip = json["data"][i]["inspection_zip"].stringValue
                        
                        self.inspectionListArr.append(inspectionList_struct.init(inspection_id: inspection_id, inspection_address_2: inspection_address_2, time_of_inspection: time_of_inspection, is_agreement: is_agreement, inspection_country: inspection_country, date_of_inspection: date_of_inspection, client_name: client_name, inspection_name: inspection_name, inspection_address: inspection_address, inspection_state: inspection_state, inspection_zip: inspection_zip))
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

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.inspectionListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let nib = UINib(nibName: "HomeInspectionListCell", bundle: nil)
        let cell = nib.instantiate(withOwner: self, options: nil).last as! HomeInspectionListCell
        
        let info = self.inspectionListArr[indexPath.row]
        cell.cellPropertyName.text = info.client_name
        cell.cellDateLbl.text = info.date_of_inspection
        cell.cellTimeLbl.text = info.time_of_inspection
        cell.cellLocationLbl.text = info.inspection_name
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let info = self.inspectionListArr[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "InspectionDetailVC") as! InspectionDetailVC
        vc.modalPresentationStyle = .fullScreen
        vc.inspectionInfo = info
       // self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
