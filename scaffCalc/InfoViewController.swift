//
//  InfoViewController.swift
//  scaffCalc
//
//  Created by Alessio on 2020-04-03.
//  Copyright © 2020 Alessio. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    var context:Int?
    
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.layer.cornerRadius = 15.0
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        
        if context != nil {
            switch context {
            case 1:
                imageView.image = UIImage(named: "has-stairs")
                textView.text = "För att säkert kunna komma upp till arbetsplatformarna kan en trapptorn byggas i anslutning till ställningen. Denna säkerställer att uppstigning till samtliga arbetsplatformar kan utföras på ett säkert sätt."
            case 2:
                imageView.image = UIImage(named: "has-ladders")
                textView.text = "Invändig uppstigning kan vara en bra alternativ för tillträde till arbetsplatformar där det inte behövs lyftas större verktyg eller material. Det kan också användas som en sekundär utrymningsväg om huvudtillträdet förekommer ifrån ett vindsutrymme."
            case 3:
                imageView.image = UIImage(named: "far-from-wall")
                textView.text = "Avståndet mellan ställningen och fasaden får inte överskrida 30cm. I det fall där ställningen står mer än 30cm ifrån fasaden, behövs skyddsräcke och sparklister även monteras på insidan för att skydda mot fall på ställningens insida."
            default:
                print("no case")
            }
        }
    }
    
    @IBAction func dismissViewController(_ sender: Any) {
        self.dismiss(animated: true, completion:  nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
