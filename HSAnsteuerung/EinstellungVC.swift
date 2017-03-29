//
//  EinstellungVC.swift
//  UniversalAnsteuerung
//
//  Created by UDLab on 13/12/2016.
//  Copyright © 2016 UDSoft. All rights reserved.
//

import UIKit
import SwiftMQTT

class EinstellungVC: UIViewController,MQTTSessionDelegate {
    
   
    var appMemory = UserDefaults.standard
    
    var gpioDictionary = [String:String]()
    var buttonArray = [UIButton]()
    
    public var mqttClient:MQTTSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print("NOW IN EINSTELLUNG")
        if(appMemory.dictionary(forKey: Keys.Gpio_Pin_Dictionary.rawValue) == nil){
            print("Dictionary Empty")
        }else{
            gpioDictionary = appMemory.dictionary(forKey: Keys.Gpio_Pin_Dictionary.rawValue) as! [String : String]
            for (gpioPin , gpioName) in gpioDictionary {
                print(gpioPin +  " : " + gpioName)
                //Change this please
                let gpioModel = GpioInitModel.init(pinNumber: gpioPin, name: gpioName,unit: "",description: "")
                let gpioInt = Int(gpioModel.getGpioPinNumber())
                
                //Search the button from the button View Tag
                let gpioSetButton:UIButton = self.view.viewWithTag(gpioInt!)! as! UIButton
                settingName(sender: gpioSetButton, gpioName: gpioName)
                
            }
        }
        mqttClient?.delegate = self
        
    }
    
    
    func mqttDidDisconnect(session: MQTTSession) {
        
    }
    
    func mqttSocketErrorOccurred(session: MQTTSession) {
        
    }
    
    func mqttDidReceive(message data: Data, in topic: String, from session: MQTTSession) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        updateGpioPinSettingPersistance()
        print("Item Saved")
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var InputTextField:UITextField?
    @IBAction func gpioManager(_ sender: UIButton) {
        let gpioNum:Int = sender.tag
        let title:String = " Gpio Einsteller"
        let message:String = "Stellen Sie das Nama des GPIO " + String(gpioNum)
        var gpioName:String = ""
        let defaultTitle = "N/A"
        
        
        let gpioManipulator = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        gpioManipulator.addTextField { (textField:UITextField) in
            textField.placeholder = "Name Einstellen"
            self.InputTextField = textField
            
        }
        
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { (okAction) in
            gpioName = (self.InputTextField?.text)!
            print(gpioName)
            if(!gpioName.isEmpty){
                sender.setTitle(gpioName, for: .normal)
                sender.backgroundColor = UIColor.blue
                sender.alpha = 0.8
                sender.setTitleColor(UIColor.white, for: .normal)
                self.gpioDictionary[String(gpioNum)] = gpioName
                //self.appMemory.setValue(self.gpioDictionary, forKey: Keys.Gpio_Pin_Dictionary.rawValue)
            }else{
                sender.setTitle(defaultTitle, for: .normal)
                sender.backgroundColor = UIColor.green
                sender.alpha = 0.5
                sender.setTitleColor(UIColor.black, for: .normal)
                self.gpioDictionary.removeValue(forKey: String(gpioNum))
                //self.appMemory.setValue(self.gpioDictionary, forKey: Keys.Gpio_Pin_Dictionary.rawValue)
            }
           
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        gpioManipulator.addAction(cancelAction)
        
        gpioManipulator.addAction(okAction)
        
        self.present(gpioManipulator, animated: true)
        
    }
    
    private func updateGpioPinSettingPersistance(){
        self.appMemory.set(self.gpioDictionary, forKey: Keys.Gpio_Pin_Dictionary.rawValue)
        print("all Item Saved")
    }
    
    func settingName(sender:UIButton,gpioName:String) {
        let defaultTitle = "N/A"
        if(!gpioName.contains(defaultTitle) || !gpioName.isEmpty){
            sender.setTitle(gpioName, for: .normal)
            sender.backgroundColor = UIColor.blue
            sender.alpha = 0.8
            sender.setTitleColor(UIColor.white, for: .normal)
        }else{
            sender.setTitle(defaultTitle, for: .normal)
            sender.backgroundColor = UIColor.green
            sender.alpha = 0.5
            sender.setTitleColor(UIColor.black, for: .normal)

        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "EinstellungNachAnsteuerung"){
            let ansteuerungVC:AnsteuerungVC = segue.destination as! AnsteuerungVC
            
            if(ansteuerungVC.mqttClient == nil){
                ansteuerungVC.mqttClient = self.mqttClient
            }
        }else if(segue.identifier == "EinstellungNachVerbindung"){
            let verbindungVC:VerbindungVC = segue.destination as! VerbindungVC
            
            if(verbindungVC.mqttClient == nil){
                verbindungVC.mqttClient = self.mqttClient
            }
        }
    }
 

}
