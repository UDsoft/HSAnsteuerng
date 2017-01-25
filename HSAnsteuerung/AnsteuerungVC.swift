//
//  AnsteuerungVC.swift
//  UniversalAnsteuerung
//
//  Created by UDLab on 13/12/2016.
//  Copyright © 2016 UDSoft. All rights reserved.
//

import UIKit
import SwiftMQTT


class AnsteuerungVC: UIViewController , UIPickerViewDataSource,UIPickerViewDelegate,MQTTSessionDelegate{
    
    @IBOutlet weak var connectBtn: UIButton!
    @IBOutlet weak var xAchsePicker: UIPickerView!
    @IBOutlet weak var yAchsePicker: UIPickerView!
    @IBOutlet weak var zAchsePicker: UIPickerView!
    @IBOutlet weak var a1SwitchOutlet: UISwitch!
    @IBOutlet weak var a2SwitchOutlet: UISwitch!
    @IBOutlet weak var a3SwitchOutlet: UISwitch!
    @IBOutlet weak var aSwitch: UIButton!
    var isConnected:Bool=false
    var mqttClient:MQTTSession?
    var pickerData = ["0"]
    var a1Enable:Bool = true
    var a2Enable:Bool = true
    var a3Enable:Bool = true
    
    
    //Todo:
    var defaultIPAddress:String = "192.168.0.101"
    var defaultPort:Int = 1883
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataBasePopulator(firstValue: 1, lastValue: 100)
        xAchsePicker.dataSource = self
        xAchsePicker.delegate = self
        yAchsePicker.dataSource = self
        yAchsePicker.delegate = self
        zAchsePicker.dataSource = self
        zAchsePicker.delegate = self
        mqttClient?.delegate = self
        
        mqttConnect(host: defaultIPAddress, port: UInt16(defaultPort), clientID: "UDIPAD",username: "darwin" , password: "21", cleanSession: true, keepAlive: 15)
        
        
    }
    
    private func mqttConnect(host:String, port:UInt16,clientID:String,username:String , password:String,cleanSession:Bool,keepAlive:UInt16,useSSL:Bool=false){
        mqttClient = MQTTSession.init(host:host, port: port, clientID: clientID, cleanSession: cleanSession, keepAlive: keepAlive, useSSL: useSSL);
        mqttClient!.connect{(succeeded, error) -> Void in
            if (succeeded){
                self.showConnectionStatus(isConnected: true)
            }else{
                self.showConnectionStatus(isConnected: false)
            }
        }
    }
    
    private func showConnectionStatus(isConnected:Bool){
        if(isConnected){
            
            connectBtn.setImage(#imageLiteral(resourceName: "ServerConnect"), for: .normal)
        }else{
            connectBtn.setImage(#imageLiteral(resourceName: "ServerDisconnect"), for: .normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let pinLabelName = "pinName"
        let pinLabelValue = "value"
        let pinLabelNumber = "pinNumber"
        
        let pinValue = String(describing : pickerData[row])
        let pinName = String(describing : pickerView.tag)
        
        let pinNumber = "1"
    
        
        let jsonDict = [pinLabelName:pinName,pinLabelValue:pinValue,pinLabelNumber:pinNumber]
        
        let data = try!JSONSerialization.data(withJSONObject: jsonDict, options: .prettyPrinted)

        mqttClient?.publish(data, in: "pinName/Value", delivering: .atLeastOnce, retain: true){ (succeeded, error) in
            if(succeeded){
                print(data)
            }else{
                print(error)
            }
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = pickerData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSForegroundColorAttributeName:UIColor.white])
        return myTitle
    }
    
    func dataBasePopulator(firstValue:Int,lastValue:Int){
        for x in firstValue...lastValue{
            pickerData.append(String(x))
        }

    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "AnsteuerungNachEinstellung"){
            let einstellungVC:EinstellungVC = segue.destination as! EinstellungVC
            
            if(einstellungVC.mqttClient == nil){
                einstellungVC.mqttClient = self.mqttClient
            }
        }
    }
    
    @IBAction func connectDisconnect(_ sender: UIButton) {
    
        if(isConnected){
            mqttConnect(host: defaultIPAddress, port: UInt16(defaultPort), clientID: "UDIPAD", username: "darwin", password: "1234", cleanSession: true, keepAlive: 15)
            isConnected = false;
        }else{
            mqttClient?.disconnect()
            connectBtn.setImage(#imageLiteral(resourceName: "ServerDisconnect"), for: .normal)
            isConnected = true
        }
        
    }
    
    @IBAction func switchPicker(_ sender: UIButton) {
        let tag = sender.tag
        let alpha:CGFloat = 0.7
        switch tag {
        case 4:
            if(a1Enable){
                sender.setImage(#imageLiteral(resourceName: "OffSwitch"), for: .normal)
                xAchsePicker.isUserInteractionEnabled = false
                xAchsePicker.alpha = alpha
                a1Enable = false
            }else{
                sender.setImage(#imageLiteral(resourceName: "OnSwitch"), for: .normal)
                xAchsePicker.isUserInteractionEnabled = true;
                xAchsePicker.alpha = 1
                a1Enable = true
            }
        case 5:
            if(a2Enable){
                sender.setImage(#imageLiteral(resourceName: "OffSwitch"), for: .normal)
                yAchsePicker.isUserInteractionEnabled = false
                yAchsePicker.alpha = alpha
                a2Enable = false
            }else{
                sender.setImage(#imageLiteral(resourceName: "OnSwitch"), for: .normal)
                yAchsePicker.isUserInteractionEnabled = true
                yAchsePicker.alpha = 1
                a2Enable = true
            }
            
        case 6:
            if(a3Enable){
                sender.setImage(#imageLiteral(resourceName: "OffSwitch"), for: .normal)
                zAchsePicker.isUserInteractionEnabled = false
                zAchsePicker.alpha = alpha
                a3Enable = false
            }else{
                sender.setImage(#imageLiteral(resourceName: "OnSwitch"), for: .normal)
                zAchsePicker.isUserInteractionEnabled = true
                zAchsePicker.alpha = 1
                a3Enable = true
            }
        default:
            break
        }
        
    }
    
    func mqttDidDisconnect(session: MQTTSession) {
        print("Disconnected")
    }
    
    func mqttSocketErrorOccurred(session: MQTTSession) {
        
    }
    
    func mqttDidReceive(message data: Data, in topic: String, from session: MQTTSession) {
        
    }

}
