//
//  TutorialViewController.swift
//  TheBeerProject_CA
//
//  Created by Nunzio Giulio Caggegi on 04/02/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol TutorialDisplayLogic: AnyObject {
    func displaySomething(viewModel: Tutorial.Something.ViewModel)
}

class TutorialViewController: UIViewController {
    
    // MARK: - Architecture properties

    var interactor: TutorialBusinessLogic?
    var router: (TutorialRoutingLogic & TutorialDataPassing)?
    
    // MARK: - UI properties

    var _view: TutorialView? {
        guard let view = view as? TutorialView else { preconditionFailure("Unable to cast view to TutorialView")}
        return view
    }

    // MARK: - Business properties
    var tutorialConfigurator: TutorialProtocol?
    var tutorialDataProvider: TutorialDataProvider?

    // MARK: - Object lifecycle
    
    init(tutorialConfigurator: TutorialProtocol) {
        super.init(nibName: nil, bundle: nil)
        setTutorialConfigurator(tutorialConfigurator: tutorialConfigurator)
    }
    
    func setTutorialConfigurator(tutorialConfigurator: TutorialProtocol) {
        self.tutorialConfigurator = tutorialConfigurator
    }

    required init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View lifecycle

    override func loadView() {
        view = TutorialView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        _view?.tutorialCollectionView.register(PageTutorialCollectionViewCell.self, forCellWithReuseIdentifier: "pageTutorialCollectionViewCell")
        tutorialDataProvider = TutorialDataProvider(collectionView: _view!.tutorialCollectionView)
        
        if let pages = tutorialConfigurator?.pageConfigurators {
            let pagesToPass = pages.map { (prot) -> TutorialPage in
                return TutorialPage(tutorialPageConf: prot as! TutorialPageConfigurator)
            }
            tutorialDataProvider?.applySnapshot(tutorialPages: pagesToPass)
        }
    }
    
    // MARK: - Setup methods

    private func setup() {
        let viewController = self
        let interactor = TutorialInteractor()
        let presenter = TutorialPresenter()
        let router = TutorialRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - Configure methods

    private func configureUI() {
        
    }
    
    // MARK: - User interactions
    
    // MARK: - Private methods

}

// MARK: - TutorialDisplayLogic

extension TutorialViewController: TutorialDisplayLogic {

    func displaySomething(viewModel: Tutorial.Something.ViewModel) {

    }

}
