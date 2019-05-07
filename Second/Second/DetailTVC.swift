//
//  DetailTVC.swift
//  Second
//
//  Created by Stan on 2017-11-05.
//  Copyright © 2017 Stan Guo. All rights reserved.
//

import UIKit

class DetailTVC: UITableViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var relativeSwitch: UISwitch!
    @IBOutlet weak var updateTimeLabel: UILabel!
    
    @IBOutlet weak var viewTimesLabel: UILabel!
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = user {
            self.title = data.name
            
            avatarImageView.image = UIImage(data: data.avatarImg)
            nameLabel.text = data.name
            mobileLabel.text = data.mobile.mobileFormat()
            relativeSwitch.isOn = data.isRelative ? true : false
            updateTimeLabel.text = data.updateTime.description
            viewTimesLabel.text = "\(data.viewTimes.description)次"
        }
        
        avatarImageView.layer.cornerRadius = min(avatarImageView.bounds.size.width, avatarImageView.bounds.size.height) * 0.5
        
        avatarImageView.layer.masksToBounds = true
    }
}


class EditTVC: UITableViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var relativeSwitch: UISwitch!
    @IBOutlet weak var updateTimeLabel: UILabel!
    @IBOutlet weak var viewTimeLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        updateTimeLabel.text = "暂时为空"
        viewTimeLabel.text = "0次"

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    @IBAction func saveBtnClick(_ sender: Any) {
        
        let user = User(avatarImg: UIImage(named: "avatar\(arc4random_uniform(5) + 1)")!.pngData()!, isRelative: relativeSwitch.isOn ? true : false, name: nameTF.text ?? "", updateTime: Date(), viewTimes: 1, mobile: mobileTF.text ?? "")

        TableViewController.insertData(contactInfo: user)
        
        self.navigationController?.popViewController(animated: true)

    }
    
    
}
extension String {
    func mobileFormat() -> String {
        guard self.count == 11 else {
            return self
        }
        
        var mobileText = self
        mobileText.insert("-", at: mobileText.prefix(8).endIndex)
        mobileText.insert("-", at: mobileText.prefix(4).endIndex)
        
        return mobileText
    }
}
