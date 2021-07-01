//
//  PageFourController.swift
//  Learddy
//
//  Created by Miftah Juanda Batubara on 16/06/21.
//

import UIKit
import AVFoundation

class PageFourController: UIViewController {

    @IBOutlet weak var img_maskot_tiga: UIImageView!
    @IBOutlet weak var view_bottom_tiga: UIView!
    @IBOutlet weak var btn_next_tiga: UIButton!
    @IBOutlet weak var lbl_hello: UILabel!
    
    let synthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLayout()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn_next_home(_ sender: Any) {
        performSegue(withIdentifier: "ToPageHome", sender: self)
    }
    
    
    func updateLayout() {
        //print("\(UserDefaults.standard.object(forKey: "NameUser"))")
        self.view.backgroundColor = UIColor(red: 239/255, green: 250/255, blue: 253/255, alpha: 1)
        
        view_bottom_tiga.layer.cornerRadius = 40
        view_bottom_tiga.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view_bottom_tiga.layer.borderWidth = 0.7
        view_bottom_tiga.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.40)
        view_bottom_tiga.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.addSubview(view_bottom_tiga)
        
        btn_next_tiga.backgroundColor = UIColor(red: 21/255, green: 151/255, blue: 187/255, alpha: 1)
        btn_next_tiga.layer.cornerRadius = 18
        
        img_maskot_tiga.image = UIImage(named: "didi.2_normal")
        
        let name = UserDefaults.standard.string(forKey: "NameUser")
        
        lbl_hello.text = "Alright, \(name!). Are you ready to start our learning journey together?"
        addDidiSound()
    }
    
    func addDidiSound(){
        let name = UserDefaults.standard.string(forKey: "NameUser")
        let utterance = AVSpeechUtterance(string: "Alright, \(name!). Are you ready to start our learning journey together??")
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.pitchMultiplier = 2.0
        synthesizer.speak(utterance)
        print("testt \(name)")
    }

}
