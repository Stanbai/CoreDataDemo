//
//  TableViewController.swift
//  first
//
//  Created by Stan on 2017-08-09.
//  Copyright © 2017 stan. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    //    保存名字的数组
    var names = [String]()
    
    var people = [NSManagedObject]()
    
    
    @IBAction func addName(_ sender: Any) {
        let alert = UIAlertController(title: "添加姓名", message: "请输入一个名字", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "保存", style: .default) { (action :UIAlertAction!) in
            let textField = alert.textFields![0] as UITextField
            //            self.names.append(textField.text!)
            
            self.saveName(text: textField.text!)
            
            let indexPath = IndexPath(row: self.people.count - 1, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
            //            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (action: UIAlertAction) in
            
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        alert.addTextField { (textField: UITextField) in
            
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    let cellIdentifier = "reuseIdentifier"
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        步骤一：获取总代理和托管对象总管
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedObectContext = appDelegate.persistentContainer.viewContext
        
//        步骤二：建立一个获取的请求
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
//        步骤三：执行请求
        do {
            let fetchedResults = try managedObectContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults {
                people = results
                
                tableView.reloadData()
            }
            
        } catch  {
            fatalError("获取失败")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return people.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        // Configure the cell...
        let person = people[indexPath.row]
        cell.textLabel?.text = person.value(forKey: "name") as? String
        
        return cell
    }
    
    private func saveName(text: String) {
        //        步骤一：获取总代理和托管对象总管
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedObectContext = appDelegate.persistentContainer.viewContext
        
        //        步骤二：建立一个entity
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedObectContext)
        
        let person = NSManagedObject(entity: entity!, insertInto: managedObectContext)
        
        //        步骤三：保存文本框中的值到person
        person.setValue(text, forKey: "name")
        
        //        步骤四：保存entity到托管对象中。如果保存失败，进行处理
        do {
            try managedObectContext.save()
        } catch  {
            fatalError("无法保存")
        }
        
        //        步骤五：保存到数组中，更新UI
        people.append(person)
    }
    
    
}
