//
//  PageSelectMusicController.swift
//  Learddy
//
//  Created by Miftah Juanda Batubara on 19/06/21.
//

import UIKit
import CoreData

class PageSelectMusicController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var img_maskot: UIImageView!
    @IBOutlet weak var view_bottom: UIView!
    @IBOutlet weak var pickGenreMusic: UIPickerView!
    @IBOutlet weak var btn_next: UIButton!
    
    //perlu diperbaiki untuk menghandle nilai nill nya
    var selectGenreMusic: String? = "Rain Sound"
    var judulMusicRandom: String? = ""
    
    struct Music {
        var genre: String
        var judul: [String]
    }
    
    let genreMusic = [
        Music(genre: "Rain Sound", judul: ["rainSound1"]),
        Music(genre: "Lo-fi Music", judul: ["lofiSound1"]),
        Music(genre: "Jazz Music", judul: ["jazzSound1"])
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickGenreMusic.delegate = self
        self.pickGenreMusic.dataSource = self

        updateLayout()
    }
    
    @IBAction func actionbtnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func bntActionNext(_ sender: UIButton) {
        if self.selectGenreMusic!.isEmpty == false {
            getMusicRandom(name: self.selectGenreMusic!)
            UserDefaults.standard.set(self.judulMusicRandom!, forKey: "JudulMusicRandom")
            performSegue(withIdentifier: "ToPageLearn2", sender: self)
            print("Judul Musik \(self.judulMusicRandom!)")
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
    }
    
    func getMusicRandom(name: String) -> [String] {
        for genres in genreMusic {
            if genres.genre == name {
                self.judulMusicRandom = genres.judul.randomElement()!
                print(genres.judul.randomElement()!)
                return genres.judul
            }
        }
        
        return []
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let genre = genreMusic.map({$0.genre})
        return genre.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let genre = genreMusic.map({$0.genre})
        return genre[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let genre = genreMusic.map({$0.genre})
        self.selectGenreMusic = genre[row]
    }
    
}
