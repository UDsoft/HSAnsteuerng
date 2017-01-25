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
    let pinLabelNummer = "pinNumber"
    let pinLabelName = "pinName"
    let pinValueLabel = "value"
    var pinNumber:Int
    var pinName:String
    var pinValue:Int
    
    init(pinNummer:Int,pinName:String,pinValue:Int) {
        self.pinNumber = pinNummer
        self.pinName = pinName
        self.pinValue = pinValue
    }
    
    public func getPinNumber() -> Int {
        return pinNumber
    }
    
    public func getPinName() -> String{
        return pinName
    }
    
    public func getPinValue() -> Int{
        return pinValue
    }
    
    public func setPinNumber(pinNumber:Int){
        self.pinNumber = pinNumber
    }
    
    public func setPinName(pinName:String){
        self.pinName = pinName
    }
    
    public func setPinValue(pinValue:Int){
        self.pinValue = pinValue
        
    }
    
    public func getDataArray() -> [String:Any]{
        let dataArray = [pinLabelName:pinName,pinLabelNummer:pinNumber,pinValueLabel:pinValue] as [String : Any]
        print(dataArray)
        return dataArray
    }
    
    public func getDataJson() -> Data{
        
        let JsonObject = getDataArray()
        let data = try!JSONSerialization.data(withJSONObject: JsonObject, options: .prettyPrinted)
        return data
    }
    
    
    
    
}
