//
//  Cellim.swift
//  TravelBookDeneme
//
//  Created by Özcan on 25.04.2024.
//

import UIKit

class Cellim: UITableViewCell {
    
    var label = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setUpObjects()
    }
    
    private func setUpObjects() {
        label.frame = CGRect(x: 10, y: 10, width: 300, height: 30)
        
        addSubview(label)
    }

}
