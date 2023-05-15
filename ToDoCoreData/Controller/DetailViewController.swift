//
//  DetailViewController.swift
//  ToDoCoreData
//
//  Created by TungLe on 27/04/2023.
//

import UIKit
protocol returnToMainViewDelegate {
    func didTapButton()
}
class DetailViewController: UIViewController {
    @IBAction func btnDeleteTaskTap(_ sender: Any) {
        deleteTask()
    }
    @IBAction func btnEditButtonTap(_ sender: Any) {
        guard newItem != nil else {return}
        let alert = UIAlertController(title: "Edit task", message: "Edit your task", preferredStyle: .alert)
        alert.addTextField() { textfield in
            textfield.text = self.newItem?.title
        }
        let ok = UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let strData = alert?.textFields![0].text
            var updateItem = Item(title: strData!, check: self.newItem!.check)
            self.realm.updateData(oldItem: self.newItem!, newItem: updateItem)
            self.settingView(item: updateItem)
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
        let updateItem = Item(title: newItem!.title, check: newItem!.check)
        realm.updateData(oldItem: newItem!, newItem: updateItem)
    }
    var newItem: Item?
    let realm = RealmDatabase()
    var delegate: returnToMainViewDelegate? = nil
    @IBAction func btnCloseTaskTap(_ sender: Any) {
        guard newItem != nil else {return}
        let updateItem = Item(title: newItem!.title, check: newItem!.check ? false : true)
        realm.updateData(oldItem: newItem!, newItem: updateItem)
        navigationController?.popToRootViewController(animated: true)
        if delegate != nil {
            delegate!.didTapButton()
        }
        
    }
    @IBOutlet weak var btnCloseTask: UIButton!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        settingView(item: newItem)
        // Do any additional setup after loading the view.
    }
    
    func settingView(item: Item?) {
        guard item != nil else {return}
        lblTitle.text = item?.title
        if item?.check == true {
            let dateString = item?.dateDone?.DateToString()
            lblStatus.text = "Task close on: \(dateString!)"
            btnCloseTask.setTitle("ReOpenTask", for: .normal)
        }
        else {
            lblStatus.text = "Not done yet"
            btnCloseTask.setTitle("Close Task", for: .normal)
        }
            
        
    }
    func deleteTask() {
        let strNameTask = self.newItem?.title
        let alert = UIAlertController(title: "Delelte \(strNameTask!)", message: "Are you sure to delete this task ?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            self.realm.deleteData(item: self.newItem!)
            self.navigationController?.popToRootViewController(animated: true)
            if self.delegate != nil {
                self.delegate!.didTapButton()
            }
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
