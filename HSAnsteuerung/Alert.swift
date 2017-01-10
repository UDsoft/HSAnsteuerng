
//
//  Alert.swift
//  UniversalAnsteuerung
//
//  Created by UDLab on 24/12/2016.
//  Copyright © 2016 UDSoft. All rights reserved.
//

import UIKit

class Alert: NSObject {

    static func show(title:String,message:String,vc:UIViewController){
        //Create the Controller
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        //Create Aleart action
        let okAc = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){(alert:UIAlertAction) -> Void in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        //Add Alert Actions to Alert Controller
        alertController.addAction(okAc)
        
        //Display Alert Controller
        vc.present(alertController, animated: true, completion: nil)
    }

    
}
