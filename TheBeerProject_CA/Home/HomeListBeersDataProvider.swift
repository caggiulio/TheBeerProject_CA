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
    
    // MARK: - Internal methods
    
    func applySnapshot(beers: [Beer]?, categories: [Category]?) {
        var snapshot = Snapshot<SectionValue, ItemModel>()

        let beerSection = Section<SectionValue>(value: .beers)
        let catSection = Section<SectionValue>(value: .categories)
        snapshot.appendSections([catSection, beerSection])
        
        if beers != nil {
            var beerItems = [Item<SectionValue, ItemModel>]()
            for beer in (beers!).enumerated() {
                let item = Item(section: beerSection, model: ItemModel(beer: beer.element, category: nil))
                beerItems.append(item)
            }
            snapshot.appendItems(beerItems, toSection: beerSection)
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
        
        getSupplementaryView(dataSource: dataSource)
    }
    
    func getSupplementaryView(dataSource: DataSource<SectionValue, ItemModel>) -> UICollectionReusableView {
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "beerListHeader", for: indexPath)
                return headerView
            default:
                break
            }
            return UICollectionReusableView()
        }
        return UICollectionReusableView()
    }
}
