//
//  timeTableM5.swift
//  DarunsikkhalaiTimeTableApp
//
//  Created by jarukit boonkerd on 2/22/2559 BE.
//  Copyright © 2559 Hades corp. All rights reserved.
//

import UIKit

class timeTableM5: UIViewController {
    
    
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

        // Do any additional setup after loading the view.
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
