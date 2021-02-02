//
//  HomeListBeersViewController.swift
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

protocol HomeListBeersDisplayLogic: class
{
  func displayBeersList(viewModel: HomeListBeers.Something.ViewModel)
    func displayCategories(viewModel: HomeListBeers.Categories.ViewModel)
}

class HomeListBeersViewController: UIViewController, HomeListBeersDisplayLogic
{
  var interactor: HomeListBeersBusinessLogic?
  var router: (NSObjectProtocol & HomeListBeersRoutingLogic & HomeListBeersDataPassing)?
    
  // MARK: View
    var beerTableView: UITableView = UITableView(frame: .zero, style: .grouped)
    var header: UIView?
    let search = UISearchController(searchResultsController: nil)
    
  // MARK: - Business properties
    var homeListBeersDataProvider: HomeListBeersDataProvider?
    var headerDataProvider: HeaderDataProvider?
    
  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = HomeListBeersInteractor()
    let presenter = HomeListBeersPresenter()
    let router = HomeListBeersRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
    homeListBeersDataProvider = HomeListBeersDataProvider()
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchList()
    fetchCategories()
    configureUI()
    setConstraints()
    setSearchBar()
  }
  
  // MARK: Do something
    
  func fetchList() {
    let request = HomeListBeers.Something.Request()
    interactor?.fetchListBeer(request: request)
  }
    
    func fetchCategories() {
        let request = HomeListBeers.Categories.Request()
        interactor?.fetchCategories(request: request)
    }
  
  func displayBeersList(viewModel: HomeListBeers.Something.ViewModel) {
    if let beers = viewModel.beers {
        self.homeListBeersDataProvider?.beers = beers
        self.beerTableView.reloadData()
    }
  }
    
    func displayCategories(viewModel: HomeListBeers.Categories.ViewModel) {
        self.headerDataProvider = HeaderDataProvider(categories: viewModel.categories)
        self.setHeaderViewPopular()
    }
}

extension HomeListBeersViewController: HeaderSectionViewControllerDelegate {
    func passCategry(category: String) {
        let request = HomeListBeers.Something.Request(page: 1, beerName: "", category: category)
        interactor?.fetchListBeer(request: request)
    }
}

extension HomeListBeersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.setTextColorAndTextFont(color: .white, font: UIFont.systemFont(ofSize: 12))
        let request = HomeListBeers.Something.Request(page: 1, beerName: searchText, category: interactor?.category)
        interactor?.fetchListBeer(request: request)
    }
}
