//
//  DiffableDataSourceProvider.swift
//  TheBeerProject_CA
//
//  Created by Nunzio Giulio Caggegi on 03/02/21.
//

import Foundation
import UIKit

// MARK: - DiffableDataSourceProvider

/// The protocol that is needed to be conformed to in order to use the whole diffable logic
public protocol DiffableDataSourceProvider {
    /// The SectionValue enum to recognize in which section of the collection view we are.
    /// e.g.
    /// enum SectionValue {
    ///     case .section_1
    ///     case .section_2
    ///     case .section_3
    ///     ...
    /// }
    associatedtype SectionValue: Hashable & RawRepresentable where SectionValue.RawValue == String
    
    /// The Hashable model needed to populate the collection view
    associatedtype ItemModel: Hashable
    
    /// The UICollectionViewDiffableDataSource used to apply the snapshot and dequeue the reusable cell
    var dataSource: DataSource<SectionValue, ItemModel> { get set }
}

// MARK: - Typealias

/// The UICollectionViewDiffableDataSource used to apply the snapshot and dequeue the reusable cell
public typealias DataSource<SectionValue: Hashable & RawRepresentable, ItemModel: Hashable> = UICollectionViewDiffableDataSource<Section<SectionValue>, Item<SectionValue, ItemModel>> where SectionValue.RawValue == String

/// The NSDiffableDataSourceSnapshot needed to be applied to the UICollectionViewDiffableDataSource
public typealias Snapshot<SectionValue: Hashable & RawRepresentable, ItemModel: Hashable> = NSDiffableDataSourceSnapshot<Section<SectionValue>, Item<SectionValue, ItemModel>> where SectionValue.RawValue == String

// MARK: - Section

/// The SectionIdentifierType of UICollectionViewDiffableDataSource
public struct Section<Value: Hashable & RawRepresentable>: Hashable where Value.RawValue == String {
    
    // MARK: - Business logic properties
    
    /// Random unique identifier for the hashable purpose
    private let identifier = UUID()
            
    /// The RawRepresentable value for the section
    let value: Value
    
    // MARK: - Hashable methods
    
    /// For the documentation check the one from Swift->Hashing->Hashable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
        hasher.combine(value)
    }
        
}

// MARK: - Item

/// The ItemIdentifierType of UICollectionViewDiffableDataSource
public struct Item<SectionValue: Hashable & RawRepresentable, Model: Hashable>: Hashable where SectionValue.RawValue == String {

    // MARK: - Business logic properties
    
    /// Random unique identifier for the hashable purpose
    private let identifier = UUID()
    
    /// The SectionIdentifierType of UICollectionViewDiffableDataSource
    let section: Section<SectionValue>
    
    /// The Hashable model needed to populate the collection view
    var model: Model

    // MARK: - Hashable methods

    /// For the documentation check the one from Swift->Hashing->Hashable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
        hasher.combine(section)
        hasher.combine(model)
    }
    
}
