//
//  ViewController.swift
//  Task Punch Card
//
//  Created by Daniel Grayson on 2/22/16.
//  Copyright © 2016 Daniel Grayson. All rights reserved.
//

import UIKit
import QuartzCore

extension String {
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
    func length()-> Int {
        return self.characters.count
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Create task arrays
    var allTasks = [
        Task(name: "Doing Nothing", times: [TimePair()] ),
        Task(name: "Ford", times: [] ),
        Task(name: "Internal", times: [] )
    ]
    
    var currentTaskIndex = 0

    @IBOutlet weak var currentTaskLabel: UILabel!
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var tallyTableView: UITableView!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let currentTask = allTasks[indexPath.row]
        
        if tableView == self.taskTableView {
            cell.textLabel!.text = currentTask.name
        }
        else if tableView == self.tallyTableView {
            cell.textLabel!.text = getTalliedLabel(currentTask)
        }
        cell.backgroundColor = UIColor.clearColor()
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red: 0.1, green: 0.8, blue: 0.2, alpha: 0.2)
        cell.selectedBackgroundView = bgColorView
        
        let bgGradientView = GradientView()
        bgGradientView.firstColor = UIColor(red: 1.0, green: 0.8, blue: 0.4, alpha: 1.0)
        bgGradientView.secondColor = UIColor(red: 1.0, green: 0.9, blue: 0.6, alpha: 1.0)
        cell.backgroundView = bgGradientView
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let taskName = allTasks[indexPath.row].name
        print("Selected \(taskName)")
        setTaskStarted(indexPath.row)
    }
    
    func setTaskStarted(taskIndex: Int) {
        if currentTaskIndex != taskIndex {
            endCurrentTask()
            updateCurrentTaskLabel(taskIndex)
            allTasks[taskIndex].times += [TimePair()]
            currentTaskIndex = taskIndex
        }
    }
    
    func endCurrentTask() {
        let endIndex: Int = allTasks[currentTaskIndex].times.count - 1
        if endIndex >= 0 && allTasks[currentTaskIndex].times[endIndex].end == nil {
            allTasks[currentTaskIndex].times[endIndex].end = NSDate()
        }
    }
    
    func updateCurrentTaskLabel(taskIndex: Int) {
        currentTaskLabel.text = "Current Task: " + allTasks[taskIndex].name
    }
    
    @IBOutlet weak var newTaskName: UITextField!
    
    @IBAction func addNewTask(sender: AnyObject) {
        if let taskToAdd = newTaskName.text {
            print("Add new task: \(taskToAdd)")
            if taskToAdd.trim().length() > 0 {
                allTasks += [Task(name: taskToAdd, times: [])]
            }
            newTaskName.text = ""
        }
        view.endEditing(true)
        taskTableView.reloadData()
    }
    
    @IBAction func tallyHours(sender: AnyObject) {
        endCurrentTask()
        setTaskStarted(0)
        endCurrentTask()
        for myTask in allTasks {
            let elapsedTime = getTimeForTask(myTask)
            print("\(myTask.name) : \(elapsedTime)")
        }
        tallyTableView.reloadData()
    }
    
    func getTimeForTask(myTask: Task) -> Int {
        var elapsedTime = 0
        for myTimePair in myTask.times {
            if let endTime = myTimePair.end {
                let interval = endTime.timeIntervalSinceDate(myTimePair.start)
                elapsedTime += Int(interval)
            }
            else {
                print("\(myTask.name) had an invalid end time")
                return 0
            }
        }
        return elapsedTime
    }
    
    func getTalliedLabel(myTask: Task) -> String {
        let seconds = getTimeForTask(myTask)
        return "\(myTask.name) : \(String(format: "%.5f", getHoursFromSeconds(seconds))) hrs"
    }
    
    func getHoursFromSeconds(seconds: Int) -> Double {
        let theSeconds = Double(seconds)
        let hours = theSeconds / 60 / 60
        return hours
    }
    
    @IBAction func resetTimes(sender: AnyObject) {
        for index in 0..<allTasks.count {
            if index == 0 {
                allTasks[0].times = [TimePair()]
            }
            else {
                allTasks[index].times = []
            }
        }
        tallyTableView.reloadData()
    }
    
    @IBOutlet weak var tallyButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var newTaskButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let topColor = UIColor(red: 1.0, green: 0.65, blue: 0.25, alpha: 1.0)
        let bottomColor = UIColor(red: 1.0, green: 0.8, blue: 0.4, alpha: 1.0)
        
        let gradientLayer = CAGradientLayer().getLayer(topColor, bottomColor: bottomColor)
        
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, atIndex: 0)
        
        currentTaskLabel.layer.cornerRadius = 4
        currentTaskLabel.layer.masksToBounds = true
        tallyButton.layer.cornerRadius = 4
        tallyButton.layer.masksToBounds = true
        resetButton.layer.cornerRadius = 4
        resetButton.layer.masksToBounds = true
        newTaskButton.layer.cornerRadius = 4
        newTaskButton.layer.masksToBounds = true
        newTaskButton.layer.borderWidth = 1
        newTaskButton.layer.borderColor = UIColor.brownColor().CGColor
        
        taskTableView.layer.cornerRadius = 4
        taskTableView.layer.masksToBounds = true
        tallyTableView.layer.cornerRadius = 4
        tallyTableView.layer.masksToBounds = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

