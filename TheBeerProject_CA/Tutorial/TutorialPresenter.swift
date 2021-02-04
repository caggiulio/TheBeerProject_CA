//
//  TutorialPresenter.swift
//  TheBeerProject_CA
//
//  Created by Nunzio Giulio Caggegi on 04/02/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol TutorialPresentationLogic {
    func presentSomething(response: Tutorial.Something.Response)
}

class TutorialPresenter {

    // MARK: - Architecture properties

    weak var viewController: TutorialDisplayLogic?
}

// MARK: - TutorialPresentationLogic

extension TutorialPresenter: TutorialPresentationLogic {

    func presentSomething(response: Tutorial.Something.Response) {
        let viewModel = Tutorial.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
    
}
