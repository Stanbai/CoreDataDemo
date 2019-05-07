//
//  TableViewController.swift
//  Second
//
//  Created by Stan on 2017-11-05.
//  Copyright © 2017 Stan Guo. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    var datas = [User]()
    
    var selectedUser: User?
    
    let cellWithIdentifier = "InfoCell"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getLocalData()
        if datas.count == 0 {
            initData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addBtnClick(_ sender: Any) {
        performSegue(withIdentifier: "insertContact", sender: sender)

    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellWithIdentifier, for: indexPath)
        
        if let myCell = cell as? TableViewCell {
            myCell.nameLabel.text = datas[indexPath.row].name
            myCell.avatarImageView.image = UIImage(data: datas[indexPath.row].avatarImg)
            return myCell
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedUser = datas[indexPath.row]
        performSegue(withIdentifier: "toInfoCard", sender: selectedUser)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toInfoCard",
            let vc = segue.destination as? DetailTVC {
            vc.user = sender as? User
        }
    }
    
}
extension TableViewController {
    fileprivate func getLocalData() {
        //        步骤一：获取总代理和托管对象总管
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedObectContext = appDelegate.persistentContainer.viewContext
        
        //        步骤二：建立一个获取的请求
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        
        //        步骤三：执行请求
        do {
            let fetchedResults = try managedObectContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults {
                datas.removeAll()
                for result in results {
                    guard let user = translateData(from: result) else { return }
                    datas.append(user)
                }
                
                tableView.reloadData()
            }
            
        } catch  {
            fatalError("获取失败")
        }

    }
    
    fileprivate func initData() {
        let data1 = #imageLiteral(resourceName: "avatar1").pngData()
        let time = Date()
        let user1 = User(avatarImg: data1!, isRelative: true, name: "Jesse Sapir", updateTime: time, viewTimes: 32, mobile: "26098642878")
        
        let data2 = #imageLiteral(resourceName: "avatar2").pngData()
        let user2 = User(avatarImg: data2!, isRelative: false, name: "Virginia Woolf", updateTime: time, viewTimes: 1, mobile: "25660228794")
        
        TableViewController.insertData(contactInfo: user1)
        TableViewController.insertData(contactInfo: user2)
        
        datas.append(user1)
        datas.append(user2)
    }
    
    class func insertData(contactInfo: User) {
        
        //        步骤一：获取总代理和托管对象总管
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedObectContext = appDelegate.persistentContainer.viewContext
        
        //        步骤二：建立一个entity
        let entity = NSEntityDescription.entity(forEntityName: "Contact", in: managedObectContext)
        let user = NSManagedObject(entity: entity!, insertInto: managedObectContext)
        
        //        步骤三：保存数值
        
        user.setValue(contactInfo.avatarImg, forKey: "avatar")
        user.setValue(contactInfo.isRelative, forKey: "isRelative")
        user.setValue(contactInfo.mobile, forKey: "mobile")
        user.setValue(contactInfo.name, forKey: "name")
        user.setValue(contactInfo.updateTime, forKey: "updateTime")
        user.setValue(contactInfo.viewTimes, forKey: "viewTimes")
        
        
        //        步骤四：保存entity到托管对象中。如果保存失败，进行处理
        do {
            try managedObectContext.save()
        } catch  {
            fatalError("无法保存")
        }

    }
    
    fileprivate func translateData(from: NSManagedObject) -> (User?) {
        if let imgData = from.value(forKey: "avatar") as? Data,let isRelative = from.value(forKey: "isRelative") as? Bool,let name = from.value(forKey: "name") as? String,let updateTime = from.value(forKey: "updateTime") as? Date, let viewTimes = from.value(forKey: "viewTimes") as? Int64, let mobile = from.value(forKey: "mobile") as? String{
                    let user = User(avatarImg: imgData, isRelative: isRelative, name: name, updateTime: updateTime, viewTimes: viewTimes, mobile: mobile)
            
            return user
        }
        return nil
    }
    

}

