//
//  Utils.swift
//  Learddy
//
//  Created by Miftah Juanda Batubara on 23/06/21.
//

import Foundation
import UIKit

func convertToTime(totalSecond : Int) -> String {
    let hours = (totalSecond / 3600)
    let minutes = (totalSecond % 3600) / 60
    
    return String(format: "%02d:%02d", hours, minutes)
}

func timeString(time: Int) -> String {
    let hours = Int(time) / 3600
    let minutes = Int(time) / 60 % 60
    let seconds = Int(time) % 60
    
    return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
}

func alertButton(title : String, message : String, completion : (UIAlertController)->()){
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    completion(alertController)
}

extension String{

    var integer: Int {
        return Int(self) ?? 0
    }

    var secondFromString : Int{
        let components: Array = self.components(separatedBy: ":")
        
        let hours = components[0].integer
        let minutes = components[1].integer
//        let seconds = components[2].integer + seconds
        
        return Int((hours * 60 * 60) + (minutes * 60) )
    }
}

//extension UIImage {
//  public class func gif(asset: String) -> UIImage? {
//    if let asset = NSDataAsset(name: asset) {
//        return UIImage.gif(data: asset.data)
//    }
//    return nil
//  }
//}
