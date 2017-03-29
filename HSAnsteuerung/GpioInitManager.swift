//
//  GpioInitManager.swift
//  HSAnsteuerung
//
//  Created by UDLab on 07/02/2017.
//  Copyright © 2017 UDSoft. All rights reserved.
//

import Foundation

class GpioInitManager
{
    var gpioInitCollection:[GpioInitModel] = []
    
    func appendToCollection(gpioInit:GpioInitModel){
        gpioInitCollection.append(gpioInit)
    }
    
    func modelToJson() -> Data{
    
        var jsonData:Data
        var totalInitPinInACollection:[String:Any]?
        
        
        for pinInit in gpioInitCollection {
            let pinNumber = pinInit.getGpioPinNumber()
            totalInitPinInACollection?[pinNumber] = pinInit.modelToArray()
        }
        
        jsonData = getDataJson(pinInit: totalInitPinInACollection!)
        print(jsonData)
        return jsonData
    
    }
    
    
    private func getDataJson(pinInit:[String:Any]) -> Data{
        let JsonObject = pinInit
        let data = try!JSONSerialization.data(withJSONObject: JsonObject, options: .prettyPrinted)
        return data
    }
}
