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
 
 group="X"
 value = 24
 
 convert to jsom
 ++++++++++++++++++++++
 {
    group:"X",
    value:"24"
 }
 ++++++++++++++++++++++
 
 convert to array
 +++++++++++++++++++++
 [group:X,value:24]
 */
 

class DataSend{
  
    var group:String
    var value:String
    var isOffsetZero:Bool
    
    //Fixed String as the main Naming
    let groupLabel:String = "group"
    let valueLabel:String = "werte"
    let isOffsetZeroLabel:String = "isOffsetZero"
    
    init(group:String,value:String,isOffsetZero:Bool) {
        self.group = group
        self.value = value
        self.isOffsetZero = isOffsetZero
        
    
    }
    
    public func getGroup() -> String {
        return group
    }
    
    public func getValue() -> String{
        return value
    }
    
    public func getIsOffsetZero() -> Bool{
        return isOffsetZero
    }
    
    
    public func setGroup(group:String){
        self.group = group
    }
    
    public func setValue(value:String){
        self.value = value
    }
    
    public func setIsOffsetZero(isOffsetZero:Bool){
        self.isOffsetZero = isOffsetZero
    }
    
    
    
    public func getDataArray() -> [String:Any]{
        let dataArray = [groupLabel:group,valueLabel:value,isOffsetZeroLabel:isOffsetZero] as [String : Any]
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
