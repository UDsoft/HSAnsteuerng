//
//  EinstellungVC.swift
//  UniversalAnsteuerung
//
//  Created by UDLab on 13/12/2016.
//  Copyright © 2016 UDSoft. All rights reserved.
//

import UIKit

class EinstellungVC: UIViewController {
    
    public let GPIODICTIONARYKEY = "GPIODICTIONARY"
   
    var appMemory = UserDefaults.standard
    
    var gpioDictionary = [String:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print("NOW IN EINSTELLUNG")
        if(appMemory.dictionary(forKey: GPIODICTIONARYKEY) == nil){
            print("Dictionary Empty")
        }else{
            gpioDictionary = appMemory.dictionary(forKey: GPIODICTIONARYKEY) as! [String : String]
            for (gpioPin , gpioName) in gpioDictionary {
                print(gpioPin +  " : " + gpioName)
            }
        }
        
        
        
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
            if(!gpioName.isEmpty || (sender.titleLabel?.text?.contains(defaultTitle))!){
                sender.setTitle(gpioName, for: .normal)
                sender.backgroundColor = UIColor.blue
                sender.alpha = 0.8
                sender.setTitleColor(UIColor.white, for: .normal)
                self.gpioDictionary[String(gpioNum)] = gpioName
            }else{
                sender.setTitle(defaultTitle, for: .normal)
                sender.backgroundColor = UIColor.green
                sender.alpha = 0.5
                sender.setTitleColor(UIColor.black, for: .normal)
            }
           
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        gpioManipulator.addAction(cancelAction)
        
        gpioManipulator.addAction(okAction)
        
        self.present(gpioManipulator, animated: true)
        
    }
    
 

}
