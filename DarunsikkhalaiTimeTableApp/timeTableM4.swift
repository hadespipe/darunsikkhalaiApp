//
//  timeTableM4.swift
//  DarunsikkhalaiTimeTableApp
//
//  Created by jarukit boonkerd on 2/22/2559 BE.
//  Copyright © 2559 Hades corp. All rights reserved.
//

import UIKit
import Parse

class timeTableM4: UIViewController {
    
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
        print(mondayDate.text)
        print(day)
        //การเปิดตารางเรียน
        //โชว์คาบ
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
                        let subjectObjectId = object["objectId"]
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
                                                                                    let teacher = PFQuery(className: "Topic_Teacher")
                                                                                    teacher.fromLocalDatastore()
                                                                                    teacher.findObjectsInBackgroundWithBlock { (object, error) -> Void in
                                                                                        if error == nil{
                                                                                            if let objects = object{
                                                                                                for object in objects{
                                                                                                    if object["TopicScheduleID"] as! String == subjectObjectId as! String{
                                                                                                        let teacherId = object["Teacher"]
                                                                                                        let teacherUser = PFQuery(className: "User")
                                                                                                        teacherUser.fromLocalDatastore()
                                                                                                        teacherUser.findObjectsInBackgroundWithBlock { (object, error) -> Void in
                                                                                                            if error == nil{
                                                                                                                if let objects = object{
                                                                                                                    for object in objects{
                                                                                                                        if object["objectId"] as! String == teacherId as! String{
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
                        let subjectObjectId = object["objectId"]
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
                                                                                    let teacher = PFQuery(className: "Topic_Teacher")
                                                                                    teacher.fromLocalDatastore()
                                                                                    teacher.findObjectsInBackgroundWithBlock { (object, error) -> Void in
                                                                                        if error == nil{
                                                                                            if let objects = object{
                                                                                                for object in objects{
                                                                                                    if object["TopicScheduleID"] as! String == subjectObjectId as! String{
                                                                                                        let teacherId = object["Teacher"]
                                                                                                        let teacherUser = PFQuery(className: "User")
                                                                                                        teacherUser.fromLocalDatastore()
                                                                                                        teacherUser.findObjectsInBackgroundWithBlock { (object, error) -> Void in
                                                                                                            if error == nil{
                                                                                                                if let objects = object{
                                                                                                                    for object in objects{
                                                                                                                        if object["objectId"] as! String == teacherId as! String{
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
    override func viewWillAppear(animated: Bool) {
        //        let user = PFUser.currentUser()
        //        print(user)
        super.viewWillAppear(true)
        
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
                        let subjectObjectId = object["objectId"]
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
                                                                                    let teacher = PFQuery(className: "Topic_Teacher")
                                                                                    teacher.fromLocalDatastore()
                                                                                    teacher.findObjectsInBackgroundWithBlock { (object, error) -> Void in
                                                                                        if error == nil{
                                                                                            if let objects = object{
                                                                                                for object in objects{
                                                                                                    if object["TopicScheduleID"] as! String == subjectObjectId as! String{
                                                                                                        let teacherId = object["Teacher"]
                                                                                                        let teacherUser = PFQuery(className: "User")
                                                                                                        teacherUser.fromLocalDatastore()
                                                                                                        teacherUser.findObjectsInBackgroundWithBlock { (object, error) -> Void in
                                                                                                            if error == nil{
                                                                                                                if let objects = object{
                                                                                                                    for object in objects{
                                                                                                                        if object["objectId"] as! String == teacherId as! String{
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
