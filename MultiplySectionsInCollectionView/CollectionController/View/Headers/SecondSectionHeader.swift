//
//  SecondSectionHeaderCollectionReusableView.swift
//  MultiplySectionsInCollectionView
//
//  Created by Егор Шкарин on 21.07.2021.
//

import UIKit

class SecondSectionHeader: UICollectionReusableView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    static let reuseId = "SecondSectionHeader"
    fileprivate var sections: [Section] = Bundle.main.decode([Section].self, from: "model.json").filter { section in
        return section.type != "Names" && section.type != "Numbers"
    }
    fileprivate var indexPathOfSelectedCell: IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "EmojiCell", bundle: nil), forCellWithReuseIdentifier: EmojiCell.reuseId)
        collectionView.layer.shadowOffset = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        collectionView.backgroundColor = #colorLiteral(red: 0.880524771, green: 0.9031272657, blue: 0.875127862, alpha: 1)
        collectionView.alpha = 1
        collectionView.reloadData()
    }
}
//MARK:- UICollectionViewDataSource
extension SecondSectionHeader: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let countOfCells = sections.first?.items.count else { return 0 }
        return countOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCell.reuseId, for: indexPath) as? EmojiCell else { return UICollectionViewCell()}
        guard let item = sections.first?.items[indexPath.item] else { return UICollectionViewCell()}
        cell.configureCell(item: item)
        return cell
    }
    
}
//MARK:- UICollectionViewDelegate

extension SecondSectionHeader:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        NotificationCenter.default.post(name: Notification.Name("SelectedIndexPath"), object: nil, userInfo: ["indexPath":indexPath])
        if let previousIndex = indexPathOfSelectedCell {
            let previousCell = collectionView.cellForItem(at: previousIndex)
            previousCell?.backgroundColor = .clear
            cell?.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        } else {
            cell?.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        }
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        indexPathOfSelectedCell = indexPath
    }
    
}
