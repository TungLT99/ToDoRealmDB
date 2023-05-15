//
//  MainCell.swift
//  ToDoCoreData
//
//  Created by TungLe on 25/04/2023.
//

import UIKit

class MainCell: UITableViewCell {
    var newItem: Item?
    @IBOutlet weak var imgImageCheck: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        settingView(item: newItem)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MainCell {
    func settingView(item: Item?) {
        guard item != nil else {return}
        lblTitle.text = item!.title
        if item?.check == true {
            imgImageCheck.isHidden = false
        }
        else
        {
            imgImageCheck.isHidden = true
        }
        
    }
}
