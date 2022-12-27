//
//  TasksViewController.swift
//  ToBeDone
//
//  Created by Udrea Alexandru-Iulian-Alberto on 19.11.2022.
//

import UIKit

class TasksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return requestedTasks?.count ?? 0
        }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "task", for: indexPath) as? TaskCell else {
            return UITableViewCell()
        }
        cell.showsReorderControl = true
        if let task = requestedTasks?[indexPath.section]{
            cell.configureTextFieldCell(task, tag: indexPath.section, color: .red)
        }
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    private var requestedTasks : [TaskModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.clipsToBounds = true
        self.tableView.layer.cornerRadius = 10
        self.tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        listButton.layer.cornerRadius = 0.5 * listButton.bounds.size.width
        listButton.clipsToBounds = true
        listButton.layer.borderWidth = 1
        listButton.layer.borderColor = UIColor.link.cgColor
        plusButton.layer.cornerRadius = 0.5 * plusButton.bounds.size.width
        plusButton.clipsToBounds = true
        plusButton.layer.borderWidth = 1
        plusButton.layer.borderColor = UIColor.link.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
           getTasks(id: "1") { result in
               switch result {
               case .success(let tasks):
                   print(tasks)
                   self.requestedTasks = tasks
                   DispatchQueue.main.async {
                       self.tableView.reloadData()
                   }
                   break
               case .failure(let error):
                   print(error)
                   break
               }
           }
        
    }
    
   

    
}
