//
//  NameSectionDecorationView.swift
//  MultiplySectionsInCollectionView
//
//  Created by Егор Шкарин on 11.07.2021.
//

import UIKit

class NameSectionDecorationView: UICollectionReusableView {
    
    static let reuseId = "NameSectionDecorationView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NameSectionDecorationView {
    func configure() {
        self.backgroundColor = #colorLiteral(red: 0.9748463952, green: 1, blue: 0.9627470216, alpha: 1)
        self.layer.cornerRadius = 20
    }
}
