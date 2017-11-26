//
//  JoinGameViewController.swift
//  In Sight
//
//  Created by Kelly Maclauchlan on 2017-09-15.
//  Copyright © 2017 Kelly Maclauchlan. All rights reserved.
//

import UIKit

class JoinGameViewController: UIViewController {
    
    @IBOutlet weak var JoinButton: UIButton!
    @IBOutlet weak var HunterSwitch: UISwitch!
    @IBOutlet weak var NameText: UITextField!
    @IBOutlet weak var WaitForLabel: UILabel!
    @IBOutlet weak var GameCodeText: UITextField!
    
    @IBOutlet weak var StartGameButton: UIButton!
    @IBOutlet weak var GameCodeLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    var player:PlayerJoin = PlayerJoin();
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        WaitForLabel.isHidden=true;
        StartGameButton.isHidden=true;
    }
    
    @IBAction func StartGameClicked(_ sender: Any) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func JoinGameClicked(_ sender: Any) {
        WaitForLabel.isHidden=false;
        JoinButton.isHidden=true;
        HunterSwitch.isHidden=true;
        NameText.isHidden = true;
        GameCodeText.isHidden = true;
        player.gameCode=GameCodeText.text!;
        player.name=NameText.text!;
        player.hunter=HunterSwitch.isOn ? 1: 0;
        StartGameButton.isHidden=false;
        
        //send to server
        let server = ServerConnection()
        _ = server.join(playerJoin: player)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("in outer segue")
        let svc = segue.destination as! MainGameViewController;
        svc.name = player.name;
        print("in segue")
    }
    
    
}
