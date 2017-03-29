//
//  DataSend.swift
//  HSAnsteuerung
//
//  Created by UDLab on 25/01/2017.
//  Copyright © 2017 UDSoft. All rights reserved.
//

import Foundation

//This DataSend class is created to join all the important data and send it to the requested method as a json object or Array.
/*
 eg.
 
 pinNumber = 1 
 pinName = speed
 pinValue = 10
 
 convert to jsom
 ++++++++++++++++++++++
 {
    "pinNummer":"1",
    "pinName"="speed",
    "pinValue"="10"
 }
 ++++++++++++++++++++++
 
 convert to array
 +++++++++++++++++++++
 [pinNummer:1,pinName:speed,pinValue:10]
 */
 

class DataSend{
  
    var group:String
    var value:String
    
    //Fixed String as the main Naming
    let groupLabel:String = "group"
    let valueLabel:String = "werte"
    
    init(group:String,value:String) {
        self.group = group
        self.value = value
    
    }
    
    public func getGroup() -> String {
        return group
    }
    
    public func getValue() -> String{
        return value
    }
    
    
    public func setGroup(group:String){
        self.group = group
    }
    
    public func setValue(value:String){
        self.value = value
    }
    
    
    
    public func getDataArray() -> [String:Any]{
        let dataArray = [groupLabel:group,valueLabel:value] as [String : Any]
        print(dataArray)
        return dataArray
    }
    
    public func getDataJson() -> Data{
        let JsonObject = getDataArray()
        let data = try!JSONSerialization.data(withJSONObject: JsonObject, options: .prettyPrinted)
        print(data)
        return data
    }
    
    
    
    
}
