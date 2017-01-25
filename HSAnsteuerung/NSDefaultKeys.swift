//
//  NSDefaultKeys.swift
//  UniversalAnsteuerung
//
//  Created by UDLab on 13/12/2016.
//  Copyright © 2016 UDSoft. All rights reserved.
//

import Foundation

enum Keys:String{
    case Mqtt_Ip_Address = "MqttAdd"
    case Mqtt_Port = "MqttPort"
    case Mqtt_Anonymous = "MqttAnonymous"
    case Mqtt_UserName = "MqttUsername"
    case Mqtt_Password = "MqttPassword"
    case default_mqtt_Ip_Address = "defaultIpAddress"
    case default_Mqtt_Port = "defaultMqttPort"
    case Mqtt_User_Set_Personal_IP_Port = "userSetPersonalIpPort"
    case X_ACTION_NAME = "X_NAME"
    case Y_ACTION_NAME = "Y_NAME"
    case Z_ACTION_NAME = "Z_NAME"
}
