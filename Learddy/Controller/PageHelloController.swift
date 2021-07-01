//
//  PageHelloController.swift
//  Learddy
//
//  Created by Miftah Juanda Batubara on 17/06/21.
//

import UIKit
import AVFoundation

class PageHelloController: UIViewController {

    @IBOutlet weak var img_maskot: UIImageView!
    @IBOutlet weak var btn_next: UIButton!
    @IBOutlet weak var view_bottom: UIView!
    @IBOutlet weak var lbl_name: UILabel!
    
    let synthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateLayout()
    }
    
    @IBAction func btn_next(_ sender: Any) {
        performSegue(withIdentifier: "ToPageLearn", sender: self)
    }
    
    func updateLayout() {
        self.view.backgroundColor = UIColor(red: 239/255, green: 250/255, blue: 253/255, alpha: 1)
        
        view_bottom.layer.cornerRadius = 40
        view_bottom.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view_bottom.layer.borderWidth = 0.7
        view_bottom.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.40)
        view_bottom.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.addSubview(view_bottom)
        
        btn_next.backgroundColor = UIColor(red: 21/255, green: 151/255, blue: 187/255, alpha: 1)
        btn_next.layer.cornerRadius = 18
        
        img_maskot.image = UIImage(named: "didi_happy")
        
        lbl_name.text = "Hello, \(UserDefaults.standard.object(forKey: "NameUser") as! String) 👋"
        addDidiSound()
    }
    
    func addDidiSound(){
        let name = UserDefaults.standard.string(forKey: "NameUser")
        let utterance = AVSpeechUtterance(string: "Hello, \(name!). Let's learn together!")
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.pitchMultiplier = 2.0
        synthesizer.speak(utterance)
    }

}
