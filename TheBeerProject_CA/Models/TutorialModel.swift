//
//  TutorialModel.swift
//  TheBeerProject_CA
//
//  Created by Nunzio Giulio Caggegi on 04/02/21.
//

import Foundation
import UIKit

struct TutorialPage : Hashable, TutorialPageProtocol {
    var backgroundColor: UIColor?
    var titleText: String?
    var id = UUID()
    
    static func == (lhs: TutorialPage, rhs: TutorialPage) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    init(tutorialPageConf: TutorialPageProtocol) {
        self.backgroundColor = tutorialPageConf.backgroundColor
        self.titleText = tutorialPageConf.titleText
    }
}
