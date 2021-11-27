//
//  NewToDoProtocols.swift
//  ToDo
//
//  Created by Kemal Sanlı on 25.11.2021.
//

import Foundation

//Forward
protocol ViewToPresenterNewToDoProtocol{
    
    var newToDoInteractor:PresenterToInteractorNewToDoProtocol? {get set}
    var newToDoView:PresenterToViewNewToDoProtocol? {get set}
    
    func addNewToDo(_ :String)
}

protocol PresenterToInteractorNewToDoProtocol{
    
    var newToDoPresenter:InteractorToPresenterNewToDoProtocol? {get set}
    
    func addNewToDo(_ :String)
}

//Back

protocol PresenterToViewNewToDoProtocol{
    func navigate()
}

protocol InteractorToPresenterNewToDoProtocol{
    func navigate()
}

//Router

protocol PresenterToRouterNewToDoProtocol{
    static func createModule(ref:NewToDoViewController)
}
