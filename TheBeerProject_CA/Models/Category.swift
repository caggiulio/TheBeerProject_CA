//
//  Category.swift
//  TheBeerProject_CA
//
//  Created by Nunzio Giulio Caggegi on 03/02/21.
//

import Foundation

struct Category: Hashable {
    var category: String? = nil
    var shouldSelect: Bool = false
    var id = UUID()
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
