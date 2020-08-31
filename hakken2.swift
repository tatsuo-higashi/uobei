 // 更新しましたー
import UIKit
import AVFoundation//オーディオがらみ
import AVKit
import Foundation
import RealmSwift
import CoreImage
class hakken2: UIViewController,UITextFieldDelegate,UITabBarDelegate {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let myInputImage = CIImage(image: UIImage(named: "hakken2")!)
    var addTimer = Timer()
    var timerCount = 0
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        self.view.addSubview(label.make(xv:40,yv:180,wv:160,hv:70,f:50,o:0,o1:0,o2:0.0,ic:"大人・子供\n(7歳〜)"))
        
        //マスク用ぁlabel
        self.view.addSubview(label.make(xv:40,yv:180,wv:160,hv:70,f:50,o:0,o1:0,o2:0.0,ic:"大人・子供\n(7歳〜)"))
        
        self.view.addSubview(button.make(xv:215,yv:180,wv:80,hv:80,f:50,b:"0",c:0,d:1,e:0,m:1))
        self.view.addSubview(button.make(xv:310,yv:180,wv:80,hv:80,f:50,b:"1",c:1,d:1,e:0,m:1))
        self.view.addSubview(button.make(xv:405,yv:180,wv:80,hv:80,f:50,b:"2",c:2,d:1,e:0,m:1))
        self.view.addSubview(button.make(xv:500,yv:180,wv:80,hv:80,f:50,b:"3",c:3,d:1,e:0,m:1))
        self.view.addSubview(button.make(xv:595,yv:180,wv:80,hv:80,f:50,b:"4",c:4,d:1,e:0,m:1))
        self.view.addSubview(button.make(xv:690,yv:180,wv:80,hv:80,f:50,b:"5",c:5,d:1,e:0,m:1))
        self.view.addSubview(button.make(xv:785,yv:180,wv:80,hv:80,f:50,b:"6",c:6,d:1,e:0,m:1))
        self.view.addSubview(button.make(xv:880,yv:180,wv:80,hv:80,f:50,b:"7+",c:7,d:1,e:0,m:1))
        
        
        
        self.view.addSubview(label.make(xv:40,yv:310,wv:160,hv:70,f:50,o:0,o1:0,o2:0.0,ic:"未就学児\n(〜6歳)"))
        self.view.addSubview(button.make(xv:215,yv:310,wv:80,hv:80,f:50,b:"0",c:8,d:1,e:0,m:1))
        self.view.addSubview(button.make(xv:310,yv:310,wv:80,hv:80,f:50,b:"1",c:9,d:1,e:0,m:1))
        self.view.addSubview(button.make(xv:405,yv:310,wv:80,hv:80,f:50,b:"2",c:10,d:1,e:0,m:1))
        self.view.addSubview(button.make(xv:500,yv:310,wv:80,hv:80,f:50,b:"3",c:11,d:1,e:0,m:1))
        self.view.addSubview(button.make(xv:595,yv:310,wv:80,hv:80,f:50,b:"4",c:12,d:1,e:0,m:1))
        self.view.addSubview(button.make(xv:690,yv:310,wv:80,hv:80,f:50,b:"5",c:12,d:1,e:0,m:1))
        self.view.addSubview(button.make(xv:785,yv:310,wv:80,hv:80,f:50,b:"6",c:14,d:1,e:0,m:1))
        self.view.addSubview(button.make(xv:880,yv:310,wv:80,hv:80,f:50,b:"7+",c:15,d:1,e:0,m:1))
        
        self.view.addSubview(button.make(xv:215,yv:440,wv:365,hv:100,f:50,b:"カウンター",c:16,d:1,e:0,m:1))
        self.view.addSubview(button.make(xv:595,yv:440,wv:365,hv:100,f:50,b:"テーブル",c:17,d:1,e:0,m:1))
        self.view.addSubview(button.make(xv:215,yv:570,wv:745,hv:100,f:50,b:"発券",c:18,d:1,e:0,m:1))
        
        
        self.view.addSubview(button.make(xv:40,yv:710,wv:100,hv:50,f:50,b:"戻る",c:19,d:1,e:0,m:1))
        
        
        func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    }
    
    @objc func B3(sender: UIButton){
        
        if sender.tag <= 7 {
            k = sender.tag
            let realm = try! Realm()
            let hakkenObj = realm.objects(hakkenData.self).last
            try! realm.write {
                hakkenObj?.adult = "\(k)"
            }
        }
        
        if sender.tag >= 8 && sender.tag <= 15{
            l = sender.tag
            let realm = try! Realm()
            let hakkenObj = realm.objects(hakkenData.self).last
            try! realm.write {
                hakkenObj?.child = "\(l)"
            }
        }
        switch sender.tag{
        case 16:
            let realm = try! Realm()
            let hakkenObj = realm.objects(hakkenData.self).last
            try! realm.write {
                hakkenObj?.seatType = "カウンター"
            }
        case 17:
            let realm = try! Realm()
            let hakkenObj = realm.objects(hakkenData.self).last
            try! realm.write {
                hakkenObj?.seatType = "テーブル"
            }

        case 18:
            // デフォルトRealmを取得
            let realm = try! Realm()
            let hakkenObj = realm.objects(hakkenData.self).last
            try! realm.write {

                hakkenObj?.memberNum = "\(k+l)"
                }
            let SViewController: UIViewController = first()
            //アニメーションを設定する.
            SViewController.modalTransitionStyle = .flipHorizontal
            //Viewの移動する.
            SViewController.modalPresentationStyle = .fullScreen
            self.present(SViewController, animated: true, completion: nil)
        case 19:
            let SViewController: UIViewController = hakken()
            //アニメーションを設定する.
            SViewController.modalTransitionStyle = .flipHorizontal
            //Viewの移動する.
            SViewController.modalPresentationStyle = .fullScreen
            self.present(SViewController, animated: true, completion: nil)
        default:break
        }
    }
}
