//
//  PageStartController.swift
//  Learddy
//
//  Created by Miftah Juanda Batubara on 19/06/21.
//

import UIKit
import AVFoundation

class PageStartController: UIViewController {
    
    @IBOutlet weak var lblActivity: UILabel!
    @IBOutlet weak var lblTimeActivity: UILabel!
    @IBOutlet weak var imgMaskot: UIImageView!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var lblLetsStartNow: UILabel!
    @IBOutlet weak var btnBreak: UIButton!
    @IBOutlet weak var btnGiveUp: UIButton!
    @IBOutlet weak var btnMusic: UIButton!
    @IBOutlet weak var btnBackk: UIButton!
    
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    let synthesizer = AVSpeechSynthesizer()
    let enable = UIImage(named: "didi.2_angry")
    let disable = UIImage.gif(name: "didi_kedip")
    
    
    var isMusicc = false
    var timer: Timer?
    var totalTime: Int = 0
    var btnStartCount = 1
    var btnMusicCount = 1
    var pointAlert = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateLayout()
        ManagerSound.playedStatus = true
        ManagerSound.player.stop()

    }
    
    func updateLayout() {
        self.view.backgroundColor = UIColor(red: 239/255, green: 250/255, blue: 253/255, alpha: 1)
        
        btnStart.backgroundColor = UIColor(red: 21/255, green: 151/255, blue: 187/255, alpha: 1)
        btnStart.layer.cornerRadius = 18
        
        btnGiveUp.backgroundColor = UIColor(red: 21/255, green: 151/255, blue: 187/255, alpha: 1)
        btnGiveUp.layer.cornerRadius = 18
        
        btnBreak.backgroundColor = UIColor(red: 21/255, green: 151/255, blue: 187/255, alpha: 1)
        btnBreak.layer.cornerRadius = 18
        
        imgMaskot.image = UIImage(named: "didi_normal")
//        imgMaskot.image = UIImage.gif(asset: "didi_kedip")
        
        let titleActivity = UserDefaults.standard.string(forKey: "TitleLearn")
        lblActivity.text = titleActivity
        
        let timeTarget =  UserDefaults.standard.integer(forKey: "LblStudy")
        lblTimeActivity.text = convertToTime(totalSecond: timeTarget)
        totalTime = timeTarget
        
        startBackgroundMusic(music: false)
        btnBreak.isHidden = true
        btnGiveUp.isHidden = true
        btnMusic.isHidden = true
        btnBackk.isHidden = false
        btnBreak.setTitle("Break", for: .normal)
        btnGiveUp.setTitle("Give Up", for: .normal)
        btnStart.setTitle("Start", for: .normal)
        
        addDidiSound(speech: "Let's Start Now!")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionImgGesture(_:)))
        imgMaskot.addGestureRecognizer(tapGesture)
        imgMaskot.isUserInteractionEnabled = true
    }
    
    
    @IBAction func actionImgGesture(_ sender: UIGestureRecognizer) {
        let btns = btnStart.isHidden
        if (btns == true) {
            imgMaskot.image = (imgMaskot.image == enable) ? disable : enable
            let nama = UserDefaults.standard.string(forKey: "NameUser")
            addDidiSound(speech: "Focus \(nama!)")
            print(btns)
        } else {
            print("Gesture OFF")
        }
    }
    
    
    @IBAction func actionBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        startBackgroundMusic(music: false)
    }
    
    @IBAction func btnActionMusic(_ sender: UIButton) {
        btnMusicCount += 1
        btnBackk.isHidden = true
        switch btnMusicCount {
        case 1:
            print("music2")
            startBackgroundMusic(music: true)
            btnMusic.setImage(UIImage(named: "check.png"), for: .normal)
        case 2:
            print("music1")
            btnMusic.setImage(UIImage(named: "offcheck.png"), for:.normal)
            startBackgroundMusic(music: false)
            
            btnMusicCount = 0
            
        default:
            print("Unable to change button")
        }
    }
    
 
    @IBAction func btnActionStart(_ sender: UIButton) {
        btnStartCount += 1
        btnBackk.isHidden = true
        switch btnStartCount {
        case 1:
            print("start 2")
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onCountdown), userInfo: nil, repeats: true)
            btnStart.isHidden = true
            btnBreak.isHidden = false
            btnGiveUp.isHidden = false
            imgMaskot.loadGif(name: "didi_kedip")
            
            let falseLearnMusic = UserDefaults.standard.bool(forKey: "falseMusic")
            if falseLearnMusic == false {
                self.startBackgroundMusic(music: false)
            } else {
                self.startBackgroundMusic(music: true)
            }
            
        case 2:
            print("start 1")
            UserDefaults.standard.set(true, forKey: "StatusMusicBg")
            
            let falseLearnMusic = UserDefaults.standard.bool(forKey: "falseMusic")
            if falseLearnMusic == false {
                print("INIII \(falseLearnMusic)")
                btnMusic.isHidden = true
                startBackgroundMusic(music: false)
            } else {
                btnMusic.isHidden = false
                startBackgroundMusic(music: true)
            }
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onCountdown), userInfo: nil, repeats: true)
        
            btnGiveUp.isHidden = false
            btnBreak.isHidden = false
            btnStart.isHidden = true
            imgMaskot.loadGif(name: "didi_kedip")
            lblLetsStartNow.isHidden = true
            
            btnStartCount = 0
    
        default:
            print("Unable to change button")
        }
    }
    
    
    @IBAction func btnActionBreak(_ sender: UIButton) {
        self.timer?.invalidate()
        btnStart.isHidden = false
        btnStart.setTitle("Continue", for: .normal)
        
        startBackgroundMusic(music: false)
        
        imgMaskot.image = UIImage(named: "didi_happy")
        btnBreak.isHidden = true
        btnGiveUp.isHidden = true
    }
    
    @IBAction func btnActionGiveUp(_ sender: UIButton) {
        self.timer?.invalidate()
        btnBackk.isHidden = true
        startBackgroundMusic(music: false)
        
        alertButton(title: "Are you sure?", message: "Are you sure you want to give up? You can take a break instead!", completion: {
            alertController in
            let yesAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
                UIAlertAction in
                    self.onYesButton()
            }
            
            let cancleAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                UIAlertAction in
                NSLog("Cancle Pressed")
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onCountdown), userInfo: nil, repeats: true)
                
                let falseLearnMusic = UserDefaults.standard.bool(forKey: "falseMusic")
                if falseLearnMusic == false {
                    self.startBackgroundMusic(music: false)
                } else {
                    self.startBackgroundMusic(music: true)
                }
            }
            alertController.addAction(yesAction)
            alertController.addAction(cancleAction)
            
            self.present(alertController, animated: true, completion: nil)
        })
    }
    
    func onYesButton() {
        print("Ini Yess Alertt")
        timer?.invalidate()
        saveData()
        goToResultPage()
        loadData()
    }
    
    @objc func onCountdown(){
        totalTime -= 1
        self.lblTimeActivity.text = timeString(time: totalTime )
        print("Countdown\(totalTime)")

        if totalTime == 0 {
            timer?.invalidate()
            timer = nil
            startBackgroundMusic(music: false)
            goToResultPage()
            saveData()
        }
    }
    
    func goToResultPage(){
        UserDefaults.standard.setValue(totalTime, forKey: "totalTimes")
        performSegue(withIdentifier: "ToPageResult", sender: self)
    }
    
    func startBackgroundMusic(music: Bool) {
        let judulRandom = UserDefaults.standard.string(forKey: "JudulMusicRandom")
        
        if let bundle = Bundle.main.path(forResource: judulRandom, ofType: "mp3") {
          let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: backgroundMusic as URL)
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                
                if isMusicc == music {
                    audioPlayer.pause()
                    btnMusic.setImage(UIImage(named: "offcheck.png"), for: .normal)
                } else{
                    audioPlayer.prepareToPlay()
                    audioPlayer.play()
                    btnMusic.setImage(UIImage(named: "check.png"), for: .normal)
                }
                
            } catch {
                print ("errorr nihh: \(error.localizedDescription)")
            }}

        do{
            if #available(iOS 10.0, *) {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord,options: AVAudioSession.CategoryOptions(rawValue: UInt(UInt8(AVAudioSession.CategoryOptions.defaultToSpeaker.rawValue)
                    | UInt8(AVAudioSession.CategoryOptions.mixWithOthers.rawValue)
                    | UInt8(AVAudioSession.CategoryOptions.allowAirPlay.rawValue))))
            } else {
            }
            print("Playback ok")
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord,options: AVAudioSession.CategoryOptions(rawValue: UInt(UInt8(AVAudioSession.CategoryOptions.defaultToSpeaker.rawValue)
                | UInt8(AVAudioSession.CategoryOptions.mixWithOthers.rawValue)
                | UInt8(AVAudioSession.CategoryOptions.allowAirPlay.rawValue))))
            
            print("session is active")
            
            if isMusicc == music {
                audioPlayer.pause()
                btnMusic.setImage(UIImage(named: "offcheck.png"), for: .normal)
            } else{
                audioPlayer.prepareToPlay()
                audioPlayer.play()
                btnMusic.setImage(UIImage(named: "check.png"), for: .normal)
            }
        }
        catch {
            print ("errorr nihh: \(error.localizedDescription)")
        }
    }
    
    func addDidiSound(speech: String){
        let utterance = AVSpeechUtterance(string: speech)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.pitchMultiplier = 2.0
        synthesizer.speak(utterance)
    }
    
    func saveData() {
        let date = Date()
        
        let titleLearn = UserDefaults.standard.string(forKey: "TitleLearn")
        let timeTargett = UserDefaults.standard.string(forKey: "LblStudy")

        let timeResult = Int(timeTargett!)! - totalTime
        
        // store to DB
        LearddyDB.shared.addLearddy(learnTitle: titleLearn!, timeResult: Int64(timeResult), timeSelect: Int64(timeTargett!)!, tanggal: date)
    }
    func loadData() {
//        learddy = LearddyDB.shared.fetchLeardy()
        let path = FileManager
                .default
                .urls(for: .applicationSupportDirectory, in: .userDomainMask)
                .last?
                .absoluteString
                .replacingOccurrences(of: "file://", with: "")
                .removingPercentEncoding

            print(path ?? "Not found")
    }
}
