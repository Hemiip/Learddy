//
//  PagePickerController.swift
//  Learddy
//
//  Created by Miftah Juanda Batubara on 18/06/21.
//

import UIKit
import AVFoundation

class PagePickerController: UIViewController, UITextFieldDelegate,
                            UIScrollViewDelegate {

    @IBOutlet weak var lblTimeStudy: UITextField!
    @IBOutlet weak var imgMaskot: UIImageView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var view_bottom: UIView!
    
    let synthesizer = AVSpeechSynthesizer()
    let timePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createTimeFocus()
        updateLayout()
        handleKeyboard()
//        lblTimeStudy.text = "00:00"
    }
    @IBAction func actionBtnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionBtnNext(_ sender: Any) {
        let lblStudy = lblTimeStudy.text ?? "00:00"
        
        print("Ini \(lblStudy)")
        
        if (lblStudy <= "00:00") {
            alertDial()
            print("Ini Kosong")
        } else {
            let timeToInt = lblStudy.secondFromString
            UserDefaults.standard.set("\(timeToInt)", forKey: "LblStudy")
            print("Ini labale \(lblStudy)")

            performSegue(withIdentifier: "ToPageMusic1", sender: self)
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

        btnNext.backgroundColor = UIColor(red: 21/255, green: 151/255, blue: 187/255, alpha: 1)
        btnNext.layer.cornerRadius = 18

        imgMaskot.image = UIImage(named: "didi_happy")
        addDidiSound()
    }
    
    func addDidiSound(){
        let utterance = AVSpeechUtterance(string: "How long do you wanna study?")
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.pitchMultiplier = 2.0
        synthesizer.speak(utterance)
    }
    
    func createTimeFocus(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.backgroundColor = UIColor(red: 239/255, green: 250/255, blue: 253/255, alpha: 1)
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(actionDatePickerDone))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([spaceButton, spaceButton, doneBtn], animated: true)
        
        lblTimeStudy.inputAccessoryView = toolbar
        
        lblTimeStudy.inputView = timePicker
        timePicker.datePickerMode = .countDownTimer
        timePicker.locale = .current
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.backgroundColor = UIColor(red: 239/255, green: 250/255, blue: 253/255, alpha: 1)
        
    }
    
    @objc func actionDatePickerDone() {
        lblTimeStudy.text = "\(formatDate())"
        self.view.endEditing(true)
    }
    
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateFormat = "HH:mm"

        return formatter.string(from: timePicker.date)
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
    
    func alertDial(){
        alertButton(title: "Correct", message: "Please complete this field", completion: {alertController in
            let cancleAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel) {
                UIAlertAction in
            }
            alertController.addAction(cancleAction)
            
            self.present(alertController, animated: true, completion: nil)
        })
    }
}


