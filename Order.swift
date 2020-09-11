import UIKit
import AVFoundation//オーディオがらみ
import AVKit
import Foundation
import RealmSwift
import CoreImage



//注文前画面クラス
class Order: UIViewController,UITextFieldDelegate,UITabBarDelegate {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var myTabBar:UITabBar!
    let myInputImage = CIImage(image: UIImage(named: "order.jpeg")!)
    var myImageView: UIImageView!
    var selectView: UIView! = nil
    var image0: UIImageView!
    var count = 0
    var count2 = 0
    var i = 0
    var name = ""
    var label2: UILabel!
    var addTimer = Timer()
    var timerCount = 0
    
    //タイマー
    @objc func timerCall() {
        viewDidLoad()
        // タイマーを無効にする
        addTimer.invalidate()
    }
 
    //画像の設定
    func imageSetteng(picture:String){
        // 画像を設定する.
        let myInputImage = CIImage(image: UIImage(named: picture)!)
        // ImageViewを.定義する.
        var myImageView: UIImageView!
        // UIImageViewを作成する.
        myImageView = UIImageView(frame: UIScreen.main.bounds)
        myImageView.image = UIImage(ciImage: myInputImage!)
        self.view.addSubview(myImageView)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayerInstance.prepareToPlay()
        // UIImageViewを作成する.
        myImageView = UIImageView(frame: UIScreen.main.bounds)
        myImageView.image = UIImage(ciImage: myInputImage!)
        self.view.addSubview(myImageView)
        //クラスをインスタンス化
        let button = makeButton()//m:backgrand,e:picture,e:border
        let label = makeLabel()//o:border,o1:backgrand,o2:0でalpha無効,ic:300でむテキスト無効
        
     
        //種類作成
        for i in 0...2{
            self.view.addSubview(label.make(label: label,num: String(i+1)))
        }
        //商品名作成
        for i in 0...2{
            self.view.addSubview(button.make(button: button,num:i))
        }
        //数量作成
        for i in 0...2{
            self.view.addSubview(label.make(label: label,num:i))
        }
        //タグ作成
        for i in 0...8{
            self.view.addSubview(button.make(xv: 5 + 80 * i, yv: 5, wv: 80, hv: 70, b: "tag\(i)",c: 16))
        }
        //上部ボタン作成
        let cate:[String] = ["まぐろ","サーモン","たこ・えび","貝","いか","光物"]
        for i in 0...5{
            self.view.addSubview(button.make(xv: 5 + i * 115, yv: 90, wv: 110, hv: 70, c: 17, b: cate[i]))
        }
        self.view.addSubview(button.make(xv:30,yv:700,wv:100,hv:50,c:1,b:"戻る"))
        self.view.addSubview(button.make(xv:550,yv:210,wv:170,hv:100,c:18,b:"注文する"))
        //+-ボタン作成
        for i in 0...2{
            if appDelegate.box[i].name != ""{
                self.view.addSubview(button.make(b:"+",xv:390,yv:280+i*60,wv:60,hv:50,f:20,c:i*2+2))
                self.view.addSubview(button.make(b:"−",xv:460,yv:280+i*60,wv:60,hv:50,f:20,c:i*2+3))
            }
        }
        //メッセージ（合計)
        let messageLabel = UILabel(frame: CGRect(x:CGFloat(190), y: CGFloat(460), width: CGFloat(120), height: CGFloat(60)))
        messageLabel.layer.borderColor = UIColor.black.cgColor
        messageLabel.layer.borderWidth = 1.5
        messageLabel.font = messageLabel.font.withSize(CGFloat(50))
        messageLabel.textAlignment = NSTextAlignment.center
        messageLabel.text = ("合計")
        messageLabel.numberOfLines = 0
        messageLabel.backgroundColor = UIColor.red
        self.view.addSubview(messageLabel)
        audioPlayerInstance.play()
        //数量用（合計)
        let sumLabel = UILabel(frame: CGRect(x:CGFloat(310), y: CGFloat(460), width: CGFloat(60), height: CGFloat(60)))
        sumLabel.layer.borderColor = UIColor.black.cgColor
        sumLabel.layer.borderWidth = 1.5
        sumLabel.font = sumLabel.font.withSize(CGFloat(50))
        sumLabel.textAlignment = NSTextAlignment.center
        sumLabel.text = ("\(appDelegate.box[0].qty + appDelegate.box[1].qty + appDelegate.box[2].qty)")
        sumLabel.numberOfLines = 0
        sumLabel.backgroundColor = UIColor.clear
        self.view.addSubview(sumLabel)
        audioPlayerInstance.play()
    }
    
    //ボタンイベント処理
    @objc func selection(sender: UIButton){
        let view = viewSetting()
        switch sender.tag{
        case 1://戻ボタン
            self.present(view.viewSet(open: ViewController(),anime: .flipHorizontal), animated: false, completion: nil)
        case 2:// 一種類目+ボタン
            i = 0
            if appDelegate.box[i].qty < 4{
                appDelegate.box[i].qty =  appDelegate.box[i].qty+1
                viewDidLoad()
                audioPlayerInstance.play()
            }else if appDelegate.box[i].qty == 4{
                imageSetteng(picture: "over.jpg")
                // タイマーの設定（5秒間隔でメソッド「timerCall」を呼び出す）
                addTimer =  Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerCall), userInfo: nil, repeats: true)
            }
        case 3:// 一種類目−ボタン
            i = 0
            if  appDelegate.box[i].qty != 0 && appDelegate.box[i].qty > 0{
                appDelegate.box[i].qty = appDelegate.box[i].qty-1
            }
            viewDidLoad()
            audioPlayerInstance.play()
        case 4:// 2種類目+ボタン
            i = 1
            if appDelegate.box[i].qty < 4{
                appDelegate.box[i].qty =  appDelegate.box[i].qty+1
                viewDidLoad()
            }else if appDelegate.box[i].qty == 4{
                imageSetteng(picture: "over.jpg")
                // タイマーの設定（5秒間隔でメソッド「timerCall」を呼び出す）
                addTimer =  Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerCall), userInfo: nil, repeats: true)
            }
        case 5:// 2種類目−ボタン
            i = 1
            if  appDelegate.box[i].qty != 0 && appDelegate.box[i].qty > 0{
                appDelegate.box[i].qty =  appDelegate.box[i].qty-1
            }
            viewDidLoad()
            audioPlayerInstance.play()
        case 6:// 3種類目+ボタン
            i = 2
            if appDelegate.box[i].qty < 4{
                appDelegate.box[i].qty =  appDelegate.box[i].qty+1
                viewDidLoad()
                audioPlayerInstance.play()
            }else if appDelegate.box[i].qty == 4{
                imageSetteng(picture: "over.jpg")
                // タイマーの設定（5秒間隔でメソッド「timerCall」を呼び出す）
                addTimer =  Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerCall), userInfo: nil, repeats: true)
            }
        case 7:// 3種類目−ボタン
            i = 2
            if  appDelegate.box[i].qty != 0 && appDelegate.box[i].qty > 0{
                appDelegate.box[i].qty =  appDelegate.box[i].qty-1
            }
            viewDidLoad()
            audioPlayerInstance.play()
        case 13://商品名(1段目)
            i = 0
            appDelegate.countMenu[0].now = "on"
            appDelegate.countMenu[1].now = "off"
            appDelegate.countMenu[2].now = "off"
            viewDidLoad()
            audioPlayerInstance.play()
        case 14://商品名(2段目)
            i = 1
            appDelegate.countMenu[0].now = "off"
            appDelegate.countMenu[1].now = "on"
            appDelegate.countMenu[2].now = "off"
            viewDidLoad()
            audioPlayerInstance.play()
        case 15://商品名(3段目)
            i = 2
            appDelegate.countMenu[0].now = "off"
            appDelegate.countMenu[1].now = "off"
            appDelegate.countMenu[2].now = "on"
            viewDidLoad()
            audioPlayerInstance.play()
        case 18://注文
            appDelegate.dishSum += appDelegate.box[0].qty + appDelegate.box[1].qty + appDelegate.box[2].qty
            appDelegate.qrString = "注文は\(appDelegate.dishSum)皿で会計金額は\(appDelegate.dishSum * 110)円です"
            for i in 0...2{
                if "\(appDelegate.box[i].name)" != ""{
                    let history = (name:"\(appDelegate.box[i].name)", num:appDelegate.box[i].qty)
                    appDelegate.history.append(history)
                }
            }
            //realm　皿数
            let realm = try! Realm()
            let dishCount = realm.objects(guestData.self).last
            try! realm.write {
                dishCount!.dish = appDelegate.dishSum
            }
            imageSetteng(picture: "end.jpg")
            appDelegate.countMenu = [(0,""),(0,""),(0,"")]
            appDelegate.box = [("",0,"kara.png"),("",0,"kara.png"),("",0,"kara.png")]
            i = 0
            audioPlayerInstance.play()
            //遅延処理
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.present(view.viewSet(open: ViewController(),anime: .flipHorizontal), animated: false, completion: nil)
                
            }
        default:break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
