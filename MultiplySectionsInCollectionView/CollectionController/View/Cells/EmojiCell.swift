//
//  TextCell.swift
//  MultiplySectionsInCollectionView
//
//  Created by Егор Шкарин on 07.07.2021.
//

import UIKit

class EmojiCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    static let reuseId = "EmojiCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(item: Item) {
        self.label.text = item.item
       // self.contentView.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        self.layer.cornerRadius = self.frame.height / 2
        self.label.textAlignment = .center
    }
}
