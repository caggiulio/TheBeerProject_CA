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
        let category: String?
    }
    
    var beersDisplayed: [Beer] = [Beer]()
    var categories: [String] = [String]()
    
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
    
    // MARK: - Internal methods
    
    func applySnapshot(beers: [Beer]?, categories: [String]?) {
        var snapshot = Snapshot<SectionValue, ItemModel>()

        let section = Section<SectionValue>(value: .beers)
        let catSection = Section<SectionValue>(value: .categories)
        snapshot.appendSections([catSection, section])
        
        if beers != nil {
            var beerItems = [Item<SectionValue, ItemModel>]()
            for beer in beers! {
                let item = Item(section: section, model: ItemModel(beer: beer, category: nil))
                beerItems.append(item)
            }
            snapshot.appendItems(beerItems, toSection: section)
            dataSource.apply(snapshot, animatingDifferences: true)
        }
        
        var catItems = [Item<SectionValue, ItemModel>]()
        if categories != nil {
            for cat in categories! {
                let catItem = Item(section: catSection, model: ItemModel(beer: nil, category: cat))
                catItems.append(catItem)
            }
            snapshot.appendItems(catItems, toSection: catSection)
            dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
}
