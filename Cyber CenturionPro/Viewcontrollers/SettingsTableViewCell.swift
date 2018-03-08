//
//  SettingsTableViewCell.swift
//  Cyber CenturionPro
//
//  Created by Lokesh on 05/03/18.
//  Copyright © 2018 Lokesh. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    @IBOutlet weak var lbl_CellTitleText: UILabel!
    @IBOutlet weak var lbl_CellSubTitleText: UILabel!
    @IBOutlet weak var swt_CellOptionSelection: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
