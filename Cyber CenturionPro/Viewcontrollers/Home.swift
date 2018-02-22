//
//  ViewController.swift
//  Cyber CenturionPro
//
//  Created by Lokesh on 10/02/18.
//  Copyright © 2018 Lokesh. All rights reserved.
//

import UIKit
import WebKit
class Home: UIViewController, UITableViewDelegate,UITableViewDataSource, UIGestureRecognizerDelegate, UIWebViewDelegate, UITextFieldDelegate, WKNavigationDelegate {

    @IBOutlet weak var view_OverLayMenuInner: UIView!
    @IBOutlet weak var view_OverLayMenuOuter: UIView!
    @IBOutlet weak var webview_Browser: WKWebView!
    
    @IBOutlet weak var txt_URLTextField: UITextField!
    
    @IBOutlet weak var tbl_AddedListToHome: UITableView!
    
    var arrOverlayMenuList: NSMutableArray = []
    var arrAddedHomeList: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        arrOverlayMenuList =  ["Go to top", "Add to home", "Find in page", "Screenshot", "Share", "Settings"]
        if CommonUttils().getHomeList() as? NSMutableArray != nil {
             arrAddedHomeList = CommonUttils().getHomeList() as! [String]
        }
       
        
        let gestureSingleTap = UITapGestureRecognizer(target: self, action: #selector(self.gesture_OutsideMenuList(_:)))
        gestureSingleTap.delegate = self
        view_OverLayMenuInner.addGestureRecognizer(gestureSingleTap)
        webview_Browser.navigationDelegate = self
    }

   
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let str_URLText:String = "https://www.google.co.in"
        
        let url:URL = URL(string: str_URLText)!
        let urlRequest:URLRequest = URLRequest(url: url)
        webview_Browser.load(urlRequest)
    }
    
    @IBAction func btn_MenuClick(_ sender: Any) {
        self.view_OverLayMenuOuter.isHidden = false
    }
    
    @objc func gesture_OutsideMenuList(_ sender: UITapGestureRecognizer) {
        self.view_OverLayMenuOuter.isHidden = true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == tbl_AddedListToHome) {
            return arrAddedHomeList.count
        }
        return arrOverlayMenuList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "CELL")
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "CELL")
        }
        if (tableView == tbl_AddedListToHome) {
            cell!.textLabel?.text = arrAddedHomeList[indexPath.row] as? String
        }
        else{
        cell!.textLabel?.text = arrOverlayMenuList.object(at: indexPath.row) as? String
        }
        return cell!
        
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        
        case 1:
            if !((txt_URLTextField.text?.isEmpty)!){
            CommonUttils().setHomeList(strURL: (self.txt_URLTextField.text)!)

                arrAddedHomeList = CommonUttils().getHomeList() as! [String]
                tbl_AddedListToHome.reloadData()
                self.view_OverLayMenuOuter.isHidden = true

            }
            else{
                let alert = UIAlertController(title: "Alert", message: "URL should not be empty", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
           return

        default:
            break
        }
        
//        performSegue(withIdentifier: "segueHomeToSettings", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        self.loadURLToWebView()
        return true
    }
    func loadURLToWebView()  {
        var strRawURL = self.txt_URLTextField.text!
         var str_URLText:String = strRawURL
        if !(strRawURL.contains(".com") || strRawURL.contains(".co")) {
          str_URLText = "http://www.google.com/search?q=\(strRawURL)"
        }
        else if !(strRawURL.contains("http")) {
            str_URLText = "http://\(strRawURL)"
        }
        
        
        
        let url:URL = URL(string: str_URLText)!
        let urlRequest:URLRequest = URLRequest(url: url)
        webview_Browser.load(urlRequest)
        self.txt_URLTextField.resignFirstResponder()
        self.webview_Browser.isHidden = false
        self.tbl_AddedListToHome.isHidden = true
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        txt_URLTextField.text = webView.url?.absoluteString
    }
    @IBAction func btn_RefreshClick(_ sender: Any) {
        self.loadURLToWebView()
    }
    
    
}

