//
//  TableViewController.swift
//  Sensor
//
//  Created by Chadwick Zhao on 11/11/2016.
//  Copyright © 2016 youbing.song. All rights reserved.
//

import UIKit
import CoreData
//Swifty.json makes it easy to deal with json data in Swift.
//https://github.com/Swiftyjson/Swiftyjson
import SwiftyJSON

import AVFoundation

class TableViewController: UITableViewController {
    
    var m:[Music]!
    var managedObjectContext: NSManagedObjectContext!
    var collectionitem: NSMutableArray
    var collectfromCreateList: NSObject
    
    required init?(coder aDecoder:NSCoder){
        self.collectfromCreateList = NSObject()
        self.collectionitem = NSMutableArray()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.managedObjectContext = appDelegate.managedObjectContext
        self.m = []
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let fetchRequest = NSFetchRequest()
        let entityDescription = NSEntityDescription.entityForName("Music", inManagedObjectContext: self.managedObjectContext)
        fetchRequest.entity = entityDescription
        var result = NSArray?()
        do {
            result = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            print(result!.count)
            if result!.count != 0{
                for r in result! {
                    let M = r as! Music
                    m.append(M)
                }
            }
        } catch{
            let fetchError = error as NSError
            print(fetchError)
            Alert.show("FILE FETCH ERROR", message: "\(fetchError)", vc: self)
        }
        
        print(m.description)


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func refreshTable(){
        do{
            try self.managedObjectContext.save()
            tableView.reloadData()
        } catch {
            print("save error")
            Alert.show("SAVE ERROR", message: "Cannot save file to database!", vc: self)
        }
        tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implemetation, return the number of rows
        return self.m.count
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if indexPath.section == 0 {
            return true
        }else {
            return false
        }
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        
        self.json = JSON.parse(self.m[indexPath.row].record!)
        self.speed = Double(self.m[indexPath.row].speed!)!
        
        playMusic()
        
        
    }
    
    
    
    //============================================================
    //PLAY MUSIC LOGICS
    //THREE FUNCTIONS
    //1. recordMusic()     >> START TO RECORD         eg: recordMusic()
    //2. playMusic()       >> PLAY RECORDED MUSIC     eg: playMusic()
    //3. modifyPlaySpeed   >> CHANGE THE PACE         eg: modifyPlaySpeed(0.5)
    //
    //TODO:  UI DISPLAY ERRORS  !!!#$%@#^!!!
    //============================================================
    
    var json:JSON?
    var musicTimer:NSTimer?
    var levelIndexPlayed:Int = 1
    var speed:Double = 0.5
    var maxRGB:Int = 1
    var maxCategory = "red"
    var backgroundMusicPlayer = AVAudioPlayer()
    
    //PRIVATE METHOD
    func playBackgroundMusic(filename: String) {
        let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
        guard let newURL = url else {
            print("Could not find file: \(filename)")
            return
        }
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: newURL)
            backgroundMusicPlayer.numberOfLoops = 0
            backgroundMusicPlayer.prepareToPlay()
            backgroundMusicPlayer.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    //PRIVATE METHOD
    func play() {
        // Code here
        
        var level = Int(ceilf(self.json![self.levelIndexPlayed-1][self.maxCategory].float!/255/64/50))
        
        
        if(level > 4){ level = 5 }
        playBackgroundMusic(String(self.maxRGB) + String(level) + ".wav")
        if(self.levelIndexPlayed == self.json?.count){
            self.musicTimer!.invalidate()
        }
        self.levelIndexPlayed++
    }
    
    
    
    // PUBLIC METHOD
    // playMusic Method
    func playMusic(){
        //stop playing
        if((self.musicTimer) != nil){
            self.musicTimer!.invalidate()
        }
        
        // wave.fps = speed
        //check json
        if(self.json?.count == 0 ){
            print("Network Error")  ////TODO  UI  DISPLAY
            return
        }
        
        //get max category
        var maxNum = max(max(self.json![0]["red"],self.json![0]["green"]),self.json![0]["blue"])
        if(maxNum == self.json![0]["green"]){
            maxRGB = 2
            maxCategory = "green"
        }else if(maxNum == self.json![0]["blue"]){
            maxRGB = 3
            maxCategory = "blue"
        }
      
            
            //Declare the timer
            self.musicTimer = NSTimer.scheduledTimerWithTimeInterval(speed, target:
                self, selector: "play", userInfo: nil, repeats: true)
            self.levelIndexPlayed = 1
            
        
    }
    
    //PUBLIC METHOD
    // speed should be ranging from 0.1 to 1
    func modifyPlaySpeed(newSpeed: Double){
        self.speed = newSpeed
    }
    
    //============================================================
    //END PLAY MUSIC LOGICS
    //============================================================
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            managedObjectContext.deleteObject(m.removeAtIndex(indexPath.row))
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellidentifer = "c1"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellidentifer, forIndexPath: indexPath) as! TableViewCell
        let gesturedName = self.m[indexPath.row].name
        
        cell.TitleLable.text = gesturedName
        cell.reloadInputViews()
                // Configure the cell...
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
