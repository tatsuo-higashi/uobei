

import UIKit
import AVFoundation//オーディオがらみ
import AVKit

class testmode: UIViewController {
    
    
    // 画像を設定する.
    let myInputImage = CIImage(image: UIImage(named: "top.jpeg")!)
    // ImageViewを.定義する.
    var myImageView: UIImageView!
    
    var addTimer = Timer()
    
    
    
    
    override func viewDidLoad() {
        
        loadView()//videoplayerを破棄
        print("overfuncのloadviewはした")
        super.viewDidLoad()
        addTimer =  Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(play), userInfo: nil, repeats: false)
        myImageView = UIImageView(frame: self.view.frame)
        myImageView.image = UIImage(ciImage: myInputImage!)
        self.view.addSubview(myImageView)
        
        // スクリーン画面のサイズを取得
        let screenWidth: CGFloat = UIScreen.main.bounds.width      //画面の幅
        let screenHeight: CGFloat = UIScreen.main.bounds.height//画面の高さ
        
        
        
        print(screenWidth)
        print(screenHeight)
        
        func make_button(xv:Int,yv:Int,wv:Int,hv:Int,f:Int,b:String,c:Int)->UIButton{
            
            let button: UIButton = UIButton(frame: CGRect(x:CGFloat(xv), y:CGFloat(yv), width: CGFloat(wv), height: CGFloat(hv)))
            let picture = UIImage(named: "\(b).png")
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.borderWidth = 1
            button.backgroundColor = UIColor.clear
            button.setTitle("\(b)", for: .normal)
            button.tag = c
            button.setImage(picture, for: .normal)
            button.layer.cornerRadius = 6
            return(button)
        }
        
        
        //m:backgrand,e:picture,e:border
        func make_b(xv:Int,yv:Int,wv:Int,hv:Int,f:Int,b:String,c:Int){
            
            let button: UIButton = UIButton(frame: CGRect(x:CGFloat(xv), y:CGFloat(yv), width: CGFloat(wv), height: CGFloat(hv)))
            let picture = UIImage(named: "\(b).jpeg")
            button.backgroundColor = UIColor.clear
            button.setTitle("\(b)", for: .normal)
            button.layer.cornerRadius = 3.0
            button.tag = c
            button.setImage(picture, for: .normal)
            button.addTarget(self, action: #selector(B1(sender:)), for: .touchUpInside)
            // ボタンを追加する.
            self.view.addSubview(button)
            
        }
        func make_b2(xv:Int,yv:Int,wv:Int,hv:Int,f:Int,b:String,c:Int){
            
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
        
        make_b(xv:80,yv:170,wv:280,hv:180,f:20,b:"set",c:0)
        make_b(xv:380,yv:170,wv:280,hv:180,f:20,b:"ikura",c:1)
        make_b(xv:680,yv:170,wv:280,hv:180,f:20,b:"osusume",c:2)
        make_b(xv:80,yv:310,wv:280,hv:180,f:20,b:"nigiri1",c:3)
        make_b(xv:380,yv:310,wv:280,hv:180,f:20,b:"nigiri2",c:4)
        make_b(xv:680,yv:310,wv:280,hv:180,f:20,b:"gunkan",c:5)
        make_b(xv:80,yv:450,wv:280,hv:180,f:20,b:"side",c:6)
        make_b(xv:380,yv:450,wv:280,hv:180,f:20,b:"deza",c:7)
        make_b(xv:680,yv:450,wv:280,hv:180,f:20,b:"drink",c:8)
        make_b2(xv:80,yv:620,wv:280,hv:130,f:20,b:"テストモード",c:9)
        make_b(xv:80,yv:620,wv:280,hv:130,f:20,b:"take",c:10)
        make_b2(xv:380,yv:620,wv:280,hv:130,f:20,b:"会計確認    注文履歴",c:11)
        make_b2(xv:680,yv:620,wv:280,hv:130,f:20,b:"店員呼出",c:12)
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
        
        print("bt_count = 0")
        let bundleDataName: String = "move"
        let bundleDataType: String = "mp4"
        
        //MovieApp_iOS -> Build Phases -> Copy Bundle Resources 内にbundle.mp4を追加
        let moviePath: String? = Bundle.main.path(forResource: bundleDataName, ofType: bundleDataType)
        playMovieFromPath(moviePath: moviePath)
        
        addTimer.invalidate()
        
    }
    
    @objc func play(){
        
        //これでタイマー切
        addTimer.invalidate()
        
        // パスからassetを生成.
        
        let path = Bundle.main.path(forResource: "move", ofType: "mp4")
        let fileURL = NSURL(fileURLWithPath: path!)
        let avAsset = AVAsset(url: fileURL as URL)
        // AVPlayerに再生させるアイテムを生成.
        let playerItem = AVPlayerItem(asset: avAsset)
        // AVPlayerを生成.
        let videoPlayer = AVPlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: videoPlayer)
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
    
    @objc internal func B1(sender: UIButton){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let qrc = make_qrc()//m:backgrand,e:picture,e:border
        let view = make_view()
        if sender.tag <= 8{
            k = sender.tag
        }
        switch sender.tag{
        case k://メニュー
            appDelegate.choise = k
            addTimer.invalidate()
            let SViewController: UIViewController = menu()
            //アニメーションを設定する.
            SViewController.modalTransitionStyle = .flipHorizontal
            //Viewの移動する.
            self.present(SViewController, animated: true, completion: nil)
            audioPlayerInstance.play()
            
        case 2://言語切替
            print("ok2")
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
            audioPlayerInstance.play()
            
            //self.view.addSubview(view.make())
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

