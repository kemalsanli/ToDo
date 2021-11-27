//
//  mainPageRouter.swift
//  ToDo
//
//  Created by Kemal Sanlı on 24.11.2021.
//

import Foundation


class MainPageRouter:PresenterToRouterMainPageProtocol{
    static func createModule(ref: MainPage) {
        let presenter : ViewToPresenterMainPageProtocol & InteractorToPresenterMainPageProtocol = MainPagePresenter()
        
        //View
        ref.mainPagePresenter = presenter
        
        //Presenter
        ref.mainPagePresenter?.mainPageView = ref
        ref.mainPagePresenter?.mainPageInteractor = MainPageInteractor()
        
        //Interactor
        ref.mainPagePresenter?.mainPageInteractor?.mainPagePresenter = presenter
    }
}
