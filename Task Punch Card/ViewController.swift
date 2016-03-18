//
//  ViewController.swift
//  Task Punch Card
//
//  Created by Daniel Grayson on 2/22/16.
//  Copyright © 2016 Daniel Grayson. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Vars and outlets
    
    var taskService = TaskService()
    var selectedTaskIndexPath: NSIndexPath?

    @IBOutlet weak var currentTaskLabel: UILabel!
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var tallyTableView: UITableView!
    @IBOutlet weak var newTaskName: UITextField!
    @IBOutlet weak var tallyButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var newTaskButton: UIButton!
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyUIStyles()
    }
    
    // MARK: Actions
    
    @IBAction func addNewTask(sender: AnyObject) {
        if let taskToAdd = newTaskName.text {
            print("Add new task: \(taskToAdd)")
            taskService.addTask(taskToAdd)
            newTaskName.text = ""
        }
        view.endEditing(true)
        taskTableView.reloadData()
    }
    
    @IBAction func tallyHours(sender: AnyObject) {
        taskService.tallyHours()
        clearCurrentTaskIndications()
        tallyTableView.reloadData()
    }
    
    @IBAction func resetTimes(sender: AnyObject) {
        taskService.resetTimes()
        clearCurrentTaskIndications()
        tallyTableView.reloadData()
    }
    
    // MARK: UI Management
    
    func updateCurrentTaskLabel(taskIndex: Int) {
        currentTaskLabel.text = "Current Task: " + taskService.taskForIndex(taskIndex).name
    }
    
    func clearCurrentTaskIndications() {
        if let indexPath = selectedTaskIndexPath {
            taskTableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        currentTaskLabel.text = "Select a task: "
    }
    
    func applyUIStyles() {
        addGradientLayer()
        
        newTaskButton.layer.borderWidth = 1
        newTaskButton.layer.borderColor = UIColor.brownColor().CGColor
        
        roundCorners(currentTaskLabel)
        roundCorners(tallyButton)
        roundCorners(resetButton)
        roundCorners(newTaskButton)
        roundCorners(taskTableView)
        roundCorners(tallyTableView)
    }
    
    func addGradientLayer() {
        let topColor = UIColor(red: 1.0, green: 0.65, blue: 0.25, alpha: 1.0)
        let bottomColor = UIColor(red: 1.0, green: 0.8, blue: 0.4, alpha: 1.0)
        let gradientLayer = CAGradientLayer().getLayer(topColor, bottomColor: bottomColor)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, atIndex: 0)
    }
    
    func roundCorners(item: UIView) {
        item.layer.cornerRadius = 4
        item.layer.masksToBounds = true
    }
    
    func applyCellStyles(cell: UITableViewCell) {
        cell.backgroundColor = UIColor.clearColor()
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red: 0.1, green: 0.8, blue: 0.2, alpha: 0.2)
        cell.selectedBackgroundView = bgColorView
        
        let bgGradientView = GradientView()
        bgGradientView.firstColor = UIColor(red: 1.0, green: 0.8, blue: 0.4, alpha: 1.0)
        bgGradientView.secondColor = UIColor(red: 1.0, green: 0.9, blue: 0.6, alpha: 1.0)
        cell.backgroundView = bgGradientView
    }
    
    // MARK: Table View Data Source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskService.count()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let currentTask = taskService.taskForIndex(indexPath.row)
        
        if tableView == self.taskTableView {
            cell.textLabel!.text = currentTask.name
        }
        else if tableView == self.tallyTableView {
            cell.textLabel!.text = taskService.getTalliedLabel(currentTask)
        }
        applyCellStyles(cell)
        
        return cell
    }
    
    // MARK: Table View Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let taskName = taskService.taskForIndex(indexPath.row).name
        print("Selected \(taskName)")
        taskService.setTaskStarted(indexPath.row)
        updateCurrentTaskLabel(indexPath.row)
        selectedTaskIndexPath = indexPath
    }

}

