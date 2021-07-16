//
//  ViewController.swift
//  MultiplySectionsInCollectionView
//
//  Created by Егор Шкарин on 07.07.2021.
//

import UIKit

class ViewController: UIViewController {
    private var sections = Bundle.main.decode([Section].self, from: "model.json")
    static let sectionBackgroundDecorationElementKind = "background-element-kind"
    fileprivate var dataSource: UICollectionViewDiffableDataSource<Section, Item>! = nil
    fileprivate var collectionView: UICollectionView! = nil
    private var indexPathOfSelectedCell: IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Sections"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        configure()
        configureDataSource()
        reloadData()
        collectionView.delegate = self
    }
    //MARK:- Configurate collectionView
    private func configure() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView?.backgroundColor = #colorLiteral(red: 0.880524771, green: 0.9031272657, blue: 0.875127862, alpha: 1)
        navigationController?.navigationBar.barTintColor = collectionView.backgroundColor
        view.addSubview(collectionView!)
        collectionView.register(UINib(nibName: "EmojiCell", bundle: nil), forCellWithReuseIdentifier: EmojiCell.reuseId)
        collectionView.register(UINib(nibName: "NumberCell", bundle: nil), forCellWithReuseIdentifier: NumberCell.reuseId)
        collectionView.register(UINib(nibName: "StringCell", bundle: nil), forCellWithReuseIdentifier: StringCell.reuseId)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    
}


//MARK:- Create layout of collection view
extension ViewController {
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {[weak self](sectionIndex: Int,
                                                                      layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let section = self?.sections[sectionIndex] else { return nil }
            
            switch section.type {
            case "Numbers":
                return self?.createNumberSection()
            case "Emoji":
                return self?.createEmojiSection()
            case "Names":
                return self?.createStringSection()
            default:
                print("There is no needed item")
                return nil
            }
        }
        layout.register(NameSectionDecorationView.self, forDecorationViewOfKind: ViewController.sectionBackgroundDecorationElementKind)
        return layout
    }
}


//MARK:- Configure sections
extension ViewController {
    // Create Sections
    private func createNumberSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 8, bottom: 0, trailing: 8)
        
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .estimated(250),
                                                     heightDimension: .estimated(88))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let section = NSCollectionLayoutSection(group: layoutGroup)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 12, bottom: 15, trailing: 12)
        let header = createHeader()
        section.boundarySupplementaryItems = [header]
        return section
    }
    private func createEmojiSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(120), heightDimension: .estimated(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 12, bottom: 15, trailing: 12)
        let header = createHeader()
        section.boundarySupplementaryItems = [header]
        return section
    }
    private func createStringSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        let sectionBackgroundDecoration = NSCollectionLayoutDecorationItem.background(
            elementKind: ViewController.sectionBackgroundDecorationElementKind)
        section.decorationItems = [sectionBackgroundDecoration]
        return section
    }
}

//MARK:- create data sourse
extension ViewController {
    private func configureDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { [weak self]
            (collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell? in
            switch self?.sections[indexPath.section].type {
            case "Numbers":
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberCell.reuseId, for: indexPath) as? NumberCell else {return nil}
                cell.configureCell(item: item)
                return cell
            case "Emoji":
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCell.reuseId, for: indexPath) as? EmojiCell else {return nil}
                cell.configureCell(item: item)
                return cell
            case "Names":
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StringCell.reuseId, for: indexPath) as? StringCell else {return nil}
                cell.configureCell(item: item)
                return cell
            default:
                print("There is no such item")
                return nil
                
            }
        }
        dataSource.supplementaryViewProvider = { [weak self]
            collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader else { return nil }
            guard let firstItem = self?.dataSource.itemIdentifier(for: indexPath) else { return nil }
            guard let section = self?.dataSource.snapshot().sectionIdentifier(containingItem: firstItem) else { return nil }
            if section.type.isEmpty { return nil }
            sectionHeader.title.text = section.type
            return sectionHeader
        }
    }
    
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sections)
        
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        
        dataSource?.apply(snapshot)
    }
}

//MARK:- Header to collectionView
extension ViewController {
    private func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return header
    }
}
// MARK: - Collection view delegate

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let firstItem = self.dataSource.itemIdentifier(for: indexPath) else { return }
        let section = self.dataSource.snapshot().sectionIdentifier(containingItem: firstItem)
        
        switch section?.type {
        case "Numbers":
            performSegue(withIdentifier: "NumberSegue", sender: nil)
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
            performSegue(withIdentifier: "EmojiSegue", sender: nil)
        case "Names":
            performSegue(withIdentifier: "NameSegue", sender: nil)
        default:
            break
        }
    }
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? NumberCell else { return }
        UIView.animate(withDuration: 0.3) {
            cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            cell.alpha = 0.5
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? NumberCell else { return }
        UIView.animate(withDuration: 0.3) {
            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
            cell.alpha = 1
        }
    }
}
//MARK:- Segues
extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "NumberSegue":
            guard let destinationVC = segue.destination as? NumberViewController,
                  let item = collectionView.indexPathsForSelectedItems,
                  let firstIndexPath = item.first,
                  let firstItem = self.dataSource.itemIdentifier(for: firstIndexPath)
            else { return }
            destinationVC.number  = firstItem.item
        case "EmojiSegue":
            guard let destinationVC = segue.destination as? EmojiViewController,
                  let item = collectionView.indexPathsForSelectedItems,
                  let firstIndexPath = item.first,
                  let firstItem = self.dataSource.itemIdentifier(for: firstIndexPath)
            else { return }
            destinationVC.emoji = firstItem.item
        case "NameSegue":
            guard let destinationVC = segue.destination as? NameViewController,
                  let item = collectionView.indexPathsForSelectedItems,
                  let firstIndexPath = item.first,
                  let firstItem = self.dataSource.itemIdentifier(for: firstIndexPath)
            else { return }
            destinationVC.name = firstItem.item
        default:
            break
        }
    }
}

