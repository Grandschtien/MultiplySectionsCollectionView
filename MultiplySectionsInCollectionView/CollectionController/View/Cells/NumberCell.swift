//
//  NumberCell.swift
//  MultiplySectionsInCollectionView
//
//  Created by Егор Шкарин on 07.07.2021.
//

import UIKit

class NumberCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    static let reuseId = "NumberCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(item: Item) {
        self.label.text = item.item
        self.contentView.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        self.layer.cornerRadius = 20
        self.label.textAlignment = .center
        self.label.textColor = .white
        self.layer.shadowRadius = 10
    }
}
