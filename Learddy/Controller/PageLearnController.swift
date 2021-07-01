//
//  PageLearnController.swift
//  Learddy
//
//  Created by Waldi Febrianda on 17/06/21.
//

import UIKit
import AVFoundation

class PageLearnController: UIViewController,UITextFieldDelegate,
                           UIScrollViewDelegate {

    @IBOutlet weak var img_maskot: UIImageView!
    @IBOutlet weak var view_bottom: UIView!
    @IBOutlet weak var fiels_learn: UITextField!
    @IBOutlet weak var btn_next: UIButton!
    
    let synthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateLayout()
        handleKeyboard()
        addDoneButtonOnKeyboard()
    
    }
    
    @IBAction func actionBackButton(_ sender: Any) {
        self.performSegue(withIdentifier: "BackPageHome", sender: self)
    }
    
    
    @IBAction func btnNext(_ sender: Any) {
        let titleLearn = fiels_learn.text ?? ""
        
        if !titleLearn.isEmpty {
            UserDefaults.standard.set("\(titleLearn)", forKey: "TitleLearn")
            performSegue(withIdentifier: "ToPageTIme", sender: self)
        } else {
            alertDial()
        }
    
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

        img_maskot.image = UIImage(named: "didi_normal")
        addDidiSound()
    }
    
    func addDidiSound(){
        let utterance = AVSpeechUtterance(string: "what do you want to learn today?")
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

        self.fiels_learn.inputAccessoryView = toolbar
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
        self.fiels_learn.resignFirstResponder()
    }
    
    func handleKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(PageLearnController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
                  
                    NotificationCenter.default.addObserver(self, selector: #selector(PageLearnController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
                
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
