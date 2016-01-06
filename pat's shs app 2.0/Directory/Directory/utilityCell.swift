//
//  utilityCell.swift
//  Directory
//
//  Created by Daniel Bessonov on 1/3/16.
//  Copyright © 2016 Daniel Bessonov. All rights reserved.
//

import UIKit

class utilityCell: UITableViewCell {
    
    @IBOutlet weak var textLabel_: UILabel!
    @IBOutlet weak var typeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func useText(text : String, text2: String)
    {
        self.textLabel_.text = text
        self.typeLabel.text = text2
    }
    
    func useStaff(member : staffMember)
    {
        self.textLabel_.text = member.name
        self.typeLabel.text = member.type
    }

}
