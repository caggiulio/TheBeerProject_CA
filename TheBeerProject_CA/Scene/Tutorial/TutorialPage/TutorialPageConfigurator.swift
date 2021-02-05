//
//  TutorialPageConfigurator.swift
//  TheBeerProject_CA
//
//  Created by Nunzio Giulio Caggegi on 04/02/21.
//

import Foundation
import UIKit

class TutorialPageConfigurator: TutorialPageProtocol {
    
    var backgroundColor: UIColor?
    
    var titleText: String?
    
    var hasNextButton: Bool?
    
    init(backgroundColor: UIColor, titleText: String, hasNextButton: Bool) {
        self.backgroundColor = backgroundColor
        self.titleText = titleText
        self.hasNextButton = hasNextButton
    }
}
