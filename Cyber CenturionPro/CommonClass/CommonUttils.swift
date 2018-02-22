//
//  CommonUttils.swift
//  Cyber CenturionPro
//
//  Created by Lokesh on 20/02/18.
//  Copyright © 2018 Lokesh. All rights reserved.
//

import UIKit

class CommonUttils: NSObject {
    func  getUserData(key: String) -> AnyObject {
        return UserDefaults.standard.object(forKey: key) as AnyObject
    }
    func setUserData(key: String, value: AnyObject)  {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey:key)
        defaults.synchronize()
    }
    
    func getHomeList() -> AnyObject {
        let arrTemp: AnyObject = (self.getUserData(key: "homelist") as? AnyObject)!
     
        return arrTemp
        
        
    }
    
    func setHomeList(strURL : String)  {
        let anyTemp: AnyObject = self.getHomeList()
        var arrTemp: [String] = []
        arrTemp = anyTemp as! [String]
            if !(arrTemp.contains(strURL)){
             arrTemp.append(strURL)
            }
      
        self.setUserData(key: "homelist", value: arrTemp as AnyObject)
    }
}
