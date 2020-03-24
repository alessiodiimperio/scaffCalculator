//
//  calcViewController.swift
//  scaffCalc
//
//  Created by Alessio on 2020-03-12.
//  Copyright © 2020 Alessio. All rights reserved.
//

import UIKit

class calcViewController: UIViewController {

    @IBOutlet weak var scaffDisplayOutlet: UIImageView!
    @IBOutlet weak var hasStairs: UISwitch!
    @IBOutlet weak var hasLadders: UISwitch!
    @IBOutlet weak var isFarFromWall: UISwitch!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let options =
        [
    [2,3,4,5,6,7,8,9,10],
    [3.07,6.14,9.21,12.28,15.35,18.42,21.49,24.56, 27.63, 30.70]
        ]
    var selectedHeight:Double = 2.0
    var selectedWidth:Double = 3.07
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        setupPickerViewHeaders()
    }
    @IBAction func calculateBttn(_ sender: Any) {
        performSegue(withIdentifier: "results", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "results" {
            let destintionVC = segue.destination as! ResultsViewController
            destintionVC.scaff.scaff.totalLength = selectedWidth
            destintionVC.scaff.scaff.topLevelPlatformHeight = Int(selectedHeight)
            destintionVC.scaff.scaff.hasStairs = hasStairs.isOn
            destintionVC.scaff.scaff.hasLadders = hasLadders.isOn
            destintionVC.scaff.scaff.isFarFromWall = isFarFromWall.isOn
            destintionVC.scaff.reloadAll()
        }
    }
}

extension calcViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(options[component][row]) + " m"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectedHeight = options[component][row]
        }
        if component == 1 {
            selectedWidth = options[component][row]
        }
    }
    func setupPickerViewHeaders(){
        let optionHeaders = ["Bomlagshöjd","Ställningsbredd"]
        
        let labelWidth = pickerView.frame.width / CGFloat(pickerView.numberOfComponents)

        for index in 0..<optionHeaders.count {
            let label: UILabel =
                UILabel(frame: CGRect(x: pickerView.frame.origin.x + labelWidth * CGFloat(index), y: 0, width: labelWidth, height: 40))
            label.text = optionHeaders[index]
            label.textAlignment = .center
            label.backgroundColor = .white
            pickerView.addSubview(label)
        }
    }
}
