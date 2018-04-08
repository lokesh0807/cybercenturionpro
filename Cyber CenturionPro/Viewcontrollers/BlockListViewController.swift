//
//  BlockListViewController.swift
//  Cyber CenturionPro
//
//  Created by Arasu on 23/02/18.
//  Copyright © 2018 Lokesh. All rights reserved.
//

import UIKit

//class BlockListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//var arrAddedHomeList: [String] = []
//    var strBlockPageTitle: String = ""
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print(strBlockPageTitle)
//        self.title = strBlockPageTitle
//
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return arrAddedHomeList.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        var cell = tableView.dequeueReusableCell(withIdentifier: "CELL")
//        if cell == nil{
//            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "CELL")
//        }
//
//            cell!.textLabel?.text = arrAddedHomeList[indexPath.row] as? String
//
//        return cell!
//
//    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}

class BlockListViewController: NSObject, NSExtensionRequestHandling {
    
    func beginRequest(with context: NSExtensionContext) {
        
        let attachment = NSItemProvider(contentsOf: Bundle.main.url(forResource: "blockerList", withExtension: "json"))!
        
        print("test")
        
        let item = NSExtensionItem()
        item.attachments = [attachment]
        
        context.completeRequest(returningItems: [item], completionHandler: nil)
        
    }
    
}


