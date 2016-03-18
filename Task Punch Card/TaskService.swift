//
//  TaskService.swift
//  Task Punch Card
//
//  Created by Daniel Grayson on 3/18/16.
//  Copyright © 2016 Daniel Grayson. All rights reserved.
//

import Foundation

class TaskService {
    
    // Create task arrays
    var allTasks = [
        Task(name: "Doing Nothing", times: [] ),
        Task(name: "Internal", times: [] )
    ]
    
    var currentTaskIndex = 0
    
    func addTask(taskName: String) {
        if taskName.trim().length() > 0 {
            allTasks += [Task(name: taskName, times: [])]
        }
    }
    
    func setTaskStarted(taskIndex: Int) {
        if currentTaskIndex != taskIndex {
            endCurrentTask()
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
    
    func tallyHours() {
        endCurrentTask()
        setTaskStarted(0)
        endCurrentTask()
        for myTask in allTasks {
            let elapsedTime = getTimeForTask(myTask)
            print("\(myTask.name) : \(elapsedTime)")
        }
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
    
    func resetTimes() {
        for index in 0..<allTasks.count {
            allTasks[index].times = []
        }
    }
    
    func count() -> Int {
        return allTasks.count
    }
    
    func taskForIndex(index: Int) -> Task {
        return allTasks[index]
    }
}
