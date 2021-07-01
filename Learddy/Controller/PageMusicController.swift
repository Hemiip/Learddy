//
//  PageMusicController.swift
//  Learddy
//
//  Created by Miftah Juanda Batubara on 18/06/21.
//

import UIKit

class PageMusicController: UIViewController {
    
    
    @IBOutlet weak var img_maskot: UIImageView!
    @IBOutlet weak var view_bottom: UIView!
    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var btnYes: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateLayout()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionBtnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionBtnYes(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "falseMusic")
        performSegue(withIdentifier: "ToPageMusic2", sender: self)
    }
    
    @IBAction func actionBtnNo(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "falseMusic")
        performSegue(withIdentifier: "ToPageStart", sender: self)
    }
    
    func updateLayout() {
        self.view.backgroundColor = UIColor(red: 239/255, green: 250/255, blue: 253/255, alpha: 1)

        view_bottom.layer.cornerRadius = 40
        view_bottom.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view_bottom.layer.borderWidth = 0.7
        view_bottom.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.40)
        view_bottom.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.addSubview(view_bottom)

        btnYes.backgroundColor = UIColor(red: 21/255, green: 151/255, blue: 187/255, alpha: 1)
        btnYes.layer.cornerRadius = 18
        
        btnNo.backgroundColor = UIColor(red: 21/255, green: 151/255, blue: 187/255, alpha: 1)
        btnNo.layer.cornerRadius = 18

        img_maskot.image = UIImage(named: "didi_normal")
    }
    
}
