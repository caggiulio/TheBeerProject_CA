//
//  BeerDetailViewController.swift
//  TheBeerProject_CA
//
//  Created by Nunzio Giulio Caggegi on 02/02/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol BeerDetailDisplayLogic: class
{
  func displaySomething(viewModel: BeerDetail.Something.ViewModel)
}

class BeerDetailViewController: UIViewController, BeerDetailDisplayLogic
{
  var interactor: BeerDetailBusinessLogic?
  var router: (NSObjectProtocol & BeerDetailRoutingLogic & BeerDetailDataPassing)?

    // MARK: View
    var containerView: UIView = UIView(frame: .zero)
    var infoStackView: UIStackView = UIStackView(frame: .zero)
    
    var beerDescr: UILabel = UILabel(frame: .zero)
    var beerTitle: UILabel = UILabel(frame: .zero)
    var beerSubtitle: UILabel = UILabel(frame: .zero)
    var beerImage: UIImageView = UIImageView(frame: .zero)
    var transparentView: UIView = UIView(frame: .zero)
    var closeButton: UIButton = UIButton(frame: .zero)
    
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
    let interactor = BeerDetailInteractor()
    let presenter = BeerDetailPresenter()
    let router = BeerDetailRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
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
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    configureUI()
    setConstraints()
    fetchBeerDetail()
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
  
  func fetchBeerDetail() {
    interactor?.fetchBeerDetail()
  }
  
  func displaySomething(viewModel: BeerDetail.Something.ViewModel) {
    self.updateView(beer: viewModel.beer)
  }
}
