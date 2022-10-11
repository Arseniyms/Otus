//
//  ViewController.swift
//  Otus
//
//  Created by Arseniy Matus on 10.10.2022.
//

import UIKit

class ViewController: UIViewController {
    var seconds = 0
    var timer = Timer()
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var timeLabel: UILabel!

    
    @IBAction func startAction(_ sender: UIButton) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
    }
    
    
    @IBAction func stopAction(_ sender: UIButton) {
        timer.invalidate()
    }
    
    @objc func timerAction() {
        seconds += 1
        let duration = Duration.seconds(seconds)
        let format = duration.formatted(.time(pattern: .minuteSecond(padMinuteToLength: 2)))
        
        timeLabel.text = "\(format)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)

    }
    
    @objc func appMovedToBackground() {
        timer.invalidate()
        viewDidLayoutSubviews()
    }
    
    
    override func viewDidLayoutSubviews() {
        startButton.isEnabled = !timer.isValid
        stopButton.isEnabled = timer.isValid
    }
}

