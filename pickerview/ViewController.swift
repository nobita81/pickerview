//
//  ViewController.swift
//  pickerview
//
//  Created by Dr on 1/17/17.
//  Copyright © 2017 Dr. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    let arrDuLieu:Array<Array<String>> = [
        ["1","2","3","4","5","6","7","8","9","10"],
        ["1","2","3","4","5","6","7","8","9","10"],
        ["1","2","3","4","5","6","7","8","9","10"]
    ]
    
    let heso:Int = 300
    var diem:Int = 10000
    var timer:Timer = Timer()
    
    
    @IBOutlet weak var lblThongBao: UILabel!
    @IBOutlet weak var lblDiem: UILabel!
    @IBOutlet weak var picker777: UIPickerView!
    
    @IBOutlet weak var btnRandom: UIButton!
    @IBAction func abtnRandom(_ sender: Any) {
        btnRandom.isEnabled = false
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.DelayTime), userInfo: nil, repeats: true)
        
    }
    
    var index:Int = 0
    var kq1:String = ""
    var kq2:String = ""
    var kq3:String = ""
    
    func DelayTime() {
        index += 1
        
        
        if index < 20 {
            let sord1 = arrDuLieu[0].count * heso
            let sord2 = arrDuLieu[1].count * heso
            let sord3 = arrDuLieu[2].count * heso
            
            let rd1 = Int(arc4random_uniform(UInt32(sord1)))
            let rd2 = Int(arc4random_uniform(UInt32(sord2)))
            let rd3 = Int(arc4random_uniform(UInt32(sord3)))
            
            picker777.selectRow(rd1, inComponent: 0, animated: true)
            picker777.selectRow(rd2, inComponent: 1, animated: true)
            picker777.selectRow(rd3, inComponent: 2, animated: true)
            if index == 19 {
                /// Cách Lấy Phần Tử Chính Xác Nhất
                kq1 = arrDuLieu[0][rd1 % arrDuLieu[0].count]
            }
        } else if index < 30 {
            
            let sord2 = arrDuLieu[1].count * heso
            let sord3 = arrDuLieu[2].count * heso
            
            let rd2 = Int(arc4random_uniform(UInt32(sord2)))
            let rd3 = Int(arc4random_uniform(UInt32(sord3)))
            
            picker777.selectRow(rd2, inComponent: 1, animated: true)
            picker777.selectRow(rd3, inComponent: 2, animated: true)
            
            if index == 29 {
                /// Cách Lấy Phần Tử Chính Xác Nhất
                kq2 = arrDuLieu[1][rd2 % arrDuLieu[1].count]
            }
            
        } else if index < 40 {
            
            let sord3 = arrDuLieu[2].count * heso
            let rd3 = Int(arc4random_uniform(UInt32(sord3)))
            
            picker777.selectRow(rd3, inComponent: 2, animated: true)
            if index == 39 {
                /// Cách Lấy Phần Tử Chính Xác Nhất
                kq3 = arrDuLieu[2][rd3 % arrDuLieu[2].count]
            }
        } else {
            index = 0
            timer.invalidate()
            btnRandom.isEnabled = true
            
            if diem >= 1000 {
                if kq1 == kq2 && kq1 == kq3 {
                    diem += 50000
                    lblDiem.text = "Bạn Có \(diem)"
                    lblThongBao.text = "Bạn Được +50.000 Điểm"
                } else if kq1 == kq2 || kq1 == kq3 || kq2 == kq3 {
                    diem += 5000
                    lblDiem.text = "Bạn Có \(diem)"
                    lblThongBao.text = "Bạn Được +5000 Điểm"
                } else {
                    diem -= 1000
                    lblDiem.text = "Bạn Có \(diem)"
                    lblThongBao.text = "Bạn Đã Bị -1000 Điểm"
                }
            } else {
                lblDiem.text = "Bạn Có \(diem)"
                lblThongBao.text = "Vui Lòng Nạp Thêm Tiền"
                
            }
            
        }
        
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        picker777.delegate = self
        picker777.dataSource = self
        
        
        
        for i in 0..<arrDuLieu.count {
            picker777.selectRow(arrDuLieu[i].count * heso/2, inComponent: i, animated: true)
        }
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return arrDuLieu.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrDuLieu[component].count * heso
    }
    
    //    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    //
    //        return arrDuLieu[component][row]
    //
    //    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let imgView:UIImageView = UIImageView()
        imgView.frame.size = CGSize(width: 100, height: 100)
        
        let tam = arrDuLieu[component].count
        imgView.image = UIImage(named: arrDuLieu[component][row % tam])
        
        return imgView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(arrDuLieu[component][row % arrDuLieu[component].count])
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

