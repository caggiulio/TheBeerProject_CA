//
//  HomeListBeersView.swift
//  TheBeerProject_CA
//
//  Created by Nunzio Giulio Caggegi on 01/02/21.
//

import UIKit
import Anchorage

class HomeListBeer: UIView {
    // MARK: - UI properties
    var beerCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    let search = UISearchController(searchResultsController: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) isn't supported")
    }
    
    func configureUI() {
        addSubview(beerCollectionView)
        
        beerCollectionView.backgroundColor = UIColor(named: "AppMainColor")
        
        func makeLayout() -> UICollectionViewLayout {
                let layout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
                    if section == 0 {
                        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(45)))
                        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(100),  heightDimension: .absolute(45))
                        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
                        let section = NSCollectionLayoutSection(group: group)
                        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 12, bottom: 0, trailing: 12)
                        section.orthogonalScrollingBehavior = .continuous
                        //HEADER
                        let header = NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(150)),
                                        elementKind: UICollectionView.elementKindSectionHeader,
                                        alignment: .top)
                                    
                        section.boundarySupplementaryItems = [header]
                        return section
                    } else {
                        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
                        item.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0)
                        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(230)), subitem: item, count: 1)
                        let section = NSCollectionLayoutSection(group: group)
                        section.contentInsets = NSDirectionalEdgeInsets(top: 16.0, leading: 0.0, bottom: 0.0, trailing: 0.0)
                        return section
                        
                    }
                }
                return layout
            }
        
        beerCollectionView.setCollectionViewLayout(makeLayout(), animated: false)
    }
    
    func configureConstraints() {
        beerCollectionView.topAnchor == self.topAnchor
        beerCollectionView.bottomAnchor == self.bottomAnchor
        beerCollectionView.leftAnchor == self.leftAnchor
        beerCollectionView.trailingAnchor == self.trailingAnchor
    }
}
