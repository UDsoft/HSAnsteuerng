//
//  AnsteuerungVC.swift
//  UniversalAnsteuerung
//
//  Created by UDLab on 13/12/2016.
//  Copyright © 2016 UDSoft. All rights reserved.
//

import UIKit

class AnsteuerungVC: UIViewController , UIPickerViewDataSource,UIPickerViewDelegate{
    
    @IBOutlet weak var xAchsePicker: UIPickerView!
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var yAchsePicker: UIPickerView!
    @IBOutlet weak var zAchsePicker: UIPickerView!
    @IBOutlet weak var a1SwitchOutlet: UISwitch!
    @IBOutlet weak var a2SwitchOutlet: UISwitch!
    @IBOutlet weak var a3SwitchOutlet: UISwitch!
    
    
    
    var pickerData = ["0"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataBasePopulator(firstValue: 1, lastValue: 100)
        xAchsePicker.dataSource = self
        xAchsePicker.delegate = self
        yAchsePicker.dataSource = self
        yAchsePicker.delegate = self
        zAchsePicker.dataSource = self
        zAchsePicker.delegate = self
        
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
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView.tag == 1){
            testLabel.text = "1 " + pickerData[row]
        }else if(pickerView.tag == 2){
            testLabel.text = "2 " + pickerData[row]
        }else if(pickerView.tag == 3){
            testLabel.text = "3 " + pickerData[row]
        }
    }

    
    @IBAction func a1SwitchAction(_ sender: UISwitch) {
        if(a1SwitchOutlet.isOn){
            xAchsePicker.isUserInteractionEnabled = true
        }else{
            xAchsePicker.isUserInteractionEnabled = false
        }
    }
    
    @IBAction func a2SwitchAction(_ sender: UISwitch) {
        if(a2SwitchOutlet.isOn){
            yAchsePicker.isUserInteractionEnabled = true
        }else{
            yAchsePicker.isUserInteractionEnabled = false
        }
    }

    @IBAction func a3SwitchAction(_ sender: UISwitch) {
        if(a3SwitchOutlet.isOn){
            zAchsePicker.isUserInteractionEnabled = true
        }else{
            zAchsePicker.isUserInteractionEnabled = false
        }
        
    }
    
    func dataBasePopulator(firstValue:Int,lastValue:Int){
        for x in firstValue...lastValue{
            pickerData.append(String(x))
        }

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
