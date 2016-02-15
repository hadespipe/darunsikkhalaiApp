//
//  ViewController.swift
//  DarunsikkhalaiTimeTableApp
//
//  Created by jarukit boonkerd on 2/2/2559 BE.
//  Copyright © 2559 Hades corp. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    
    @IBOutlet var userTextField: UITextField!
    @IBOutlet var passTextField: UITextField!
    
    @IBAction func login(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(userTextField.text!, password:passTextField.text!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                print("yeah")
                let view = self.storyboard?.instantiateViewControllerWithIdentifier("timetable") as! TimeTable
                self.presentViewController(view, animated: true, completion: nil)
            } else {
                // The login failed. Check error to see why.
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

