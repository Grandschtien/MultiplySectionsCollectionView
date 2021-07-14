//
//  SectionHeader.swift
//  MultiplySectionsInCollectionView
//
//  Created by Егор Шкарин on 11.07.2021.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    
    static let reuseId = "SectionHeader"
    let title = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeader()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHeader() {
        self.title.textColor = .black
        self.title.font = UIFont(name: "avenir", size: 20)
        self.title.translatesAutoresizingMaskIntoConstraints = false
    }
    private func setupConstraints() {
        addSubview(self.title)
        NSLayoutConstraint.activate([
            self.title.topAnchor.constraint(equalTo: topAnchor),
            self.title.trailingAnchor.constraint(equalTo: trailingAnchor),
            self.title.leadingAnchor.constraint(equalTo: leadingAnchor),
            self.title.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        

    }
}
