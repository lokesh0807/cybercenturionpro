//
//  SettingsViewController.swift
//  Cyber CenturionPro
//
//  Created by Lokesh on 11/02/18.
//  Copyright © 2018 Lokesh. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
   
    
    var arrListHeader: NSMutableArray = []
    var arrBrowserListValues: NSMutableArray = []
    var arrBrowserListSubValues: NSMutableArray = []
    
    var arrAdBlockListValues: NSMutableArray = []
    var arrAdBlockListSubValues: NSMutableArray = []
    
    var arrReadabilityListValues: NSMutableArray = []
    var arrReadabilityListSubValues: NSMutableArray = []
    
    var arrDataListValues: NSMutableArray = []
    var arrDataListSubValues: NSMutableArray = []
    
    var arrOthersListValues: NSMutableArray = []
    var arrOthersListSubValues: NSMutableArray = []
    
    var arrTableListData: NSMutableArray = []
    var arrTableListSubData: NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        arrListHeader = ["Browser Settings" , "AdBlock", "Readability", "Data", "Others"]
        arrBrowserListValues = ["Search Engine","Notification Priority", "Omnibox Position", "Omnibox Control", "Volume Control", "Images", "Cookies","JavaScript", "Location", "Multiple Windows", "Scroll Bar", "Text Reflow", "User Environment", "Rendering"]
        arrBrowserListSubValues = ["Google", "High", "Bottom", "Swipe omnibox left/right to switch tabs", "Switch Tabs", "Enable Network images", "Enable Cookies", "Enable JavaScript", "Allow website to access your location", "Enable Multiple windows", "Show/Hide scroll bar on webpages","Enable text reflow", "Default", "Default"]
        
        arrAdBlockListValues = ["AdBlock", "Whitelist & Blacklist", "Export whitelist", "Import whitelist"]
        arrAdBlockListSubValues = ["Enable AdBlock", "Allow these sites show ads", "", ""]
        
        arrReadabilityListValues = ["Readability", "Token"]
        arrReadabilityListSubValues = ["Enable Readability", "Set Readability Token"]
        
        arrDataListValues = ["Passwords", "Export Bookmarks", "Import Bookmarks", "Clear Control"]
        arrDataListSubValues = ["Save Passwords", "", "", ""]
        
        arrOthersListValues = ["Version", "License", "Donate"]
        arrOthersListSubValues = ["1.0.0", "", ""]

        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrListHeader.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrListHeader.object(at: section) as! String
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            
            return arrBrowserListValues.count
            
        case 1:
            return arrAdBlockListValues.count
            
        case 2:
            return arrReadabilityListValues.count
            
        case 3:
            return arrDataListValues.count
            
        case 4:
            return arrOthersListValues.count
            
            
        default:
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:SettingsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier") as! SettingsTableViewCell
//        if cell == nil{
//            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cellIdentifier")
//        }
        switch indexPath.section {
        case 0:
            
            arrTableListData =  arrBrowserListValues
            arrTableListSubData =  arrBrowserListSubValues
            
        case 1:
            arrTableListData = arrAdBlockListValues
             arrTableListSubData = arrAdBlockListSubValues
        case 2:
            arrTableListData = arrReadabilityListValues
             arrTableListSubData = arrReadabilityListSubValues
        case 3:
            arrTableListData = arrDataListValues
             arrTableListSubData = arrDataListSubValues
        case 4:
            arrTableListData = arrOthersListValues
             arrTableListSubData = arrOthersListSubValues
            
        default:
        break
        }
        cell.lbl_CellTitleText.text = arrTableListData.object(at: indexPath.row) as? String
        cell.lbl_CellSubTitleText.text = arrTableListSubData.object(at: indexPath.row) as? String
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            
            view.textLabel?.textColor = UIColor(red:0.20, green:0.67, blue:0.96, alpha:1.0)
        }
    }
    
  
}
