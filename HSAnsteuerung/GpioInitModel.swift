//
//  GpioInit.swift
//  HSAnsteuerung
//
//  Created by UDLab on 26/01/2017.
//  Copyright © 2017 UDSoft. All rights reserved.
//

import Foundation

class GpioInitModel {

    
    private var gpioPinNumber:String
    private var name:String
    private var unit:String
    private var description:String
    
    private let pinNumberLabel:String = "pinNumber"
    private let nameLabel = "name"
    private let unitLabel = "unit"
    private let descriptionLabel = "description"
    
    
    init(pinNumber:String, name:String, unit:String, description:String){
        self.gpioPinNumber = pinNumber
        self.name = name
        self.unit = unit
        self.description = description
        
    }
    
    func setGpioPinNumber(gpioNumber:String) {
        self.gpioPinNumber = gpioNumber
    }
    
    func setName(name:String) {
        self.name = name
    }
    
    func setUnit(unit:String) {
        self.unit = unit
    }
    
    func setDescription(description:String) {
        self.description = description
    }
    
    func getGpioPinNumber() -> String {
        return self.gpioPinNumber
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getUnit() -> String {
        return self.unit
    }
    func getDescription() -> String {
        return self.description
    }
    
    public func modelToArray() -> [String:Any] {
        let dataArray = [pinNumberLabel:gpioPinNumber,nameLabel:name,unitLabel:unit,descriptionLabel:description] as [String : Any]
        print(dataArray)
        return dataArray
    }
    
}
