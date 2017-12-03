//
//  ViewController.swift
//  Attendance
//
//  Created by Stan on 2017-11-29.
//  Copyright © 2017 Stan Guo. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    lazy var dataFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    
    var managedContext: NSManagedObjectContext!
    var currentWorker: Worker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        
        let workerName = "Frank"
        let workerFetch: NSFetchRequest<Worker> = Worker.fetchRequest()
        workerFetch.predicate = NSPredicate(format: "%K == %@", #keyPath(Worker.name),workerName)
        
        do {
            let results = try managedContext.fetch(workerFetch)
            if results.count > 0 {
//                this person have found
                currentWorker = results.first
            } else {
//                this person have not found, so create this person's name as the ID
                currentWorker = Worker(context: managedContext)
                currentWorker?.name = workerName
                try managedContext.save()
            }
        } catch let error as NSError {
            debugPrint("ViewController Fetch error:\(error), description:\(error.userInfo)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addAttendanceTimeBtnClick(_ sender: UIBarButtonItem) {
        let attendance = AttendanceTime(context: managedContext)
        attendance.date = NSDate()
        currentWorker?.addToAttendances(attendance)
        do {
            try managedContext.save()
        } catch let error as NSError {
            debugPrint("context save error:\(error),description:\(error.userInfo)")
        }
        tableView.reloadData()
        
    }
    
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let attendances = currentWorker?.attendances else { return 1 }
        return attendances.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        guard let attendance = currentWorker?.attendances![indexPath.row] as? AttendanceTime,
                let attendanceDate = attendance.date as NSDate?
            else {
                return cell
        }
        
        cell.textLabel?.text = dataFormatter.string(from: attendanceDate as Date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "List of Attendance"
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard let attendanceRemove = currentWorker?.attendances?[indexPath.row] as? AttendanceTime,
        editingStyle == .delete
        else { return }
        
        managedContext.delete(attendanceRemove)
        
        do {
            try managedContext.save()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } catch let error as NSError {
            debugPrint("context save error:\(error),description:\(error.userInfo)")

        }
    }
}
