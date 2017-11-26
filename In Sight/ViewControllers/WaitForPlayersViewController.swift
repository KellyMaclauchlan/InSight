//
//  WaitForPlayersViewController.swift
//  In Sight
//
//  Created by Kelly Maclauchlan on 2017-09-15.
//  Copyright © 2017 Kelly Maclauchlan. All rights reserved.
//

import UIKit

class WaitForPlayersViewController: UIViewController {
    @IBOutlet weak var codeText: UILabel!
    var code = "wrer"
    var name = "jj"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        codeText.text  = code
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("in outer segue")
        var svc = segue.destination as! MainGameViewController;
        
        svc.name = name;
        print("in segue")
    }
    
}
