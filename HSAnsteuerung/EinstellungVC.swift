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
    
    public let GPIODICTIONARYKEY = "GPIODICTIONARY"
   
    var appMemory = UserDefaults.standard
    
    var gpioDictionary = [String:String]()
    var buttonArray = [UIButton]()
    
    public var mqttClient:MQTTSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print("NOW IN EINSTELLUNG")
        if(appMemory.dictionary(forKey: GPIODICTIONARYKEY) == nil){
            print("Dictionary Empty")
        }else{
            gpioDictionary = appMemory.dictionary(forKey: GPIODICTIONARYKEY) as! [String : String]
            for (gpioPin , gpioName) in gpioDictionary {
                print(gpioPin +  " : " + gpioName)
                let gpioInt = Int(gpioPin)
                
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
        
        
        let gpioManipulator = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        gpioManipulator.addTextField { (textField:UITextField) in
            textField.placeholder = "Name Einstellen"
            self.InputTextField = textField
            
        }
        
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { (okAction) in
            gpioName = (self.InputTextField?.text)!
            print(gpioName)
            let defaultTitle = "N/A"
            if(!gpioName.isEmpty){
                sender.setTitle(gpioName, for: .normal)
                sender.backgroundColor = UIColor.blue
                sender.alpha = 0.8
                sender.setTitleColor(UIColor.white, for: .normal)
                self.gpioDictionary[String(gpioNum)] = gpioName
                self.appMemory.setValue(self.gpioDictionary, forKey: self.GPIODICTIONARYKEY)
            }else{
                sender.setTitle(defaultTitle, for: .normal)
                sender.backgroundColor = UIColor.green
                sender.alpha = 0.5
                sender.setTitleColor(UIColor.black, for: .normal)
                self.gpioDictionary.removeValue(forKey: String(gpioNum))
                self.appMemory.setValue(self.gpioDictionary, forKey: self.GPIODICTIONARYKEY)
            }
           
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        gpioManipulator.addAction(cancelAction)
        
        gpioManipulator.addAction(okAction)
        
        self.present(gpioManipulator, animated: true)
        
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
    
 

}
