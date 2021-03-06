//
//  HomeListBeersRouter.swift
//  TheBeerProject_CA
//
//  Created by Nunzio Giulio Caggegi on 01/02/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol HomeListBeersRoutingLogic
{
  func routeToDetail()
    func presentTutorial()
}

protocol HomeListBeersDataPassing
{
  var dataStore: HomeListBeersDataStore? { get }
}

class HomeListBeersRouter: NSObject, HomeListBeersRoutingLogic, HomeListBeersDataPassing
{
  weak var viewController: HomeListBeersViewController?
  var dataStore: HomeListBeersDataStore?
  
  // MARK: Routing
  
  func routeToDetail() {
    let destination = BeerDetailViewController()
    var destinationDS = destination.router?.dataStore
    passDataToSomewhere(source: self.dataStore!, destination: &destinationDS!)
    navigateToDetail(source: self.viewController!, destination: destination)
  }
    
    func presentTutorial() {
        let tutorial = TutorialViewController(tutorialConfigurator: TutorialConfigurator(pageConfigurators: [TutorialPageConfigurator(backgroundColor: .systemRed, titleText: "TEST1", hasNextButton: true), TutorialPageConfigurator(backgroundColor: .systemGreen, titleText: "TEST2", hasNextButton: true), TutorialPageConfigurator(backgroundColor: .systemBlue, titleText: "TEST3", hasNextButton: true), TutorialPageConfigurator(backgroundColor: .systemGray, titleText: "TEST4", hasNextButton: false)]))
        presentTutorial(source: self.viewController!, destination: tutorial)
    }

  // MARK: Navigation
  
  func navigateToSomewhere(source: HomeListBeersViewController, destination: BeerDetailViewController)
  {
    source.show(destination, sender: nil)
  }
  
  // MARK: Passing data
  
  func passDataToSomewhere(source: HomeListBeersDataStore, destination: inout BeerDetailDataStore) {
    destination.beer = source.beerToDetail
  }
}

extension HomeListBeersRouter {
    func navigateToDetail(source: HomeListBeersViewController, destination: BeerDetailViewController) {
        DispatchQueue.main.async {
            destination.modalPresentationStyle = .overFullScreen
            source.present(destination, animated: true, completion: nil)
        }
    }
    
    func presentTutorial(source: HomeListBeersViewController, destination: TutorialViewController) {
        DispatchQueue.main.async {
            destination.modalPresentationStyle = .automatic
            source.present(destination, animated: true, completion: nil)
        }
    }
}
