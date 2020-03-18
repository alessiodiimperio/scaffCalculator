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
        //        scaffCollection.delegate = self
        //        scaffCollection.dataSource = self
        //        scaffCollection.layer.cornerRadius = 10.0
        scaffContainer.layer.cornerRadius = 10.0
        
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        itemsTableView.layer.cornerRadius = 10.0
        
        drawScaff()
    }
    override func viewWillAppear(_ animated: Bool) {
        scaff.reloadAll()
        adjustScaffView()
        itemsTableView.reloadData()
    }
    func adjustScaffView(){
        if scaff.sectionsToDraw > scaff.levels {
    
        }
    }
    func drawScaff(){
        
        for section in 1...scaff.sectionsToDraw {
            
            let stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .fill
            stack.distribution = .fillProportionally
            
            for level in (1...scaff.levels).reversed() {
                
                let image = createImage(level: level, section: section, hasStairs: scaff.hasStairs, hasLadders: scaff.hasLadders)
                stack.addArrangedSubview(image)
         
            }
            scaffView.addArrangedSubview(stack)
        }
    }
    
    func createImage(level:Int, section:Int, hasStairs:Bool, hasLadders:Bool) -> UIImageView {
        
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
        
        if level == 1 {
            let image = UIImageView(image: UIImage(named: imageString))
            image.contentMode = .scaleAspectFit
            //                        image.sizeToFit()
            //                        image.layoutIfNeeded()
            return image
        } else if level == scaff.levels {
            let image = UIImageView(image: UIImage(named: imageString))
            image.contentMode = .scaleAspectFit
            //                       image.sizeToFit()
            //                        image.layoutIfNeeded()
            return image
            
        } else {
            let image = UIImageView(image: UIImage(named: imageString))
            image.contentMode = .scaleAspectFit
            //                        image.sizeToFit()
            //                        image.layoutIfNeeded()
            return image
        }
    
    }
    
    
    
}

extension ResultsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scaff.levels
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return scaff.sectionsToDraw
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ScaffCollectionViewCell
        
        //        let imageView = UIImageView()
        
        if indexPath.section == 0 {
            
            if indexPath.row == scaff.levels - 1 {
                cell.imageView.image = UIImage(named: "scaff_base_diagonal")
            } else if indexPath.row == 0 {
                cell.imageView.image = UIImage(named: "scaff_top")
            } else {
                cell.imageView.image = UIImage(named: "scaff_middle_diagonal")
            }
        }
        
        if indexPath.section == scaff.sectionsToDraw - 1 {
            if indexPath.row == scaff.levels - 1 {
                cell.imageView.image = UIImage(named: "scaff_base_diagonal")
            } else if indexPath.row == 0 {
                cell.imageView.image = UIImage(named: "scaff_top")
            } else {
                cell.imageView.image = UIImage(named: "scaff_middle_diagonal")
            }
        }
        if indexPath.section != 0 && indexPath.section != scaff.sectionsToDraw - 1 {
            if indexPath.row == scaff.levels - 1 {
                cell.imageView.image = UIImage(named: "scaff_base")
            } else if indexPath.row == 0 {
                cell.imageView.image = UIImage(named: "scaff_top")
            } else {
                cell.imageView.image = UIImage(named: "scaff_middle")
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return insets
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
