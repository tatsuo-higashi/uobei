
import UIKit
import AVFoundation//オーディオがらみ
import AVKit
import Foundation
import CoreImage
import RealmSwift



class Call: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    // 画像を設定する.
    let myInputImage = CIImage(image: UIImage(named: "call.jpeg")!)
    // ImageViewを.定義する.
    var myImageView: UIImageView!
    var addTimer = Timer()
    
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
        loadView()//videoplayerを破棄
        super.viewDidLoad()
        
        
        let button = makeButton()//m:backgrand,e:picture,e:border
        audioPlayerInstance.prepareToPlay()
        myImageView = UIImageView(frame: self.view.frame)
        myImageView.image = UIImage(ciImage: myInputImage!)
        self.view.addSubview(myImageView)
        if appDelegate.qrStatus == "bc"{
            let bc = makeBarcord()
            self.view.addSubview(bc.make(string: "12-34")!)
        }
        
        //ボタン作成
        self.view.addSubview(button.make(xv:80,yv:500,wv:280,hv:180,f:20,b:"会計",c:0,t:1))
        self.view.addSubview(button.make(xv:380,yv:500,wv:280,hv:180,f:20,b:"キャンセル",c:1,t:1))
        self.view.addSubview(button.make(xv:680,yv:500,wv:280,hv:180,f:20,b:"戻る",c:2,t:1))
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
        printIntaractionController.printingItem = appDelegate.scImage
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
    
    @objc internal func selection(sender: UIButton){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let view = viewSetting()
        switch sender.tag{
            case 0:
                let image:UIImage = getScreenShot()
                appDelegate.scImage = image
                showPrinterPicker()
                imageSetteng(picture: "wait.jpg")
                
                //遅延処理
                DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                    self.present(view.viewSet(open: Camera(),anime: .flipHorizontal), animated: false, completion: nil)
                }
            case 1:
                    self.present(view.viewSet(open: Accounting(),anime: .flipHorizontal), animated: false, completion: nil)
                 
            case 2:
                    self.present(view.viewSet(open: ViewController(),anime: .flipHorizontal), animated: false, completion: nil)
            case 12:
                addTimer.invalidate()
                let makeView = UIImageView(frame: CGRect(x:CGFloat(0), y: CGFloat(0), width: CGFloat(550), height: CGFloat(700)))
                // 画像をUIImageViewに設定する.
                makeView.image = UIImage(named: "call.jpeg")!
                self.present(view.viewSet(open:ViewController(),anime: .flipHorizontal), animated: false, completion: nil)
                self.view.addSubview(makeView)
            case 22://動画再生中のタップ
                addTimer.invalidate()
                loadView()//videoplayerを破棄 画面遷移なしで
                viewDidLoad()
            default:break
        }
    }
    override func viewDidAppear(_ animated: Bool){
        addTimer.invalidate()
        loadView()//videoplayerを破棄 画面遷移なしで
        viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        print("メモリ使いすぎ")
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

