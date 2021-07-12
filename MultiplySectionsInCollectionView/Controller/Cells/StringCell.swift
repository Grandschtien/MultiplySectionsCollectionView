//
//  StringCell.swift
//  MultiplySectionsInCollectionView
//
//  Created by Егор Шкарин on 07.07.2021.
//

import UIKit

class StringCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    static let reuseId = "StringCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configureCell(item: Item) {
        self.label.text = item.item
        self.label.textAlignment = .center
        self.contentView.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        self.layer.cornerRadius = 10
        self.label.textColor = .white
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = CGSize(width: self.frame.width, height: self.frame.height)
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
