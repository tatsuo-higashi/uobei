
import UIKit
import AVFoundation//オーディオがらみ
import AVKit
import Foundation
import CoreImage
import RealmSwift



class call: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    // 画像を設定する.
    let myInputImage = CIImage(image: UIImage(named: "call.jpeg")!)
    // ImageViewを.定義する.
    var myImageView: UIImageView!
    var addTimer = Timer()

    override func viewDidLoad() {
        
        loadView()//videoplayerを破棄
        print("overfuncのloadviewはした")
        super.viewDidLoad()
        myImageView = UIImageView(frame: self.view.frame)
        myImageView.image = UIImage(ciImage: myInputImage!)
        self.view.addSubview(myImageView)
        if appDelegate.qr_sta == "bc"{
        let qrc = make_bc()
        self.view.addSubview(qrc.make(string: "12-34")!)
        }else{
        let qrc = make_qrc()
        self.view.addSubview(qrc.make(sum: appDelegate.qr_string))
        }
        
        // スクリーン画面のサイズを取得
        let screenWidth: CGFloat = UIScreen.main.bounds.width      //画面の幅
        let screenHeight: CGFloat = UIScreen.main.bounds.height//画面の高さ

        func make_b(xv:Int,yv:Int,wv:Int,hv:Int,f:Int,b:String,c:Int){
            
            let button: UIButton = UIButton(frame: CGRect(x:CGFloat(xv), y:CGFloat(yv), width: CGFloat(wv), height: CGFloat(hv)))
            button.backgroundColor = UIColor.white
            button.layer.borderColor = UIColor.brown.cgColor
            button.layer.borderWidth = 1.5
            button.setTitle("\(b)", for: .normal)
            button.layer.cornerRadius = 3.0
            button.setTitleColor(UIColor.red, for: .normal)
            button.titleLabel?.numberOfLines = 2//0:無限改行,2:2行表示
            button.titleLabel?.font =  UIFont.systemFont(ofSize: 50)
            button.tag = c
            //button.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-CGFloat(yh))key
            button.addTarget(self, action: #selector(B1(sender:)), for: .touchUpInside)
            // ボタンを追加する.
            self.view.addSubview(button)
            
        }
        
        make_b(xv:80,yv:500,wv:280,hv:180,f:20,b:"会計",c:0)
        make_b(xv:380,yv:500,wv:280,hv:180,f:20,b:"キャンセル",c:1)
        make_b(xv:680,yv:500,wv:280,hv:180,f:20,b:"戻る",c:2)

    }
    

    func showPrinterPicker() {
        // UIPrinterPickerControllerのインスタンス化
        let printerPicker = UIPrinterPickerController(initiallySelectedPrinter: nil)
        
        // UIPrinterPickerControllerをモーダル表示する
    //printerPicker.present(animated: true, completionHandler://iphoneの場合
        printerPicker.present(from: CGRect(x: 20, y: 20, width: 10, height: 10), in: view, animated: true, completionHandler:
            {
                [unowned self] printerPickerController, userDidSelect, error in
                if (error != nil) {
                    // エラー
                    print("Error")
                } else {
                    // 選択したUIPrinterを取得する
                    if let printer: UIPrinter = printerPickerController.selectedPrinter {
                        print("Printer's URL : \(printer.url)")
                        self.printToPrinter(printer: printer)
                    } else {
                        print("Printer is not selected")
                    }
                }
            }
        )
        
    }
    
    func printToPrinter(printer: UIPrinter) {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        // 印刷してみる
        let printIntaractionController = UIPrintInteractionController.shared
        let info = UIPrintInfo(dictionary: nil)
        info.jobName = "Sample Print"
        info.orientation = .portrait
        printIntaractionController.printInfo = info
        //印刷する内容
        printIntaractionController.printingItem = appDelegate.sc_image
        printIntaractionController.print(to: printer, completionHandler: {
            controller, completed, error in
        })
    }
    
    
    func getScreenShot() -> UIImage {
        let rect = self.view.bounds
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        self.view.layer.render(in: context)
        let capturedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return capturedImage
    }
    
    @objc internal func B1(sender: UIButton){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let qrc = make_qrc()
        //m:backgrand,e:picture,e:border
        let view = make_view()
   
        switch sender.tag{
        case 2:
            let SViewController: UIViewController = ViewController()
            //アニメーションを設定する.
            SViewController.modalTransitionStyle = .flipHorizontal
            //Viewの移動する.
            self.present(SViewController, animated: true, completion: nil)
            //audioPlayerInstance.play()
            
        case 0://言語切替
            
            //とりあえず封印
            /*var image:UIImage = getScreenShot()
            appDelegate.sc_image = image
            showPrinterPicker()*/

                    let ab = r_data()
                    let date = Date()
                    let dateAndTime = date.formattedDateWith(style: .time)
                    ab.time_out = dateAndTime
                    
                    // (1)Realmのインスタンスを生成する
                    let realm = try! Realm()
                    // (2)書き込みトランザクション内でデータを追加する
                    try! realm.write {
                        realm.add(ab)
                    }
            let SViewController: UIViewController = kaikei2()
            //アニメーションを設定する.
            SViewController.modalTransitionStyle = .flipHorizontal
            //Viewの移動する.
            self.present(SViewController, animated: true, completion: nil)

        case 3://テイクアウト
            print("ok3")
        case 4://注文履歴
            print("ok4")
        case 5://店員呼び出し
            print("ok5")
        case 6:
            print("ok6")
        case 7:
            print("ok7")
        case 8:
            print("ok8")
        case 9:
            print("ok9")
        case 10:
            print("ok10")
        case 11:
            print("ok11")
        case 12:
            addTimer.invalidate()
            let SViewController: UIViewController = call()
            //アニメーションを設定する.
            SViewController.modalTransitionStyle = .flipHorizontal
            //Viewの移動する.
            self.present(SViewController, animated: true, completion: nil)
            //audioPlayerInstance.play()
            self.view.addSubview(view.make())
        //self.view.addSubview(qrc.make())
        case 22://動画再生中のタップ
            print("透明なボタン押してる")
            addTimer.invalidate()
            loadView()//videoplayerを破棄 画面遷移なしで
            viewDidLoad()
        default:break
            
        }
        
        
    }
    override func viewDidAppear(_ animated: Bool){
        print("player破棄しにきた")
        addTimer.invalidate()
        
        print("loadviewはした")
        loadView()//videoplayerを破棄 画面遷移なしで
        print("loadview後ろviewDidloadした")
        viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        print("メモリ使いすぎ")
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

