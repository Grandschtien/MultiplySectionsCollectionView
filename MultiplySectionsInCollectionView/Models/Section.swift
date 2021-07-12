//
//  Section.swift
//  MultiplySectionsInCollectionView
//
//  Created by Егор Шкарин on 08.07.2021.
//

import Foundation

struct Section: Codable, Hashable {
    let type: String
    let items: [Item]
}

// MARK: - Item
struct Item: Codable, Hashable {
    let item: String
}
