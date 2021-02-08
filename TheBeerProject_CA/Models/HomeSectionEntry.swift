//
//  HomeSection.swift
//  TheBeerProject_CA
//
//  Created by Nunzio Giulio Caggegi on 03/02/21.
//

import Foundation

struct HomeSectionEntry: Hashable {
    var beers: [Beer]? = nil
    var categories: [Category]? = nil
    var id = UUID()
    
    static func == (lhs: HomeSectionEntry, rhs: HomeSectionEntry) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
}
