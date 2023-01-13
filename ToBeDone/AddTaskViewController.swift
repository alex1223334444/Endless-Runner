//
//  AddTaskViewController.swift
//  ToBeDone
//
//  Created by Udrea Alexandru-Iulian-Alberto on 25.12.2022.
//

import UIKit
import FirebaseAuth

class AddTaskViewController: UIViewController, TextFieldWithLabelDelegate {
    func changeText(_ textContent: UITextField?) {
        if let text=textContent?.text
        {
            switch textContent?.tag{
            case 0:
                taskTitle = text
            case 1:
                taskDescription = text
                
            default:
                break;
            }
        }
    }
    
    @IBOutlet weak var AlarmLabel: UILabel!
    @IBOutlet weak var PriorityPicker: UISegmentedControl!
    @IBOutlet weak var TrackedBtn: UISwitch!
    @IBOutlet weak var AlarmBtn: UISwitch!
    @IBOutlet weak var CalendarPkr: UIDatePicker!
    weak var viewController: TasksViewController?

    private var date : Date?
    private var priority : Int?
    private var tracked : Bool? = false
    private var uid : String?
    private var taskTitle : String?
    private var taskDescription : String?
    @IBAction func Tracked(_ sender: Any) {
        if TrackedBtn.isOn {
            CalendarPkr.isHidden.toggle()
            AlarmBtn.isHidden.toggle()
            AlarmLabel.isHidden.toggle()
            tracked?.toggle()
        }
        else {
            CalendarPkr.isHidden.toggle()
            AlarmBtn.isHidden.toggle()
            AlarmLabel.isHidden.toggle()
            tracked?.toggle()
        }
        print(tracked)
    }
    
    @IBAction func Priority(_ sender: UISegmentedControl) {
        switch PriorityPicker.selectedSegmentIndex {
        case 0:
            priority = 1
        case 1:
            priority = 2
        case 2:
            priority = 3
        case 3:
            priority = 4
        case 4:
            priority = 5
        default: break;
        }
        print(priority)
    }
    
    @IBAction func Alarm(_ sender: Any) {
    }
    
    @IBAction func Calendar(_ sender: UIDatePicker) {
        date = sender.date
        print(date)
    }
    
    @IBOutlet weak var textfield: TextFieldWithLabel!
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var TaskTitle: TextFieldWithLabel!
    
    @IBOutlet weak var TaskDescription: TextFieldWithLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.layer.cornerRadius = 8
        TaskTitle.configureTextField(with: "Title", tag:0, delegate: self)
        TaskDescription.configureTextField(with: "Description", tag:1, delegate: self)
        //CalendarPkr.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        self.hideKeyboardWhenTappedAround()

    }
    
    /*@objc func dateChanged(_ sender: UIDatePicker) {
     let components = Foundation.Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
     if let day = components.day, let month = components.month, let year = components.year {
     print("\(day) \(month) \(year)")
     }
     }*/
    
    override func viewWillAppear(_ animated: Bool) {
       
        if let user = Auth.auth().currentUser {
          let id = user.uid
          uid = id
          print(id)
        } else {
          //
        }
        
    }
    
    
    @IBAction func pressSubmit(_ sender: Any) {
        let targetDate = CalendarPkr.date
        if taskTitle != nil || taskDescription != nil || AlarmBtn.isOn{
            let content = UNMutableNotificationContent()
            content.title = taskTitle!
            content.body = taskDescription!
            //content.sound = UNNotificationSound(named: .defaultRingtone)
            let getDate = targetDate.addingTimeInterval(10)
            let trigger = UNCalendarNotificationTrigger(dateMatching: Foundation.Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: getDate), repeats: false)
            let request = UNNotificationRequest(identifier: "id_\(String(describing: taskTitle))", content: content, trigger: trigger)
            do {
                UNUserNotificationCenter.current().add(request)
            }
            catch {
                print("Something Went Wrong")
            }
            
            
            
        }
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "HH:mm E, d MMM y"
        var time : String = " "
        if let date = date {
            time = formatter3.string(from: date)
        }
        let uuid = UUID().uuidString
        let myTask : TaskModel = TaskModel(title: taskTitle, description: taskDescription, priority: priority, time: time, tracked: tracked, finished: false, uid: uid, taskId: uuid)
            print(myTask)
            createTask(task: myTask ) { result in
                switch result {
                case .success(_):
                    print(result)
                case .failure(let error):
                    print(error)
                }
            }
            viewController?.updateViewController()
            print("submit")
            self.dismiss(animated: true)
        }
        
}
