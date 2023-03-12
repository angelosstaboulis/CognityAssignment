//
//  TVDetailsCell.swift
//  CognityAssignment
//
//  Created by Angelos Staboulis on 9/3/23.
//

import UIKit

class TVDetailsCell: UITableViewCell {

    @IBOutlet weak var lblRatings: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgThumb: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
