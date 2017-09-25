//
//  TrygetViewController.swift
//  Sensor
//
//  Created by Chadwick Zhao on 11/11/2016.
//  Copyright © 2016 youbing.song. All rights reserved.
//

import UIKit

//Swifty.json makes it easy to deal with json data in Swift.
//https://github.com/Swiftyjson/Swiftyjson
import SwiftyJSON


import AVFoundation

class TrygetViewController: UIViewController {

    var countdown = 0
    var myTimer: NSTimer? = nil
    var backgroundMusicPlayer = AVAudioPlayer()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "bg_image")
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: self, action: "stopPlay:")
        self.navigationItem.leftBarButtonItem = newBackButton
        getjson(1)
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // set a time to retrive data repeatedly
        myTimer = NSTimer.scheduledTimerWithTimeInterval(1 , target: self, selector: "countDownTick", userInfo: nil, repeats: true)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        getjson(1)
        
    }
    
    // triggle timer method
    func countDownTick(){
        getjson(1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // Getting gesture X velocity from leap motion, and mapping it to 15 music files. Different gesture velocity will play different music file.
    func getjson(n:Int?){
        
        // URL for retrieve data
        var json:JSON!
        let BaseURL = "http://118.139.12.106:8080/gestureXVelocity"
        let url = NSURL(string: BaseURL)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!)
        {
            (mydata, respinse, error) in
            
            // render data
            if error == nil {
                 dispatch_async(dispatch_get_main_queue()){
                    var option:Double?
                    json = JSON(data: mydata!)
                    if json != nil
                    {
                        
                        option = json[0]["velocity"].double!
                        print(option)
                        
                        // velocity range greater than 300
                        if option>300 {
                            let url1 = NSBundle.mainBundle().URLForResource("11.wav", withExtension: nil)
                            guard let newURL = url1 else {
                                print("Could not find file: \(11)")
                                return
                            }
                            do {
                                self.backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: newURL)
                                self.backgroundMusicPlayer.numberOfLoops = 0
                                self.backgroundMusicPlayer.prepareToPlay()
                                self.backgroundMusicPlayer.play()
                            } catch let error as NSError {
                                print(error.description)
                            }
                            
                        }
                            // velocity range between 250 and 300
                        else if option>250 && option<300{
                            let url1 = NSBundle.mainBundle().URLForResource("12.wav", withExtension: nil)
                            guard let newURL = url1 else {
                                print("Could not find file: \(12)")
                                return
                            }
                            do {
                                self.backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: newURL)
                                self.backgroundMusicPlayer.numberOfLoops = 0
                                self.backgroundMusicPlayer.prepareToPlay()
                                self.backgroundMusicPlayer.play()
                            } catch let error as NSError {
                                print(error.description)
                            }
                        }
                            // velocity range between 200 and 250
                        else if option>200 && option<250{
                            let url1 = NSBundle.mainBundle().URLForResource("13.wav", withExtension: nil)
                            guard let newURL = url1 else {
                                print("Could not find file: \(13)")
                                return
                            }
                            do {
                                self.backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: newURL)
                                self.backgroundMusicPlayer.numberOfLoops = 0
                                self.backgroundMusicPlayer.prepareToPlay()
                                self.backgroundMusicPlayer.play()
                            } catch let error as NSError {
                                print(error.description)
                            }
                        }
                            
                            // velocity range between 150 and 200
                        else if option>150 && option<200{
                            let url1 = NSBundle.mainBundle().URLForResource("14.wav", withExtension: nil)
                            guard let newURL = url1 else {
                                print("Could not find file: \(14)")
                                return
                            }
                            do {
                                self.backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: newURL)
                                self.backgroundMusicPlayer.numberOfLoops = 0
                                self.backgroundMusicPlayer.prepareToPlay()
                                self.backgroundMusicPlayer.play()
                            } catch let error as NSError {
                                print(error.description)
                            }
                        }
                            
                            // velocity range between 100 and 150
                        else if option>100 && option<150{
                            let url1 = NSBundle.mainBundle().URLForResource("15.wav", withExtension: nil)
                            guard let newURL = url1 else {
                                print("Could not find file: \(15)")
                                return
                            }
                            do {
                                self.backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: newURL)
                                self.backgroundMusicPlayer.numberOfLoops = 0
                                self.backgroundMusicPlayer.prepareToPlay()
                                self.backgroundMusicPlayer.play()
                            } catch let error as NSError {
                                print(error.description)
                            }
                        }
                            // velocity range between 50 and 100

                        else if option>50 && option<100{
                            let url1 = NSBundle.mainBundle().URLForResource("21.wav", withExtension: nil)
                            guard let newURL = url1 else {
                                print("Could not find file: \(21)")
                                return
                            }
                            do {
                                self.backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: newURL)
                                self.backgroundMusicPlayer.numberOfLoops = 0
                                self.backgroundMusicPlayer.prepareToPlay()
                                self.backgroundMusicPlayer.play()
                            } catch let error as NSError {
                                print(error.description)
                            }
                        }
                            
                            // velocity range between 0 and 50
                            
                        else if option>0 && option<50{
                            let url1 = NSBundle.mainBundle().URLForResource("22.wav", withExtension: nil)
                            guard let newURL = url1 else {
                                print("Could not find file: \(22)")
                                return
                            }
                            do {
                                self.backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: newURL)
                                self.backgroundMusicPlayer.numberOfLoops = 0
                                self.backgroundMusicPlayer.prepareToPlay()
                                self.backgroundMusicPlayer.play()
                            } catch let error as NSError {
                                print(error.description)
                            }
                        }
                            // velocity range between -50 and 0
                            
                        else if option>(-50) && option<0{
                            let url1 = NSBundle.mainBundle().URLForResource("23.wav", withExtension: nil)
                            guard let newURL = url1 else {
                                print("Could not find file: \(23)")
                                return
                            }
                            do {
                                self.backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: newURL)
                                self.backgroundMusicPlayer.numberOfLoops = 0
                                self.backgroundMusicPlayer.prepareToPlay()
                                self.backgroundMusicPlayer.play()
                            } catch let error as NSError {
                                print(error.description)
                            }
                        }
                            // velocity range between -100 and -50
                            
                        else if option>(-100) && option<(-50){
                            let url1 = NSBundle.mainBundle().URLForResource("24.wav", withExtension: nil)
                            guard let newURL = url1 else {
                                print("Could not find file: \(24)")
                                return
                            }
                            do {
                                self.backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: newURL)
                                self.backgroundMusicPlayer.numberOfLoops = 0
                                self.backgroundMusicPlayer.prepareToPlay()
                                self.backgroundMusicPlayer.play()
                            } catch let error as NSError {
                                print(error.description)
                            }
                        }
                            // velocity range between -150 and -100
                            
                        else if option>(-150) && option<(-100){
                            let url1 = NSBundle.mainBundle().URLForResource("25.wav", withExtension: nil)
                            guard let newURL = url1 else {
                                print("Could not find file: \(25)")
                                return
                            }
                            do {
                                self.backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: newURL)
                                self.backgroundMusicPlayer.numberOfLoops = 0
                                self.backgroundMusicPlayer.prepareToPlay()
                                self.backgroundMusicPlayer.play()
                            } catch let error as NSError {
                                print(error.description)
                            }
                        }
                            // velocity range between -200 and -150
                            
                        else if option>(-200) && option<(-150){
                            let url1 = NSBundle.mainBundle().URLForResource("31.wav", withExtension: nil)
                            guard let newURL = url1 else {
                                print("Could not find file: \(32)")
                                return
                            }
                            do {
                                self.backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: newURL)
                                self.backgroundMusicPlayer.numberOfLoops = 0
                                self.backgroundMusicPlayer.prepareToPlay()
                                self.backgroundMusicPlayer.play()
                            } catch let error as NSError {
                                print(error.description)
                            }
                        }
                                // velocity range between -250 and -200
                            
                        else if option>(-250) && option<(-200){
                            let url1 = NSBundle.mainBundle().URLForResource("33.wav", withExtension: nil)
                            guard let newURL = url1 else {
                                print("Could not find file: \(33)")
                                return
                            }
                            do {
                                self.backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: newURL)
                                self.backgroundMusicPlayer.numberOfLoops = 0
                                self.backgroundMusicPlayer.prepareToPlay()
                                self.backgroundMusicPlayer.play()
                            } catch let error as NSError {
                                print(error.description)
                            }
                        }
                        else {
                            
                            let url1 = NSBundle.mainBundle().URLForResource("34.wav", withExtension: nil)
                            guard let newURL = url1 else {
                                print("Could not find file: \(34)")
                                return
                            }
                            do {
                                self.backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: newURL)
                                self.backgroundMusicPlayer.numberOfLoops = 0
                                self.backgroundMusicPlayer.prepareToPlay()
                                self.backgroundMusicPlayer.play()
                            } catch let error as NSError {
                                print(error.description)
                            }
                            
                            
                        }
                        
                    }
                    
                   // print(json[0]["velocity"].double!)
            
                    
                }
                
            } else {
                 print("error")
            }
            
        }
        task.resume()
    }
    
    
    
    
    func stopPlay(sender: UIBarButtonItem){
        myTimer?.invalidate()
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
