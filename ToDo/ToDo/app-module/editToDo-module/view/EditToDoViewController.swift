//
//  EditToDoViewController.swift
//  ToDo
//
//  Created by Kemal Sanlı on 25.11.2021.
//

import UIKit

class EditToDoViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var selectedToDo:ToDo?
    var editToDoPresenter:ViewToPresenterEditToDoProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        textView.delegate = self
        
        if let todo = selectedToDo?.todoText {
            textView.text = todo
        }
        
        EditToDoRouter.createModule(ref: self)

    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        guard let todo = selectedToDo else { return }
        todo.todoText = textView.text
        editToDoPresenter?.editToDo(todo)
    }
    

}

//MARK: Presenter To View Protocol Stubs

extension EditToDoViewController:PresenterToViewEditToDoProtocol{
    func navigate() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

//MARK: UITextViewDelegate for placeholder.
extension EditToDoViewController:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "What you need ToDo ?".localized
            textView.textColor = UIColor.lightGray
        }
    }
}
