//
//  TimerView.swift
//  ToeicSpeaking
//
//  Created by 기상이 on 2017. 6. 29..
//  Copyright © 2017년 kisangCho. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class TimerView : UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate{
    
    //Chapter
    let prepareTime = [0, 45, 45, 30, 0, 0, 0, 0, 0, 0, 30, 15]
    let answerTime = [0, 45, 45, 45, 15,15 ,30, 15, 15, 30, 60, 60]
    
    //Timer
    var selectedChapter : Int? = 1
    var count : Int = 45
    var soundPlay = SoundPlayer()
    var timer : Timer?
    
    //record
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var recordPlay: AVAudioPlayer!
    
    //Timer Source
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
    
    
    //Record
    
    @IBAction func click_Record(_ sender: UIButton) {
        
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
        
    }
    
    @IBAction func click_RecodStop(_ sender: UIButton) {
        finishRecording(success: false)
    }
    
    @IBAction func click_RecordPlay(_ sender: UIButton) {
        recordPlayStart()
    }
    
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
         //   recordButton.setTitle("Tap to Stop", for: .normal)
        } catch {
            finishRecording(success: false)
        }
    }
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
       //     recordButton.setTitle("Tap to Re-record", for: .normal)
        } else {
         //   recordButton.setTitle("Tap to Record", for: .normal)
            // recording failed :(
        }
    }
    
    func audioInit(){
        
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                 //       self.loadRecordingUI()
                    } else {
                        // failed to record!
                    }
                }
            }
        } catch {
            // failed to record!
        }
    }
    
    func recordPlayStart(){
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        
        do {
            let sound = try AVAudioPlayer(contentsOf: audioFilename)
            recordPlay = sound
            sound.play()
        } catch {
            // couldn't load file :(
        }
        /* 멈춤.
        if bombSoundEffect != nil {
            bombSoundEffect.stop()
            bombSoundEffect = nil
        }*/
    }
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        chapter_Stepper.wraps = true //최대값 다음 최소값
        chapter_Stepper.autorepeat = true //누르고있으면 반복해서 적용
        chapter_Stepper.minimumValue = 1
        chapter_Stepper.maximumValue = 11
        time_Label.text = "\(count):00"
        audioInit()
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
}
