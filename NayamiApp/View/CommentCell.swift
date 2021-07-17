//
//  CommentCell.swift
//  NayamiApp
//
//  Created by yamaguchi iori on 2021/06/09.
//

import UIKit

class CommentCell: UITableViewCell {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var topView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImageView.layer.cornerRadius = userImageView.frame.width/2
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 10.0
        
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 2, height: 4)
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 0.5
        // Initialization code
        
        let randomDoubles1 = CGFloat.random(in: 0.0...1.0)
        let randomDoubles2 = CGFloat.random(in: 0.0...1.0)
        let randomDoubles3 = CGFloat.random(in: 0.0...1.0)
        self.topView.backgroundColor = UIColor(red: randomDoubles1, green: randomDoubles2, blue: randomDoubles3, alpha: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
