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
        alignScaffDesign()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        scaff.reloadAll()
        itemsTableView.reloadData()
    }

    func drawScaff(){
        let sections = CGFloat(scaff.sectionsToDraw)
        let levels = CGFloat(scaff.levels)
        let imageWidth = CGFloat(175)
        let imageHeight = CGFloat(145)
        
        for section in 1...scaff.sectionsToDraw {
            
            let stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .fill
            stack.distribution = .fillProportionally
            
            for level in (1...scaff.levels).reversed() {
                
                let image = createImage(level: level, section: section, hasStairs: scaff.hasStairs, hasLadders: scaff.hasLadders, hasDivide: scaff.hasDivide)
                stack.addArrangedSubview(image)
         
            }
            
            scaffContainer.addSubview(stack)
            
            //Tag stackview with section number
            stack.tag = section
            
            //Set fixed size constraints and Y position to center
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.centerYAnchor.constraint(equalTo: scaffContainer.centerYAnchor).isActive = true
            
            if levels > sections {
                print("fixed height")
                stack.heightAnchor.constraint(equalToConstant: scaffContainer.frame.height - 20).isActive = true
                stack.widthAnchor.constraint(equalTo: stack.heightAnchor, multiplier: imageWidth/(levels * imageHeight)).isActive = true
            } else {
                print("fixed width")
                stack.widthAnchor.constraint(equalToConstant: (scaffContainer.bounds.size.width / 7)).isActive = true
                stack.heightAnchor.constraint(equalTo: stack.widthAnchor, multiplier: (levels * imageHeight) / imageWidth).isActive = true
            }
            
        }
    }
    
    func alignScaffDesign() {
        let numberOfSections = CGFloat(scaff.sectionsToDraw)
        
        //Align X constraint depending on number of sections.
        
        switch numberOfSections {
        case 1:
            let stack = scaffContainer.viewWithTag(1)!
            
            stack.centerXAnchor.constraint(equalTo: scaffContainer.centerXAnchor).isActive = true
        
        case 2:
            let stack1 = scaffContainer.viewWithTag(1)!
            let stack2 = scaffContainer.viewWithTag(2)!
            
            stack1.trailingAnchor.constraint(equalTo: scaffContainer.centerXAnchor).isActive = true
            
            stack2.leadingAnchor.constraint(equalTo: stack1.trailingAnchor).isActive = true

        case 3:
            let stack1 = scaffContainer.viewWithTag(1)!
            let stack2 = scaffContainer.viewWithTag(2)!
            let stack3 = scaffContainer.viewWithTag(3)!
            
            
            stack1.trailingAnchor.constraint(equalTo: stack2.leadingAnchor).isActive = true
            
            stack2.centerXAnchor.constraint(equalTo: scaffContainer.centerXAnchor).isActive = true
            
            stack3.leadingAnchor.constraint(equalTo: stack2.trailingAnchor).isActive = true
           
        case 4:
            let stack1 = scaffContainer.viewWithTag(1)!
            let stack2 = scaffContainer.viewWithTag(2)!
            let stack3 = scaffContainer.viewWithTag(3)!
            let stack4 = scaffContainer.viewWithTag(4)!
            
            stack1.trailingAnchor.constraint(equalTo: stack2.leadingAnchor).isActive = true
            
            stack2.trailingAnchor.constraint(equalTo: scaffContainer.centerXAnchor).isActive = true
            
            stack3.leadingAnchor.constraint(equalTo: stack2.trailingAnchor).isActive = true
            
            stack4.leadingAnchor.constraint(equalTo: stack3.trailingAnchor).isActive = true
           
            
        case 5:
            let stack1 = scaffContainer.viewWithTag(1)!
            let stack2 = scaffContainer.viewWithTag(2)!
            let stack3 = scaffContainer.viewWithTag(3)!
            let stack4 = scaffContainer.viewWithTag(4)!
            let stack5 = scaffContainer.viewWithTag(5)!
            
            stack1.trailingAnchor.constraint(equalTo: stack2.leadingAnchor).isActive = true
            
            stack2.trailingAnchor.constraint(equalTo: stack3.leadingAnchor).isActive = true
                       
            stack3.centerXAnchor.constraint(equalTo: scaffContainer.centerXAnchor).isActive = true
            
            stack4.leadingAnchor.constraint(equalTo: stack3.trailingAnchor).isActive = true
            
            stack5.leadingAnchor.constraint(equalTo: stack4.trailingAnchor).isActive = true
        
        case 6:
            let stack1 = scaffContainer.viewWithTag(1)!
            let stack2 = scaffContainer.viewWithTag(2)!
            let stack3 = scaffContainer.viewWithTag(3)!
            let stack4 = scaffContainer.viewWithTag(4)!
            let stack5 = scaffContainer.viewWithTag(5)!
            let stack6 = scaffContainer.viewWithTag(6)!
            
            stack1.trailingAnchor.constraint(equalTo: stack2.leadingAnchor).isActive = true
                       
            stack2.trailingAnchor.constraint(equalTo: stack3.leadingAnchor).isActive = true
                                  
            stack3.trailingAnchor.constraint(equalTo: scaffContainer.centerXAnchor).isActive = true
                       
            stack4.leadingAnchor.constraint(equalTo: stack3.trailingAnchor).isActive = true
                       
            stack5.leadingAnchor.constraint(equalTo: stack4.trailingAnchor).isActive = true
            
            stack6.leadingAnchor.constraint(equalTo: stack5.trailingAnchor).isActive = true
            
        default:
            print("No case")
        }
    }
    
    func createImage(level:Int, section:Int, hasStairs:Bool, hasLadders:Bool, hasDivide:Bool) -> UIImageView {
        let topLevel = scaff.levels
        
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
        if level == topLevel - 1 && !(hasLadders || hasStairs){
            imageString += "_hasPlatform"
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
