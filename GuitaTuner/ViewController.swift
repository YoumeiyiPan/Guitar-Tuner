//
//  ViewController.swift
//  GuitaTuner
//
//  Created by Youmeiyi Pan on 4/4/17.
//  Copyright © 2017 Youmeiyi Pan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PdListener {

    @IBOutlet weak var pitchLabel: UILabel!
    @IBOutlet weak var detectFreq: UILabel!
    //MARK: Properties
    let pd = PdAudioController()
    let dispathcher = PdDispatcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pdInit = pd.configurePlayback(withSampleRate: 44100, numberChannels: 2, inputEnabled: true, mixingEnabled: false)
        if pdInit != PdAudioOK  //
        {
            print("Eroor, could not instantiate pd audio engine")
            return
        }
        dispathcher.add(self, forSource: "pitch")
        PdBase.setDelegate(dispathcher)
        fiddle_tilde_setup()
        
        let patch = PdBase.openFile("tuner.pd", path: Bundle.main.resourcePath)
        if patch == nil {
            print("Failed to open patch!")
            
        } else {
            pd.isActive = true
        }

        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    func receive(_ received: Float, fromSource source: String!) {
        if source == "pitch" {
            print("received float: \n(received)")
            detectFreq.text = "\(received)" + "Hz"
        }
    }

    func playNote(_ n: Int) {
        PdBase.send(Float(n), toReceiver: "midinote")
        PdBase.sendBang(toReceiver: "trigger")
    }
    @IBAction func playE(_ sender: Any) {
        playNote(40)
        pitchLabel.text = "Playing E"
    }
  
    @IBAction func playA(_ sender: Any) {
        playNote(45)
        pitchLabel.text = "Playing A"
    }
    @IBAction func playD(_ sender: Any) {
        playNote(50)
        pitchLabel.text = "Playing D"
    }
    @IBAction func playG(_ sender: Any) {
        playNote(55)
        pitchLabel.text = "Playing G"
    }

    @IBAction func playB(_ sender: Any) {
        playNote(59)
        pitchLabel.text = "Playing B"
    }
    @IBAction func playE2(_ sender: Any) {
        playNote(64)
        pitchLabel.text = "Playing E2"
    }
}























