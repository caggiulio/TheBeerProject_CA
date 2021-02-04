//
//  TutorialConfigurator.swift
//  TheBeerProject_CA
//
//  Created by Nunzio Giulio Caggegi on 04/02/21.
//

import Foundation
import UIKit

class TutorialConfigurator: TutorialProtocol {
    var pageConfigurators: [TutorialPageProtocol]?
    
    init(pageConfigurators: [TutorialPageProtocol]) {
        self.pageConfigurators = pageConfigurators
    }
    
}
