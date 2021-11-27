//
//  NewToDoInteractor.swift
//  ToDo
//
//  Created by Kemal Sanlı on 25.11.2021.
//

import Foundation

class NewToDoInteractor {
    var newToDoPresenter: InteractorToPresenterNewToDoProtocol?
    
    let db:FMDatabase?
    
    init(){
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true).first!
        
        let databaseURL = URL(fileURLWithPath: targetPath).appendingPathComponent("ToDo.sqlite")
        
        db = FMDatabase(path: databaseURL.path)
    }
}


//MARK: Presenter To Interactor Protocol Stubs
extension NewToDoInteractor:PresenterToInteractorNewToDoProtocol{
    func addNewToDo(_ todotext: String) {
        
        let newtodo = ToDo(id: 1, text: todotext, date: Date()) //I know, not a great design choice but it's simple.
        
        db?.open()
        
        do {
            try db!.executeUpdate("INSERT INTO ToDoMain (text,date) VALUES (?,?)", values: [newtodo.todoText!,newtodo.date!])
            newToDoPresenter?.navigate()
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
}
