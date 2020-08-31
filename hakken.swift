import UIKit
import AVFoundation//オーディオがらみ
import AVKit
import Foundation
import RealmSwift
import CoreImage
class hakken: UIViewController,UITextFieldDelegate,UITabBarDelegate {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let myInputImage = CIImage(image: UIImage(named: "kara")!)
    var addTimer = Timer()
    var timerCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // let drawView = DrawView(frame: self.view.bounds)
        //self.view.addSubview(drawView)
        
        // UIImageViewを作成する.
        myImageView = UIImageView(frame: CGRect(x: 0,y: 0,width: 1024,height: 768))
        myImageView.image = UIImage(ciImage: myInputImage!)
        self.view.addSubview(myImageView)
        ////audioPlayerInstance.prepareToPlay()
        // audioPlayerInstance.volume = appDelegate.volume
        //クラスをインスタンス化
        let button = make_button()//m:backgrand,e:picture,e:border
        let label = make_label()//o:border,o1:backgrand,o2:0でalpha無効,ic:300でむテキスト無効
        let qrc = make_qrc()
        //共通ボタン作成
        self.view.addSubview(label.make(xv:40,yv:55,wv:300,hv:80,f:35,o:0,o1:0,o2:0.0,ic:"只今の待ち時間"))
         self.view.addSubview(label.make(xv:40,yv:160,wv:300,hv:150,f:90,o:0,o1:0,o2:0.0,ic:"約25分"))
        self.view.addSubview(label.make(xv:340,yv:55,wv:300,hv:80,f:35,o:0,o1:0,o2:0.0,ic:"次のご案内予定"))
        self.view.addSubview(label.make(xv:340,yv:160,wv:300,hv:150,f:90,o:0,o1:0,o2:0.0,ic:"218"))
        self.view.addSubview(label.make(xv:640,yv:55,wv:300,hv:80,f:35,o:0,o1:0,o2:0.0,ic:"ご案内済みのお客様"))
        self.view.addSubview(label.make(xv:640,yv:140,wv:300,hv:110,f:35,o:0,o1:0,o2:0.0,ic:"ご予約テーブル:1420"))
        self.view.addSubview(label.make(xv:640,yv:250,wv:300,hv:110,f:35,o:0,o1:0,o2:0.0,ic:"テーブル:1237"))
        self.view.addSubview(label.make(xv:640,yv:360,wv:300,hv:120,f:35,o:0,o1:0,o2:0.0,ic:"カウンター:237"))
        self.view.addSubview(label.make(xv:40,yv:320,wv:640,hv:60,f:90,o:0,o1:0,o2:0.0,ic:"待ち時間は状況により前後する場合がございます"))
        
        /*// 線
        let line = UIBezierPath()
        // 最初の位置
        line.move(to: CGPoint(x: 40, y: 400))
        // 次の位置
        line.addLine(to:CGPoint(x: 960, y: 400))
        // 終わる
        line.close()
        // 線の色
        UIColor.gray.setStroke()
        // 線の太さ
        line.lineWidth = 2.0
        // 線を塗りつぶす
        line.stroke()*/
        
        self.view.addSubview(label.make(xv:40,yv:490,wv:460,hv:270,f:50,o:0,o1:3,o2:0.0,ic:""))
        self.view.addSubview(label.make(xv:55,yv:490,wv:470,hv:100,f:50,o:0,o1:0,o2:0.0,ic:"お店で受付の方"))
        self.view.addSubview(button.make(xv:100,yv:590,wv:300,hv:150,f:50,b:"発券",c:1,d:1,e:0,m:1))
        self.view.addSubview(label.make(xv:540,yv:490,wv:460,hv:270,f:50,o:0,o1:4,o2:0.0,ic:""))
        self.view.addSubview(label.make(xv:555,yv:490,wv:470,hv:100,f:50,o:0,o1:0,o2:0.0,ic:"スマホで受付の方"))
        self.view.addSubview(button.make(xv:625,yv:590,wv:300,hv:150,f:50,b:"チックイン",c:2,d:1,e:0,m:1))

        
      
        func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    }
    
      @objc func B3(sender: UIButton){
        switch sender.tag{
        case 1:
            let SViewController: UIViewController = hakken2()
            //アニメーションを設定する.
            SViewController.modalTransitionStyle = .flipHorizontal
            //Viewの移動する.
            SViewController.modalPresentationStyle = .fullScreen
            self.present(SViewController, animated: true, completion: nil)
        case 2:
            //githubで更新テスト用S
                let SViewController: UIViewController = first()
                //アニメーションを設定する.
                SViewController.modalTransitionStyle = .flipHorizontal
                //Viewの移動する.
                SViewController.modalPresentationStyle = .fullScreen
                self.present(SViewController, animated: true, completion: nil)
        case 7:
            print("プラスを押した")
        default:break
        }
    }
}
