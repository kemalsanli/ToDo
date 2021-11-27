//
//  NewToDoViewController.swift
//  ToDo
//
//  Created by Kemal Sanlı on 25.11.2021.
//

import UIKit

class NewToDoViewController: UIViewController {

    var NewToDoPresenter: ViewToPresenterNewToDoProtocol?
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        textView.delegate = self
        textView.text = "What you need ToDo ?".localized
        textView.textColor = UIColor.lightGray
        
        NewToDoRouter.createModule(ref: self)
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        guard let text = textView.text else { return }
        
        NewToDoPresenter?.addNewToDo(text)
    }
    
}

//MARK: Presenter To View Protocol Stubs

extension NewToDoViewController:PresenterToViewNewToDoProtocol{
    func navigate() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}


//MARK: UITextViewDelegate for placeholder.
extension NewToDoViewController:UITextViewDelegate{
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
