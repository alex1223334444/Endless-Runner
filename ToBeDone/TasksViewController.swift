//
//  TasksViewController.swift
//  ToBeDone
//
//  Created by Udrea Alexandru-Iulian-Alberto on 19.11.2022.
//

import UIKit
import FirebaseAuth

class TasksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CompletableTaskDelegate {
    func pressComplete( _ button: UIButton?) {
        
        if state == "unfinished" {
            var completedTask = uncompletedTasks?[button?.tag ?? 0]
            completedTask?.finished = true
            getUser(id: uid) { result in
                switch result {
                case .success(let user):
                    self.user = user[0]
                    print("aici e userul")
                    print(self.user)
                    if let total = self.user?.totalTasks{
                        self.total = total
                    }
                    print(self.total)
                    print("gata user")
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }
            if let task = completedTask{
                self.user?.doneTasks! += 1
                self.user?.coins! += 10
                self.user?.totalTasks = total
                print("new user")
                print(self.user)
                print("")
                if let newUser = self.user {
                    updateUser(updatedUser: newUser) { data, response, error in
                        if let error = error {
                            let alert = UIAlertController(title: "Error at updating user data. Try again please.", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            DispatchQueue.main.async {
                                self.present(alert, animated: true, completion: nil)
                            }
                            return
                        }
                        
                    }
                }
                updateTask(updatedTask: task) { data, response, error in
                    if let error = error {
                        let alert = UIAlertController(title: "Error at completing task. Try again please.", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        DispatchQueue.main.async {
                            self.present(alert, animated: true, completion: nil)
                        }
                        return
                    }
                    
                    updateTask(updatedTask: task) { data, response, error in
                        if let error = error {
                            let alert = UIAlertController(title: "Error at completing task. Try again please.", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            DispatchQueue.main.async {
                                self.present(alert, animated: true, completion: nil)
                            }
                            return
                        }
                    }
                    DispatchQueue.main.async {
                        self.refresh(self)
                    }
                }
            }
        }
    }
    
    func changeTask(_ button: UIButton) {
        print("delegat")
        performSegue(withIdentifier: "edit", sender: self)
    }
    
    @IBOutlet var taskView: [UIView]!
    @IBOutlet weak var picker: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var floatingButton: UIButton!
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var shop: UIButton!
    private var requestedTasks : [TaskModel]? = []
    private var uncompletedTasks : [TaskModel]? = []
    private var completedTasks : [TaskModel]? = []
    private var user : User? = User(username: "", lastName: "", uid: "", firstName: "", totalTasks: 0, doneTasks: 0, coins: 0)
    private var uid = ""
    let refreshControl = UIRefreshControl()
    private var state = "today"
    private var total = 0
     
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.clipsToBounds = true
        self.tableView.layer.cornerRadius = 10
        self.tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        /*listButton.layer.cornerRadius = 0.5 * listButton.bounds.size.width
        listButton.clipsToBounds = true
        listButton.layer.borderWidth = 1
        listButton.layer.borderColor = UIColor.link.cgColor*/
        /*logout.layer.cornerRadius = 0.5 * logout.bounds.size.width
        logout.clipsToBounds = true
        logout.layer.borderWidth = 1
        logout.layer.borderColor = UIColor.link.cgColor
        logout.tintColor = UIColor.link*/
        /*shop.layer.cornerRadius = 0.5 * logout.bounds.size.width
        shop.clipsToBounds = true
        shop.layer.borderWidth = 1
        shop.layer.borderColor = UIColor.link.cgColor
        shop.tintColor = UIColor.link*/
        self.tabBarController?.navigationItem.hidesBackButton = true
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        picker.addTarget(self, action: #selector(self.selectTypeOfTask(sender:)), for:.valueChanged)
        tableView.addSubview(refreshControl)
        createFloatingButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.backgroundColor = Theme.current.tableBackground
        view.backgroundColor = Theme.current.view
        createFloatingButton()
        //floatingButton.backgroundColor = Theme.current.view
        //taskCell.backgroundColor = Theme.current.background
    }
    
    private func createFloatingButton() {
        let floatingButton = UIButton()
        floatingButton.setTitle("+", for: .normal)
        floatingButton.backgroundColor = .blue
        
        floatingButton.layer.cornerRadius = 25
        
        view.addSubview(floatingButton)
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        floatingButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        floatingButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        floatingButton.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -10).isActive = true
        floatingButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true

        floatingButton.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -100).isActive = true
        
        floatingButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
    }
    
    func updateViewController() {
        self.tableView.reloadData()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        refreshControl.beginRefreshing()
        switch state {
        case "today":
            getTasks(id: uid) { result in
                switch result {
                case .success(let tasks):
                    //self.requestedTasks = tasks
                    self.requestedTasks = self.getTodaysTasks(tasks: tasks)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }
        case "finished":
            getFinishedTasks(id: uid) { result in
                switch result {
                case .success(let tasks):
                    self.completedTasks = tasks
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }
        case "unfinished":
            getUnfinishedTasks(id: uid) { result in
                switch result {
                case .success(let tasks):
                    self.uncompletedTasks = tasks
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }
        default: break
            
        }
        refreshControl.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let user = Auth.auth().currentUser {
            let id = user.uid
            uid = id
            print(id)
        } else {
            //
        }
        getUser(id: uid) { result in
            switch result {
            case .success(let user):
                self.user = user[0]
                print("aici e userul")
                print(self.user)
                print("gata user")
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        
        switch state {
        case "today":
            getTasks(id: uid) { result in
                switch result {
                case .success(let tasks):
                    //self.requestedTasks = tasks
                    self.requestedTasks = self.getTodaysTasks(tasks: tasks)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }
        case "finished":
            getFinishedTasks(id: uid) { result in
                switch result {
                case .success(let tasks):
                    self.completedTasks = tasks
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }
        case "unfinished":
            getUnfinishedTasks(id: uid) { result in
                switch result {
                case .success(let tasks):
                    self.uncompletedTasks = tasks
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }
        default: break
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch state {
        case "today":
            return requestedTasks?.count ?? 0
        case "unfinished":
            return uncompletedTasks?.count ?? 0
        case "finished":
            return completedTasks?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "task", for: indexPath) as? TaskCell else {
            return UITableViewCell()
        }
        cell.showsReorderControl = true
        cell.backgroundColor = .clear
        switch state {
        case "today":
            if let task = requestedTasks?[indexPath.section]{
                var color : UIColor = .link
                switch task.priority {
                case 1:
                    color = .link
                case 2:
                    color = .green
                case 3:
                    color = .red
                case 4:
                    color = .blue
                case 5:
                    color = .orange
                default:
                    color = .link
                }
                cell.configureTaskCell(task, tag: indexPath.section, color: color, finished: task.finished!, delegate: self)
            }
        case "finished":
            if let task = completedTasks?[indexPath.section]{
                var color : UIColor = .link
                switch task.priority {
                case 1:
                    color = .link
                case 2:
                    color = .green
                case 3:
                    color = .red
                case 4:
                    color = .blue
                case 5:
                    color = .orange
                default:
                    color = .link
                }
                cell.configureTaskCell(task, tag: indexPath.section, color: color, finished: true,delegate: self)
            }
        case "unfinished":
            if let task = uncompletedTasks?[indexPath.section]{
                var color : UIColor = .link
                switch task.priority {
                case 1:
                    color = .link
                case 2:
                    color = .green
                case 3:
                    color = .red
                case 4:
                    color = .blue
                case 5:
                    color = .orange
                default:
                    color = .link
                }
                cell.configureTaskCell(task, tag: indexPath.section, color: color, finished: false, delegate: self)
            }
        default :
            break
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Edit", bundle:nil)
        let editViewController = storyBoard.instantiateViewController(withIdentifier: "Edit") as! EditViewController
        switch state {
        case "unfinished":
            if let task = uncompletedTasks?[indexPath.section]{
                editViewController.task = task
                navigationController?.present(editViewController, animated: true)
            }
        default:
            break
        }
        
    }
    
    @IBAction func logout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let err {
            print(err)
        }
    }
    
    @IBAction func goToSettings(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Settings", bundle:nil)
        let settingsViewController = storyBoard.instantiateViewController(withIdentifier: "settings") as! SettingsViewController
        
        if let total = self.requestedTasks?.count{
            if let uncompleted = self.uncompletedTasks?.count{
                let numbers = NumberOfTasks(totalTasks: total , uncompleted: uncompleted)
                settingsViewController.numbers = numbers
                navigationController?.present(settingsViewController, animated: true)
            }
        }
    }
    
    @IBAction func addTask(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "AddTask", bundle:nil)
        let addViewController = storyBoard.instantiateViewController(withIdentifier: "addtask") as! AddTaskViewController
        navigationController?.present(addViewController, animated: true)
    }
    
    @objc func selectTypeOfTask(sender: UISegmentedControl) {
        switch picker.selectedSegmentIndex
        {
        case 0:
            state = "today"
            refresh(self)
        case 1:
            state = "finished"
            refresh(self)
        case 2:
            state = "unfinished"
            refresh(self)
        default:
            break;
        }
    }
    
    func getTodaysTasks(tasks : [TaskModel]?) -> [TaskModel]? {
        var newTasks : [TaskModel]? = []
        let today = Date()
        let calendar = Calendar.current
        let todayComponents = calendar.dateComponents([.year, .month, .day], from: today)
        for i in 0..<(tasks?.count ?? 0){
            if let task = tasks?[i]{
                if task.time != " "{
                    let dateString = task.time?.components(separatedBy: ", ")[1]
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd MMM yyyy"
                    if let date = dateFormatter.date(from: dateString!) {
                        let taskComponents = calendar.dateComponents([.year, .month, .day], from: date)
                        if todayComponents == taskComponents {
                            newTasks?.append(task)
                        }
                    }
                }
            }
        }
        return newTasks
    }
}


struct NumberOfTasks {
    var totalTasks : Int? = 0
    var uncompleted : Int? = 0
}
