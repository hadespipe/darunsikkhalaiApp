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

    }
  
    
    var subjectTest = String()
    
        


    
    
    func test (completion: (classid:String, info:String) -> Void){
        var keepAlive = true
        let test:PFQuery = PFQuery(className: "Subject")
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
    
    
    func checkApp (completion: (check:String) -> Void){
        var keepAlive = true
        let test:PFQuery = PFQuery(className: "check")
        test.whereKey("check", equalTo: "check")
        test.findObjectsInBackgroundWithBlock{(objects, error) -> Void in
            if error == nil
            {
                if let objects = objects
                {
                    for object in objects{
                        //  print(object[""])
                        completion(check: object["check"] as! String)
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
    
    func checkPoint (completion: (check:Int) -> Void){
        var keepAlive = true
        let test:PFQuery = PFQuery(className: "Check")
        test.fromLocalDatastore()
        test.whereKey("check", equalTo: "check")
        test.findObjectsInBackgroundWithBlock{(objects, error) -> Void in
            if error == nil
            {
                if let objects = objects
                {
                    completion(check: objects.capacity)
                    keepAlive = false
                    
                }
            }
        }
        
        let runLoop = NSRunLoop.currentRunLoop()
        while keepAlive && runLoop.runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceNow: 0.1)) {
            print("x")
        }
    }
    func checkLocal(classname:String)->Void{
        let query = PFQuery(className: classname)
        query.limit = 1000
        query.fromLocalDatastore()
        query.findObjectsInBackgroundWithBlock { (object, error) -> Void in
            if error == nil{
                if let objects = object{
                    print("object capa is \(objects.capacity)")
                    for object in objects{
                        print(object)
                    }
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
        // สำหรับการเช็คว่า เราเคยเก็บค่าต่างๆ ใส่เครื่องหรือยัง
//                checkApp { (check) -> Void in
//            print(check)
//            self.checkApp = check
//        }
     
        
        

//            let query = PFQuery(className: "Topic_Schedule")
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
        //ไว้เก็บตาราง topic_techer
//        topicTeacherRetrive { (objectId, teacherId, topicScheduleId) -> Void in
//            print(objectId, teacherId, topicScheduleId)
//            let topicTeacher = PFObject(className: "Topic_Teacher")
//            topicTeacher["objectId"] = objectId
//            topicTeacher["Teacher"] = teacherId
//            topicTeacher["TopicScheduleID"] = topicScheduleId
//            topicTeacher.pinInBackground()
//        }
        
        
        
        

        
        
        
        
        
       
//        testQuery { (result) -> Void in
//            print(result)
//            self.subjectTest = result
//            self.array.append(result)
//            
//        }
//        print("a")
//        print(subjectTest)
//        print(array)
        
//        let subTest = PFObject(className: "subTest")
//        subTest["info"] = array
//        subTest.pinInBackground()
//        
//        let query = PFQuery(className: "subTest")
//        query.fromLocalDatastore()
//        query.findObjectsInBackgroundWithBlock { (object, error) -> Void in
//            if error == nil{
//                if let objects = object{
//                    print(objects)
//                }
//            }else{
//                print(error)
//            }
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
//            termTable["objectId"] = objectId
//            termTable["No_term"] = noTerm
//            termTable["Term"] = term
//            termTable.pinInBackground()
//        }
//        timeRetrive { (objectId, time) -> Void in
//            print(objectId, time)
//            let timeTable = PFObject(className: "Time_FK")
//            timeTable["objectId"] = objectId
//            timeTable["Time"] = time
//            timeTable.pinInBackground()
//        }
//        subjectRetrive { (objectId, classId, info, subject, termId) -> Void in
//            print(objectId, classId, info, subject, termId)
//            let subTable = PFObject(className: "Subject")
//            subTable["objectId"] = objectId
//            subTable["Class"] = classId
//            subTable["Info"] = info
//            subTable["Subject"] = subject
//            subTable["Term"] = termId
//            subTable.pinInBackground()
//        }
//        placeRetrive { (objectId, noPlace, place) -> Void in
//            print(objectId, noPlace, place)
//            let placeTable = PFObject(className: "Place_FK")
//            placeTable["objectId"] = objectId
//            placeTable["No_place"] = noPlace
//            placeTable["Place_name"] = place
//            placeTable.pinInBackground()
//        }
//        userRetrive { (objectId, namelist, classId, email) -> Void in
//            print(objectId, namelist, classId, email)
//            let userTable = PFObject(className: "User")
//            userTable["objectId"] = objectId
//            userTable["namelist"] = namelist
//            userTable["class"] = classId
//            userTable["email"] = email
//            userTable.pinInBackground()
//        }
//        classRetrive { (objectId, classId, noClass) -> Void in
//            print(objectId, classId, noClass)
//            let classTable = PFObject(className: "Class_FK")
//            classTable["objectId"] = objectId
//            classTable["Class"] = classId
//            classTable["No_class"] = noClass
//            classTable.pinInBackground()
//        }
//        topicRetrive { (objectId, detail, subjectCodeId, topicName) -> Void in
//            print(objectId, detail, subjectCodeId, topicName)
//            let topic = PFObject(className: "Topic")
//            topic["objectId"] = objectId
//            topic["Detail"] = detail
//            topic["SubjectCode"] = subjectCodeId
//            topic["Topic_Name"] = topicName
//            topic.pinInBackground()
//        }
//------------------------------------------
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
                    completion(objectId: object.objectId!, time: object["Time"] as! String)
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
                    completion(objectId: object.objectId!, noTerm: object["No_term"] as! Int, term: object["Term"] as! String)
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

func subjectRetrive (completion: (objectId:String,classId:String,info:String,subject:Int,termId:String) -> Void){
    var keepAlive = true
    let test:PFQuery = PFQuery(className: "Subject")
    test.limit = 1000
    test.findObjectsInBackgroundWithBlock{(objects, error) -> Void in
        
        if error == nil
        {
            
            if let objects = objects
            {
                for object in objects{
                    completion(objectId: object.objectId!, classId: object["Class"].objectId!!, info: object["Info"] as! String, subject: object["Subject"] as! Int, termId: object["Term"].objectId!!)
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
                    completion(objectId: object.objectId!, detail: object["Detail"] as! String, subjectCodeId: object["SubjectCode"].objectId!!, topicName: object["Topic_Name"] as! String)
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
                    completion(objectId: object.objectId!, teacherId: object["Teacher"].objectId!! , topicScheduleId: object["TopicScheduleID"].objectId!! )
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
                    completion(objectId: object.objectId!, noPlace: object["No_place"] as! Int, place: object["Place_name"] as! String)
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
                    completion(objectId: object.objectId!, classId: object["Class"] as! String, noClass: object["No_class"] as! Int)
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
                    completion(objectId: object.objectId!, placeId: object["Place"].objectId!!, topicId: object["TopicID"].objectId!!, date: object["Date"] as! String, timeStartId: object["Time_start"].objectId!!, timeStopId: object["Time_stop"].objectId!!, detail: object["Detail"] as! String, tools: object["Tools"] as! String
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
                    completion(objectId: object.objectId!, namelist: object["namelist"] as! String, classId: object["class"].objectId!!, email: object["email"] as! String)
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

