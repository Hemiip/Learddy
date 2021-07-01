//
//  PageThreeController.swift
//  Learddy
//
//  Created by Miftah Juanda Batubara on 16/06/21.
//

import UIKit
import AVFoundation

class PageThreeController: UIViewController, UITextFieldDelegate,
UIScrollViewDelegate {

    @IBOutlet weak var img_maskot_dua: UIImageView!
    @IBOutlet weak var view_bottom_dua: UIView!
    @IBOutlet weak var name_field: UITextField!
    @IBOutlet weak var btn_next_dua: UIButton!
    
    let synthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateLayout()
        addDoneButtonOnKeyboard()
        handleKeyboard()
        
        // Do any additional setup after loading the view.
        
        if UserDefaults.standard.bool(forKey: "UserLogin") == true {
            let homeVc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.navigationController?.pushViewController(homeVc, animated: true)
        }
        
    }
    
    @IBAction func btn_next_two(_ sender: Any) {
        let name: String = name_field.text ?? ""
        
        if !name.isEmpty {
            UserDefaults.standard.set(true, forKey: "UserLogin")
            UserDefaults.standard.set("\(name)", forKey: "NameUser")
            performSegue(withIdentifier: "PageThree", sender: self)
        } else {
            self.alertDial()
            print("Isii text")
        }
    }
    
    func updateLayout() {
        self.view.backgroundColor = UIColor(red: 239/255, green: 250/255, blue: 253/255, alpha: 1)
        
        view_bottom_dua.layer.cornerRadius = 40
        view_bottom_dua.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view_bottom_dua.layer.borderWidth = 0.7
        view_bottom_dua.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.40)
        view_bottom_dua.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.addSubview(view_bottom_dua)
        
        btn_next_dua.backgroundColor = UIColor(red: 21/255, green: 151/255, blue: 187/255, alpha: 1)
        btn_next_dua.layer.cornerRadius = 18
        
        img_maskot_dua.image = UIImage(named: "didi.2_normal")
        
        addDidiSound()
    }
    
    func addDidiSound(){
        let utterance = AVSpeechUtterance(string: "What's your name, buddy?")
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.pitchMultiplier = 2.0
        synthesizer.speak(utterance)
    }

    func addDoneButtonOnKeyboard(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.backgroundColor = UIColor(red: 239/255, green: 250/255, blue: 253/255, alpha: 1)
        toolbar.barStyle = UIBarStyle.default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonAction))

        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)

        toolbar.items = items as? [UIBarButtonItem]
        toolbar.sizeToFit()

        self.name_field.inputAccessoryView = toolbar

    }
    
    func alertDial(){
        alertButton(title: "Correct", message: "Please complete this field", completion: {alertController in
            let cancleAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel) {
                UIAlertAction in
            }
            alertController.addAction(cancleAction)
            
            self.present(alertController, animated: true, completion: nil)
        })
    }

    @objc func doneButtonAction()
    {
        self.name_field.resignFirstResponder()
    }
    
    func handleKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(PageThreeController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
                  
                    NotificationCenter.default.addObserver(self, selector: #selector(PageThreeController   .keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
                    view.addGestureRecognizer(tap)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            dismissKeyboard()
            return true
        }
        
        @objc func keyboardWillShow(notification: NSNotification) {
            let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue

            guard ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil else {

               return
            }
            self.view.frame.origin.y = 0 - keyboardSize!.height
        }
        
        
        @objc func keyboardWillHide(notification: NSNotification) {
          self.view.frame.origin.y = 0
        }
        
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    
}
