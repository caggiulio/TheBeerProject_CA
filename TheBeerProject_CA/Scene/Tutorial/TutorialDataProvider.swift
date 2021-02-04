//
//  TutorialDataProvider.swift
//  TheBeerProject_CA
//
//  Created by Nunzio Giulio Caggegi on 04/02/21.
//

import Foundation

import Foundation
import UIKit

class TutorialDataProvider: DiffableDataSourceProvider {
    
    enum Sections: String {
        case tutorialPage
    }
    
    typealias SectionValue = Sections
    
    struct ItemModel: Hashable {
        let tutorialPage: TutorialPage?
    }
    
    var tutorialPageDisplayed: [TutorialPage] = [TutorialPage]()
    
    // MARK: - UI properties
    
    private let collectionView: UICollectionView
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    // MARK: - Business logic properties
    
    lazy var dataSource = DataSource<SectionValue, ItemModel>(collectionView: collectionView) { collectionView, indexPath, item in
        
        switch item.section.value {
        case .tutorialPage:
            let cell: PageTutorialCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "pageTutorialCollectionViewCell", for: indexPath) as! PageTutorialCollectionViewCell
            if let tutorialPageConf = item.model.tutorialPage {
                cell.setConfigurator(tutorialPageConfiguration: tutorialPageConf)
            }
            return cell
        }
    }
    
    // MARK: - Internal methods
    
    func applySnapshot(tutorialPages: [TutorialPage]) {
        var snapshot = Snapshot<SectionValue, ItemModel>()

        let tutorialPageSection = Section<SectionValue>(value: .tutorialPage)
        snapshot.appendSections([tutorialPageSection])
        
        var tutorialPagesItem = [Item<SectionValue, ItemModel>]()
        for tutorial in tutorialPages {
            let tutItem = Item(section: tutorialPageSection, model: ItemModel(tutorialPage: tutorial))
            tutorialPagesItem.append(tutItem)
        }
        snapshot.appendItems(tutorialPagesItem, toSection: tutorialPageSection)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
