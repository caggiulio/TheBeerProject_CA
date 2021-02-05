//
//  TutorialView.swift
//  TheBeerProject_CA
//
//  Created by Nunzio Giulio Caggegi on 04/02/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Anchorage

class TutorialView: UIView {
    
    // MARK: - UI properties
    var transparentView: UIView = UIView(frame: .zero)
    var tutorialCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
    // MARK: - Object lifecycle
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) isn't supported")
    }

    // MARK: - Configure methods
    
    private func configureUI() {
        func makeLayout() -> UICollectionViewLayout {
            let layout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),  heightDimension: .fractionalHeight(1.0))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                
                return section
            }
            
            return layout
        }
        
        tutorialCollectionView.setCollectionViewLayout(makeLayout(), animated: false)
        tutorialCollectionView.backgroundColor = .clear
        
        addSubview(tutorialCollectionView)
    }

    private func configureConstraints() {
        tutorialCollectionView.topAnchor == self.topAnchor
        tutorialCollectionView.leadingAnchor == self.leadingAnchor
        tutorialCollectionView.trailingAnchor == self.trailingAnchor
        tutorialCollectionView.bottomAnchor == self.bottomAnchor
    }

}
