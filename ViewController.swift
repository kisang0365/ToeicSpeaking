//
//  ViewController.swift
//  ToeicSpeaking
//
//  Created by 기상이 on 2017. 6. 26..
//  Copyright © 2017년 kisangCho. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var selectedChapter : Int?
  
    func moveView(chapter : Int?){
        let uvc = self.storyboard!.instantiateViewController(withIdentifier: "TimerVC") as! TimerView // 1
        uvc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve // 2
       // uvc.selectedChapter = chapter
        self.present(uvc, animated: true, completion: nil) // 3
    }
    
    @IBAction func btn_Chapter1_Click(_ sender: UIButton) {
        moveView(chapter: 1)
    }
    @IBAction func btn_Chapter2_Click(_ sender: UIButton) {
        moveView(chapter: 2)
    }
    
    @IBAction func btn_Chapter3_Click(_ sender: UIButton) {
        moveView(chapter: 3)
    }
    
    @IBAction func btn_Chapter4_Click(_ sender: UIButton) {
        moveView(chapter: 4)
    }
    
    @IBAction func btn_Chapter5_Click(_ sender: UIButton) {
        moveView(chapter: 5)
    }
    
    @IBAction func btn_Chapter6_Click(_ sender: UIButton) {
        moveView(chapter: 6)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

