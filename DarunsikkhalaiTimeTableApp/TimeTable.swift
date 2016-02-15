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
    
    func topicSchedule(completion: (result: String,result2: String) -> Void){
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
                        completion(result: object["Info"] as! String, result2: object.objectId! as String)
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
    override func viewDidLoad() {  // <-- func นี้สำหรับ code ที่ต้องการให้ run เมื่อเปิดหน้านี้

        super.viewDidLoad()
      
        test { (classid, info) -> Void in
            let test = PFObject(className: "Test")
            let query = PFQuery(className: "Test")
            
            query.fromLocalDatastore()
            query.findObjectsInBackgroundWithBlock({ (object, error) -> Void in
                if error == nil{
                    if let objects = object{
                        for key in objects{
                            var i = 0
                            if key["Class"] as! String != classid {
                                test["Class"] = classid
                                test["Contain"][0] = info
                            }else{
                                
                            }
                        }
                    }
                }else{
                    print(error)
                }
            })
           
        }
        
        
        
        
        
       
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
        
       //เช็ควันที่ใน week นั้น
        //var todayDate = NSDate()
        //var thisWeek = getweekfromDate(todayDate) //ตัวแปรที่บอกค่า week ในรูปของ string ("W-yy")
       // เริ่มจากหาว่าอาทิตย์นี้มีวันอะไรบ้าง
      
        
       //เช็ค local datastore
        //Local week
//        let queryLocalWeek = PFQuery(className: "HT_Timestart")
//        queryLocalWeek.fromLocalDatastore()
//        queryLocalWeek.findObjectsInBackgroundWithBlock { (object, error) -> Void in
//            if error == nil{
//                if let objects = object{
//                    print("success 1")
//                    print(object)
//                    for subject in objects{
//                        print(subject)
//                        print("success 2")
//                    }
//                }
//            }else{
//                print(error)
//            }
//        }
        //HT_Timestart
        
        //HT_Timestop
        
        //HT_Place
        
        //HT_Topic_Subject_Class_Term
        
        //HT_Teacher
        
        
    
        
      /*
        
       //ดึงข้อมูลจาก parse ใน class Topic_Schedule ลงมา
       let query = PFQuery(className: "Topic_Schedule")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in // ดึงข้อมูลจาก parse ถ้ามี error ก็ print
            if error == nil{
                if let object = objects{
                    for object in object{
                        //print(object)
                        print(object.objectId)  //Optional String
                        print(object["Time_start"].objectId)//Pointer
                        print(object["Time_stop"]) //Pointer
                        print(object["Date"])      //Date
                        print(object["Place"])     //Pointer
                       // print(object["Tools"]!)      //String
                       // print(object["Detail"]!)    //String
                        print(object["TopicID"])   //Pointer
                        
        //ใส่ข้อมูลลงตารางช่วย (local datastore)
                        
                       // objectId ลง local week
                        let localWeek = PFObject(className: "Local week")
                        localWeek["objectId"] = object.objectId! as String
                        
                        // Time_ID ลง HT_Timestart
                        let ht_timestart = PFObject(className: "HT_Timestart")
                        ht_timestart["objectId"] = object["Time_start"].objectId!! as String
                        
                        // Time_ID ลง HT_Timestop
                        let ht_timestop = PFObject(className: "HT_Timestop")
                        ht_timestop["objectId"] = object["Time_stop"].objectId!! as String
                        
                        // เก็บวันที่ ลง local week
                        localWeek["Date"] = object["Date"] as! String
                        
                        // Place ลง HT_Place
                        let ht_place = PFObject(className: "HT_Place")
                        ht_place["objectId"] = object["Place"].objectId!! as String
                        
                        // Tools ลง local week
                        localWeek["Tools"] = object["Tools"]  as! String

                        
                        // Detail ลง local week
                        localWeek["Detail"] = object["Detail"]  as! String

                        
                        // TopicID(Topic) ลง HT_Topic_Subject_Class_Term
                        let ht_topic_subject_class = PFObject(className: "HT_Topic_Subject_Class_Term")
                        ht_topic_subject_class["objectId"] = object["TopicID"].objectId!!  as String

                       
                    }
                }
            }else{
                print("error")
            }
        }*/
        /*
        // ดึง class Time ลงมาใส่ HT_Timestart และ HT_timestop มี id, no_time, time
            let timeQuery = PFQuery(className: "Time_FK") // เปิด time บน parse
            timeQuery.findObjectsInBackgroundWithBlock { (object, error) -> Void in
                if error == nil{
                    if let objects = object{
                        for time in objects{
                            var timeId = time.objectId! as String      //เปิด timeId
                            var timeString = time["Time"] as! String   //เปิด time ที่เป็น String Ex. 9.00
                            //HT_Timestart
                            let timestartQuery = PFQuery(className: "HT_Timestart")
                            timestartQuery.fromLocalDatastore()
                            timestartQuery.findObjectsInBackgroundWithBlock { (object, error) -> Void in
                                if error == nil{
                                    if let objects = object{
                                        for timestart in objects{
                                            if timestart["objectId"] as! String == timeId{ //ถ้า objectId ใน HT_Timestart ตรงกับ objectId บน Time_Fk
                                                timestart["Time"] = timeString //ให้ object นั้นเก็บค่า time ที่เป็น string เช่น มี objectId: 78j3scs9 เก็บค่า 9.00
                                            }
                                        }
                                    }
                                }else{
                                    print(error)
                                }
                            }// จบ timestartQuery ตรงนี้
                            //HT_Timestop
                            let timestopQuery = PFQuery(className: "HT_Timestop")
                            timestopQuery.fromLocalDatastore()
                            timestopQuery.findObjectsInBackgroundWithBlock { (object, error) -> Void in
                                if error == nil{
                                    if let objects = object{
                                        for timestop in objects{
                                            if timestop["objectId"] as! String == timeId{ //ถ้า objectId ใน HT_Timestop ตรงกับ objectId บน Time_Fk
                                                timestop["Time"] = timeString //ให้ object นั้นเก็บค่า time ที่เป็น string เช่น มี objectId: 78j3scs9 เก็บค่า 9.00
                                            }
                                        }
                                    }

                                }else{
                                    print(error)
                                }
                                
                            }
                        }
                    }
                }else{
                    print(error)
                }
        }
        */
        // ดึง class Place ลงมาใส่ HT_Place มี id, no_place, place_name
        
        // ดึง class topic ลงมาใส่ HT_Topic_Subject_Class_Term มี id, detail, subjectCode, TopicName
        
        // ดึง class subject ลงมาใส่ HT_Topic_Subject_Class_Term มี id, class, info, subject, term
        
        // ดึง class term ลงมาใส่ HT_Topic_Subject_Class_Term มี id, no_term, term
        
        // ดึง class class ลงมาใส่ มี id, class, no_class, num_class
        
        // ดึง class topic_teacher ลงมาใส่ HT_Teacher มี id, teacher, topicScheduleId
        
        // ดึง class teacher(USER) ลงมาใส่ HT_Teacher มี id, namelist, email verify, ...
        
        
        

        
        //เติมข้อมูลตารางหลัก n อัน เมื่อ n คือจำนวนสัปดาห์
        
        
        
//        let queryTest = PFQuery(className: "Topic_Schedule")
//        queryTest.whereKey("objectId", equalTo: "5555555")
//        queryTest.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
//            if objects == nil{
//                print("คาบว่าง")
//            }else if error == nil{
//                print("error == nil")
//                print(objects)
//            }else{
//                print("error")
//            }
//        }
        
        
        
        
        
        
        
        
        }//viewDidLoad เขียนถึงปีกกานี้
}





//        let test = PFObject(className: "datastore")
//        test["Data"] = "3"
//        test["Name"] = "ออม"
//        test["Status"] = "เหมียว"
//        //test.saveEventually()
//        test.pinInBackground()
//        print("good")

//
//        let query = PFQuery(className: "datastore")
//        query.fromLocalDatastore()
//        query.whereKey("Status", equalTo: "อ้วน")
//        query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
//            if error == nil{
//                if let status = object{
//                    print(status["Status"])
//                    print(status)
//                }
//            }
//        }



//        let datastore = PFObject(className: "datastore")
//        datastore.unpinInBackgroundWithName("ออม")
//
//        let query = PFQuery(className: "datastore")
//        query.fromLocalDatastore()
//        query.findObjectsInBackgroundWithBlock { (object, error) -> Void in
//            if error == nil{
//                if let object = object {
//                    //print(object)
//                    for i in object{
//                       // print(i)
//                        let aom = i["Name"] as! String
//                        print(i["Status"])
//                        print(i["Said"][0])
//                        let data = i["Data"] as! String
//                        print("\(aom) and \(data)")
//
//                    }
//                }
//            }else{
//                print("error")
//            }
//        }



//        var i = 1
//        let queryTest = PFQuery(className: "Topic_Teacher")
//        queryTest.findObjectsInBackgroundWithBlock { (object, error) -> Void in
//            if error == nil{
//                if let objects = object{
//                    for object in objects{
//                        print(object)
//                        print(i)
//                        i++
//                    }
//
//                }
//            }else{
//                print("error")
//            }
//        }
//        print("finish")

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



//        let test = PFObject(className: "test")
//        test.addObject(["hello"], forKey: "day")
//        test.pinInBackground()
//          let query = PFQuery(className: "test")
//        query.fromLocalDatastore()
//        query.findObjectsInBackgroundWithBlock { (object, error) -> Void in
//            if  error == nil{
//                                        if let objects = object{
//                                           // print(objects)
//                                            for i in objects{
//                                                print(i)
//                                               i.unpinInBackground()
//                                            }
//                                                                                    }
//                                    }else{
//                                        print("error")
//                                    }
//
//        }


//
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
