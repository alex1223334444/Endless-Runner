//
//  AddTaskViewController.swift
//  ToBeDone
//
//  Created by Udrea Alexandru-Iulian-Alberto on 25.12.2022.
//

import UIKit
import FirebaseAuth

/*extension UIView {
    func showToast(toastMessage: String, duration: CGFloat) {
    // View to blur bg and stopping user interaction
    let bgView = UIView(frame: self.frame)
    bgView.backgroundColor = UIColor(red: CGFloat(255.0/255.0), green: CGFloat(255.0/255.0), blue: CGFloat(255.0/255.0), alpha: CGFloat(0.6))
    bgView.tag = 555

    // Label For showing toast text
    let lblMessage = UILabel()
    lblMessage.numberOfLines = 0
    lblMessage.lineBreakMode = .byWordWrapping
    lblMessage.textColor = .white
    lblMessage.backgroundColor = .black
    lblMessage.textAlignment = .center
    lblMessage.font = UIFont.init(name: "Helvetica Neue", size: 17)
    lblMessage.text = toastMessage

    // calculating toast label frame as per message content
    let maxSizeTitle: CGSize = CGSize(width: self.bounds.size.width-16, height: self.bounds.size.height)
    var expectedSizeTitle: CGSize = lblMessage.sizeThatFits(maxSizeTitle)
    // UILabel can return a size larger than the max size when the number of lines is 1
    expectedSizeTitle = CGSize(width: maxSizeTitle.width.getMinimum(value2: expectedSizeTitle.width), height: maxSizeTitle.height.getMinimum(value2: expectedSizeTitle.height))
    lblMessage.frame = CGRect(x:((self.bounds.size.width)/2) - ((expectedSizeTitle.width+16)/2), y: (self.bounds.size.height/2) - ((expectedSizeTitle.height+16)/2), width: expectedSizeTitle.width+16, height: expectedSizeTitle.height+16)
    lblMessage.layer.cornerRadius = 8
    lblMessage.layer.masksToBounds = true
    lblMessage.padding = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    bgView.addSubview(lblMessage)
    self.addSubview(bgView)
    lblMessage.alpha = 0

    UIView.animateKeyframes(withDuration: TimeInterval(duration), delay: 0, options: [], animations: {
        lblMessage.alpha = 1
    }, completion: { success in
        UIView.animate(withDuration: TimeInterval(duration), delay: 8, options: [], animations: {
        lblMessage.alpha = 0
        bgView.alpha = 0
        })
        bgView.removeFromSuperview()
    })
}
}

extension CGFloat {
    func getMinimum(value2: CGFloat) -> CGFloat {
    if self < value2 {
        return self
    } else
    {
        return value2
        }
    }
}
        
        // MARK: Extension on UILabel for adding insets - for adding padding in top, bottom, right, left.
        
        extension UILabel {
        private struct AssociatedKeys {
            static var padding = UIEdgeInsets()
        }
        
        var padding: UIEdgeInsets? {
            get {
            return objc_getAssociatedObject(self, &AssociatedKeys.padding) as? UIEdgeInsets
            }
            set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.padding, newValue as UIEdgeInsets?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            }
        }
        
        override open func draw(_ rect: CGRect) {
            if let insets = padding {
                self.drawText(in: rect.inset(by: insets))
            } else {
            self.drawText(in: rect)
            }
        }
        
        override open var intrinsicContentSize: CGSize {
            get {
            var contentSize = super.intrinsicContentSize
            if let insets = padding {
                contentSize.height += insets.top + insets.bottom
                contentSize.width += insets.left + insets.right
            }
            return contentSize
            }
        }
    }*/

extension UIViewController {
  func showToast(message: String, seconds: Double) {
    let alert = UIAlertController(title: nil, message: message,
      preferredStyle: .alert)
    alert.view.backgroundColor = UIColor.black
    alert.view.alpha = 0.6
    alert.view.layer.cornerRadius = 15
    present(alert, animated: true)
    do{
        sleep(UInt32(seconds))
        alert.dismiss(animated: true)
    }
  }
}

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
    private var user : User? = User(username: "", lastName: "", uid: "", firstName: "", totalTasks: 0, doneTasks: 0, coins: 0)
    @IBAction func Tracked(_ sender: Any) {
        if TrackedBtn.isOn {
            CalendarPkr.isHidden.toggle()
            AlarmBtn.isHidden.toggle()
            AlarmLabel.isHidden.toggle()
            tracked?.toggle()
        }
        else {
            showToast(message: "Task Created Successfully", seconds: 1.1)
            CalendarPkr.isHidden.toggle()
            AlarmBtn.isHidden.toggle()
            AlarmLabel.isHidden.toggle()
            tracked?.toggle()
        }
    }
    
    @IBAction func Priority(_ sender: UISegmentedControl) {
        switch PriorityPicker.selectedSegmentIndex {
        case 0:
            showToast(message: "Task Created Successfully", seconds: 1.1)
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
    }
    
    @IBAction func Alarm(_ sender: Any) {
    }
    
    @IBAction func Calendar(_ sender: UIDatePicker) {
        date = sender.date
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
            getUser(id: uid ?? " " ) { result in
                switch result {
                case .success(let user):
                    print("aici")
                    self.user = user[0]
                    break
                case .failure(let error):
                    print("aici eroare")
                    print(error)
                    break
                }
            }
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
        
        
        createTask(task: myTask ) { result in
            switch result {
            case .success(_):
                print(result)
                
                print("user")
                print(self.user)
                self.user?.totalTasks! += 1
                print("new user")
                print(self.user)
                print("")
                if let user = self.user {
                    updateUser(updatedUser: user) { data, response, error in
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
                
                
            case .failure(let error):
                print(error)
            }
        }
        viewController?.updateViewController()
        print("submit")
        
        //self.showToast(message: "Task Created Successfully", seconds: 1.1)
        
        /*let alert = UIAlertController(title: nil, message: "Task Created Successfully",
          preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        present(alert, animated: true)
        do{
            sleep(1)
            alert.dismiss(animated: true)
        }*/
        self.dismiss(animated: true)
        
    }
    
}




