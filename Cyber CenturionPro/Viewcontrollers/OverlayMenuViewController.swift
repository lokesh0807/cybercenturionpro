//
//  OverlayMenuViewController.swift
//  Cyber CenturionPro
//
//  Created by Lokesh on 11/02/18.
//  Copyright © 2018 Lokesh. All rights reserved.
//

import UIKit

class OverlayMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var arrMenuList : NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
arrMenuList = ["Go to top", "Add to home", "Find in page", "Screenshot", "Share", "Settings"]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenuList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CELL")
        if cell == nil{
            cell = UITableViewCell (style: UITableViewCellStyle.default, reuseIdentifier: "CELL")
        }
        cell!.textLabel?.text = arrMenuList.object(at: indexPath.row) as? String
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "segueHomeToSettings", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
