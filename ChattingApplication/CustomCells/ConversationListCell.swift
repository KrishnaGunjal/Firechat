//
//  ConversationListCell.swift
//  ChattingApplication
//
//  Created by krishna gunjal on 24/11/18.
//  Copyright © 2018 krishna gunjal. All rights reserved.
//

import UIKit

class ConversationListCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var lastMessage: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
