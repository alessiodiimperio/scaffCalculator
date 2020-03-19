//
//  ViewController.swift
//  scaffCalc
//
//  Created by Alessio on 2020-02-22.
//  Copyright © 2020 Alessio. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var scaffContainer: UIView!
    @IBOutlet weak var scaffView: UIStackView!
    
    let scaff = ScaffModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Layout and design
        itemsTableView.layer.cornerRadius = 10.0
        scaffContainer.layer.cornerRadius = 10.0
        
        //Logic
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        
        //func calls
        drawScaff()
    }
    override func viewWillAppear(_ animated: Bool) {
        scaff.reloadAll()
        itemsTableView.reloadData()
    }

    func drawScaff(){
        
        for section in 1...scaff.sectionsToDraw {
            
            let stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .fill
            stack.distribution = .fillProportionally
            
            for level in (1...scaff.levels).reversed() {
                
                let image = createImage(level: level, section: section, hasStairs: scaff.hasStairs, hasLadders: scaff.hasLadders, hasDivide: scaff.hasDivide)
                stack.addArrangedSubview(image)
         
            }
            scaffView.addArrangedSubview(stack)
        }
    }
    
    func createImage(level:Int, section:Int, hasStairs:Bool, hasLadders:Bool, hasDivide:Bool) -> UIImageView {
        
        var imageString = "scaff"
        if level == 1 {
            imageString += "_base"
        } else if level == scaff.levels {
            imageString += "_top"
        } else {
            imageString += "_middle"
        }
        
        if hasStairs && section == 1 {
                imageString += "_hasStairs"
        }
        if hasLadders && section == scaff.sectionsToDraw {
            imageString += "_hasLadders"
        }
        if (section == 1 || section == scaff.sectionsToDraw) && level != scaff.levels {
            imageString += "_hasDiagonals"
        }
        if section == 4 && hasDivide {
            imageString += "_hasDivide"
        }
        
        if level == 1 {
            let image = UIImageView(image: UIImage(named: imageString))
            image.contentMode = .scaleAspectFit

            return image
        } else if level == scaff.levels {
            let image = UIImageView(image: UIImage(named: imageString))
            image.contentMode = .scaleAspectFit

            return image
            
        } else {
            let image = UIImageView(image: UIImage(named: imageString))
            image.contentMode = .scaleAspectFit

            return image
        }
    }
}
extension ResultsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scaff.scaffParts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell") as! ItemCellTableViewCell
        
        cell.itemLabel.text = scaff.scaffParts[indexPath.row].title
        cell.itemQtyLabel.text = String(scaff.scaffParts[indexPath.row].qty) + " st"
        cell.itemIcon.image = UIImage(named: scaff.scaffParts[indexPath.row].image)
        
        return cell
        
    }
}
