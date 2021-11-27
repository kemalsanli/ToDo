//
//  ToDos.swift
//  ToDo
//
//  Created by Kemal Sanlı on 24.11.2021.
//

import Foundation


class ToDo {
    var id:Int?
    var todoText:String?
    var date:String?
    
    init(){}
    
    init(id:Int, text:String, date:Date){
        self.id = id
        self.todoText = text
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd.yyyy HH:mm"
        self.date = formatter.string(from: date)
    }
    
    init(id:Int, text:String, date:String){
        self.id = id
        self.todoText = text        
        self.date = date
    }
}
