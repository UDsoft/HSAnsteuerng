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
    case Gpio_Pin_Dictionary = "GPIODICTIONARY"
}

enum Topics:String{
    case INITIALIZATION_TOPIC = "/main/init"
    case CHECK_PIN_VALUE = "/pin/value"
    case BROKER_STATUS_INIT = "/status/broker/init"
    case BROKER_STATUS = "/status/broker"
    case CLIENT_STATUS_INIT = "status/client/init"
    case CLIENT_STATUS = "status/client"
    case BROKER_ERROR_INIT = "/error/broker/init"
    case BROKER_ERROR = "/error/broker"
    case CLIENT_ERROR_INIT = "/error/client/init"
    case CLIENT_ERROR = "/error/client"

}
