//
//  MessagesCustomCellTableViewCell.swift
//  ChattingApplication
//
//  Created by krishna gunjal on 26/11/18.
//  Copyright © 2018 krishna gunjal. All rights reserved.
//

import UIKit

class MessagesCustomCellTableViewCell: UITableViewCell {

    @IBOutlet weak var msgFromYou: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
  }

}
