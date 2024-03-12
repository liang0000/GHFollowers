//
//  ViewController.swift
//  HelloWorld
//
//  Created by Liang on 11/5/20.
//

import UIKit

class WarCardVC: UIViewController {
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftScoreLabel: UILabel!
    @IBOutlet weak var rightScoreLabel: UILabel!
    var leftScore = 0
    var rightScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func dealTapped(_ sender: Any) {
		// MARK: Deal Clicked
        let leftNumber = Int.random(in: 2...14)
        let rightNumber = Int.random(in: 2...14)
        
        leftImageView.image = UIImage(named: "card\(leftNumber)")
        rightImageView.image = UIImage(named: "card\(rightNumber)")
        
        if leftNumber > rightNumber {
			leftScore += 1
            leftScoreLabel.text = String(leftScore)
        } else if leftNumber < rightNumber {
			rightScore += 1
            rightScoreLabel.text = String(rightScore)
        }
		
		// MARK: Storyboard way
		// click the VC in storyboard > Editor tab on top > Embed in > Navigation Controller
		// assign class and Storyboard ID to SquidVC in storyboard inspector > tick Use Storyboard ID
		let squidVC = storyboard?.instantiateViewController(withIdentifier: "SquidVC") as! SquidVC
		show(squidVC, sender: self)
		
		// MARK: Segue way
		// click the VC in storyboard > Editor tab on top > Embed in > Navigation Controller
		// hold right click on WardCardVC on pull to SquidVC > show > provide Identifier to the segue like 'toSquidVC'
		performSegue(withIdentifier: "toSquidVC", sender: self)
    }
}
