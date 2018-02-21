//
//  SettingsViewController.swift
//  Cyber CenturionPro
//
//  Created by Lokesh on 11/02/18.
//  Copyright © 2018 Lokesh. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Header"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CELL")
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "CELL")
        }
        cell?.textLabel?.text = "Settings"
        cell?.detailTextLabel?.text = "Detail Text"
        return cell!
    }

}
