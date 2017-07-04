//
//  SoundPlayer.swift
//  ToeicSpeaking
//
//  Created by 기상이 on 2017. 7. 3..
//  Copyright © 2017년 kisangCho. All rights reserved.
//

import Foundation
import AudioToolbox
import AVFoundation

class SoundPlayer {
    
    var nowRecord = false
    var nowPlay = false
    
    var recordingSession : AVAudioSession!
    var audioRecorder    :AVAudioRecorder!
    var settings         = [String : Int]()
    
    func startSound(){
        AudioServicesPlaySystemSound(1007)
    }
    


}
