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
    
    let appMemory = UserDefaults.standard
    
    @IBOutlet weak var connectBtn: UIButton!
    @IBOutlet weak var xAchsePicker: UIPickerView!
    @IBOutlet weak var yAchsePicker: UIPickerView!
    @IBOutlet weak var zAchsePicker: UIPickerView!
    @IBOutlet weak var versetzem_nullpunkt: UISwitch!

    @IBOutlet weak var aSwitch: UIButton!
    @IBOutlet weak var informationRequire: UIButton!
    @IBOutlet weak var zActionLabelButton: UIButton!
    @IBOutlet weak var yActionLabelButton: UIButton!
    @IBOutlet weak var xActionLabelButton: UIButton!
    var isConnected:Bool=false
    var mqttClient:MQTTSession?
    var pickerData = ["0"]
    
    //This boolean is variable for stating if the manipulater picker is on switched state and not in switched off state. if the state is switched Off the touch gesture will be false. So User cannot manipulate the picker accidentally.
    var a1Enable:Bool = true
    var a2Enable:Bool = true
    var a3Enable:Bool = true
    
    //Todo:Transfer this to SharedUser ** DONE Just left to be initialised
    var defaultIPAddress:String = "192.168.0.101"
    var defaultPort:Int = 1883
    var userName:String = ""
    var password:String = ""
    
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
        
        if(appMemory.bool(forKey: Keys.Mqtt_User_Set_Personal_IP_Port.rawValue)){
           defaultIPAddress = appMemory.string(forKey: Keys.Mqtt_Ip_Address.rawValue)!
           defaultPort = appMemory.integer(forKey: Keys.Mqtt_Port.rawValue)
        userName = appMemory.string(forKey: Keys.Mqtt_UserName.rawValue)!
            password = appMemory.string(forKey: Keys.Mqtt_Password.rawValue)!
            
        }else{
            defaultIPAddress = appMemory.string(forKey: Keys.Mqtt_Ip_Address.rawValue)!
            defaultPort = appMemory.integer(forKey: Keys.Mqtt_Port.rawValue)
        }
        
        mqttConnect(host: defaultIPAddress, port: UInt16(defaultPort), clientID: "UDIPAD",username: userName , password: password, cleanSession: true, keepAlive: 15)
        
    }
    //This method is called is the changes in the model GPIOInit is made
    func pinInitialization() {
        
    }

    //This method will call for an uialeart with a text fill to give the name for the following action. This name is currently on planned to be used in client side to ensure user to know what the action will do once they come back to the app after awhile. This Action name will be saved in sharedpreference and retrieved using the key "X_ACTION_NAME", "Y_ACTION_NAME","Z_ACTION_NAME"
    @IBAction func setActionName(_ sender: UIButton) {
        
    }
    
    //Method to show the information like which ipaddress broker is the client is currently connected to with the port number . this enable the user to know and change the ipaddress in verbindung view if the broker ip address the client connecting is not the same as the real broker ip address.
    @IBAction func informationBroadcast(_ sender: UIButton) {
        let informationBroadcast = UIAlertController.init(title: "Server Verbindung Details", message: "Ip Address : " + defaultIPAddress + ":" + String(defaultPort), preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "JA", style: .default, handler: nil)
        
        informationBroadcast.addAction(okAction)
        
        self.present(informationBroadcast,animated:true,completion: nil)
        
    }
    
    
    @IBAction func versetzemNullpunkt(_ sender: UISwitch) {
        
        let groupName:String = "offsetZero"
        var data:DataSend
        
        if(versetzem_nullpunkt.isOn){
            data = DataSend.init(group: groupName, value:"1", isOffsetZero: true)
        }else{
            data = DataSend.init(group: groupName, value:"0" , isOffsetZero: false)
        }
        
        mqttClient?.publish(data.getDataJson(), in: Topics.VERSETZEM_NULLPUNKT.rawValue, delivering: .atMostOnce, retain: true){ (succeeded, error) in
            if(succeeded){
                print(data)
            }else{
                print(error)
            }
        }
        
        
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
    
    // Define the Number of component involved in the Picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //Variable To know which Group does the Picker View Belong to
        var group:String = ""
        // The chosen Data by the user in Picker View
        let value = pickerData[row]
        
        //Each Picker view is given the Tag which belong to -
        //appriopriate group Name Tag-1 = X , Tag -2 = Y and Tag-3 = Z.
        //Find the Tag of the Picker View user touched and changed .
        //Set the group variable to String Value of appriopriate Group Name
        switch pickerView.tag{
        case 1:
            group = "X"
        case 2:
            group = "Y"
        case 3:
            group = "Z"
        default: break
        }
        
        // initialise DataSend Object with the parameter group name and the value chosen.
        let data:DataSend = DataSend(group: group, value: value,isOffsetZero: versetzem_nullpunkt.isOn)
        
        //Publish the value under the topic /pin/value
        mqttClient?.publish(data.getDataJson(), in: Topics.OUTPUT_PIN_VALUE.rawValue, delivering: .atLeastOnce, retain: true){ (succeeded, error) in
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
    
    
    //This method populate the database of the picker view 
    //The firstValue is the value of the start of the pickerView and the last is the maximum value of the picker view.
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
        if(segue.identifier == "AnsteuerungNachVerbindung"){
            let verbindungVC:VerbindungVC = segue.destination as! VerbindungVC
            
            if(verbindungVC.mqttClient == nil){
                verbindungVC.mqttClient = self.mqttClient
            }
        }
    }
    
    //This function will close the connection with the Broker if previously connected
    //If previous the Application is not connected to Broker it will try to connect.
    @IBAction func connectDisconnect(_ sender: UIButton) {
    
        //if Application is connected to Broker. Disconnect Action
        //if Application is not connected to Broker . Connect Action
        if(isConnected){
            //Disconnecting
            mqttClient?.disconnect()
            connectBtn.setImage(#imageLiteral(resourceName: "ServerDisconnect"), for: .normal)
            isConnected = false
          
        }else{
            //Connection
            mqttConnect(host: defaultIPAddress, port: UInt16(defaultPort), clientID: "UDIPAD", username: "", password: "",  cleanSession: true, keepAlive: 15)
            isConnected = true;
        }
        
    }
    
    @IBAction func switchPicker(_ sender: UIButton) {
        let tag = sender.tag
        switch tag {
        case 4:
            if(a1Enable){
                switchOffAnimation(sender:sender,achsePicker: xAchsePicker)
                a1Enable = false
            }else{
                switchOnAnimation(sender: sender, achsePicker: xAchsePicker)
                a1Enable = true
            }
        case 5:
            if(a2Enable){
               switchOffAnimation(sender: sender, achsePicker: yAchsePicker)
                a2Enable = false
            }else{
               switchOnAnimation(sender: sender, achsePicker: yAchsePicker)
                a2Enable = true
            }
            
        case 6:
            if(a3Enable){
                switchOffAnimation(sender: sender, achsePicker: zAchsePicker)
                a3Enable = false
            }else{
                switchOnAnimation(sender: sender, achsePicker: zAchsePicker)
                a3Enable = true
            }
        default:
            break
        }
        
    }
    
    private func switchOffAnimation(sender:UIButton,achsePicker:UIPickerView){
        let alpha:CGFloat = 0.7
        sender.setImage(#imageLiteral(resourceName: "OffSwitch"), for: .normal)
        achsePicker.isUserInteractionEnabled = false
        achsePicker.alpha = alpha
        
    }
    
    private func switchOnAnimation(sender:UIButton,achsePicker:UIPickerView){
        sender.setImage(#imageLiteral(resourceName: "OnSwitch"), for: .normal)
        achsePicker.isUserInteractionEnabled = true;
        achsePicker.alpha = 1
    }
    
    func mqttDidDisconnect(session: MQTTSession) {
        print("Disconnected")
        showConnectionStatus(isConnected: false)
    }
    
    func mqttSocketErrorOccurred(session: MQTTSession) {
        showConnectionStatus(isConnected: false)
    }
    
    func mqttDidReceive(message data: Data, in topic: String, from session: MQTTSession) {
        
    }

}
