import UIKit
import AVFoundation//オーディオがらみ
import AVKit
import CoreImage
import RealmSwift


class First: UIViewController {
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate// 画像を設定する.
    let myInputImage = CIImage(image: UIImage(named: "first.jpeg")!)
    var myImageView: UIImageView! // ImageViewを.定義する.
    override func viewDidLoad() {
        

        print(Realm.Configuration.defaultConfiguration.fileURL!)
        loadView()//videoplayerを破棄
        super.viewDidLoad()
        audioPlayerInstance.prepareToPlay()
        let launchViewController: UIViewController = Menu() // 起動直後に遷移させる画面を宣言
        self.addChild(launchViewController) // 子ViewのViewControllerを指定
        launchViewController.didMove(toParent: self)  // 子Viewの所有権を譲渡
        myImageView = UIImageView(frame: self.view.frame)
        myImageView.image = UIImage(ciImage: myInputImage!)
        self.view.addSubview(myImageView)
        
        //透明なボタンを作ってタップを反応させる
        let button: UIButton = UIButton(frame: CGRect(x:CGFloat(0), y:CGFloat(0), width: CGFloat(1024), height: CGFloat(768)))
        button.tag = 0
        button.addTarget(self, action: #selector(selection(sender:)), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    
 
    @objc func selection(sender: UIButton){
        let view = viewSetting()
        switch sender.tag{
            case 0:
                let date = Date()
                let dateAndTime = date.formattedDateWith(style: .time)
                let realm = try! Realm()
                let obj = realm.objects(guestData.self).last
                try! realm.write {
                    obj?.inTime = dateAndTime
                }
                self.present(view.viewSet(open: ViewController(),anime: .flipHorizontal), animated: false, completion: nil)
                audioPlayerInstance.play()
            default:break
        }
    }
    override func viewDidAppear(_ animated: Bool){
        loadView()//videoplayerを破棄 画面遷移なしで
        viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        print("メモリ使いすぎ")
        super.didReceiveMemoryWarning()
    }
}
