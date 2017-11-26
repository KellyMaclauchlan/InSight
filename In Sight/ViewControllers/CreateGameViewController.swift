//
//  CreateGameViewController.swift
//  In Sight
//
//  Created by Kelly Maclauchlan on 2017-09-15.
//  Copyright © 2017 Kelly Maclauchlan. All rights reserved.
//
//numberPlayers=numPlayers;
//timeLimit = timeLim;
//numberFlags=numFlags;
//numberHunters=numHunters;
//boundaries=bounds;

import UIKit

class CreateGameViewController: UIViewController {
    
    @IBOutlet weak var NumPlayersText: UITextField!
    @IBOutlet weak var TimeLimitText: UITextField!
    @IBOutlet weak var NumFlagsText: UITextField!
    @IBOutlet weak var NumHuntersText: UITextField!
    @IBOutlet weak var PickRoleSwitch: UISwitch!
    @IBOutlet weak var NameText: UITextField!
    @IBOutlet weak var HunterSwitch: UISwitch!
    
    var boundaries = [2,3,4,5];
    var game:GameSettings = GameSettings();
    var tempGame:GameSettings = GameSettings();
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CreateBounderies(_ sender: Any) {
        self.saveData(g:game);
    }
    @IBAction func CreateGameClicked(_ sender: Any) {
        self.saveData(g:game);
        
        //send to server
    }
    func saveData(g:GameSettings){
        g.hunter=HunterSwitch.isOn;
        g.chooseHunter=PickRoleSwitch.isOn;
        g.numberPlayers=Int(self.NumPlayersText.text!)!;
        g.timeLimit = Int(self.TimeLimitText.text!)!;
        g.numberFlags=Int(self.NumFlagsText.text!)!;
        g.numberHunters=Int(self.NumHuntersText.text!)!;
        g.name=self.NameText.text!;
    }
    func fillInTemp(){
//        HunterSwitch.setOn((tempGame.hunter==1 ? true : false), animated: false)
//        boundaries=tempGame.boundaries
//        self.NumPlayersText.text=String(tempGame.numberPlayers);
//        self.TimeLimitText.text=String(tempGame.timeLimit);
//        self.NumHuntersText.text=String(tempGame.numberHunters);
//        self.NameText.text=String(tempGame.name);
//        self.NumFlagsText.text=String(tempGame.numberFlags);
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("in outer segue")
        if (segue.identifier == "ToBoundaries") {
            
            var svc = segue.destination as! AddBoundariesViewController;
            
            svc.game = game;
            print("in segue")
        }
    }
}
