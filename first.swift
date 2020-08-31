import UIKit
import AVFoundation//オーディオがらみ
import AVKit
import CoreImage
import RealmSwift
class first: UIViewController {
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    // 画像を設定する.
    let myInputImage = CIImage(image: UIImage(named: "first.jpeg")!)
    // ImageViewを.定義する.
    var myImageView: UIImageView!
    override func viewDidLoad() {
        var soundFilePath = Bundle.main.path(forResource: "\(appDelegate.sound_num)", ofType: "mp3")!
        let sound:URL = URL(fileURLWithPath: soundFilePath)
        
      
  
        
        //realm書き込み
        let date = Date()
        let dateAndTime = date.formattedDateWith(style: .time)
        let realm = try! Realm()
        let obj = realm.objects(r_data3.self).last
        try! realm.write {
            obj?.time_out = dateAndTime
        }
        try! realm.write {
            realm.add(r_data3())
        }
        

 
        
         /*初回のみ必要
         try! realm.write {
         realm.add(saveSetting1())
         }*/
        
        //  初期動作時
        let saveObj = realm.objects(saveSetting1.self).last
        if saveObj != nil {
            try! realm.write {
                appDelegate.touch_volume = saveObj!.touch_volume
                appDelegate.movie_volume = saveObj!.movie_volume
                appDelegate.volume_m = saveObj!.volume_m
                appDelegate.volume_m_sta = saveObj!.volume_m_sta
                appDelegate.volume_v_sta = saveObj!.volume_v_sta
                appDelegate.sound_num = saveObj!.sound_num
                appDelegate.movie_num = saveObj!.movie_num
                appDelegate.pickerView1Ini = saveObj!.pickerView1Ini
                appDelegate.pickerView2Ini = saveObj!.pickerView2Ini
            }
        }else{
            try! realm.write {
                realm.add(saveSetting1())
            }
        }
        //初期動作時
        // try! realm.write {
        //  realm.add(saveSetting1())
        // }
            
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        loadView()//videoplayerを破棄
        print("overfuncのloadviewはした")
        super.viewDidLoad()
        print("sound_flagは")
        print(appDelegate.sound_flag)
        var audioPlayerInstance : AVAudioPlayer! = nil
        do {
            audioPlayerInstance = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
        } catch {
            print("AVAudioPlayerインスタンス作成でエラー")
        }
        // 再生準備
        audioPlayerInstance.prepareToPlay()
        audioPlayerInstance.volume = appDelegate.touch_volume
        // 起動直後に遷移させる画面を宣言
        let launchViewController: UIViewController = menu()
        // 子ViewのViewControllerを指定
        self.addChild(launchViewController)
        // 子ViewをSubViewとして追加
        //launchViewController.view.frame = UIScreen.main.bounds
        //self.view.addSubView(launchViewController.view)
        // 子Viewの所有権を譲渡
        launchViewController.didMove(toParent: self)
        myImageView = UIImageView(frame: self.view.frame)
        myImageView.image = UIImage(ciImage: myInputImage!)
        self.view.addSubview(myImageView)
        // スクリーン画面のサイズを取得
        let screenWidth: CGFloat = UIScreen.main.bounds.width  //画面の幅
        let screenHeight: CGFloat = UIScreen.main.bounds.height//画面の高さ
        print(screenWidth)
        print(screenHeight)
        print(UIScreen.main.bounds)
        print(self.view.frame)
        //透明なボタンを作ってタップを反応させる
        let button: UIButton = UIButton(frame: CGRect(x:CGFloat(0), y:CGFloat(0), width: CGFloat(1024), height: CGFloat(768)))
        button.tag = 0
        button.addTarget(self, action: #selector(B1(sender:)), for: .touchUpInside)
        self.view.addSubview(button)
    }
    @objc func play(){
        print("play")
        //これでタイマー切
        print("\(appDelegate.movie_num)")
        // パスからassetを生成.
        var path = Bundle.main.path(forResource: "\(appDelegate.movie_num)", ofType: "mp4")
        let fileURL = NSURL(fileURLWithPath: path!)
        let avAsset = AVAsset(url: fileURL as URL)
        // AVPlayerに再生させるアイテムを生成.
        let playerItem = AVPlayerItem(asset: avAsset)
        // AVPlayerを生成.
        let videoPlayer = AVPlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: videoPlayer)
        videoPlayer.volume = appDelegate.movie_volume
        // 出力先判定
        func IsHeadSetConnected() -> Bool{
            let route = AVAudioSession.sharedInstance().currentRoute;
            for desc in route.outputs
            {
                let portType = desc.portType;
                if (portType == AVAudioSession.Port.headphones)
                {
                    return true;
                }
            }
            return false;
        }
        print(IsHeadSetConnected())
        // イヤホンが刺された、出された時に呼ばれる
        func setAudioNotification(){
            //NotificationCenter.default.addObserver(self,
            // selector: #selector(self.didChangeAudioSessionRoute(notification:)),
            //name: NSNotification.Name.AVAudioSessionRouteChange,
            //object: nil)
        }
        /* func didChangeAudioSessionRoute(notification:Notification){
         for desc in AVAudioSession.sharedInstance().currentRoute.outputs{
         if desc.portType == AVAudioSession.Port.headphones{
         // イヤホン刺さった
         }else{
         // イヤホン抜けた
         if !self.isSetSpeeker{
         self.setupSpeeker()
         }
         }
         }
         }*/
        // 変える実装
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            do{
                let audioSession = AVAudioSession.sharedInstance()
                //try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
                try audioSession.setMode(AVAudioSession.Mode.videoChat)
                try audioSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
                try audioSession.setActive(true)
            }catch let error as NSError{
                //
            }
        }
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        //サイズを決める
        playerLayer.frame = CGRect(x:0, y:0, width:1024, height:768)
        self.view.layer.addSublayer(playerLayer)
        // 動画が再生し終わったことを監視する設定
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        //透明なボタンを作ってタップを反応させる
        let button: UIButton = UIButton(frame: CGRect(x:CGFloat(0), y:CGFloat(0), width: CGFloat(1024), height: CGFloat(768)))
        button.tag = 22
        button.addTarget(self, action: #selector(B1(sender:)), for: .touchUpInside)
        self.view.addSubview(button)
        videoPlayer.play()
    }
    @objc func playerDidFinishPlaying(notification: NSNotification) {
        play()
    }
    @objc func B1(sender: UIButton){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        switch sender.tag{
        case 0:
            let date = Date()
            let dateAndTime = date.formattedDateWith(style: .time)
            let realm = try! Realm()
            let obj = realm.objects(r_data3.self).last
            try! realm.write {
                obj?.time_in = dateAndTime
            }
            let SViewController: UIViewController = ViewController()
            //アニメーションを設定する.
            SViewController.modalTransitionStyle = .flipHorizontal
            //Viewの移動する.
            SViewController.modalPresentationStyle = .fullScreen
            self.present(SViewController, animated: true, completion: nil)
            audioPlayerInstance.play()
        default:break
        }
    }
    override func viewDidAppear(_ animated: Bool){
        print("player破棄しにきた")
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
