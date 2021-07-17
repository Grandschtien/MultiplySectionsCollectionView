//
//  SectionHeader.swift
//  MultiplySectionsInCollectionView
//
//  Created by Егор Шкарин on 11.07.2021.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    static let reuseId = "SectionHeader"
    var sections: [Section] = Bundle.main.decode([Section].self, from: "model.json")
    private var indexPathOfSelectedCell: IndexPath?
    
    fileprivate var collectionView: UICollectionView! = nil
    fileprivate var dataSource: UICollectionViewDiffableDataSource<Section, Item>! = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cofigureCollectionView()
        setupConstraints()
        createDataSource()
        reloadData()
        collectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Configure collection view
    private func cofigureCollectionView() {
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: createLayout())
        collectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .clear
        collectionView.alpha = 1
        collectionView.register(UINib(nibName: "EmojiCell", bundle: nil), forCellWithReuseIdentifier: EmojiCell.reuseId)
        addSubview(self.collectionView)
    }
    
    
    //MARK: - Create layout
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {[weak self](sectionIndex: Int,
                                                                      layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let section = self?.sections[sectionIndex] else { return nil }
            switch section.type {
            case "Emoji":
                return self?.createEmojiSection()
            default:
                print("There is no such item")
                return nil
            }
        }
        return layout
    }
    
    //MARK:- Create section
    private func createEmojiSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(120), heightDimension: .estimated(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 12, bottom: 15, trailing: 12)
        return section
    }
    
    //MARK:- setup constraints
    private func setupConstraints() {
        addSubview(self.collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: topAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])


    }
    
    //MARK:- Create data source
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { [weak self]
            (collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell? in
            switch self?.sections[indexPath.section].type {
            case "Emoji":
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCell.reuseId, for: indexPath) as? EmojiCell else {return nil}
                cell.configureCell(item: item)
                return cell
            default:
                print("There is no such item")
                return nil
            }
        }
    }
    
    //MARK:- Reload data
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sections)
        
        for section in sections {
            if section.type == "Emoji" {
                snapshot.appendItems(section.items, toSection: section)
            }
        }
        
        dataSource?.apply(snapshot)
    }
}
//MARK:- CollectionView delegate
extension SectionHeader: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let firstItem = self.dataSource.itemIdentifier(for: indexPath) else { return }
        let section = self.dataSource.snapshot().sectionIdentifier(containingItem: firstItem)
        switch section?.type {
        case "Emoji":
            let cell = collectionView.cellForItem(at: indexPath)

            if let previousIndex = indexPathOfSelectedCell {
                let previousCell = collectionView.cellForItem(at: previousIndex)
                previousCell?.backgroundColor = .clear
                cell?.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
            } else {
                cell?.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
            }
            indexPathOfSelectedCell = indexPath
        default:
            break
        }
    }
}

