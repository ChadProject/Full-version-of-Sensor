//
//  StartViewController.swift
//  Sensor
//
//  Created by Chadwick Zhao on 9/11/2016.
//  Copyright © 2016 youbing.song. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var startBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toPlayPage(sender: AnyObject) {
        performSegueWithIdentifier("toHome", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
