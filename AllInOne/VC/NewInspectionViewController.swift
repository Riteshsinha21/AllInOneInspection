//
//  NewInspectionViewController.swift
//  AllInOne
//
//  Created by Apple on 10/29/18.
//  Copyright © 2018 mac08. All rights reserved.
//

import UIKit

class NewInspectionViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource
    
{
    
    @IBOutlet weak var tblVIew: UITableView!
     var expandedRows = Set<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      tblVIew.delegate = self
      tblVIew.dataSource = self
      tblVIew.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:tblViewCell = tblVIew.dequeueReusableCell(withIdentifier: "cell") as! tblViewCell
        cell.isExpanded = self.expandedRows.contains(indexPath.row)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400.0
    }
    // TableView Delegate methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        guard let cell = tableView.cellForRow(at: indexPath) as? tblViewCell
            else { return }
        switch cell.isExpanded
        {
        case true:
            self.expandedRows.remove(indexPath.row)
        case false:
            self.expandedRows.insert(indexPath.row)
        }
        
        
        cell.isExpanded = !cell.isExpanded
        
        tblVIew.beginUpdates()
        tblVIew.endUpdates()
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? tblViewCell
            else { return }
        
        self.expandedRows.remove(indexPath.row)
        
        cell.isExpanded = false
        
        tblVIew.beginUpdates()
        tblVIew.endUpdates()
        
    }
    
    
}


