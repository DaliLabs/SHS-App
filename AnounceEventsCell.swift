 //
//  AnounceEventsCell.swift
//  pat's shs app 2.0
//
//  Created by Patrick Li on 11/1/15.
//  Copyright © 2015 Dali Labs, Inc. All rights reserved.
//

import UIKit

class AnounceEventsCell: UITableViewCell {

   @IBOutlet weak var dayOfTheWeekLabel: UILabel!
   @IBOutlet weak var locationLabel: UILabel!
   @IBOutlet weak var name: UILabel!
   @IBOutlet weak var timeLabel: UILabel!
   @IBOutlet weak var dayOfMonthLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
