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
    
    
    func checkLocal(classname:String)->Void{
        let query = PFQuery(className: classname)
        query.limit = 1000
        query.fromLocalDatastore()
        query.findObjectsInBackgroundWithBlock { (object, error) -> Void in
            if error == nil{
                if let objects = object{
                    print("object capacity is \(objects.capacity)")
                    for object in objects{
                        print(object)
                    }
                }
            }else{
                print(error)
            }
        }
    }
    
    func topicScheduleRetrieve (completion: (objectId:String,placeId:String,topicId:String,date:String,timeStartId:String,timeStopId:String,detail:String,tools:String) -> Void){
        var keepAlive = true
        let test:PFQuery = PFQuery(className: "Topic_Schedule")
        test.limit = 1000
        test.findObjectsInBackgroundWithBlock{(objects, error) -> Void in
            
            if error == nil
            {
                
                if let objects = objects
                {
                    print(objects.capacity)
                    for object in objects{
                        completion(objectId: object.objectId! as String, placeId: object["Place"].objectId!!, topicId: object["TopicID"].objectId!!, date: object["Date"] as! String, timeStartId: object["Time_start"].objectId!!, timeStopId: object["Time_stop"].objectId!!, detail: object["Detail"] as! String, tools: object["Tools"] as! String
                        )
                        keepAlive = false
                    }
                }
            }
        }
        
        let runLoop = NSRunLoop.currentRunLoop()
        while keepAlive && runLoop.runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceNow: 0.1)) {
            print("x")
        }
    }

    
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
    
    @IBAction func forgetPassword(sender: AnyObject) {
      /*  let forget = UIAlertController(title: "Forget Password", message: "Enter your E-mail", preferredStyle: UIAlertControllerStyle.Alert)
        forget.addTextFieldWithConfigurationHandler { (textfield) -> Void in
            textfield.placeholder = "Your E-mail"
            
            forget.addAction(UIAlertAction(title: "Submit", style: UIAlertActionStyle.Default, handler: { (alertAction) -> Void in
                let textField = forget.textFields
                print(textField)
                let query = PFUser.query()
                query?.whereKey("emailVerified", equalTo: textField!)
                query?.findObjectsInBackgroundWithBlock({ (object, error) -> Void in
                    if error == nil{
                       //if let objects = object{
                         //   for object in objects{
                                print(object)
                           // }
                        //}
                    }else{
                        print(error)
                    }
                })
                
                
                
            }))
            forget.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: { (alertAction) -> Void in
                
            }))
        }
        self.presentViewController(forget, animated: true, completion: nil)
     */   
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    
        // Do any additional setup after loading the view, typically from a nib.
    }



}



