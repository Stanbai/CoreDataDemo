//
//  AttendanceTime+CoreDataProperties.swift
//  Attendance
//
//  Created by Stan on 2017-12-02.
//  Copyright © 2017 Stan Guo. All rights reserved.
//
//

import Foundation
import CoreData


extension AttendanceTime {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AttendanceTime> {
        return NSFetchRequest<AttendanceTime>(entityName: "AttendanceTime")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var workers: Worker?

}
