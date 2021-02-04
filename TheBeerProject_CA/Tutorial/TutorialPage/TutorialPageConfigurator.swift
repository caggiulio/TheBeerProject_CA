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
    
    init(backgroundColor: UIColor, titleText: String) {
        self.backgroundColor = backgroundColor
        self.titleText = titleText
    }
}
