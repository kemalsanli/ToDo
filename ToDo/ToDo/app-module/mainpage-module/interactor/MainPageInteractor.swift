//
//  MainPageInteractor.swift
//  ToDo
//
//  Created by Kemal Sanlı on 24.11.2021.
//

import Foundation

class MainPageInteractor{
    var mainPagePresenter: InteractorToPresenterMainPageProtocol?
    
    let db:FMDatabase?
    
    init(){
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true).first!
        
        let databaseURL = URL(fileURLWithPath: targetPath).appendingPathComponent("ToDo.sqlite")
        
        db = FMDatabase(path: databaseURL.path)
    }
}

extension MainPageInteractor:PresenterToInteractorMainPageProtocol{
         
    func loadFromDB() {
        var list = [ToDo]()
       
        db?.open()
        
        do {
            let rows = try db!.executeQuery("SELECT * FROM ToDoMain", values: nil)
            
            while rows.next() {
                
                let todo = ToDo(id: Int(rows.string(forColumn: "id"))!, text: rows.string(forColumn: "text")!, date: rows.string(forColumn: "date")!)
                list.insert(todo, at: 0)
            }
            
            mainPagePresenter?.sendArray(list)
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func searchDb(with keyword: String) {
        var list = [ToDo]()
       
        db?.open()
        
        do {
            let rows = try db!.executeQuery("SELECT * FROM ToDoMain WHERE text like '%\(keyword)%'", values: nil)
            
            while rows.next() {
                
                let todo = ToDo(id: Int(rows.string(forColumn: "id"))!, text: rows.string(forColumn: "text")!, date: rows.string(forColumn: "date")!)
                list.insert(todo, at: 0)
            }
            
            mainPagePresenter?.sendArray(list)
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func delete(with id : Int, index: IndexPath) {
        db?.open()
        
        do {
            try db!.executeUpdate("DELETE FROM ToDoMain WHERE id=?", values: [id])
            mainPagePresenter?.sendDeleteAnimation(at: index)
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
    }
    
    
}
