import UIKit
import AVFoundation//オーディオがらみ
import AVKit
import Foundation
import RealmSwift
import CoreImage


class kaikei2: UIViewController,UITextFieldDelegate,UITabBarDelegate {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let myInputImage = CIImage(image: UIImage(named: "kara")!)
    var addTimer = Timer()
    var timerCount = 0
    //テンキー用
    var tenkey:[[String]] = [[("1"),("2"),("3")],[("4"),("5"),("6")],[("7"),("8"),("9")]]
    var inputNum:String = ""
    var change:String = ""
    var warning:String = ""
    var calculation:Int = 0
    //年齢層用
    var generation:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // UIImageViewを作成する.
        myImageView = UIImageView(frame: CGRect(x: 0,y: 0,width: 1024,height: 768))
        myImageView.image = UIImage(ciImage: myInputImage!)
        self.view.addSubview(myImageView)
        ////audioPlayerInstance.prepareToPlay()
        // audioPlayerInstance.volume = appDelegate.volume
        //クラスをインスタンス化
        let button = makeButton()//m:backgrand,e:picture,e:border
        let label = makeLabel()//o:border,o1:backgrand,o2:0でalpha無効,ic:300でむテキスト無効
        //集計操作
        let realm = try! Realm()
        let obj = realm.objects(guestData.self).last
        let dish = obj!.dish
        let dishFee = String(formatterMake().string(from: dish*100 as NSNumber)!)
        self.view.addSubview(label.make(xv: 50, yv: 100, wv: 270, hv: 60, f: 40, o: 0, o1: 0, o2: 0, ic: "\(dish)皿です。"))
        self.view.addSubview(label.make(xv: 50, yv: 200, wv: 270, hv: 60, f: 40, o: 0, o1: 0, o2: 0, ic: "お会計は"))
        self.view.addSubview(label.make(xv: 50, yv: 300, wv: 270, hv: 60, f: 40, o: 0, o1: 0, o2: 0, ic: "\(dishFee)円です。"))
        //ラベル作成 //計算
        self.view.addSubview(label.make(xv: 400, yv: 29, wv: 50, hv: 20, f: 10, o: 0, o1: 0, o2: 0, ic: "預かり"))
        self.view.addSubview(label.make(xv: 400, yv: 129, wv: 50, hv: 20, f: 10, o: 0, o1: 0, o2: 0, ic: "会計"))
        self.view.addSubview(label.make(xv: 400, yv: 229, wv: 50, hv: 20, f: 10, o: 0, o1: 0, o2: 0, ic: "お釣り"))
        self.view.addSubview(label.make(xv: 400, yv: 50, wv: 270, hv: 60, f: 50, o: 2, o1: 0, o2: 0, ic: "¥\(inputNum)"))
        self.view.addSubview(label.make(xv: 400, yv: 150, wv: 270, hv: 60, f: 50, o: 2, o1: 0, o2: 0, ic: "¥\(dishFee)"))
        self.view.addSubview(label.make(xv: 400, yv: 250, wv: 270, hv: 60, f: 50, o: 2, o1: 0, o2: 0, ic: "¥\(change)"))
        self.view.addSubview(label.make(xv: 600, yv: 29, wv: 50, hv: 20, f: 10, o: 0, o1: 0, o2: 0, ic: "\(warning)"))
        //ボタン作成
        self.view.addSubview(button.make(xv:30,yv:700,wv:100,hv:50,f:50,b:"戻る",c:20,d:1,e:0,m:1))
        self.view.addSubview(button.make(xv:750,yv:650,wv:200,hv:80,f:50,b:"ENTER",c:21,d:1,e:0,m:1))
        //テンキー作成
    for i in 1...3{
        for j in 1...3{
            self.view.addSubview(button.make(xv:(300 + j * 100) ,yv:250 + i * 100,wv:70,hv:70,f:50,b:tenkey[i-1][j-1],c:Int(tenkey[i-1][j-1])!,d:1,e:0,m:1))
        }
    }
    self.view.addSubview(button.make(xv:400,yv:650,wv:180,hv:70,f:50,b:"0",c:10,d:1,e:0,m:1))
    self.view.addSubview(button.make(xv:600,yv:650,wv:70,hv:70,f:50,b:"✗",c:22,d:1,e:0,m:1))
    //終わり
    //年齢層
    let gene:[UIButton] = [button.make(xv:750,yv:50,wv:100,hv:100,f:50,b:"12",c:30,d:1,e:0,m:1),
                           button.make(xv:850,yv:50,wv:100,hv:100,f:50,b:"12",c:31,d:1,e:0,m:1),
                           button.make(xv:750,yv:150,wv:100,hv:100,f:50,b:"19",c:32,d:1,e:0,m:1),
                           button.make(xv:850,yv:150,wv:100,hv:100,f:50,b:"19",c:33,d:1,e:0,m:1),
                           button.make(xv:750,yv:250,wv:100,hv:100,f:50,b:"29",c:34,d:1,e:0,m:1),
                           button.make(xv:850,yv:250,wv:100,hv:100,f:50,b:"29",c:35,d:1,e:0,m:1),
                           button.make(xv:750,yv:350,wv:100,hv:100,f:50,b:"49",c:36,d:1,e:0,m:1),
                           button.make(xv:850,yv:350,wv:100,hv:100,f:50,b:"49",c:37,d:1,e:0,m:1),
                           button.make(xv:750,yv:450,wv:100,hv:100,f:50,b:"50",c:38,d:1,e:0,m:1),
                           button.make(xv:850,yv:450,wv:100,hv:100,f:50,b:"50",c:39,d:1,e:0,m:1)]
    for i in 0...9{
        if i % 2 == 0 {
            gene[i].backgroundColor = UIColor(red:0.10, green:0.10, blue:1, alpha:0.5)
        }else{
            gene[i].backgroundColor = UIColor(red:0.96, green:0.25, blue:0.15, alpha:0.5)
        }
        self.view.addSubview(gene[i])
    }
    let geneAns = button.make(xv:750,yv:570,wv:200,hv:60,f:50,b:"\(generation)",c:22,d:1,e:0,m:1)
    geneAns.titleLabel?.font = UIFont(name: "Bold",size: CGFloat(25))
    self.view.addSubview(geneAns)
    //年齢層終わり
    func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        }
    }
    
    //テンキー用メソッド
    func tenkeyHandle(inputNum:String) -> String{
        var input = inputNum
        calculation = Int(input.replacingOccurrences(of: ",", with: ""))!
        if input.first == "0"{input = String(input.dropFirst())}
        if input.count >= 7 {
            warning = "これ以上入力できません"
            viewDidLoad()
            return input
        }else{
            warning = ""
            viewDidLoad()
            //if input.count == 4 {input = inputNum + ","}
            return input
        }
    }
    
    //formatterメソッド
    func formatterMake() -> NumberFormatter{
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        return formatter
    }
    
    //ボタンイベント
    @objc func B3(sender: UIButton){
        if sender.tag <= 10 {
            k = sender.tag
        }
        switch sender.tag{
            case k://tenkey
                if inputNum.count <= 7{
                    if k == 10 {
                        inputNum += "0"
                    }else{
                        inputNum += "\(k)"
                    }
                    let value = Int(inputNum.replacingOccurrences(of: ",", with: ""))!
                    inputNum = String(formatterMake().string(from: value as NSNumber)!)
                }
                inputNum = tenkeyHandle(inputNum: inputNum)
            case 20://戻るボタン
                let SViewController: UIViewController = ViewController()
                SViewController.modalTransitionStyle = .flipHorizontal
                SViewController.modalPresentationStyle = .fullScreen
                self.present(SViewController, animated: true, completion: nil)
            case 21://Enter
                if inputNum == ""{break}
                let value = Int(inputNum.replacingOccurrences(of: ",", with: ""))! - (dishSum * 110)
                if value < 0 {
                    change = "エラー"
                    inputNum = ""
                    viewDidLoad()
                    break
                }
                change = String(formatterMake().string(from: value as NSNumber)!)
                viewDidLoad()

                //realm書き込み
                let date = Date()
                let dateAndTime = date.formattedDateWith(style: .time)
                let realm = try! Realm()
                let obj = realm.objects(guestData.self).last
                try! realm.write {
                    obj?.outTime = dateAndTime
                }
                try! realm.write {
                    realm.add(appSetting())
                }
                let saveObj = realm.objects(appSetting.self).last
                try! realm.write {
                    saveObj?.touch_volume = appDelegate.touch_volume
                    saveObj?.movie_volume = appDelegate.movie_volume
                    saveObj?.volume_m = appDelegate.volume_m
                    saveObj?.volume_m_sta = appDelegate.volume_m_sta
                    saveObj?.volume_v_sta = appDelegate.volume_v_sta
                    saveObj?.sound_num = appDelegate.sound_num
                    saveObj?.movie_num = appDelegate.movie_num
                    saveObj?.pickerView1Ini = appDelegate.pickerView1Ini
                    saveObj?.pickerView2Ini = appDelegate.pickerView2Ini
                }

                //遅延
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    let SViewController: UIViewController = hakken()
                    //アニメーションを設定する.
                    SViewController.modalTransitionStyle = .flipHorizontal
                    //Viewの移動する.
                    SViewController.modalPresentationStyle = .fullScreen
                    self.present(SViewController, animated: true, completion: nil)
                }
            case 22:
                //✗
                inputNum = String(inputNum.dropLast())
                if inputNum == "" {
                    viewDidLoad()
                    break
                }
                let value = Int(inputNum.replacingOccurrences(of: ",", with: ""))!
                inputNum = String(formatterMake().string(from: value as NSNumber)!)
                viewDidLoad()
            //年齢層
            case 30:
                generation = "12歳以下男性"
                viewDidLoad()
            case 31:
                generation = "12歳以下女性"
                viewDidLoad()
            case 32:
                generation = "13-19歳男性"
                viewDidLoad()
            case 33:
                generation = "13-19歳女性"
                viewDidLoad()
            case 34:
                generation = "20-29歳男性"
                viewDidLoad()
            case 35:
                generation = "20-29歳女性"
                viewDidLoad()
            case 36:
                generation = "30-49歳以下男性"
                viewDidLoad()
            case 37:
                generation = "30-49歳女性"
                viewDidLoad()
            case 38:
                generation = "50歳以上男性"
                viewDidLoad()
            case 39:
                generation = "50歳以上女性"
                viewDidLoad()
            //年齢層終わり
            default:break
        }
    }
}
