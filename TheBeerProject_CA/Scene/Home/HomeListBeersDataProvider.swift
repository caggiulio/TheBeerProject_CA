//
//  HomeListBeersDataProvider.swift
//  TheBeerProject_CA
//
//  Created by Nunzio Giulio Caggegi on 01/02/21.
//

import Foundation
import UIKit

class HomeListBeersDataProvider: DiffableDataSourceProvider {
    
    enum Sections: String {
        case beers
        case categories
    }
    
    typealias SectionValue = Sections
    
    struct ItemModel: Hashable {
        let beer: Beer?
        var category: Category?
    }
    
    var beersDisplayed: [Beer] = [Beer]()
    var categories: [Category] = [Category]()
    
    // MARK: - UI properties
    
    private let collectionView: UICollectionView
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    // MARK: - Business logic properties
    
    lazy var dataSource = DataSource<SectionValue, ItemModel>(collectionView: collectionView) { collectionView, indexPath, item in
        
        switch item.section.value {
        case .categories:
            let cell: CategoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            if let cat = item.model.category {
                cell.updateUI(category: cat)
            }
            return cell
            
        case .beers:
            if let beer = item.model.beer {
                let cell: BeerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "beerTableViewCell", for: indexPath) as! BeerCollectionViewCell
                cell.updateUI(beer: beer)
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
    func applySnapshot(homeEntries: HomeSectionEntry) {
        var snapshot = Snapshot<SectionValue, ItemModel>()

        let beerSection = Section<SectionValue>(value: .beers)
        let catSection = Section<SectionValue>(value: .categories)
        snapshot.appendSections([catSection, beerSection])
        
        let categoriesEntries = homeEntries.categories
        let beersEntries = homeEntries.beers
        
        let catToParse = categoriesEntries ?? self.categories
        var catItems = [Item<SectionValue, ItemModel>]()
        for cat in catToParse {
            let catItem = Item(section: catSection, model: ItemModel(beer: nil, category: cat))
            catItems.append(catItem)
        }
        snapshot.appendItems(catItems, toSection: catSection)
        
        let beersToParse = beersEntries ?? beersDisplayed
        var beerItems = [Item<SectionValue, ItemModel>]()
        for beer in beersToParse {
            let item = Item(section: beerSection, model: ItemModel(beer: beer, category: nil))
            beerItems.append(item)
        }
        snapshot.appendItems(beerItems, toSection: beerSection)
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            self.getSupplementaryView(kind: kind, indexPath: indexPath)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
        
    }
    
    // MARK: - Internal methods
    
    func getSupplementaryView(kind: String, indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "beerListHeader", for: indexPath)
            return headerView
        default:
            break
        }
        return UICollectionReusableView()
    }
}
