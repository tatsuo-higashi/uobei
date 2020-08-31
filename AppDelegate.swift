//
//  AppDelegate.swift
//  uobei
//
//  Created by 東竜生 on 2019/12/07.
//  Copyright © 2019年 東竜生.佐藤 All rights reserved.
//

import UIKit
import AVFoundation
import UserNotifications//リモート通信に必要
import RealmSwift
 
//時間作成
extension Date {
    enum FormattedStyle {
        case longDate
        case longDateAndTime
        case shortDate
        case shortDateAndTime
        case time
    }
    func format(with format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: self)
    }
    var formattedWeekday: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        let symbol = formatter.weekdaySymbols[Calendar.current.component(.weekday, from: self) - 1]
        switch symbol {
            case    "Sunday": return "日"
            case    "Monday": return "月"
            case   "Tuesday": return "火"
            case "Wednesday": return "水"
            case  "Thursday": return "木"
            case    "Friday": return "金"
            case  "Saturday": return "土"
            default: assertionFailure("error"); return ""
        }
    }
    func formattedDateWith(style: FormattedStyle) -> String {
        switch style {
            case .longDate:
                return format(with: "yyyy年M月d日\(formattedWeekday)")
            case .longDateAndTime:
                return format(with: "yyyy年M月日d\(formattedWeekday)曜日 H:mm")
            case .shortDateAndTime:
                return format(with: "M月d日\(formattedWeekday)曜日 H:mm")
            case .shortDate:
                return format(with: "M 月  d 日   \(formattedWeekday)  曜日")
            case .time:
                return format(with: "H:mm")
        }
    }
}

//realm作成 guest
class guestData:Object{
  @objc dynamic var seatNum = ""
  @objc dynamic var inTime = ""
  @objc dynamic var outTime = ""
  @objc dynamic var adultCount = ""
  @objc dynamic var childCount = ""
  @objc dynamic var seatType = ""
  @objc dynamic var dish = 0
}

//realm作成 設定初期値
class appSetting:Object{
    @objc dynamic var touch_volume: Float = 0.5
    @objc dynamic var movie_volume: Float = 0.5
    @objc dynamic var qr_sta: String = "qr"
    @objc dynamic var qr_string: String = ""
    @objc dynamic var volume_m: Float = 0.5
    @objc dynamic var volume_v: Float = 0.5
    @objc dynamic var volume_m_sta: String = "on"
    @objc dynamic var volume_v_sta: String = "on"
    @objc dynamic var sound_num: String = "button01a"
    @objc dynamic var movie_num: String = "movie01"
    @objc dynamic var pickerView1Ini: Int = 0
    @objc dynamic var pickerView2Ini: Int = 0
}

//ラベル作成class
class makeLabel:UILabel{
    func make(xv:Int,yv:Int,wv:Int,hv:Int,f:Int,o:Int,o1:Int,o2:Double,ic:String)->UILabel{
         //o1:バックグランドカラー
        let label = UILabel(frame: CGRect(x:CGFloat(xv), y: CGFloat(yv), width: CGFloat(wv), height: CGFloat(hv)))
        label.textAlignment = NSTextAlignment.center
        if o == 2{
            label.layer.borderWidth = 1.5
            label.layer.borderColor = UIColor.black.cgColor
        }
        label.font = label.font.withSize(CGFloat(f))
        label.textAlignment = NSTextAlignment.center
        if ic != ""{
            label.text = ic
        }
        label.numberOfLines = 0
        label.layer.cornerRadius = 3.0
        if o1 == 0{
            label.backgroundColor = UIColor.clear
        }else if o1 == 1{
            label.backgroundColor = UIColor.white
        }else if o1 == 2{
            label.backgroundColor = UIColor.black
        }else{
            label.backgroundColor = UIColor.yellow
        }
        if o2 != 0{
            label.alpha = CGFloat(o2)
        }
        return(label)
    }
}
//スライダー作成class
class SliderClass: NSObject {
    var title: String
    var subtitle: String
    var sliderMinimum: Float
    var sliderMaximum: Float
    
    init(title: String, subtitle: String, sliderMinimum: Float, sliderMaximum: Float) {
        self.title = "a"
        self.subtitle = "b"
        self.sliderMinimum = 10
        self.sliderMaximum = 30
    }
}
//ボタン作成class(イメージ有り)
class makeButton:UIButton{
    func make(xv:Int,yv:Int,wv:Int,hv:Int,f:Int,b:String,c:Int,d:Int,e:Int,m:Int)->UIButton{
        let button: UIButton = UIButton(frame: CGRect(x:CGFloat(xv), y:CGFloat(yv), width: CGFloat(wv), height: CGFloat(hv)))
        if e == 1{
            let picture = UIImage(named: "\(b).png")
            button.setImage(picture, for: .normal)
        }else if e == 2{
            let picture = UIImage(named: "\(b).jpeg")
            button.setImage(picture, for: .normal)
        }
        if d == 0{
            button.layer.borderColor = UIColor.clear.cgColor
        } else if d == 1{
            button.layer.borderColor = UIColor.black.cgColor
        }else{
            button.layer.borderColor = UIColor.white.cgColor
        }
        button.layer.borderWidth = 1
        if m == 0{
            button.backgroundColor = UIColor.clear
        }else{
            button.backgroundColor = UIColor.white
        }
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("\(b)", for: .normal)
        button.tag = c
        button.layer.cornerRadius = 6
        //button.titleLabel?.numberOfLines = 2//0:無限改行,2:2行表示
        button.titleLabel?.font =  UIFont.systemFont(ofSize: CGFloat(f))
        button.addTarget(self, action: #selector(menu.B3(sender:)), for: .touchUpInside)
        return(button)
    }
}
class makeBarcord:UIImageView{
    func make(string: String) -> UIImageView? {
        guard let data = string.data(using: .utf8) else {
            return nil
        }
        guard let filter = CIFilter(name: "CICode128BarcodeGenerator") else {
            return nil
        }
        filter.setDefaults()
        filter.setValue(data, forKey: "inputMessage")
        guard let output = filter.outputImage else {
            return nil
        }
        let context = CIContext(options: nil)
        guard let cgImage = context.createCGImage(output, from: output.extent) else {
            return nil
        }
        let uiImage = UIImage(cgImage: cgImage, scale: 2.0, orientation: UIImage.Orientation.up)
        // 作成したバーコードを表示
        let barImageView = UIImageView(frame: CGRect(x:CGFloat(100), y: CGFloat(250), width: CGFloat(150), height: CGFloat(150)))
        barImageView.contentMode = .scaleAspectFit
        barImageView.image = uiImage
        return(barImageView)
    }
}
//QRコード作成class
class makeQrcode:UIImageView{
    func make(sum:String)->UIImageView{
        let str =  sum
        let data = str.data(using: String.Encoding.utf8)!
        let qr = CIFilter(name: "CIQRCodeGenerator", parameters: ["inputMessage": data, "inputCorrectionLevel": "M"])!
        let sizeTransform = CGAffineTransform(scaleX: 10, y: 10)
        let qrImage = qr.outputImage!.transformed(by: sizeTransform)
        let context = CIContext()
        let cgImage = context.createCGImage(qrImage, from: qrImage.extent)
        let uiImage = UIImage(cgImage: cgImage!)
        // 作成したQRコードを表示
        let qrImageView = UIImageView(frame: CGRect(x:CGFloat(100), y: CGFloat(250), width: CGFloat(150), height: CGFloat(150)))
        qrImageView.contentMode = .scaleAspectFit
        qrImageView.image = uiImage
        return(qrImageView)
    }
}
//サウンド作成class
class makeSound:AVAudioPlayer{
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    func make()->AVAudioPlayer{
        var audioPlayerInstance : AVAudioPlayer! = nil
        let soundFilePath = Bundle.main.path(forResource: "button01a", ofType: "mp3")!
        let sound:URL = URL(fileURLWithPath: soundFilePath)
        do {
            audioPlayerInstance = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
        } catch {
            print("AVAudioPlayerインスタンス作成でエラー")
        }
        // 再生準備
        audioPlayerInstance.prepareToPlay()
        audioPlayerInstance.volume = appDelegate.volume_m
        return(audioPlayerInstance)
    }
}
//ジェスチャー作成class
class makeGess:UISwipeGestureRecognizer{
    func make()->UISwipeGestureRecognizer{
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(menu.leftSwipeView(sender:)))  //Swift3
        // レフトスワイプのみ反応するようにする
        leftSwipe.direction = .left
        return(leftSwipe)
    }
}
//view
class makeView:UIImageView{
    func make()->UIImageView{
        // UIImageViewを作成.
        let mess = UIImageView(frame: CGRect(x:CGFloat(0), y: CGFloat(0), width: CGFloat(550), height: CGFloat(700)))
        // UIImageを作成.
        let myImage: UIImage = UIImage(named: "call.jpeg")!
        // 画像をUIImageViewに設定する.
        mess.image = myImage
        return(mess)
    }
}

//stepper
class makeStepper:UIStepper{
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    func make(xv:Int,yv:Int,wv:Int,hv:Int,f:Int,o:Int,o1:Int,o2:Double,ic:Int)->UIStepper{
        let stepper = UIStepper(frame: CGRect(x:CGFloat(xv), y: CGFloat(yv), width: CGFloat(wv), height: CGFloat(hv)))
        // 最小値, 最大値, 規定値の設定をする.
        stepper.minimumValue = 0
        stepper.maximumValue = 59
        stepper.value = 1
        stepper.layer.cornerRadius = 3.0
        stepper.backgroundColor = UIColor.clear
        // ボタンを押した際に動く値の.を設定する.
        stepper.stepValue = 1
        return(stepper)
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    var window: UIWindow?
    var choise: Int = 0//メニュー選択
    var change_flag: Int = 0//設定画面選択
    var view_setting: String = "アカウント"
    var sound_flag: String = "on"
    var touch_sound: String = "on"
    var movie_sound: String = "on"
    var touch_volume: Float = 0.5
    var movie_volume: Float = 0.5
    var sc_image: UIImage?
    var qr_sta: String = "qr"
    var qr_string: String = ""
    var volume_m: Float = 0.5
    var volume_v: Float = 0.5
    var volume_m_sta: String = "on"
    var volume_v_sta: String = "on"
    var sound_num: String = "button01a"
    var movie_num: String = "movie01"
    var pickerView1Ini: Int = 0
    var pickerView2Ini: Int = 0
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            // 起動直後に遷移する画面をRootViewControllerに指定する
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = first()
            self.window?.makeKeyAndVisible()
            return true
        }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    

}

