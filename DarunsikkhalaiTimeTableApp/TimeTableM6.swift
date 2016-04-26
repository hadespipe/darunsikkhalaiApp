//
//  TimeTable.swift
//  DarunsikkhalaiTimeTableApp
//
//  Created by jarukit boonkerd on 2/3/2559 BE.
//  Copyright © 2559 Hades corp. All rights reserved.
//

import UIKit
import Parse

class TimeTable: UIViewController {
    
    
    func classRetrive (completion: (objectId:String, classId:String, noClass: Int) -> Void){
        var keepAlive = true
        let test:PFQuery = PFQuery(className: "Class_FK")
        test.limit = 1000
        test.findObjectsInBackgroundWithBlock{(objects, error) -> Void in
            
            if error == nil
            {
                
                if let objects = objects
                {
                    for object in objects{
                        completion(objectId: object.objectId! as String, classId: object["Class"] as! String, noClass: object["No_class"] as! Int)
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

    @IBOutlet var conclude: UITabBarItem!
    @IBOutlet var m4Button: UITabBar!
    @IBOutlet var m5Button: UITabBarItem!
    @IBOutlet var m6Button: UITabBarItem!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    func timeRetrive (completion: (objectId:String,time:String) -> Void){
        var keepAlive = true
        let test:PFQuery = PFQuery(className: "Time_FK")
        test.limit = 1000
        test.findObjectsInBackgroundWithBlock{(objects, error) -> Void in
            
            if error == nil
            {
                
                if let objects = objects
                {
                    for object in objects{
                        completion(objectId: object.objectId! as String, time: object["Time"] as! String)
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
    @IBAction func nextButton(sender: AnyObject) {
        count += 1
        //ใส่วันที่ลงแอป
        let today = NSDate()
        let todayFormatter = NSDateFormatter()
        todayFormatter.dateFormat = "dd-MM-yyyy"
        _ = todayFormatter.stringFromDate(today)
        let todayFormatterCheck = NSDateFormatter()
        todayFormatterCheck.dateFormat = "E"
        let todayCheckString = todayFormatterCheck.stringFromDate(today)
        _ = NSCalendar.currentCalendar().components(NSCalendarUnit.Month, fromDate: today)
        
        switch(todayCheckString){
        case "Mon" :
            mondayDate.text = adaptDateString(0+(count*7))
            tuesdayDate.text = adaptDateString(1+(count*7))
            wednesdayDate.text = adaptDateString(2+(count*7))
            thursdayDate.text = adaptDateString(3+(count*7))
            fridayDate.text = adaptDateString(4+(count*7))
        case "Tue" :
            mondayDate.text = adaptDateString(-1+(count*7))
            tuesdayDate.text = adaptDateString(0+(count*7))
            wednesdayDate.text = adaptDateString(+1+(count*7))
            thursdayDate.text = adaptDateString(2+(count*7))
            fridayDate.text = adaptDateString(3+(count*7))
        case "Wed" :
            mondayDate.text = adaptDateString(-2+(count*7))
            tuesdayDate.text = adaptDateString(-1+(count*7))
            wednesdayDate.text = adaptDateString(0+(count*7))
            thursdayDate.text = adaptDateString(1+(count*7))
            fridayDate.text = adaptDateString(2+(count*7))
        case "Thu" :
            mondayDate.text = adaptDateString(-3+(count*7))
            tuesdayDate.text = adaptDateString(-2+(count*7))
            wednesdayDate.text = adaptDateString(-1+(count*7))
            thursdayDate.text = adaptDateString(0+(count*7))
            fridayDate.text = adaptDateString(1+(count*7))
        case "Fri" :
            mondayDate.text = adaptDateString(-4+(count*7))
            tuesdayDate.text = adaptDateString(-3+(count*7))
            wednesdayDate.text = adaptDateString(-2+(count*7))
            thursdayDate.text = adaptDateString(-1+(count*7))
            fridayDate.text = adaptDateString(0+(count*7))
        case "Sat" :
            mondayDate.text = adaptDateString(-5+(count*7))
            tuesdayDate.text = adaptDateString(-4+(count*7))
            wednesdayDate.text = adaptDateString(-3+(count*7))
            thursdayDate.text = adaptDateString(-2+(count*7))
            fridayDate.text = adaptDateString(-1+(count*7))
        case "Sun" :
            mondayDate.text = adaptDateString(-6+(count*7))
            tuesdayDate.text = adaptDateString(-5+(count*7))
            wednesdayDate.text = adaptDateString(-4+(count*7))
            thursdayDate.text = adaptDateString(-3+(count*7))
            fridayDate.text = adaptDateString(-2+(count*7))
        default :
            print("Error")
        }
        
        let day:[String] = [mondayDate.text!,tuesdayDate.text!,wednesdayDate.text!,thursdayDate.text!,fridayDate.text!]
        let subject = PFQuery(className: "HT_Topic_Schedule")
        subject.fromLocalDatastore()
        subject.whereKey("Date", containedIn: day)
        subject.findObjectsInBackgroundWithBlock { (object, error) -> Void in
            if error == nil{
                if let objects = object{
                    print(objects.capacity)
                    for object in objects{
                        print(object)
                        //เปิดเวลา และ topicId
                        let subjectObjectId = object.objectId!
                        
                        
                        let timeStart = object["timeStartId"] as! String
                        
                        
                        let timeStop = object["timeStopId"]  as! String
                        
                        let topicId = object["TopicId"]
                        let date = object["Date"]
                        
                        
                        //print(timeStart,timeStop,topicId)
                        print("TimeStart = \(timeStart),TimeStop = \(timeStop), TopicId = \(topicId)")
                        let timeQuery = PFQuery(className: "HT_Time_FK")
                        timeQuery.fromLocalDatastore()
                        //timeQuery.whereKey("objectId", equalTo: timeStop)
                        timeQuery.findObjectsInBackgroundWithBlock({ (object, error) -> Void in
                            if error == nil{
                                if let objects = object{
                                    //print(objects.capacity)
                                    for object in objects{
                                        if timeStart    == object.objectId!  {
                                            
                                            //อยู่คาบเช้า
                                            let period = timeConvert(object["Time"] as! String)
                                            //let endPeriod = timeConvert()
                                            
                                            let topic = PFQuery(className: "HT_Topic")
                                            topic.fromLocalDatastore()
                                            //topic.whereKey("objectId", equalTo: topicId)
                                            topic.findObjectsInBackgroundWithBlock({ (object, error) -> Void in
                                                if error == nil{
                                                    if let objects = object{
                                                        print(objects.capacity)
                                                        for object in objects{
                                                            if object.objectId! == topicId as! String{
                                                                let topicName = object["Topic_Name"]
                                                                
                                                                let subjectCode = object["SubjectCode"]
                                                                let subjectQuery = PFQuery(className: "HT_Subject")
                                                                subjectQuery.fromLocalDatastore()
                                                                subjectQuery.findObjectsInBackgroundWithBlock({ (object, error) -> Void in
                                                                    if error == nil{
                                                                        if let objects = object{
                                                                            for object in objects{
                                                                                if subjectCode as! String == object.objectId! {
                                                                                    print(object["Class"].objectId)
                                                                                    let classId = object["Class"].objectId!
                                                                                    var theirClass = String()
                                                                                    switch classId!{
                                                                                    case "Jdr0Rowr8p":
                                                                                        theirClass = "m.6"
                                                                                    case "exv130NBiY":
                                                                                        theirClass = "m.5"
                                                                                    case "wleD05apD3":
                                                                                        theirClass = "m.4"
                                                                                    default:
                                                                                        print("error in classId switch case.")
                                                                                    }
                                                                                    
                                                                                    
                                                                                    
                                                                                    print("\(topicName) in (\(date)) is \(period) =  \(object.objectId)   \(theirClass)")
                                                                                    if self.mondayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                        self.mondayClassMorning.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.mondayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                        self.mondayClassAfternoon.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.tuesdayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                        self.tuesdayClassMorning.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.tuesdayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                        self.tuesdayClassAfternoon.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.wednesdayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                        self.wednesdayClassMorning.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.wednesdayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                        self.wednesdayClassAfternoon.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.thursdayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                        self.thursdayClassMorning.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.thursdayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                        self.thursdayClassAfternoon.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.fridayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                        self.fridayClassMorning.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.fridayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                        self.fridayClassAfternoon.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    
                                                                                    //teacher
                                                                                    let teacher = PFQuery(className: "HT_Topic_Teacher")
                                                                                    teacher.fromLocalDatastore()
                                                                                    teacher.findObjectsInBackgroundWithBlock { (object, error) -> Void in
                                                                                        if error == nil{
                                                                                            if let objects = object{
                                                                                                for object in objects{
                                                                                                    if object["TopicScheduleID"] as! String == subjectObjectId {
                                                                                                        let teacherId = object["Teacher"]
                                                                                                        let teacherUser = PFQuery(className: "User")
                                                                                                        teacherUser.fromLocalDatastore()
                                                                                                        teacherUser.findObjectsInBackgroundWithBlock { (object, error) -> Void in
                                                                                                            if error == nil{
                                                                                                                if let objects = object{
                                                                                                                    for object in objects{
                                                                                                                        if object.objectId!  == teacherId as! String{
                                                                                                                            print("I'm \(object["namelist"]) teach \(topicName)")
                                                                                                                            let teacherName = object["namelist"]
                                                                                                                            if self.mondayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                                                                self.mondayTeacherMorning.setTitle(teacherName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.mondayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                                                                self.mondayTeacherAfternoon.setTitle(teacherName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.tuesdayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                                                                self.tuesdayTeacherMorning.setTitle(teacherName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.tuesdayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                                                                self.tuesdayTeacherAfternoon.setTitle(teacherName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.wednesdayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                                                                self.wednesdayTeacherMorning.setTitle(teacherName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.wednesdayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                                                                self.wednesdayTeacherAfternoon.setTitle(teacherName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.thursdayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                                                                self.thursdayTeacherMorning.setTitle(teacherName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.thursdayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                                                                self.thursdayTeacherAfternoon.setTitle(teacherName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.fridayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                                                                self.fridayTeacherMorning.setTitle(teacherName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.fridayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                                                                self.fridayTeacherAfternoon.setTitle(teacherName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            
                                                                                                                        }
                                                                                                                    }
                                                                                                                }
                                                                                                            }else{
                                                                                                                print(error)
                                                                                                            }
                                                                                                        }
                                                                                                        
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }else{
                                                                                            print(error)
                                                                                        }
                                                                                    }
                                                                                    
                                                                                }
                                                                            }
                                                                        }
                                                                    }else{
                                                                        print(error)
                                                                    }
                                                                })
                                                            }
                                                            
                                                        }
                                                    }
                                                }
                                            })
                                            
                                        }
                                    }
                                }
                            }else{
                                print(error)
                            }
                        })
                    }
                }
            }else{
                print(error)
            }
        }

        
        viewDidLoad()
        print(mondayDate.text)
        
    }
    @IBAction func previousButton(sender: AnyObject) {
        count -= 1
        //ใส่วันที่ลงแอป
        let today = NSDate()
        let todayFormatter = NSDateFormatter()
        todayFormatter.dateFormat = "dd-MM-yyyy"
        _ = todayFormatter.stringFromDate(today)
        let todayFormatterCheck = NSDateFormatter()
        todayFormatterCheck.dateFormat = "E"
        let todayCheckString = todayFormatterCheck.stringFromDate(today)
        _ = NSCalendar.currentCalendar().components(NSCalendarUnit.Month, fromDate: today)
        
        switch(todayCheckString){
        case "Mon" :
            mondayDate.text = adaptDateString(0+(count*7))
            tuesdayDate.text = adaptDateString(1+(count*7))
            wednesdayDate.text = adaptDateString(2+(count*7))
            thursdayDate.text = adaptDateString(3+(count*7))
            fridayDate.text = adaptDateString(4+(count*7))
        case "Tue" :
            mondayDate.text = adaptDateString(-1+(count*7))
            tuesdayDate.text = adaptDateString(0+(count*7))
            wednesdayDate.text = adaptDateString(+1+(count*7))
            thursdayDate.text = adaptDateString(2+(count*7))
            fridayDate.text = adaptDateString(3+(count*7))
        case "Wed" :
            mondayDate.text = adaptDateString(-2+(count*7))
            tuesdayDate.text = adaptDateString(-1+(count*7))
            wednesdayDate.text = adaptDateString(0+(count*7))
            thursdayDate.text = adaptDateString(1+(count*7))
            fridayDate.text = adaptDateString(2+(count*7))
        case "Thu" :
            mondayDate.text = adaptDateString(-3+(count*7))
            tuesdayDate.text = adaptDateString(-2+(count*7))
            wednesdayDate.text = adaptDateString(-1+(count*7))
            thursdayDate.text = adaptDateString(0+(count*7))
            fridayDate.text = adaptDateString(1+(count*7))
        case "Fri" :
            mondayDate.text = adaptDateString(-4+(count*7))
            tuesdayDate.text = adaptDateString(-3+(count*7))
            wednesdayDate.text = adaptDateString(-2+(count*7))
            thursdayDate.text = adaptDateString(-1+(count*7))
            fridayDate.text = adaptDateString(0+(count*7))
        case "Sat" :
            mondayDate.text = adaptDateString(-5+(count*7))
            tuesdayDate.text = adaptDateString(-4+(count*7))
            wednesdayDate.text = adaptDateString(-3+(count*7))
            thursdayDate.text = adaptDateString(-2+(count*7))
            fridayDate.text = adaptDateString(-1+(count*7))
        case "Sun" :
            mondayDate.text = adaptDateString(-6+(count*7))
            tuesdayDate.text = adaptDateString(-5+(count*7))
            wednesdayDate.text = adaptDateString(-4+(count*7))
            thursdayDate.text = adaptDateString(-3+(count*7))
            fridayDate.text = adaptDateString(-2+(count*7))
        default :
            print("Error")
        }
        
        let day:[String] = [mondayDate.text!,tuesdayDate.text!,wednesdayDate.text!,thursdayDate.text!,fridayDate.text!]
        let subject = PFQuery(className: "HT_Topic_Schedule")
        subject.fromLocalDatastore()
        subject.whereKey("Date", containedIn: day)
        subject.findObjectsInBackgroundWithBlock { (object, error) -> Void in
            if error == nil{
                if let objects = object{
                    print(objects.capacity)
                    for object in objects{
                        print(object)
                        //เปิดเวลา และ topicId
                        let subjectObjectId = object.objectId!
                       
                        
                        let timeStart = object["timeStartId"] as! String
                     
                        
                        let timeStop = object["timeStopId"]  as! String
                     
                        let topicId = object["TopicId"]
                        let date = object["Date"]
                        
                      
                        //print(timeStart,timeStop,topicId)
                        print("TimeStart = \(timeStart),TimeStop = \(timeStop), TopicId = \(topicId)")
                        let timeQuery = PFQuery(className: "HT_Time_FK")
                        timeQuery.fromLocalDatastore()
                        //timeQuery.whereKey("objectId", equalTo: timeStop)
                        timeQuery.findObjectsInBackgroundWithBlock({ (object, error) -> Void in
                            if error == nil{
                                if let objects = object{
                                    //print(objects.capacity)
                                    for object in objects{
                                        if timeStart    == object.objectId!  {
                                            
                                            //อยู่คาบเช้า
                                            let period = timeConvert(object["Time"] as! String)
                                            //let endPeriod = timeConvert()
                                            
                                            let topic = PFQuery(className: "HT_Topic")
                                            topic.fromLocalDatastore()
                                            //topic.whereKey("objectId", equalTo: topicId)
                                            topic.findObjectsInBackgroundWithBlock({ (object, error) -> Void in
                                                if error == nil{
                                                    if let objects = object{
                                                        print(objects.capacity)
                                                        for object in objects{
                                                            if object.objectId! == topicId as! String{
                                                                let topicName = object["Topic_Name"]
                                                                
                                                                let subjectCode = object["SubjectCode"]
                                                                let subjectQuery = PFQuery(className: "HT_Subject")
                                                                subjectQuery.fromLocalDatastore()
                                                                subjectQuery.findObjectsInBackgroundWithBlock({ (object, error) -> Void in
                                                                    if error == nil{
                                                                        if let objects = object{
                                                                            for object in objects{
                                                                                if subjectCode as! String == object.objectId! {
                                                                                    print(object["Class"].objectId)
                                                                                    let classId = object["Class"].objectId!
                                                                                    var theirClass = String()
                                                                                    switch classId!{
                                                                                    case "Jdr0Rowr8p":
                                                                                        theirClass = "m.6"
                                                                                    case "exv130NBiY":
                                                                                        theirClass = "m.5"
                                                                                    case "wleD05apD3":
                                                                                        theirClass = "m.4"
                                                                                    default:
                                                                                        print("error in classId switch case.")
                                                                                    }
                                                                                    
                                                                                    
                                                                                    
                                                                                    print("\(topicName) in (\(date)) is \(period) =  \(object.objectId)   \(theirClass)")
                                                                                    if self.mondayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                        self.mondayClassMorning.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.mondayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                        self.mondayClassAfternoon.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.tuesdayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                        self.tuesdayClassMorning.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.tuesdayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                        self.tuesdayClassAfternoon.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.wednesdayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                        self.wednesdayClassMorning.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.wednesdayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                        self.wednesdayClassAfternoon.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.thursdayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                        self.thursdayClassMorning.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.thursdayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                        self.thursdayClassAfternoon.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.fridayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                        self.fridayClassMorning.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.fridayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                        self.fridayClassAfternoon.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    
                                                                                    //teacher
                                                                                    let teacher = PFQuery(className: "HT_Topic_Teacher")
                                                                                    teacher.fromLocalDatastore()
                                                                                    teacher.findObjectsInBackgroundWithBlock { (object, error) -> Void in
                                                                                        if error == nil{
                                                                                            if let objects = object{
                                                                                                for object in objects{
                                                                                                    if object["TopicScheduleID"] as! String == subjectObjectId {
                                                                                                        let teacherId = object["Teacher"]
                                                                                                        let teacherUser = PFQuery(className: "User")
                                                                                                        teacherUser.fromLocalDatastore()
                                                                                                        teacherUser.findObjectsInBackgroundWithBlock { (object, error) -> Void in
                                                                                                            if error == nil{
                                                                                                                if let objects = object{
                                                                                                                    for object in objects{
                                                                                                                        if object.objectId!  == teacherId as! String{
                                                                                                                            print("I'm \(object["namelist"]) teach \(topicName)")
                                                                                                                            let teacherName = object["namelist"]
                                                                                                                            if self.mondayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                                                                self.mondayTeacherMorning.setTitle(teacherName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.mondayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                                                                self.mondayTeacherAfternoon.setTitle(teacherName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.tuesdayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                                                                self.tuesdayTeacherMorning.setTitle(teacherName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.tuesdayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                                                                self.tuesdayTeacherAfternoon.setTitle(teacherName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.wednesdayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                                                                self.wednesdayTeacherMorning.setTitle(teacherName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.wednesdayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                                                                self.wednesdayTeacherAfternoon.setTitle(teacherName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.thursdayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                                                                self.thursdayTeacherMorning.setTitle(teacherName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.thursdayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                                                                self.thursdayTeacherAfternoon.setTitle(teacherName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.fridayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                                                                self.fridayTeacherMorning.setTitle(teacherName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.fridayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                                                                self.fridayTeacherAfternoon.setTitle(teacherName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            
                                                                                                                        }
                                                                                                                    }
                                                                                                                }
                                                                                                            }else{
                                                                                                                print(error)
                                                                                                            }
                                                                                                        }
                                                                                                        
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }else{
                                                                                            print(error)
                                                                                        }
                                                                                    }
                                                                                    
                                                                                }
                                                                            }
                                                                        }
                                                                    }else{
                                                                        print(error)
                                                                    }
                                                                })
                                                            }
                                                            
                                                        }
                                                    }
                                                }
                                            })
                                            
                                        }
                                    }
                                }
                            }else{
                                print(error)
                            }
                        })
                    }
                }
            }else{
                print(error)
            }
        }
        
    }
    //UIButton List
    // วัน
    @IBOutlet var mondayDate: UILabel!
    @IBOutlet var tuesdayDate: UILabel!
    @IBOutlet var wednesdayDate: UILabel!
    @IBOutlet var thursdayDate: UILabel!
    @IBOutlet var fridayDate: UILabel!
    // คาบเช้า
    @IBOutlet var mondayClassMorning: UIButton!
    @IBOutlet var tuesdayClassMorning: UIButton!
    @IBOutlet var wednesdayClassMorning: UIButton!
    @IBOutlet var thursdayClassMorning: UIButton!
    @IBOutlet var fridayClassMorning: UIButton!
    // คาบบ่าย
    @IBOutlet var mondayClassAfternoon: UIButton!
    @IBOutlet var tuesdayClassAfternoon: UIButton!
    @IBOutlet var wednesdayClassAfternoon: UIButton!
    @IBOutlet var thursdayClassAfternoon: UIButton!
    @IBOutlet var fridayClassAfternoon: UIButton!
    // ครูคาบเช้า
    @IBOutlet var mondayTeacherMorning: UIButton!
    @IBOutlet var tuesdayTeacherMorning: UIButton!
    @IBOutlet var wednesdayTeacherMorning: UIButton!
    @IBOutlet var thursdayTeacherMorning: UIButton!
    @IBOutlet var fridayTeacherMorning: UIButton!
    // ครูคาบบ่าย
    @IBOutlet var mondayTeacherAfternoon: UIButton!
    @IBOutlet var tuesdayTeacherAfternoon: UIButton!
    @IBOutlet var wednesdayTeacherAfternoon: UIButton!
    @IBOutlet var thursdayTeacherAfternoon: UIButton!
    @IBOutlet var fridayTeacherAfternoon: UIButton!
    // lunch
    @IBOutlet var mondayLunch: UIButton!
    @IBOutlet var tuesdayLunch: UIButton!
    @IBOutlet var wednesdayLunch: UIButton!
    @IBOutlet var thursdayLunch: UIButton!
    @IBOutlet var fridayLunch: UIButton!
    // extra
    @IBOutlet var mondayExtra: UIButton!
    @IBOutlet var tuesdayExtra: UIButton!
    @IBOutlet var wednesdayExtra: UIButton!
    @IBOutlet var thursdayExtra: UIButton!
    @IBOutlet var fridayExtra: UIButton!
    // variable
    var count = 0 // สำหรับเปลี่ยนสัปดาห์
    
    var timeStart = String()
    var timeStop = String()
    override func viewWillAppear(animated: Bool) {
        
        //        let user = PFUser.currentUser()
        //        print(user)
        super.viewWillAppear(true)
        
        //_______________________________________________________________________________________
        
  


        
//        countLocal("HT_Term_FK")
//        countLocal("HT_Class_FK")
//        countLocal("HT_Time_FK")
//        countLocal("HT_Subject")
//        countLocal("HT_Place_FK")
//        countLocal("User")
//        countLocal("HT_Topic")
//        countLocal("HT_Topic_Teacher")
//        
//
//                timeRetrive { (objectId, time) -> Void in
//                    print(objectId, time)
//                    let timeTable = PFObject(className: "HT_Time_FK")
//                    timeTable.objectId = objectId
//                    timeTable["Time"] = time
//                    timeTable.pinInBackground()
//                }
//                subjectRetrive { (objectId, classId, info, subject, termId) -> Void in
//                    print(objectId, classId, info, subject, termId)
//                    let subTable = PFObject(className: "HT_Subject")
//                    subTable.objectId = objectId
//                    subTable["Class"] = classId
//                    subTable["Info"] = info
//                    subTable["Subject"] = subject
//                    subTable["Term"] = termId
//                    subTable.pinInBackground()
//                }
//                placeRetrive { (objectId, noPlace, place) -> Void in
//                    print(objectId, noPlace, place)
//                    let placeTable = PFObject(className: "HT_Place_FK")
//                    placeTable.objectId = objectId
//                    placeTable["No_place"] = noPlace
//                    placeTable["Place_name"] = place
//                    placeTable.pinInBackground()
//                }
//                userRetrive { (objectId, namelist, classId, email) -> Void in
//                    print(objectId, namelist, classId, email)
//                    let userTable = PFObject(className: "HT_User")
//                    userTable.objectId = objectId
//                    userTable["namelist"] = namelist
//                    userTable["class"] = classId
//                    userTable["email"] = email
//                    userTable.pinInBackground()
//                }
//                classRetrive { (objectId, classId, noClass) -> Void in
//                    print(objectId, classId, noClass)
//                    let classTable = PFObject(className: "HT_Class_FK")
//                    classTable.objectId = objectId
//                    classTable["Class"] = classId
//                    classTable["No_class"] = noClass
//                    classTable.pinInBackground()
//                }
//                topicRetrive { (objectId, detail, subjectCodeId, topicName) -> Void in
//                    print(objectId, detail, subjectCodeId, topicName)
//                    let topic = PFObject(className: "HT_Topic")
//                    topic.objectId = objectId
//                    topic["Detail"] = detail
//                    topic["SubjectCode"] = subjectCodeId
//                    topic["Topic_Name"] = topicName
//                    topic.pinInBackground()
//                }
//                topicTeacherRetrive { (objectId, teacherId, topicScheduleId) -> Void in
//                    print(objectId, teacherId, topicScheduleId)
//                    let topicTeacher = PFObject(className: "HT_Topic_Teacher")
//                    topicTeacher.objectId = objectId
//                    topicTeacher["Teacher"] = teacherId
//                    topicTeacher["TopicScheduleID"] = topicScheduleId
//                    topicTeacher.pinInBackground()
//                }
        
        
        //clearLocal("HT_Topic_Schedule")
        
        
        //_______________________________________________________________________________________
        
        let day:[String] = [mondayDate.text!,tuesdayDate.text!,wednesdayDate.text!,thursdayDate.text!,fridayDate.text!]
        //        subjectThisWeek(day) { (objectId, date, timeStartId, timeStopId,topicId) -> Void in
        //            print(objectId, date, timeStartId, timeStopId,topicId)
        //            print(timeStartId)
        //            print(timeConvertNew(timeStartId as String))
        //
        //        }
        
        //        timeConvert("MffGvFd0QV") { (time) -> Void in
        //            print("It's \(time)")
        //            print(timeToPeriod(time))
        //        }
        
        
        //
        //        topicLocal("czHP4szIao") { (subjectCode, topicName) -> Void in
        //            print("haha")
        //            print(subjectCode, topicName)
        //        }
        //
        //        subjectCodeToGrade("b9104bVKbj") { (grade) -> Void in
        //            print("I'm in \(grade)")
        //        }
        //
        //        teacherFromTopicId("O5iqTQBYCq") { (teacher) -> Void in
        //            print("I'm \(teacher)")
        //        }
        
        
        
        
        print(day)
        //การเปิดตารางเรียน
        //โชว์คาบ
        let subject = PFQuery(className: "HT_Topic_Schedule")
        subject.fromLocalDatastore()
        subject.whereKey("Date", containedIn: day)
        subject.findObjectsInBackgroundWithBlock { (object, error) -> Void in
            if error == nil{
                if let objects = object{
                    print(objects.capacity)
                    for object in objects{
                        print(object)
                        //เปิดเวลา และ topicId
                        let subjectObjectId = object.objectId!
                        
                        
                        let timeStart = object["timeStartId"] as! String
                        
                        
                        let timeStop = object["timeStopId"]  as! String
                        
                        let topicId = object["TopicId"]
                        let date = object["Date"]
                        
                        
                        //print(timeStart,timeStop,topicId)
                        print("TimeStart = \(timeStart),TimeStop = \(timeStop), TopicId = \(topicId)")
                        let timeQuery = PFQuery(className: "HT_Time_FK")
                        timeQuery.fromLocalDatastore()
                        //timeQuery.whereKey("objectId", equalTo: timeStop)
                        timeQuery.findObjectsInBackgroundWithBlock({ (object, error) -> Void in
                            if error == nil{
                                if let objects = object{
                                    //print(objects.capacity)
                                    for object in objects{
                                        if timeStart    == object.objectId!  {
                                            
                                            //อยู่คาบเช้า
                                            let period = timeConvert(object["Time"] as! String)
                                            //let endPeriod = timeConvert()
                                            
                                            let topic = PFQuery(className: "HT_Topic")
                                            topic.fromLocalDatastore()
                                            //topic.whereKey("objectId", equalTo: topicId)
                                            topic.findObjectsInBackgroundWithBlock({ (object, error) -> Void in
                                                if error == nil{
                                                    if let objects = object{
                                                        print(objects.capacity)
                                                        for object in objects{
                                                            if object.objectId! == topicId as! String{
                                                                let topicName = object["Topic_Name"]
                                                                
                                                                let subjectCode = object["SubjectCode"]
                                                                let subjectQuery = PFQuery(className: "HT_Subject")
                                                                subjectQuery.fromLocalDatastore()
                                                                subjectQuery.findObjectsInBackgroundWithBlock({ (object, error) -> Void in
                                                                    if error == nil{
                                                                        if let objects = object{
                                                                            for object in objects{
                                                                                if subjectCode as! String == object.objectId! {
                                                                                    print(object["Class"].objectId)
                                                                                    let classId = object["Class"].objectId!
                                                                                    var theirClass = String()
                                                                                    switch classId!{
                                                                                    case "Jdr0Rowr8p":
                                                                                        theirClass = "m.6"
                                                                                    case "exv130NBiY":
                                                                                        theirClass = "m.5"
                                                                                    case "wleD05apD3":
                                                                                        theirClass = "m.4"
                                                                                    default:
                                                                                        print("error in classId switch case.")
                                                                                    }
                                                                                    
                                                                                    
                                                                                    
                                                                                    print("\(topicName) in (\(date)) is \(period) =  \(object.objectId)   \(theirClass)")
                                                                                    if self.mondayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                        self.mondayClassMorning.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.mondayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                        self.mondayClassAfternoon.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.tuesdayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                        self.tuesdayClassMorning.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.tuesdayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                        self.tuesdayClassAfternoon.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.wednesdayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                        self.wednesdayClassMorning.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.wednesdayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                        self.wednesdayClassAfternoon.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.thursdayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                        self.thursdayClassMorning.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.thursdayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                        self.thursdayClassAfternoon.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.fridayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                        self.fridayClassMorning.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.fridayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                        self.fridayClassAfternoon.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    
                                                                                    //teacher
                                                                                    let teacher = PFQuery(className: "HT_Topic_Teacher")
                                                                                    teacher.fromLocalDatastore()
                                                                                    teacher.findObjectsInBackgroundWithBlock { (object, error) -> Void in
                                                                                        if error == nil{
                                                                                            if let objects = object{
                                                                                                for object in objects{
                                                                                                    if object["TopicScheduleID"] as! String == subjectObjectId {
                                                                                                        let teacherId = object["Teacher"]
                                                                                                        let teacherUser = PFQuery(className: "User")
                                                                                                        teacherUser.fromLocalDatastore()
                                                                                                        teacherUser.findObjectsInBackgroundWithBlock { (object, error) -> Void in
                                                                                                            if error == nil{
                                                                                                                if let objects = object{
                                                                                                                    for object in objects{
                                                                                                                        if object.objectId!  == teacherId as! String{
                                                                                                                            print("I'm \(object["namelist"]) teach \(topicName)")
                                                                                                                            let teacherName = object["namelist"]
                                                                                                                            if self.mondayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                                                                self.mondayTeacherMorning.setTitle(teacherName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.mondayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                                                                self.mondayTeacherAfternoon.setTitle(teacherName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.tuesdayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                                                                self.tuesdayTeacherMorning.setTitle(teacherName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.tuesdayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                                                                self.tuesdayTeacherAfternoon.setTitle(teacherName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.wednesdayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                                                                self.wednesdayTeacherMorning.setTitle(teacherName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.wednesdayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                                                                self.wednesdayTeacherAfternoon.setTitle(teacherName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.thursdayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                                                                self.thursdayTeacherMorning.setTitle(teacherName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.thursdayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                                                                self.thursdayTeacherAfternoon.setTitle(teacherName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.fridayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                                                                self.fridayTeacherMorning.setTitle(teacherName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.fridayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                                                                self.fridayTeacherAfternoon.setTitle(teacherName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            
                                                                                                                        }
                                                                                                                    }
                                                                                                                }
                                                                                                            }else{
                                                                                                                print(error)
                                                                                                            }
                                                                                                        }
                                                                                                        
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }else{
                                                                                            print(error)
                                                                                        }
                                                                                    }
                                                                                    
                                                                                }
                                                                            }
                                                                        }
                                                                    }else{
                                                                        print(error)
                                                                    }
                                                                })
                                                            }
                                                            
                                                        }
                                                    }
                                                }
                                            })
                                            
                                        }
                                    }
                                }
                            }else{
                                print(error)
                            }
                        })
                    }
                }
            }else{
                print(error)
            }
        }
        
        
        
    }
    
    
    var subjectTest = String()
    
    
    
    //ต้นแบบการรับค่า
    func test (completion: (classid:String, info:String) -> Void){
        var keepAlive = true
        let test:PFQuery = PFQuery(className: "HT_Subject")
        //test.whereKey("Info", equalTo: "English")
        test.findObjectsInBackgroundWithBlock{(objects, error) -> Void in
            
            if error == nil
            {
                
                if let objects = objects
                {
                    for object in objects{
                        //  print(object[""])
                        completion(classid: object["Class"] as! String, info: object["Info"] as! String)
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
    
    

// check ว่ามีข้อมูลอยู่ใน local datastore โดยบอกชื่อ class
    func checkLocal(classname:String)->Void{
        let query = PFQuery(className: classname)
        query.limit = 1000
        query.fromLocalDatastore()
        query.findObjectsInBackgroundWithBlock { (object, error) -> Void in
            if error == nil{
                if let objects = object{
                    print("\(classname)'s capacity is \(objects.capacity)")
                    for object in objects{
                        print(object)
                    }
                }
            }else{
                print(error)
            }
        }
    }
    
    
    func clearLocal(classname:String)->Void{
        let query = PFQuery(className: classname)
        query.limit = 1000
        query.fromLocalDatastore()
        query.findObjectsInBackgroundWithBlock { (object, error) -> Void in
            if error == nil{
                if let objects = object{
                    print("\(classname)'s capacity is \(objects.capacity)")
                    for object in objects{
                        object.unpinInBackground()
                    }
                }
            }else{
                print(error)
            }
        }
    }
    func countLocal(classname:String)->Void{
        let query = PFQuery(className: classname)
        query.limit = 1000
        query.fromLocalDatastore()
        query.findObjectsInBackgroundWithBlock { (object, error) -> Void in
            if error == nil{
                if let objects = object{
                    print("\(classname)'s capacity is \(objects.capacity)")
                    
                }
            }else{
                print(error)
            }
        }
    }
    
    
    
    var checkApp = String()
    var checkPoint = Int()
    
    
    
    override func viewDidLoad() {  // <-- func นี้สำหรับ code ที่ต้องการให้ run เมื่อเปิดหน้านี้
        
        super.viewDidLoad()
        
 
        
        //        topicTeacherRetrive { (objectId, teacherId, topicScheduleId) -> Void in
        //            print(objectId, teacherId, topicScheduleId)
        //            let topicTeacher = PFObject(className: "Topic_Teacher")
        //            topicTeacher.objectId = objectId
        //            topicTeacher["Teacher"] = teacherId
        //            topicTeacher["TopicScheduleID"] = topicScheduleId
        //            topicTeacher.pinInBackground()
        //        }
        
        // checkLocal("Topic_Schedule")
        
        
        //
        //        let query = PFQuery(className: "Time_FK")
        //        query.fromLocalDatastore()
        //        query.whereKey("Time", equalTo: "19.00")
        //        query.findObjectsInBackgroundWithBlock{ (object, error) -> Void in
        //            if error == nil{
        //                if let objects = object{
        //                    print(objects.capacity)
        //                    for object in objects{
        //                        print("hah")
        //                        print(object["objectId"])
        //                    }
        //                }
        //            }else{
        //                print(error)
        //            }
        //        }
        
        
        // สำหรับการเช็คว่า เราเคยเก็บค่าต่างๆ ใส่เครื่องหรือยัง
        //                checkApp { (check) -> Void in
        //            print(check)
        //            self.checkApp = check
        //        }
        // ลบตาราง
        //            let query = PFQuery(className: "Time_FK")
        //            query.fromLocalDatastore()
        //            query.limit = 1000
        //            query.findObjectsInBackgroundWithBlock { (object, error) -> Void in
        //                if error == nil{
        //                    if let objects = object{
        //                        for object in objects{
        //                            object.unpinInBackground()
        //                        }
        //                    }
        //                }else{
        //                    print(error)
        //                }
        //            }
        
        //เก็บค่า check ลงตาราง "Check"
        
        //        let checkQuery = PFQuery(className: "Check")
        //        checkQuery.fromLocalDatastore()
        //        checkQuery.whereKey("check", equalTo: "check")
        //        checkQuery.findObjectsInBackgroundWithBlock{(objects, error) -> Void in
        //            if error == nil
        //            {
        //                if let objects = objects
        //                {
        //                    print(objects.capacity)
        //                    if objects.capacity == 0{
        //                        let checkTable = PFObject(className: "Check")
        //                        checkTable["check"] = "check"
        //                        checkTable.pinInBackground()
        //
        //                    }else{
        //                        print("Check is here.")
        //                    }
        //
        //                }
        //            }
        //        }
        //
        //        checkPoint { (check) -> Void in
        //            self.checkPoint = check
        //        }
        //        print("check =  \(checkPoint)")
        //
        //        //เริ่มเก็บค่าต่างๆ ลง Local datastore
        //        if checkPoint == 0{
        //
        //        }
        
        
        
        //ใส่วันที่ลงแอป
        let today = NSDate()
        let todayFormatter = NSDateFormatter()
        todayFormatter.dateFormat = "dd-MM-yyyy"
        _ = todayFormatter.stringFromDate(today)
        let todayFormatterCheck = NSDateFormatter()
        todayFormatterCheck.dateFormat = "E"
        let todayCheckString = todayFormatterCheck.stringFromDate(today)
        _ = NSCalendar.currentCalendar().components(NSCalendarUnit.Month, fromDate: today)
        
        switch(todayCheckString){
        case "Mon" :
            mondayDate.text = adaptDateString(0+(count*7))
            tuesdayDate.text = adaptDateString(1+(count*7))
            wednesdayDate.text = adaptDateString(2+(count*7))
            thursdayDate.text = adaptDateString(3+(count*7))
            fridayDate.text = adaptDateString(4+(count*7))
        case "Tue" :
            mondayDate.text = adaptDateString(-1+(count*7))
            tuesdayDate.text = adaptDateString(0+(count*7))
            wednesdayDate.text = adaptDateString(+1+(count*7))
            thursdayDate.text = adaptDateString(2+(count*7))
            fridayDate.text = adaptDateString(3+(count*7))
        case "Wed" :
            mondayDate.text = adaptDateString(-2+(count*7))
            tuesdayDate.text = adaptDateString(-1+(count*7))
            wednesdayDate.text = adaptDateString(0+(count*7))
            thursdayDate.text = adaptDateString(1+(count*7))
            fridayDate.text = adaptDateString(2+(count*7))
        case "Thu" :
            mondayDate.text = adaptDateString(-3+(count*7))
            tuesdayDate.text = adaptDateString(-2+(count*7))
            wednesdayDate.text = adaptDateString(-1+(count*7))
            thursdayDate.text = adaptDateString(0+(count*7))
            fridayDate.text = adaptDateString(1+(count*7))
        case "Fri" :
            mondayDate.text = adaptDateString(-4+(count*7))
            tuesdayDate.text = adaptDateString(-3+(count*7))
            wednesdayDate.text = adaptDateString(-2+(count*7))
            thursdayDate.text = adaptDateString(-1+(count*7))
            fridayDate.text = adaptDateString(0+(count*7))
        case "Sat" :
            mondayDate.text = adaptDateString(-5+(count*7))
            tuesdayDate.text = adaptDateString(-4+(count*7))
            wednesdayDate.text = adaptDateString(-3+(count*7))
            thursdayDate.text = adaptDateString(-2+(count*7))
            fridayDate.text = adaptDateString(-1+(count*7))
        case "Sun" :
            mondayDate.text = adaptDateString(-6+(count*7))
            tuesdayDate.text = adaptDateString(-5+(count*7))
            wednesdayDate.text = adaptDateString(-4+(count*7))
            thursdayDate.text = adaptDateString(-3+(count*7))
            fridayDate.text = adaptDateString(-2+(count*7))
        default :
            print("Error")
        }
        
        
        
        
        
        
        //
        //        timeRetrive { (objectId, time) -> Void in
        //            print(objectId, time)
        //            let timeTable = PFObject(className: "Time_FK")
        //            timeTable.objectId = objectId
        //            timeTable["Time"] = time
        //            timeTable.pinInBackground()
        //        }
        //
        
        
    }//viewDidLoad เขียนถึงปีกกานี้
}


//        let query = PFQuery(className: "HT_Place")
//        query.fromLocalDatastore()
//        //query.whereKey("No_Place", equalTo: "1")
//        query.findObjectsInBackgroundWithBlock { (object, error) -> Void in
//            if  error == nil{
//                if let objects = object{
//                    print(objects[0]["No_place"])
//                    let place = String(objects[0]["No_place"])
//                    //let place = objects[0]["No_place"] as! String
//                    self.mondayClassMorning.setTitle(place, forState: .Normal)
//                }
//            }else{
//                print("error")
//            }
//        }




//คาบว่าง
//                let query = PFQuery(className: "HT_Place")
//                query.fromLocalDatastore()
//                query.whereKey("No_place", equalTo: 1)
//                query.findObjectsInBackgroundWithBlock { (object, error) -> Void in
//                    if  error == nil{
//                        if let objects = object{
//                            print(objects)
//                            let place = String(objects[0]["No_place"])
//                            self.mondayClassMorning.setTitle(place, forState: .Normal)
//                            if objects.capacity == 1{
//                                self.mondayClassMorning.backgroundColor = UIColor.redColor()
//                            }
//                        }
//                    }else{
//                        print("error")
//                    }
//      }

// func สำหรับวันเวลา
func adapt (value:Int) -> NSDate
{   let calendar = NSCalendar.currentCalendar()
    let today = NSDate()
    let result: NSDate = calendar.dateByAddingUnit(NSCalendarUnit.Day, value: value, toDate: today, options: [])!
    return result
}

func getdatetoString(date:NSDate) -> String{
    _ = NSDate()
    let dateFormat = NSDateFormatter()
    dateFormat.dateFormat = "dd-MM-yyyy"
    let dateString = dateFormat.stringFromDate(date)
    return dateString
}

func adaptDateString(value:Int) -> String{
    let date = adapt(value)
    let result = getdatetoString(date)
    return result
}

// func สำหรับระบุว่า วันไหนอยู่ใน week ไหนของตารางเรียน

func getStringtoDate(date:String)->NSDate{
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy"
    let result = dateFormatter.dateFromString(date)
    return result!
}

func getweekfromDate(date:NSDate)->String{
    let dateFormat = NSDateFormatter()
    dateFormat.dateFormat = "w-yy"
    let dateString = dateFormat.stringFromDate(date)
    return dateString
}

func getweek(date:String)->String{
    let NSDate = getStringtoDate(date)
    let result = getweekfromDate(NSDate)
    return result
}

///---------------เก็บค่าจาก parse ลง local------------------
//        termRetrive { (objectId, noTerm, term) -> Void in
//            print(objectId, noTerm, term)
//            let termTable = PFObject(className: "Term_FK")
//            termTable.objectId = objectId
//            termTable["No_term"] = noTerm
//            termTable["Term"] = term
//            termTable.pinInBackground()
//        }
//        timeRetrive { (objectId, time) -> Void in
//            print(objectId, time)
//            let timeTable = PFObject(className: "Time_FK")
//            timeTable.objectId = objectId
//            timeTable["Time"] = time
//            timeTable.pinInBackground()
//        }
//        subjectRetrive { (objectId, classId, info, subject, termId) -> Void in
//            print(objectId, classId, info, subject, termId)
//            let subTable = PFObject(className: "Subject")
//            subTable.objectId = objectId
//            subTable["Class"] = classId
//            subTable["Info"] = info
//            subTable["Subject"] = subject
//            subTable["Term"] = termId
//            subTable.pinInBackground()
//        }
//        placeRetrive { (objectId, noPlace, place) -> Void in
//            print(objectId, noPlace, place)
//            let placeTable = PFObject(className: "Place_FK")
//            placeTable.objectId = objectId
//            placeTable["No_place"] = noPlace
//            placeTable["Place_name"] = place
//            placeTable.pinInBackground()
//        }
//        userRetrive { (objectId, namelist, classId, email) -> Void in
//            print(objectId, namelist, classId, email)
//            let userTable = PFObject(className: "User")
//            userTable.objectId = objectId
//            userTable["namelist"] = namelist
//            userTable["class"] = classId
//            userTable["email"] = email
//            userTable.pinInBackground()
//        }
//        classRetrive { (objectId, classId, noClass) -> Void in
//            print(objectId, classId, noClass)
//            let classTable = PFObject(className: "Class_FK")
//            classTable.objectId = objectId
//            classTable["Class"] = classId
//            classTable["No_class"] = noClass
//            classTable.pinInBackground()
//        }
//        topicRetrive { (objectId, detail, subjectCodeId, topicName) -> Void in
//            print(objectId, detail, subjectCodeId, topicName)
//            let topic = PFObject(className: "Topic")
//            topic.objectId = objectId
//            topic["Detail"] = detail
//            topic["SubjectCode"] = subjectCodeId
//            topic["Topic_Name"] = topicName
//            topic.pinInBackground()
//        }
//        topicTeacherRetrive { (objectId, teacherId, topicScheduleId) -> Void in
//            print(objectId, teacherId, topicScheduleId)
//            let topicTeacher = PFObject(className: "Topic_Teacher")
//            topicTeacher.objectId = objectId
//            topicTeacher["Teacher"] = teacherId
//            topicTeacher["TopicScheduleID"] = topicScheduleId
//            topicTeacher.pinInBackground()
//        }
//------------------------------------------



func termRetrive (completion: (objectId:String,noTerm:Int,term:String) -> Void){
    var keepAlive = true
    let test:PFQuery = PFQuery(className: "Term_FK")
    test.limit = 1000
    test.findObjectsInBackgroundWithBlock{(objects, error) -> Void in
        
        if error == nil
        {
            
            if let objects = objects
            {
                for object in objects{
                    completion(objectId: object.objectId! as String, noTerm: object["No_term"] as! Int, term: object["Term"] as! String)
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

func subjectRetrive (completion: (objectId:String,classId:PFObject,info:String,subject:Int,termId:PFObject) -> Void){
    var keepAlive = true
    let test:PFQuery = PFQuery(className: "Subject")
    test.limit = 1000
    
    test.findObjectsInBackgroundWithBlock{(objects, error) -> Void in
        
        if error == nil
        {
            
            if let objects = objects
            {
                for object in objects{
                    completion(objectId: object.objectId! as String, classId: object["Class"] as! PFObject, info: object["Info"] as! String, subject: object["Subject"] as! Int, termId: object["Term"] as! PFObject)
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

func topicRetrive (completion: (objectId:String,detail:String,subjectCodeId:String,topicName:String) -> Void){
    var keepAlive = true
    let test:PFQuery = PFQuery(className: "Topic")
    test.limit = 1000
    test.findObjectsInBackgroundWithBlock{(objects, error) -> Void in
        
        if error == nil
        {
            
            if let objects = objects
            {
                for object in objects{
                    completion(objectId: object.objectId! as String, detail: object["Detail"] as! String, subjectCodeId: object["SubjectCode"].objectId!!, topicName: object["Topic_Name"] as! String)
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
func topicTeacherRetrive (completion: (objectId:String,teacherId:String,topicScheduleId:String) -> Void){
    var keepAlive = true
    let test:PFQuery = PFQuery(className: "Topic_Teacher")
    test.limit = 1000
    test.findObjectsInBackgroundWithBlock{(objects, error) -> Void in
        
        if error == nil
        {
            
            if let objects = objects
            {
                for object in objects{
                    completion(objectId: object.objectId! as String, teacherId: object["Teacher"].objectId!! , topicScheduleId: object["TopicScheduleID"].objectId!! )
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
func placeRetrive (completion: (objectId:String, noPlace:Int, place:String) -> Void){
    var keepAlive = true
    let test:PFQuery = PFQuery(className: "Place_FK")
    test.limit = 1000
    test.findObjectsInBackgroundWithBlock{(objects, error) -> Void in
        
        if error == nil
        {
            
            if let objects = objects
            {
                for object in objects{
                    completion(objectId: object.objectId! as String, noPlace: object["No_place"] as! Int, place: object["Place_name"] as! String)
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
func classRetrive (completion: (objectId:String, classId:String, noClass: Int) -> Void){
    var keepAlive = true
    let test:PFQuery = PFQuery(className: "Class_FK")
    test.limit = 1000
    test.findObjectsInBackgroundWithBlock{(objects, error) -> Void in
        
        if error == nil
        {
            
            if let objects = objects
            {
                for object in objects{
                    completion(objectId: object.objectId! as String, classId: object["Class"] as! String, noClass: object["No_class"] as! Int)
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

func topicScheduleRetrive (completion: (objectId:String,placeId:String,topicId:String,date:String,timeStartId:String,timeStopId:String,detail:String,tools:String) -> Void){
    var count = 0
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
                    print(count)
                    count += 1
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

func userRetrive (completion: (objectId:String,namelist:String,classId:String,email:String) -> Void){
    var keepAlive = true
    let test:PFQuery = PFUser.query()!
    test.limit = 1000
    test.findObjectsInBackgroundWithBlock{(objects, error) -> Void in
        
        if error == nil
        {
            
            if let objects = objects
            {
                print(objects.capacity)
                for object in objects{
                    completion(objectId: object.objectId! as String, namelist: object["namelist"] as! String, classId: object["class"].objectId!!, email: object["email"] as! String)
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


//func ดูว่าเป็นคาบเช้าหรือบ่าย

func morningOrAfternoon(timeStart:String,timeStop:String)->(String){
    var result = String()
    
    switch timeStart {
    case "8.00","9.00","10.00","11.00":
        print("morning")
        result = "morning"
    case "13.00","14.00","15.00":
        print("haha")
        result = "afternoon"
    case "18.00","19.00","20.00","21.00":
        print("night")
        result = "night"
    default:
        print("error")
    }
    return (result)
}

func timeFromTimeFK(completion: (time:String) -> Void){
    var keepAlive = true
    let test:PFQuery = PFQuery(className: "HT_Time_FK")
    test.fromLocalDatastore()
    test.limit = 1000
    test.whereKey("objectId", equalTo: "MDD7fWwAd0")
    test.findObjectsInBackgroundWithBlock{(objects, error) -> Void in
        
        if error == nil
        {
            
            if let objects = objects
            {
                print(objects.capacity)
                for object in objects{
                    completion(time: object["Time"] as! String)
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

func timeConvert(time:String)->String{
    
    switch time{
    case "9.00","10.00","11.00":
        return "M"
    case "13.00","14.00","15.00":
        return "A"
    case "18.00","19.00","20.00","21.00":
        return "n"
    default:
        return "error"
        
    }
    
}

/*func toLocal(completion: ()->String{
let subject = PFQuery(className: "Topic_Schedule")
subject.fromLocalDatastore()
subject.whereKey("Date", containedIn: day)
subject.findObjectsInBackgroundWithBlock { (object, error) -> Void in
if error == nil{
if let objects = object{
print(objects.capacity)
for object in objects{
//print(object)
//เปิดเวลา และ topicId
let timeStart = object["Time_start"] as AnyObject

let timeStop = object["Time_stop"] as! String
let topicId = object["TopicID"]
let date = object["Date"]
//print(timeStart,timeStop,topicId)
print("TimeStart = \(timeStart),TimeStop = \(timeStop)")
let timeQuery = PFQuery(className: "Time_FK")
timeQuery.fromLocalDatastore()
//timeQuery.whereKey("objectId", equalTo: timeStop)
timeQuery.findObjectsInBackgroundWithBlock({ (object, error) -> Void in
if error == nil{
if let objects = object{
//print(objects.capacity)
for object in objects{
if (timeStart as! String as String) as String == object["objectId"] as! String{

//อยู่คาบเช้า
let period = timeConvert(object["Time"] as! String)
//let endPeriod = timeConvert()

let topic = PFQuery(className: "Topic")
topic.fromLocalDatastore()
//topic.whereKey("objectId", equalTo: topicId)
topic.findObjectsInBackgroundWithBlock({ (object, error) -> Void in
if error == nil{
if let objects = object{
print(objects.capacity)
for object in objects{
if object["objectId"] as! String == topicId as! String{
let topicName = object["Topic_Name"]

let subjectCode = object["SubjectCode"]
let subjectQuery = PFQuery(className: "Subject")
subjectQuery.fromLocalDatastore()
subjectQuery.findObjectsInBackgroundWithBlock({ (object, error) -> Void in
if error == nil{
if let objects = object{
for object in objects{
if subjectCode as! String == object["objectId"] as! String{
let classId = object["Class"] as! String
var theirClass = String()
switch classId{
case "Jdr0Rowr8p":
theirClass = "m.6"
case "exv130NBiY":
theirClass = "m.5"
case "wleD05apD3":
theirClass = "m.4"
default:
print("error in classId switch case.")
}
print("\(topicName) in (\(date)) is \(period) =  \(object["objectId"])   \(theirClass)")

}
}
}
}else{
print(error)
}
})
}

}
}
}
})

}
}
}
}else{
print(error)
}
})
}
}
}else{
print(error)
}
}

}*/


func subjectThisWeek (week:[String],completion: (objectId:String,date:String,timeStartId:String,timeStopId:String,topicId:String) -> Void){
    var keepAlive = true
    let test:PFQuery = PFQuery(className: "HT_Topic_Schedule")
    test.fromLocalDatastore()
    test.limit = 1000
    test.whereKey("Date", containedIn: week)
    test.findObjectsInBackgroundWithBlock{(objects, error) -> Void in
        
        if error == nil
        {
            
            if let objects = objects
            {
                // print(objects.capacity)
                // print(objects)
                for object in objects{
                    completion(objectId:object["objectId"] as! String ,date:object["Date"] as! String,timeStartId:object["Time_start"] as! String,timeStopId:object["Time_stop"] as! String,topicId: object["TopicID"] as! String)
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

func timeConvert (timeId:String,completion:(time:String) -> Void){
    var keepAlive = true
    let test:PFQuery = PFQuery(className: "HT_Time_FK")
    test.fromLocalDatastore()
    test.limit = 1000
    // test.whereKey("objectId", equalTo: timeId)
    test.findObjectsInBackgroundWithBlock{(objects, error) -> Void in
        
        if error == nil
        {
            
            if let objects = objects
            {
                // print(objects.capacity)
                //print(objects)
                for object in objects{
                    if object["objectId"] as! String == timeId as String{
                        completion(time: object["Time"] as! String)
                    }
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

func timeToPeriod(time:String)->String{
    switch time{
    case "9.00","10.00","11.00":
        return "Morning"
    case "13.00","14.00","15.00":
        return "Afternoon"
    case "18.00","19.00","20.00","21.00":
        return "Night"
    default:
        return "Default in timeToPeriod"
    }
}

func topicLocal (topicId:String,completion:(subjectCode:String,topicName:String) -> Void){
    var keepAlive = true
    let test:PFQuery = PFQuery(className: "HT_Topic")
    test.fromLocalDatastore()
    test.limit = 1000
    // test.whereKey("objectId", equalTo: timeId)
    test.findObjectsInBackgroundWithBlock{(objects, error) -> Void in
        
        if error == nil
        {
            
            if let objects = objects
            {
                print(objects.capacity)
                print(objects)
                for object in objects{
                    if object["objectId"] as! String == topicId as String{
                        completion(subjectCode: object["SubjectCode"] as! String, topicName: object["Topic_Name"] as! String)
                    }
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

func subjectCodeToGrade (subjectCodeId:String,completion:(grade:String) -> Void){
    var keepAlive = true
    let test:PFQuery = PFQuery(className: "HT_Subject")
    test.fromLocalDatastore()
    test.limit = 1000
    // test.whereKey("objectId", equalTo: timeId)
    test.findObjectsInBackgroundWithBlock{(objects, error) -> Void in
        
        if error == nil
        {
            
            if let objects = objects
            {
                print(objects.capacity)
                print(objects)
                for object in objects{
                    if object["objectId"] as! String == subjectCodeId as String{
                        let classId = object["Class"] as! String
                        let query = PFQuery(className: "HT_Class_FK")
                        query.fromLocalDatastore()
                        query.findObjectsInBackgroundWithBlock({ (object, error) -> Void in
                            if error == nil{
                                if let objects = object{
                                    for object in objects{
                                        if object["objectId"] as! String == classId{
                                            completion(grade: object["Class"] as! String)
                                        }
                                    }
                                }
                            }else{
                                print(error)
                            }
                        })
                        
                    }
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

func teacherFromTopicId (objectId:String,completion:(teacher:String) -> Void){
    var keepAlive = true
    let test:PFQuery = PFQuery(className: "HT_Topic_Teacher")
    test.fromLocalDatastore()
    test.limit = 1000
    // test.whereKey("objectId", equalTo: timeId)
    test.findObjectsInBackgroundWithBlock{(objects, error) -> Void in
        
        if error == nil
        {
            
            if let objects = objects
            {
                print(objects.capacity)
                print(objects)
                for object in objects{
                    if object["TopicScheduleID"] as! String == objectId as String{
                        let teacherId = object["Teacher"] as! String
                        let query = PFQuery(className: "User")
                        query.fromLocalDatastore()
                        query.findObjectsInBackgroundWithBlock({ (object, error) -> Void in
                            if error == nil{
                                if let objects = object{
                                    for object in objects{
                                        if object["objectId"] as! String == teacherId{
                                            completion(teacher: object["namelist"] as! String)
                                        }
                                    }
                                }
                            }else{
                                print(error)
                            }
                        })
                        
                    }
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

func timeConvertNew(timeId:String)->String{
    var result = String()
    timeConvert(timeId) { (time) -> Void in
        result = time
    }
    return result
}


func clearButton(button:UIButton)->Void{
    button.setTitle("        ", forState: .Normal)
}



