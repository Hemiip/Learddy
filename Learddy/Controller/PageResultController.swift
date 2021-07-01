//
//  PageResultController.swift
//  Learddy
//
//  Created by Miftah Juanda Batubara on 19/06/21.
//

import UIKit
import Charts

class PageResultController: UIViewController {
    
    let enable = UIImage(named: "didi.2_smile")
    let disable = UIImage(named: "didi_happy")
    
    var date = Date()


    @IBOutlet weak var imgMaskot: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateLayout()
        addChart()
        
        print("INi Tanggal \(date)")
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionBtnHome(_ sender: UIButton) {
        performSegue(withIdentifier: "BackToPageHome2", sender: self)
    }
    
    func updateLayout() {
        self.view.backgroundColor = UIColor(red: 239/255, green: 250/255, blue: 253/255, alpha: 1)
        imgMaskot.image = UIImage(named: "didi_happy")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImage(_:)))
        imgMaskot.addGestureRecognizer(tapGesture)
        imgMaskot.isUserInteractionEnabled = true
    }
    
    @objc func didTapImage(_ sender: UIGestureRecognizer) {
        imgMaskot.image = (imgMaskot.image == enable) ? disable : enable
    }
     
    private func addChart(){
        let barChart = BarChartView(frame: CGRect(x: (view.center.x / 9), y: 135, width: 350, height: 320))
        barChart.translatesAutoresizingMaskIntoConstraints = false
        
        let days = ["Mon", "Tues", "Wed", "Thur", "Fri", "Sat", "Sund"]
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: days)
        barChart.xAxis.granularity = 1
        
        var entries = [BarChartDataEntry]()
        
        for i in 0..<7 {
            entries.append(BarChartDataEntry(x: Double(i), y: Double(Int.random(in: 0..<25))))
        }
        
        
        let set = BarChartDataSet(entries: entries, label: "Weeks")
        let data = BarChartData(dataSet: set)
        
        barChart.data = data
        
        view.addSubview(barChart)
    }

}
