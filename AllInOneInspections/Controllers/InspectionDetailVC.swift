//
//  InspectionDetailVC.swift
//  AllInOneInspections
//
//  Created by Ritesh Sinha on 02/05/21.
//

import UIKit

class InspectionDetailVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var propertyName: UILabel!
    
    var inspectionInfo = inspectionList_struct()
    let mainCategories = ["Info", "Pics", "Inspect", "Additional Photos","Wind mitigation", "4 Point", "Home Agreement"]
    let infoSubCategories = ["Client", "Retalors", "Inspection Info", "Payment Info"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.register(UINib(nibName: "InspectionInfoMainCategoryCollCell", bundle: nil), forCellWithReuseIdentifier: "InspectionInfoMainCategoryCollCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.register(UINib(nibName: "InspectionInfoTableCell", bundle: nil), forCellReuseIdentifier: "InspectionInfoTableCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.navigationBar.isHidden = false
        self.propertyName.text = inspectionInfo.inspection_address
        self.timeLbl.text = inspectionInfo.time_of_inspection
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

}

extension InspectionDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mainCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InspectionInfoMainCategoryCollCell", for: indexPath) as! InspectionInfoMainCategoryCollCell
        cell.cellLbl.text = self.mainCategories[indexPath.row] as String
        return cell
    }
    
    
}

extension InspectionDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.infoSubCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InspectionInfoTableCell", for: indexPath) as! InspectionInfoTableCell
        cell.cellLbl.text = self.infoSubCategories[indexPath.row] as String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "InfoDetailVC") as! InfoDetailVC
        vc.modalPresentationStyle = .fullScreen
        vc.inspectionAddress = inspectionInfo.inspection_name
        vc.inspectionId = inspectionInfo.inspection_id
        vc.infoType = self.infoSubCategories[indexPath.row] as String
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
