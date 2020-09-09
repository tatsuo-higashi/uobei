
import UIKit
import AVFoundation//オーディオがらみ
import AVKit
import CoreImage
import RealmSwift

var k = 0
var j = 0
var l = 0
var seat_num = "1"
var time_num_s = "1"
var time_num_m = "1"


class ViewController: UIViewController ,selection{
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let myInputImage = CIImage(image: UIImage(named: "top.jpeg")!) // 画像を設定する.
    var myImageView: UIImageView! // ImageViewを.定義する.
    var addTimer = Timer()
    
    
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //クラスをインスタンス化
        let button = makeButton()//m:backgrand,e:picture,e:border
        let label = makeLabel()//o:border,o1:backgrand,o2:0でalpha無効,ic:300でむテキスト無効
        let launchViewController: UIViewController = test()
        audioPlayerInstance.prepareToPlay()
        self.addChild(launchViewController)  // 子ViewのViewControllerを指定
        launchViewController.didMove(toParent: self)  // 子Viewの所有権を譲渡
        addTimer =  Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(play), userInfo: nil, repeats: false)
        myImageView = UIImageView(frame: UIScreen.main.bounds)
        myImageView.image = UIImage(ciImage: myInputImage!)
        self.view.addSubview(myImageView)
        


        self.view.addSubview(button.make(xv:80,yv:170,wv:280,hv:180,f:20,b:"set",c:0,t:0))
        self.view.addSubview(button.make(xv:380,yv:170,wv:280,hv:180,f:20,b:"ikura",c:1,t:0))
        self.view.addSubview(button.make(xv:680,yv:170,wv:280,hv:180,f:20,b:"osusume",c:2,t:0))
        self.view.addSubview(button.make(xv:80,yv:310,wv:280,hv:180,f:20,b:"nigiri1",c:3,t:0))
        self.view.addSubview(button.make(xv:380,yv:310,wv:280,hv:180,f:20,b:"nigiri2",c:4,t:0))
        self.view.addSubview(button.make(xv:680,yv:310,wv:280,hv:180,f:20,b:"gunkan",c:5,t:0))
        self.view.addSubview(button.make(xv:80,yv:450,wv:280,hv:180,f:20,b:"side",c:6,t:0))
        self.view.addSubview(button.make(xv:380,yv:450,wv:280,hv:180,f:20,b:"deza",c:7,t:0))
        self.view.addSubview(button.make(xv:680,yv:450,wv:280,hv:180,f:20,b:"drink",c:8,t:0))
        self.view.addSubview(button.make(xv:80,yv:620,wv:280,hv:130,f:20,b:"テストモード",c:9,t:1))
        self.view.addSubview(button.make(xv:80,yv:620,wv:280,hv:130,f:20,b:"take",c:10,t:0))
        self.view.addSubview(button.make(xv:380,yv:620,wv:280,hv:130,f:20,b:"会計確認   注文履歴",c:11,t:1))
        self.view.addSubview(button.make(xv:680,yv:620,wv:280,hv:130,f:20,b:"店員呼出",c:12,t:1))
    }
    
    
    func playMovieFromUrl(movieUrl: URL?) {
        if let movieUrl = movieUrl {
            let videoPlayer = AVPlayer(url: movieUrl)
            let playerController = AVPlayerViewController()
            playerController.player = videoPlayer
            self.present(playerController, animated: true, completion: {
                videoPlayer.play()
            })
        } else {
            print("cannot play")
        }
    }
    
    func playMovieFromPath(moviePath: String?) {
        if let moviePath = moviePath {
            self.playMovieFromUrl(movieUrl: URL(fileURLWithPath: moviePath))
        } else {
            print("no such file")
        }
    }
    
    @objc func playMovieFromBundleFile() {
       print("playMovieFromBundleFile")
        let bundleDataName: String = "\(appDelegate.movie_num)"
        let bundleDataType: String = "mp4"
        
        //MovieApp_iOS -> Build Phases -> Copy Bundle Resources 内にbundle.mp4を追加
        let moviePath: String? = Bundle.main.path(forResource: bundleDataName, ofType: bundleDataType)
        playMovieFromPath(moviePath: moviePath)
        
        addTimer.invalidate()

    }
    
    @objc func play(){
        print("play")
        //これでタイマー切
        addTimer.invalidate()
        
        // パスからassetを生成.
   
        let path = Bundle.main.path(forResource:  "\(appDelegate.movie_num)", ofType: "mp4")
        let fileURL = NSURL(fileURLWithPath: path!)
        let avAsset = AVAsset(url: fileURL as URL)
        // AVPlayerに再生させるアイテムを生成.
        let playerItem = AVPlayerItem(asset: avAsset)
        // AVPlayerを生成.
        let videoPlayer = AVPlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: videoPlayer)
        videoPlayer.volume = appDelegate.volume_v
        
        // 出力先判定
    func IsHeadSetConnected() -> Bool{
            let route  = AVAudioSession.sharedInstance().currentRoute;
            for desc   in route.outputs
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
        
      /*  func didChangeAudioSessionRoute(notification:Notification){
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
            }catch _ as NSError{
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
        button.addTarget(self, action: #selector(selection(sender:)), for: .touchUpInside)
        self.view.addSubview(button)
        videoPlayer.play()
    }
    
    @objc func playerDidFinishPlaying(notification: NSNotification) {
     play()
    }

    @objc func selection(sender: UIButton){
        print("menu")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if sender.tag <= 8{
            k = sender.tag
        }
        switch sender.tag{
        case 10:
            addTimer.invalidate()
            appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
            //　Storyboardを指定
            // rootViewControllerに入れる
            appDelegate.window?.rootViewController = test()
            // 表示
            appDelegate.window?.makeKeyAndVisible()
            //let SViewController: UIViewController = MasterViewController()
            //アニメーションを設定する.
            //SViewController.modalTransitionStyle = .flipHorizontal
            //Viewの移動する.
            //self.present(SViewController, animated: true, completion: nil)
            //audioPlayerInstance.play()
        case 11:
            addTimer.invalidate()
            let SViewController: UIViewController = history()
            //アニメーションを設定する.
            SViewController.modalTransitionStyle = .flipHorizontal
            //Viewの移動する.
            SViewController.modalPresentationStyle = .fullScreen
            self.present(SViewController, animated: true, completion: nil)
        case 12:
            addTimer.invalidate()
            let SViewController: UIViewController = call()
            //アニメーションを設定する.
            SViewController.modalTransitionStyle = .flipHorizontal
            //Viewの移動する.
            SViewController.modalPresentationStyle = .fullScreen
            self.present(SViewController, animated: true, completion: nil)
            //self.view.addSubview(view.make())
            //self.view.addSubview(qrc.make())
        case 22://動画再生中のタップ
            print("透明なボタン押してる")
            addTimer.invalidate()
            loadView()//videoplayerを破棄 画面遷移なしで
            viewDidLoad()
        case k://メニュー
            appDelegate.choise = k
            addTimer.invalidate()
            let SViewController: UIViewController = menu()
            //アニメーションを設定する.
            SViewController.modalTransitionStyle = .flipHorizontal
            //Viewの移動する.
            SViewController.modalPresentationStyle = .fullScreen
            self.present(SViewController, animated: true, completion: nil)
            // 再生準備
            audioPlayerInstance.play()
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

