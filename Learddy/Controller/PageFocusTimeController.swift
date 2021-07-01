//
//  PageFocusTimeController.swift
//  Learddy
//
//  Created by Miftah Juanda Batubara on 19/06/21.
//

import UIKit
import AudioToolbox

class PageFocusTimeController: UIViewController {
    
    @IBOutlet weak var lblNameActivity: UILabel!
    @IBOutlet weak var lblTimeActivity: UILabel!
    @IBOutlet weak var imageMaskot: UIImageView!
    @IBOutlet weak var btnLearnAgain: UIButton!
    @IBOutlet weak var btnLearnSummary: UIButton!
    
    let textName = ["You succeed!!", "You Failed :("]
    
    var soundURL: NSURL?
    var soundID: SystemSoundID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLayout()
        
        // Do any additional setup after loading the view.
    }
    
    func updateLayout() {
        self.view.backgroundColor = UIColor(red: 239/255, green: 250/255, blue: 253/255, alpha: 1)
        
        let nameTitle = UserDefaults.standard.string(forKey: "TitleLearn")!
        let resultTime = UserDefaults.standard.integer(forKey: "totalTimes")
        lblTimeActivity.text = convertToTime(totalSecond: resultTime)
        
        if resultTime == 0 {
            lblNameActivity.text = "\(textName[0])\n\(nameTitle)"
            self.createParticles()
            self.SoundEffect(sound: "Success")
            imageMaskot.image = UIImage(named: "didi_happy")
        } else {
            lblNameActivity.text = "\(textName[1])\n\(nameTitle)"
            self.SoundEffect(sound: "fail")
            imageMaskot.image = UIImage(named: "didi_sad")
        }
    
        btnLearnSummary.backgroundColor = UIColor(red: 21/255, green: 151/255, blue: 187/255, alpha: 1)
        btnLearnSummary.layer.cornerRadius = 18
        
        btnLearnAgain.backgroundColor = UIColor(red: 21/255, green: 151/255, blue: 187/255, alpha: 1)
        btnLearnAgain.layer.cornerRadius = 18
        
        
    }
    
    
    func createParticles() {
        let particleEmitter = CAEmitterLayer()

        particleEmitter.emitterPosition = CGPoint(x: view.center.x / 2, y: -90)
        particleEmitter.emitterShape = .line
        particleEmitter.emitterSize = CGSize(width: view.frame.size.width, height: 1)

        let red = makeEmitterCell(color: UIColor.red)
        let green = makeEmitterCell(color: UIColor.systemGreen)
        let pink = makeEmitterCell(color: UIColor.systemPink)
        let blue = makeEmitterCell(color: UIColor.systemBlue)
        let yellow = makeEmitterCell(color: UIColor.yellow)
        let gray = makeEmitterCell(color: UIColor.gray)

        particleEmitter.emitterCells = [red, green,pink, blue, yellow, gray]

        view.layer.addSublayer(particleEmitter)
    }

    func makeEmitterCell(color: UIColor) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.scale = 0.13
        cell.birthRate = 30
        cell.lifetime = 7.0
        cell.lifetimeRange = 0
        cell.color = color.cgColor
        cell.velocity = 150
        cell.velocityRange = 100
        cell.emissionLongitude = CGFloat.pi
        cell.emissionRange = CGFloat.pi / 4
        cell.spin = 4
        cell.spinRange = 3
        cell.scaleSpeed = -0.02

        cell.contents = UIImage(named: "star.png")?.cgImage
        return cell
    }
    
    @IBAction func btnActionLearnAgain(_ sender: UIButton) {
        performSegue(withIdentifier: "BackToLearnAgain", sender: self)
    }
    
    
    @IBAction func btnActionResult(_ sender: UIButton) {
        performSegue(withIdentifier: "ToPageResult1", sender: self)
    }
    
    func SoundEffect(sound: String!){
        let filePath = Bundle.main.path(forResource: sound, ofType: "mp3")
        soundURL = NSURL(fileURLWithPath: filePath!)
        if let url = soundURL {
            AudioServicesCreateSystemSoundID(url, &soundID)
            AudioServicesPlaySystemSound(soundID)
        }
        
    }

}
