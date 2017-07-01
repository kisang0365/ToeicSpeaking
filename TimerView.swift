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
    
    var selectedChapter : Int?
    
    @IBOutlet weak var chapterNumber: UILabel!

    @IBAction func backView(_ sender: Any) {
                self.presentingViewController?.dismiss(animated: true)
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        print(selectedChapter!)
    }
    
}
