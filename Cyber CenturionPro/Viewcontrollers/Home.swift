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
    
    @IBOutlet weak var prg_LoadingProgressView: UIProgressView!
    @IBOutlet weak var txt_URLTextField: UITextField!
    
    @IBOutlet weak var tbl_AddedListToHome: UITableView!
    @IBOutlet weak var btn_Back: UIBarButtonItem!
    @IBOutlet weak var btn_Forward: UIBarButtonItem!
    @IBOutlet weak var btn_Refresh: UIBarButtonItem!
    
    
    
    var strPageTitle: String = ""
    var arrHistoryList: NSMutableArray = []
    var arrBlockedList: NSMutableArray = []
    var arrOverlayMenuList: NSMutableArray = []
    var arrAddedHomeList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrOverlayMenuList =  ["View Blocklist", "Add to Blocklist", "Find in page", "Screenshot", "Share","History", "Settings"]
        btn_Back.isEnabled = false
        btn_Forward.isEnabled = false
        webview_Browser.addObserver(self, forKeyPath: "loading", options: .new, context: nil)
        prg_LoadingProgressView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        if CommonUttils().getHomeList() as? NSMutableArray != nil {
             arrAddedHomeList = CommonUttils().getHomeList() as! [String]
        }
       
        
        let gestureSingleTap = UITapGestureRecognizer(target: self, action: #selector(self.gesture_OutsideMenuList(_:)))
        gestureSingleTap.delegate = self
        view_OverLayMenuInner.addGestureRecognizer(gestureSingleTap)
        webview_Browser.navigationDelegate = self
        
        let str_URLText:String = "https://www.google.co.in"
        
        let url:URL = URL(string: str_URLText)!
        let urlRequest:URLRequest = URLRequest(url: url)
        webview_Browser.load(urlRequest)
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
        
       
    }
    
    @IBAction func btn_MenuClick(_ sender: Any) {
        self.view_OverLayMenuOuter.isHidden = false
    }
    
    @objc func gesture_OutsideMenuList(_ sender: UITapGestureRecognizer) {
        self.view_OverLayMenuOuter.isHidden = true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if (tableView == tbl_AddedListToHome) {
//            return arrAddedHomeList.count
//        }
        return arrOverlayMenuList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "CELL")
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "CELL")
        }
//        if (tableView == tbl_AddedListToHome) {
//            cell!.textLabel?.text = arrAddedHomeList[indexPath.row] as? String
//        }
//        else{
        cell!.textLabel?.text = arrOverlayMenuList.object(at: indexPath.row) as? String
       cell?.selectionStyle = UITableViewCellSelectionStyle.none
        return cell!
        
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view_OverLayMenuOuter.isHidden = true

        switch indexPath.row {
        case 0:
            
            if !(CommonUttils().getHomeList() is NSNull ) {
                arrAddedHomeList = CommonUttils().getHomeList() as! [String]
            }
            strPageTitle = "Blocked List"
            performSegue(withIdentifier: "segueHomeToBlockList", sender: nil)
            
            
        case 1:
            if !((txt_URLTextField.text?.isEmpty)!){
            CommonUttils().setHomeList(strURL: (self.txt_URLTextField.text)!)

                arrAddedHomeList = CommonUttils().getHomeList() as! [String]
                tbl_AddedListToHome.reloadData()
                

            }
            else{
                let alert = UIAlertController(title: "Alert", message: "URL should not be empty", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        case 3:
            self.captureScreen()
        case 5:
            if !(CommonUttils().getHomeList() is NSNull ) {
                arrAddedHomeList =  CommonUttils().getHistoryList() as! [String]
            }
          strPageTitle = "History"
          performSegue(withIdentifier: "segueHomeToBlockList", sender: nil)
            
        case 6:
            
            performSegue(withIdentifier: "segueHomeToSettings", sender: nil)
           

        default:
            break
        }
       
//        performSegue(withIdentifier: "segueHomeToSettings", sender: nil)
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
        self.setupHistory()
        
        
    }
    func setupHistory()  {
        if !((txt_URLTextField.text?.isEmpty)!){
            CommonUttils().setHistoryList(strURL: (self.txt_URLTextField.text)!)
//            arrAddedHomeList = CommonUttils().getHistoryList() as! [String]
        }
    }
    func startFilter(completionHandler: @escaping (Error?) -> Void){
        print("Test")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        txt_URLTextField.text = webView.url?.absoluteString
        self.setupHistory()
         prg_LoadingProgressView.setProgress(0.0, animated: false)
    }
    @IBAction func btn_RefreshClick(_ sender: Any) {
        self.loadURLToWebView()
    }
    
    @IBAction func btn_BackClick(_ sender: Any) {
        webview_Browser.goBack()
    }
    
    @IBAction func btn_ForwardClick(_ sender: Any) {
        webview_Browser.goForward()
    }
    @IBAction func btn_ReloadClick(_ sender: Any) {
        let urlRequest:URLRequest = URLRequest(url: webview_Browser.url!)
        webview_Browser.load(urlRequest)
       
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "loading") {
            btn_Back.isEnabled = webview_Browser.canGoBack
            btn_Forward.isEnabled = webview_Browser.canGoForward
        }
        if (keyPath == "estimatedProgress") {
            prg_LoadingProgressView.isHidden = webview_Browser.estimatedProgress == 1
            prg_LoadingProgressView.setProgress(Float(webview_Browser.estimatedProgress), animated: true)
            
        }
    }
    

   
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //screen capture
    
    func captureScreen() {
        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, self.view.isOpaque, UIScreen.main.scale)
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        let alert = UIAlertController(title: "", message: "Captured image stored in Gallery", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueHomeToBlockList"{
        let segueVC = segue.destination as! BlockListViewController
            print("arrAddedHomeList: \(arrAddedHomeList)")
            
        //segueVC.arrAddedHomeList = arrAddedHomeList
        //segueVC.strBlockPageTitle = strPageTitle
        }
    }
}

