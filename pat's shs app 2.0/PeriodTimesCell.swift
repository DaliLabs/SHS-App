//
//  PeriodTimesCell.swift
//  Pat'sshsapp
//
//  Created by Patrick Li on 10/11/15.
//

import UIKit

class PeriodTimesCell: UITableViewCell {

   @IBOutlet weak var periodLabel: UILabel!
   @IBOutlet weak var timesLabel: UILabel!
   @IBOutlet weak var progressBar: UIProgressView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.progressBar.hidden = true
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

   
   func showProgressBar()
   {
      progressBar.hidden = false
   }
   func hideProgressBar()
   {
      progressBar.hidden = true
   }

}
