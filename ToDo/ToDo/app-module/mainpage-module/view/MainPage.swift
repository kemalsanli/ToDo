//
//  MainPage.swift
//  ToDo
//
//  Created by Kemal Sanlı on 24.11.2021.
//

import UIKit

class MainPage: UIViewController {

    @IBOutlet weak var toDoTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var plusButton: UIButton!
    
    var todoList = [ToDo]()
    
    var mainPagePresenter:ViewToPresenterMainPageProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        searchBar.delegate = self
        
        styling()
        
        copyDatabase()
        
        MainPageRouter.createModule(ref: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mainPagePresenter?.load()
    }

    
    @IBAction func plusButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "MainToNewVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MainToNewVC"{
            //Do Nothing
        }
        if segue.identifier == "MainToEditVC" {
            let todo = sender as? ToDo
            let destinationVC = segue.destination as! EditToDoViewController
            destinationVC.selectedToDo = todo
        }
    }
    
    
    func copyDatabase(){
        let bundlePath = Bundle.main.path(forResource: "ToDo", ofType: ".sqlite")
        
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true).first!
        
        let destinationPath = URL(fileURLWithPath: targetPath).appendingPathComponent("ToDo.sqlite")
        
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: destinationPath.path) {
            print("DB already exists.")
        }else {
            do {
                try fileManager.copyItem(atPath: bundlePath!, toPath: destinationPath.path)
            }catch{}
        }
    }

}

//MARK: TableView
extension MainPage:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedToDo = todoList[indexPath.row]
        let cell = toDoTableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
        cell.toDoLabel.text = selectedToDo.todoText
        cell.dateLabel.text = selectedToDo.date
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedtodo = todoList[indexPath.row]
        performSegue(withIdentifier: "MainToEditVC", sender: selectedtodo)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete".localized){ [weak self] (contextualAction,view,bool) in
            guard let selectedToDo = self?.todoList[indexPath.row] else { return }
            
            let alert = UIAlertController(title: "Delete".localized, message: "Are you sure to delete ?".localized, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel".localized, style: .cancel){ action in
                
            }
            alert.addAction(cancelAction)
            let yesAction = UIAlertAction(title: "Yes".localized, style: .destructive){ action in
                self?.mainPagePresenter?.delete(with: selectedToDo.id!, index: indexPath)
            }
            alert.addAction(yesAction)
            self?.present(alert, animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

//MARK: Presenter To View Protocols
extension MainPage:PresenterToViewMainPageProtocol{
    func setArray(_ array : Array<ToDo>) {
        self.todoList = array
        toDoTableView.reloadData()
    }
    
    func deleteAnimation(at indexPath: IndexPath) {
        todoList.remove(at: indexPath.row)
        toDoTableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
    }
}

//MARK: UISearchBar

extension MainPage:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        mainPagePresenter?.search(with: searchText)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.dismissKeyboard()
    }
}


//MARK: Styling

extension MainPage{
    func styling(){
        plusButton.layer.cornerRadius = 0.5 * plusButton.bounds.size.width
        plusButton.clipsToBounds = true
    }
}

