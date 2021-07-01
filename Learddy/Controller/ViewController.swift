//
//  ViewController.swift
//  Learddy
//
//  Created by Miftah Juanda Batubara on 15/06/21.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var img_maskot_empat: UIImageView!
    @IBOutlet weak var btn_learn: UIButton!
    @IBOutlet weak var btn_summary: UIButton!
    
//    private var learddy: [Leardy]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateLayout()
        ManagerSound.playedStatus = false
        ManagerSound.didiSound = true
        ManagerSound.player.play()

    }

    @IBAction func btn_learn_next(_ sender: Any) {
        performSegue(withIdentifier: "ToPageHello", sender: self)
//        loadDb()
    }
    
    
    @IBAction func btnActionResult(_ sender: UIButton) {
        performSegue(withIdentifier: "ToPageResult2", sender: self)
    }
    
    func updateLayout() {
        self.view.backgroundColor = UIColor(red: 239/255, green: 250/255, blue: 253/255, alpha: 1)
        
        btn_learn.backgroundColor = UIColor(red: 21/255, green: 151/255, blue: 187/255, alpha: 1)
        btn_learn.layer.cornerRadius = 18
        
        btn_summary.backgroundColor = UIColor(red: 21/255, green: 151/255, blue: 187/255, alpha: 1)
        btn_summary.layer.cornerRadius = 18
        
        img_maskot_empat.image = UIImage(named: "didi.2_normal")
    }
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    
        print("Inii becomeee")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
//    func loadDb() {
//        let leardy = LearddyDB.shared.fetchLeardy()
//
//        for items in leardy as [Leardy] {
//            print("INI Titleee :", items.learn_title!)
//        }
//    }
    
}
