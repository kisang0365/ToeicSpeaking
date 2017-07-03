//
//  SoundPlayer.swift
//  ToeicSpeaking
//
//  Created by 기상이 on 2017. 7. 3..
//  Copyright © 2017년 kisangCho. All rights reserved.
//

import Foundation
import AudioToolbox

class SoundPlayer {
    
    func startSound(){
        AudioServicesPlaySystemSound(1007)
    }
    
}
