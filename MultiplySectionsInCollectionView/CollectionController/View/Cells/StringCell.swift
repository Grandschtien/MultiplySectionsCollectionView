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
        self.label.textColor = .black
        self.layer.addBorder(edge: .bottom, color: #colorLiteral(red: 0.804650509, green: 0.804650509, blue: 0.804650509, alpha: 1), thickness: 0.5)
    }
}

