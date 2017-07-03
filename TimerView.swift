//
//  TimerView.swift
//  ToeicSpeaking
//
//  Created by 기상이 on 2017. 6. 29..
//  Copyright © 2017년 kisangCho. All rights reserved.
//

import Foundation

import UIKit

class TimerView : UIViewController{
    
    let prepareTime = [0, 45, 45, 30, 0, 0, 0, 0, 0, 0, 30, 15]
    let answerTime = [0, 45, 45, 45, 15,15 ,30, 15, 15, 30, 60, 60]
    var selectedChapter : Int? = 1
    var count : Int = 45
    var soundPlay = SoundPlayer()
    
    var timer : Timer?
    
    
    @IBOutlet weak var time_Label: UILabel!
    @IBOutlet weak var chapter_Label: UILabel!
    @IBOutlet weak var chapter_Stepper: UIStepper!
    @IBOutlet weak var chapterNumber: UILabel!
    

    @IBAction func backView(_ sender: Any) {
                self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func click_Stepper(_ sender: UIStepper) {
        chapter_Label.text = Int(sender.value).description
        selectedChapter = Int(sender.value)
        count = answerTime[selectedChapter!]
        time_Label.text = "\(count):00"
        stopTimer()
    }
    
    @IBAction func click_start(_ sender: UIButton) {
        
        if(timer == nil){
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: Selector("startTimer"), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func click_pause(_ sender: UIButton) {
        stopTimer()
    }
    
    @IBAction func click_reset(_ sender: UIButton) {
        stopTimer()
        count = answerTime[selectedChapter!]

        time_Label.text = "\(count):00"
    }
    
    
    func startTimer(){
        
        if(count <= 0)
        {
            soundPlay.startSound()
            stopTimer()
            
        }
        else { count = count-1 }
        if(count < 10) { time_Label.text = "0\(count):00" }
        else { time_Label.text = "\(count):00" }
        
        
        print(count)
    }
    
    func stopTimer(){
        self.timer?.invalidate()
        self.timer = nil
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        chapter_Stepper.wraps = true //최대값 다음 최소값
        chapter_Stepper.autorepeat = true //누르고있으면 반복해서 적용
        chapter_Stepper.minimumValue = 1
        chapter_Stepper.maximumValue = 11
        time_Label.text = "\(count):00"
    }

}
