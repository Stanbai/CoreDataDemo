//
//  Worker+CoreDataProperties.swift
//  Attendance
//
//  Created by Stan on 2017-12-02.
//  Copyright © 2017 Stan Guo. All rights reserved.
//
//

import Foundation
import CoreData


extension Worker {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Worker> {
        return NSFetchRequest<Worker>(entityName: "Worker")
    }

    @NSManaged public var name: String?
    @NSManaged public var attendances: NSOrderedSet?

}

// MARK: Generated accessors for attendances
extension Worker {

    @objc(insertObject:inAttendancesAtIndex:)
    @NSManaged public func insertIntoAttendances(_ value: AttendanceTime, at idx: Int)

    @objc(removeObjectFromAttendancesAtIndex:)
    @NSManaged public func removeFromAttendances(at idx: Int)

    @objc(insertAttendances:atIndexes:)
    @NSManaged public func insertIntoAttendances(_ values: [AttendanceTime], at indexes: NSIndexSet)

    @objc(removeAttendancesAtIndexes:)
    @NSManaged public func removeFromAttendances(at indexes: NSIndexSet)

    @objc(replaceObjectInAttendancesAtIndex:withObject:)
    @NSManaged public func replaceAttendances(at idx: Int, with value: AttendanceTime)

    @objc(replaceAttendancesAtIndexes:withAttendances:)
    @NSManaged public func replaceAttendances(at indexes: NSIndexSet, with values: [AttendanceTime])

    @objc(addAttendancesObject:)
    @NSManaged public func addToAttendances(_ value: AttendanceTime)

    @objc(removeAttendancesObject:)
    @NSManaged public func removeFromAttendances(_ value: AttendanceTime)

    @objc(addAttendances:)
    @NSManaged public func addToAttendances(_ values: NSOrderedSet)

    @objc(removeAttendances:)
    @NSManaged public func removeFromAttendances(_ values: NSOrderedSet)

}
