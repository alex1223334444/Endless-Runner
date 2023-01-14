//
//  EditViewController.swift
//  ToBeDone
//
//  Created by user230454 on 1/4/23.
//

import UIKit

class EditViewController: UIViewController, TextFieldWithLabelDelegate {
    func changeText(_ textContent: UITextField?) {
        if let text = textContent?.text{
            if textContent?.tag == 0 {
                newTask?.title = text
            }
            else  if textContent?.tag == 1{
                newTask?.description = text
            }
            enableButton()
        }
    }
    

    @IBOutlet var taskTitle: TextFieldWithLabel!
    @IBOutlet weak var tracked: UISwitch!
    @IBOutlet var taskDescription: TextFieldWithLabel!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var alarmButton: UISwitch!
    @IBOutlet weak var label: UILabel!
    var task : TaskModel? = TaskModel()
    var newTask : TaskModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("aici incepe")
        newTask = task
        print("aici se termina")
        taskTitle.configureTextField(with: "Title",tag: 0 ,delegate: self)
        taskTitle.setText(with: task?.title ?? "")
        taskDescription.configureTextField(with: "Description",tag: 1 ,delegate: self)
        taskDescription.setText(with: task?.description ?? "")
        if ((task?.tracked) == true) {
            tracked.setOn(true, animated: false)
        }
        if let priority = task?.priority{
            segment.selectedSegmentIndex = priority - 1
        }
        button.isEnabled = false
        if !tracked.isOn {
            timePicker.isHidden.toggle()
            alarmButton.isHidden.toggle()
            label.isHidden.toggle()
        }
        self.hideKeyboardWhenTappedAround()

    }
    
    @IBAction func setPriority(_ sender: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 0:
            newTask?.priority = 1
        case 1:
            newTask?.priority = 2
        case 2:
            newTask?.priority = 3
        case 3:
            newTask?.priority = 4
        case 4:
            newTask?.priority = 5
        default: break;
        }
        enableButton()
    }
    
    
    @IBAction func setTime(_ sender: UIDatePicker) {
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "HH:mm E, d MMM y"
        var time : String = ""
        let date = sender.date
        time = formatter3.string(from: date)
        newTask?.time = time
        
    }
    
    @IBAction func setTracking(_ sender: Any) {
        if tracked.isOn {
            timePicker.isHidden.toggle()
            alarmButton.isHidden.toggle()
            label.isHidden.toggle()
            newTask?.tracked?.toggle()
            let date = Date.now
            let formatter3 = DateFormatter()
            formatter3.dateFormat = "HH:mm E, d MMM y"
            var time : String = ""
            time = formatter3.string(from: date)
            newTask?.time = time
        }
        else {
            timePicker.isHidden.toggle()
            alarmButton.isHidden.toggle()
            label.isHidden.toggle()
            newTask?.tracked?.toggle()
            newTask?.time = ""

            
        }
        enableButton()
    }
    
    @IBAction func Cancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func enableButton(){
        if newTask == task {
            button.isEnabled = false
        }
        else {
            button.isEnabled = true
        }
    }
    
    @IBAction func editTask(_ sender: Any) {
        if let edited = newTask{
            updateTask(updatedTask: edited) { data, response, error in
                if let error = error {
                    let alert = UIAlertController(title: "The task could not be edited. Try again please.", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
            }
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func deleteTask(_ sender: Any) {
        if let task = task, let taskId = task.taskId {
            deleteATask(taskId: taskId) { success in
                if success {
                    let alert = UIAlertController(title: "The task was deleted.", message: "Please refresh your list of tasks to see the cahnge.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in         self.dismiss(animated: true)}))
                    DispatchQueue.main.async {
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                } else {
                    let alert = UIAlertController(title: "The task could not be deleted.", message: "Please try again.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in        self.dismiss(animated: true)}))
                    DispatchQueue.main.async {
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
}
