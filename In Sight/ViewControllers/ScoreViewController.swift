//
//  ScoreViewController.swift
//  In Sight
//
//  Created by Kelly Maclauchlan on 2017-09-15.
//  Copyright © 2017 Kelly Maclauchlan. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    
    @IBOutlet weak var WinNameLabel: UILabel!
    @IBOutlet weak var WinScoreLabel: UILabel!
    @IBOutlet weak var ScoreTable: UITableView!
    var game:Game!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var maxScore=0;
        var winnerName=""
        for p in game.players {
            if(p.score>maxScore){
                maxScore=p.score
                winnerName=p.name
            }
            print(p.name+" "+p.score.description)
        }
        WinNameLabel.text=winnerName
        WinScoreLabel.text=maxScore.description
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
