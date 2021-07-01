//
//  PageTwoController.swift
//  Learddy
//
//  Created by Miftah Juanda Batubara on 16/06/21.
//

import UIKit
import AVFoundation

class PageTwoController: UIViewController, UNUserNotificationCenterDelegate {

    @IBOutlet weak var view_bottom: UIView!
    @IBOutlet weak var img_maskot: UIImageView!
    @IBOutlet weak var btn_next_one: UIButton!
    
    var status: Bool! = false
    var didiSound: Bool! = false
    let audioPlay = Bundle.main.path(forResource: "bgSong-2", ofType: "mp3")
    let notifCenter = UNUserNotificationCenter.current()
    let synthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.notifCenter.delegate = self
        
        self.requestNotifAuth()
        self.sendNotification()
        
        if UserDefaults.standard.bool(forKey: "UserLogin") == true {
            ManagerSound.didiSound = true
            let homeVc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.navigationController?.pushViewController(homeVc, animated: true)
        }
        
        updateLayout()
        setMusicBg()
        ManagerSound.playedStatus = false
        ManagerSound.didiSound = false
        
    }
    
    
    @IBAction func btn_action_one(_ sender: Any) {
        performSegue(withIdentifier: "PagesTwo", sender: self)
        
    }

    func updateLayout() {
        self.view.backgroundColor = UIColor(red: 239/255, green: 250/255, blue: 253/255, alpha: 1)
        
        view_bottom.layer.cornerRadius = 40
        view_bottom.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view_bottom.layer.borderWidth = 0.7
        view_bottom.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.40)
        view_bottom.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.addSubview(view_bottom)
        
        btn_next_one.backgroundColor = UIColor(red: 21/255, green: 151/255, blue: 187/255, alpha: 1)
        btn_next_one.layer.cornerRadius = 18
        
        img_maskot.image = UIImage(named: "didi.2_normal")
        
        if ManagerSound.didiSound == didiSound {
            synthesizer.continueSpeaking()
            
            let utterance = AVSpeechUtterance(string: "Hii, i am your study buddy You can call me Didi!?")
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            utterance.pitchMultiplier = 2.0
            synthesizer.speak(utterance)
            print("Didi Sound ON")
            
        } else {
            synthesizer.pauseSpeaking(at: AVSpeechBoundary.immediate)
            print("Didi Sound Off")
        }
    }
    
    func setMusicBg(){
        do {
            try ManagerSound.player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPlay ?? "bgSong-2") as URL)
        }
        catch{
            print(error)
        }
        
        if ManagerSound.playedStatus == status {
            ManagerSound.player.play()
        } else {
            ManagerSound.player.pause()
        }
    }
    
    func requestNotifAuth() {
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        
        self.notifCenter.requestAuthorization(options: authOptions, completionHandler:{ (succes, error) in
            if let error = error {
                print("error: ", error)
            }
        })
    }
    
    func sendNotification() {
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "How are you doing buddy?"
        notificationContent.body = "You Haven't Learn for 2 days :("
        notificationContent.badge = NSNumber(value: 3)
        
        if let url = Bundle.main.url(forResource: "dune",
                                        withExtension: "png") {
            if let attachment = try? UNNotificationAttachment(identifier: "dune", url: url,options: nil) { notificationContent.attachments = [attachment]
            }
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "testNotification", content: notificationContent, trigger: trigger)
        
        notifCenter.add(request, withCompletionHandler: {(error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        })
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }

}
struct ManagerSound {
    static var player: AVAudioPlayer = AVAudioPlayer()
    static var playedStatus = Bool()
    static var didiSound = Bool()
}

