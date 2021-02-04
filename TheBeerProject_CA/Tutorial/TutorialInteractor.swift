//
//  TutorialInteractor.swift
//  TheBeerProject_CA
//
//  Created by Nunzio Giulio Caggegi on 04/02/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol TutorialBusinessLogic {
    func doSomething(request: Tutorial.Something.Request)
}

protocol TutorialDataStore { }

class TutorialInteractor: TutorialDataStore {
    
    // MARK: - Architecture properties

    var presenter: TutorialPresentationLogic?

}

// MARK: - TutorialBusinessLogic

extension TutorialInteractor: TutorialBusinessLogic {

    func doSomething(request: Tutorial.Something.Request) {
        let response = Tutorial.Something.Response()
        presenter?.presentSomething(response: response)
    }

}
