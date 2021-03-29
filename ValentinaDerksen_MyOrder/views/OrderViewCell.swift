// Student ID: 153803184
// Student name: Valentina Derksen
// Upated: 2021-03-29

//  OrderViewCell.swift
//  ValentinaDerksen_MyOrder
//
//  Created by Valya Derksen on 2021-02-19.
//

import UIKit

class OrderCell: UITableViewCell {
    
    @IBOutlet var lblOrderType : UILabel!
    @IBOutlet var lblOrderSize : UILabel!
    @IBOutlet var lblOrderQuantity : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
