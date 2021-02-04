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
        _view?.tutorialCollectionView.delegate = self
        _view?.tutorialCollectionView.dataSource = self
        
        _view?.tutorialCollectionView.register(PageTutorialCollectionViewCell.self, forCellWithReuseIdentifier: "pageTutorialCollectionViewCell")
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

extension TutorialViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tutorialConfigurator?.pageConfigurators?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pageTutorialCollectionViewCell", for: indexPath) as! PageTutorialCollectionViewCell
        if let pageConfigurator = self.tutorialConfigurator?.pageConfigurators?[indexPath.item] {
            cell.setConfigurator(tutorialPageConfiguration: pageConfigurator)
        }
        return cell
    }
    
    
}
