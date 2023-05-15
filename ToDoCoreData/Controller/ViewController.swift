//
//  ViewController.swift
//  ToDoCoreData
//
//  Created by TungLe on 25/04/2023.
//

import UIKit

class ViewController: UIViewController {
    var arrItem = [Item]()
    var realm = RealmDatabase()
    let urlFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathExtension("Item")
    @IBOutlet weak var tbvMainTableView: UITableView!
    @IBAction func btnAddButton(_ sender: Any) {
        alertShow()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        settingView()
        reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        reloadData()
    }
}


extension ViewController {
    func reloadData() {
        self.arrItem = realm.getAllData()
        self.tbvMainTableView.reloadData()
    }
    func settingView() {
        tbvMainTableView.delegate = self
        tbvMainTableView.dataSource = self
        tbvMainTableView.register(UINib(nibName: "MainCell", bundle: nil), forCellReuseIdentifier: "mainCell")
        print(urlFilePath)
    }
    func alertShow() {
        let alert = UIAlertController(title: "Add new Task", message: "Create a new task", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler:  { [weak alert] (_) in
            let textInput = (alert?.textFields![0].text)!
            self.saveData(strData: textInput)
            print(textInput)
        })
        
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        alert.addTextField() { textField in
            textField.placeholder = "Add a task"
        }
        self.present(alert, animated: true)
    }
    func saveData(strData: String) {
        let newItem = Item(title: strData, check: false)
        realm.createData(item: newItem)
        reloadData()
        
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MainCell
        cell.settingView(item: arrItem[indexPath.row])
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = arrItem[indexPath.row]
        weak var viewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        if let vc = viewController {
            vc.newItem = item
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
        
}

extension ViewController: returnToMainViewDelegate {
    func didTapButton() {
      //  weak var detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        reloadData()
    }
    
    
}


