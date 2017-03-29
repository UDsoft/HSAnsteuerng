//
//  GpioModel.swift
//  HSAnsteuerung
//
//  Created by UDLab on 26/01/2017.
//  Copyright © 2017 UDSoft. All rights reserved.
//

import Foundation


//This is a gpio model to standardise how the gpio in this app should be created for the server usage
class GpioModel
{
    //gpioName is the name of the action or any identity name of the pin action
    var gpioName:String
    //gpioNumber is the gpoiPin number of as stated in RaspiGpio.
    var gpioNumber:String
    
    
    init(gpioName:String,gpioNumber:String) {
        self.gpioName = gpioName
        self.gpioNumber = gpioNumber
    }
    
    func getGpioName() -> String {
        return gpioName
    }
    
    //This method is called to change the gpioName of the initialized GpioModel.
    func setGpioName(name:String){
        self.gpioName = name
    }

    //This method is called to the gpioNumber of the initialized GpioModel.
    func setGpioNumber(gpioPinNumber:String){
        self.gpioNumber = gpioPinNumber
    }
    
    func getGpioNumber() -> String {
        return gpioNumber
    }
    
}
