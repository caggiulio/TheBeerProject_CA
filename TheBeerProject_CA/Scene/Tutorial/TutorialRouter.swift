//
//  TutorialRouter.swift
//  TheBeerProject_CA
//
//  Created by Nunzio Giulio Caggegi on 04/02/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//


protocol TutorialRoutingLogic {
    // func routeToSomewhere()
}

protocol TutorialDataPassing {
    var dataStore: TutorialDataStore? { get set }
}

class TutorialRouter: TutorialDataPassing {

    // MARK: - Architecture properties

    weak var viewController: TutorialViewController?

    // MARK: - Business properties

    var dataStore: TutorialDataStore?

}

// MARK: - TutorialRoutingLogic

extension TutorialRouter: TutorialRoutingLogic {

    // func routeToSomewhere() {
    //     let destinationVC = SomewhereViewController()
    //     var destinationDS = destinationVC.router!.dataStore!
    //     passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //     navigateToSomewhere(source: viewController!, destination: destinationVC)
    // }

}

// MARK: - Navigation methods

private extension TutorialRouter {
    
    // func navigateToSomewhere(source: TutorialViewController, destination: SomewhereViewController) {
    //     source.show(destination, sender: nil)
    // }

}

// MARK: - Passing data methods

private extension TutorialRouter {
   
    // func passDataToSomewhere(source: TutorialDataStore, destination: inout SomewhereDataStore) {
    //     destination.someObject = source.someObject
    // }

}
