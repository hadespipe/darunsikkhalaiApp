//
//  threeView.swift
//  DarunsikkhalaiTimeTableApp
//
//  Created by jarukit boonkerd on 2/7/2559 BE.
//  Copyright © 2559 Hades corp. All rights reserved.
//

import UIKit
import Parse
class threeMView: UIViewController{
    
    @IBAction func nextSwipe(sender: UISwipeGestureRecognizer) {
        mondayDate.backgroundColor = UIColor.orangeColor()
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
                                                                                                                            //let teacherName = object["namelist"]
                                                                                                                            
                                                                                                                            //M.6
                                                                                                                            if self.mondayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                                                                self.mondayClassMorningM6.setTitle(topicName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.mondayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                                                                self.mondayClassAfternoonM6.setTitle(topicName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.tuesdayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                                                                self.tuesdayClassMorningM6.setTitle(topicName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.tuesdayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                                                                self.tuesdayClassAfternoonM6.setTitle(topicName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.wednesdayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                                                                self.wednesdayClassMorningM6.setTitle(topicName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.wednesdayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                                                                self.wednesdayClassAfternoonM6.setTitle(topicName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.thursdayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                                                                self.thursdayClassMorningM6.setTitle(topicName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.thursdayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                                                                self.thursdayClassAfternoonM6.setTitle(topicName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.fridayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                                                                self.fridayClassMorningM6.setTitle(topicName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.fridayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                                                                self.fridayClassAfternoonM6.setTitle(topicName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                                
                                                                                                                                //M.5
                                                                                                                            else if self.mondayDate.text! == date as! String && theirClass == "m.5" && period == "M"{
                                                                                                                                self.mondayClassMorningM5.setTitle(topicName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.mondayDate.text! == date as! String && theirClass == "m.5" && period == "A"{
                                                                                                                                self.mondayClassAfternoonM5.setTitle(topicName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.tuesdayDate.text! == date as! String && theirClass == "m.5" && period == "M"{
                                                                                                                                self.tuesdayClassMorningM5.setTitle(topicName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.tuesdayDate.text! == date as! String && theirClass == "m.5" && period == "A"{
                                                                                                                                self.tuesdayClassAfternoonM5.setTitle(topicName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.wednesdayDate.text! == date as! String && theirClass == "m.5" && period == "M"{
                                                                                                                                self.wednesdayClassMorningM5.setTitle(topicName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.wednesdayDate.text! == date as! String && theirClass == "m.5" && period == "A"{
                                                                                                                                self.wednesdayClassAfternoonM5.setTitle(topicName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.thursdayDate.text! == date as! String && theirClass == "m.5" && period == "M"{
                                                                                                                                self.thursdayClassMorningM5.setTitle(topicName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.thursdayDate.text! == date as! String && theirClass == "m.5" && period == "A"{
                                                                                                                                self.thursdayClassAfternoonM5.setTitle(topicName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.fridayDate.text! == date as! String && theirClass == "m.5" && period == "M"{
                                                                                                                                self.fridayClassMorningM5.setTitle(topicName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.fridayDate.text! == date as! String && theirClass == "m.5" && period == "A"{
                                                                                                                                self.fridayClassAfternoonM5.setTitle(topicName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                                
                                                                                                                                //M.4
                                                                                                                            else if self.mondayDate.text! == date as! String && theirClass == "m.4" && period == "M"{
                                                                                                                                self.mondayClassMorningM4.setTitle(topicName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.mondayDate.text! == date as! String && theirClass == "m.4" && period == "A"{
                                                                                                                                self.mondayClassAfternoonM4.setTitle(topicName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.tuesdayDate.text! == date as! String && theirClass == "m.4" && period == "M"{
                                                                                                                                self.tuesdayClassMorningM4.setTitle(topicName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.tuesdayDate.text! == date as! String && theirClass == "m.4" && period == "A"{
                                                                                                                                self.tuesdayClassAfternoonM4.setTitle(topicName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.wednesdayDate.text! == date as! String && theirClass == "m.4" && period == "M"{
                                                                                                                                self.wednesdayClassMorningM4.setTitle(topicName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.wednesdayDate.text! == date as! String && theirClass == "m.4" && period == "A"{
                                                                                                                                self.wednesdayClassAfternoonM4.setTitle(topicName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.thursdayDate.text! == date as! String && theirClass == "m.4" && period == "M"{
                                                                                                                                self.thursdayClassMorningM4.setTitle(topicName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.thursdayDate.text! == date as! String && theirClass == "m.4" && period == "A"{
                                                                                                                                self.thursdayClassAfternoonM4.setTitle(topicName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.fridayDate.text! == date as! String && theirClass == "m.4" && period == "M"{
                                                                                                                                self.fridayClassMorningM4.setTitle(topicName as? String, forState: .Normal)
                                                                                                                            }
                                                                                                                            else if self.fridayDate.text! == date as! String && theirClass == "m.4" && period == "A"{
                                                                                                                                self.fridayClassAfternoonM4.setTitle(topicName as? String, forState: .Normal)
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
                        //let subjectObjectId = object["objectId"]
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
                                                                                    //M.6
                                                                                    if self.mondayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                        self.mondayClassMorningM6.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.mondayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                        self.mondayClassAfternoonM6.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.tuesdayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                        self.tuesdayClassMorningM6.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.tuesdayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                        self.tuesdayClassAfternoonM6.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.wednesdayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                        self.wednesdayClassMorningM6.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.wednesdayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                        self.wednesdayClassAfternoonM6.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.thursdayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                        self.thursdayClassMorningM6.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.thursdayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                        self.thursdayClassAfternoonM6.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.fridayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                        self.fridayClassMorningM6.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.fridayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                        self.fridayClassAfternoonM6.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                        
                                                                                        //M.5
                                                                                    else if self.mondayDate.text! == date as! String && theirClass == "m.5" && period == "M"{
                                                                                        self.mondayClassMorningM5.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.mondayDate.text! == date as! String && theirClass == "m.5" && period == "A"{
                                                                                        self.mondayClassAfternoonM5.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.tuesdayDate.text! == date as! String && theirClass == "m.5" && period == "M"{
                                                                                        self.tuesdayClassMorningM5.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.tuesdayDate.text! == date as! String && theirClass == "m.5" && period == "A"{
                                                                                        self.tuesdayClassAfternoonM5.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.wednesdayDate.text! == date as! String && theirClass == "m.5" && period == "M"{
                                                                                        self.wednesdayClassMorningM5.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.wednesdayDate.text! == date as! String && theirClass == "m.5" && period == "A"{
                                                                                        self.wednesdayClassAfternoonM5.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.thursdayDate.text! == date as! String && theirClass == "m.5" && period == "M"{
                                                                                        self.thursdayClassMorningM5.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.thursdayDate.text! == date as! String && theirClass == "m.5" && period == "A"{
                                                                                        self.thursdayClassAfternoonM5.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.fridayDate.text! == date as! String && theirClass == "m.5" && period == "M"{
                                                                                        self.fridayClassMorningM5.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.fridayDate.text! == date as! String && theirClass == "m.5" && period == "A"{
                                                                                        self.fridayClassAfternoonM5.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                        
                                                                                        //M.4
                                                                                    else if self.mondayDate.text! == date as! String && theirClass == "m.4" && period == "M"{
                                                                                        self.mondayClassMorningM4.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.mondayDate.text! == date as! String && theirClass == "m.4" && period == "A"{
                                                                                        self.mondayClassAfternoonM4.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.tuesdayDate.text! == date as! String && theirClass == "m.4" && period == "M"{
                                                                                        self.tuesdayClassMorningM4.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.tuesdayDate.text! == date as! String && theirClass == "m.4" && period == "A"{
                                                                                        self.tuesdayClassAfternoonM4.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.wednesdayDate.text! == date as! String && theirClass == "m.4" && period == "M"{
                                                                                        self.wednesdayClassMorningM4.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.wednesdayDate.text! == date as! String && theirClass == "m.4" && period == "A"{
                                                                                        self.wednesdayClassAfternoonM4.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.thursdayDate.text! == date as! String && theirClass == "m.4" && period == "M"{
                                                                                        self.thursdayClassMorningM4.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.thursdayDate.text! == date as! String && theirClass == "m.4" && period == "A"{
                                                                                        self.thursdayClassAfternoonM4.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.fridayDate.text! == date as! String && theirClass == "m.4" && period == "M"{
                                                                                        self.fridayClassMorningM4.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.fridayDate.text! == date as! String && theirClass == "m.4" && period == "A"{
                                                                                        self.fridayClassAfternoonM4.setTitle(topicName as? String, forState: .Normal)
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
    // คาบเช้าม.4
    @IBOutlet var mondayClassMorningM4: UIButton!
    @IBOutlet var tuesdayClassMorningM4: UIButton!
    @IBOutlet var wednesdayClassMorningM4: UIButton!
    @IBOutlet var thursdayClassMorningM4: UIButton!
    @IBOutlet var fridayClassMorningM4: UIButton!
    // คาบบ่ายม.4
    @IBOutlet var mondayClassAfternoonM4: UIButton!
    @IBOutlet var tuesdayClassAfternoonM4: UIButton!
    @IBOutlet var wednesdayClassAfternoonM4: UIButton!
    @IBOutlet var thursdayClassAfternoonM4: UIButton!
    @IBOutlet var fridayClassAfternoonM4: UIButton!
    // คาบเช้าม.5
    @IBOutlet var mondayClassMorningM5: UIButton!
    @IBOutlet var tuesdayClassMorningM5: UIButton!
    @IBOutlet var wednesdayClassMorningM5: UIButton!
    @IBOutlet var thursdayClassMorningM5: UIButton!
    @IBOutlet var fridayClassMorningM5: UIButton!
    // คาบบ่ายม.5
    @IBOutlet var mondayClassAfternoonM5: UIButton!
    @IBOutlet var tuesdayClassAfternoonM5: UIButton!
    @IBOutlet var wednesdayClassAfternoonM5: UIButton!
    @IBOutlet var thursdayClassAfternoonM5: UIButton!
    @IBOutlet var fridayClassAfternoonM5: UIButton!
    // คาบเช้าม.6
    @IBOutlet var mondayClassMorningM6: UIButton!
    @IBOutlet var tuesdayClassMorningM6: UIButton!
    @IBOutlet var wednesdayClassMorningM6: UIButton!
    @IBOutlet var thursdayClassMorningM6: UIButton!
    @IBOutlet var fridayClassMorningM6: UIButton!
    // คาบบ่ายม.6
    @IBOutlet var mondayClassAfternoonM6: UIButton!
    @IBOutlet var tuesdayClassAfternoonM6: UIButton!
    @IBOutlet var wednesdayClassAfternoonM6: UIButton!
    @IBOutlet var thursdayClassAfternoonM6: UIButton!
    @IBOutlet var fridayClassAfternoonM6: UIButton!
    
    
    
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
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        let day:[String] = [mondayDate.text!,tuesdayDate.text!,wednesdayDate.text!,thursdayDate.text!,fridayDate.text!]
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
                  //      let subjectObjectId = object["objectId"]
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
                                                                                    //M.6
                                                                                    if self.mondayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                        self.mondayClassMorningM6.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.mondayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                        self.mondayClassAfternoonM6.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.tuesdayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                        self.tuesdayClassMorningM6.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.tuesdayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                        self.tuesdayClassAfternoonM6.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.wednesdayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                        self.wednesdayClassMorningM6.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.wednesdayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                        self.wednesdayClassAfternoonM6.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.thursdayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                        self.thursdayClassMorningM6.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.thursdayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                        self.thursdayClassAfternoonM6.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.fridayDate.text! == date as! String && theirClass == "m.6" && period == "M"{
                                                                                        self.fridayClassMorningM6.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.fridayDate.text! == date as! String && theirClass == "m.6" && period == "A"{
                                                                                        self.fridayClassAfternoonM6.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                        
                                                                                        //M.5
                                                                                    else if self.mondayDate.text! == date as! String && theirClass == "m.5" && period == "M"{
                                                                                        self.mondayClassMorningM5.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.mondayDate.text! == date as! String && theirClass == "m.5" && period == "A"{
                                                                                        self.mondayClassAfternoonM5.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.tuesdayDate.text! == date as! String && theirClass == "m.5" && period == "M"{
                                                                                        self.tuesdayClassMorningM5.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.tuesdayDate.text! == date as! String && theirClass == "m.5" && period == "A"{
                                                                                        self.tuesdayClassAfternoonM5.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.wednesdayDate.text! == date as! String && theirClass == "m.5" && period == "M"{
                                                                                        self.wednesdayClassMorningM5.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.wednesdayDate.text! == date as! String && theirClass == "m.5" && period == "A"{
                                                                                        self.wednesdayClassAfternoonM5.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.thursdayDate.text! == date as! String && theirClass == "m.5" && period == "M"{
                                                                                        self.thursdayClassMorningM5.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.thursdayDate.text! == date as! String && theirClass == "m.5" && period == "A"{
                                                                                        self.thursdayClassAfternoonM5.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.fridayDate.text! == date as! String && theirClass == "m.5" && period == "M"{
                                                                                        self.fridayClassMorningM5.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.fridayDate.text! == date as! String && theirClass == "m.5" && period == "A"{
                                                                                        self.fridayClassAfternoonM5.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                        
                                                                                        //M.4
                                                                                    else if self.mondayDate.text! == date as! String && theirClass == "m.4" && period == "M"{
                                                                                        self.mondayClassMorningM4.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.mondayDate.text! == date as! String && theirClass == "m.4" && period == "A"{
                                                                                        self.mondayClassAfternoonM4.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.tuesdayDate.text! == date as! String && theirClass == "m.4" && period == "M"{
                                                                                        self.tuesdayClassMorningM4.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.tuesdayDate.text! == date as! String && theirClass == "m.4" && period == "A"{
                                                                                        self.tuesdayClassAfternoonM4.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.wednesdayDate.text! == date as! String && theirClass == "m.4" && period == "M"{
                                                                                        self.wednesdayClassMorningM4.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.wednesdayDate.text! == date as! String && theirClass == "m.4" && period == "A"{
                                                                                        self.wednesdayClassAfternoonM4.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.thursdayDate.text! == date as! String && theirClass == "m.4" && period == "M"{
                                                                                        self.thursdayClassMorningM4.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.thursdayDate.text! == date as! String && theirClass == "m.4" && period == "A"{
                                                                                        self.thursdayClassAfternoonM4.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.fridayDate.text! == date as! String && theirClass == "m.4" && period == "M"{
                                                                                        self.fridayClassMorningM4.setTitle(topicName as? String, forState: .Normal)
                                                                                    }
                                                                                    else if self.fridayDate.text! == date as! String && theirClass == "m.4" && period == "A"{
                                                                                        self.fridayClassAfternoonM4.setTitle(topicName as? String, forState: .Normal)
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
    
    
}


func haha()->Void{
    
   
}
