
import UIKit
import AVFoundation//オーディオがらみ
import AVKit
import Foundation
import RealmSwift
import CoreImage



var myImageView: UIImageView!


//メニュー関係
var count_t: [(k:Int,now:String)] = [
    (0,""),
    (0,""),
    (0,"")]
var box: [(name: String, qty: Int ,view: String)] = [
    ("",0,"kara.png"),
    ("",0,"kara.png"),
    ("",0,"kara.png")]
var tag1: [String] = ["セットメニュー・期間限定","どか盛りフェア","にぎり(おすすめ)","にぎり①","にぎり②","ぐんかん・巻物・いなり","サイドメニュー","デザート","ドリンク・アルコール" ]
var tag2: [[String]] = [[("ページ1")],//tag0 セットメニュー・季節限定
    [("ページ1"), ("ページ2")],//tag1 どか盛り
    [("ページ1")],//tag2 にぎりおすすめ
    [("まぐろ"), ("サーモン"),("えび"),("いか・たこ"),("光物"),("貝")],//tag3 にぎり①
    [("うなぎ・穴子"), ("その他1"),("その他2")],//tag4 にぎり②
    [("ぐんかん1"), ("ぐんかん2"),("巻物・いなり")],//ぐんかん・巻物・いなり
    [("麺"), ("味噌汁"),("揚げ物"),("その他")],//サイドメニュー
    [("デザート1"), ("デザート2"),("デザート3")],//デザート
    [("アルコール"), ("ソフトドリンク")],//ドリンク・アルコール
    
]

//0:まぐろ,1:さーもん
var tag_flag2 = 0
//
let date: [[[(name: String, pic: String)]]] =
    [
        [[(name:"蟹の豪華盛り",pic:"001"), (name:"生タコ梅キュウ",pic:"002"),(name:"よだれ鶏にぎり",pic:"003"),(name:"匠の本格海老マヨ",pic:"004"),(name:"すりながしカレーうどん",pic:"005")]],
        //
        [[(name:"どか盛りホタテ",pic:"006"), (name:"どか盛りいくらサーモン",pic:"007"),(name:"どか盛り甘えび",pic:"008"),(name:"どか盛りびんとろ",pic:"009"),(name:"ローストビーフマウンテン",pic:"010"),(name:"Wかつお",pic:"011")],[(name:"どか盛りねぎとろ",pic:"012")]],
        //おすすめ握り
        [[(name:"生ほっき貝",pic:"013"), (name:"生本まぐろ",pic:"014"),(name:"生本まぐろ大とろ",pic:"015"),(name:"特大天然車えび",pic:"016"),(name:"特大ジャンボほたて",pic:"017")]],
        //握り1
        [[(name:"まぐろ",pic:"018"), (name:"漬けまぐろ",pic:"019"),(name:"びんとろ",pic:"020"),(name:"中とろ",pic:"021"),(name:"大トロ",pic:"022")],[(name:"サーモン",pic:"023"),    (name:"オニオンサーモン",pic:"024"),(name:"焼サーモン",pic:"025"),(name:"おろしサーモン",pic:"026"),(name:"サーモンモッツアレラ",pic:"027"),(name:"生サーモン",pic:"028")],
         [(name:"赤えび",pic:"029"),(name:"えび",pic:"030"),(name:"生えび",pic:"031"),(name:"えびチーズ",pic:"032"),(name:"えびバジルチーズ",pic:"033"),                           (name:"えびアボカド",pic:"034")],
         [(name:"紋甲いか",pic:"035"), (name:"いか",pic:"036"),(name:"いか塩レモン",pic:"037"),(name:"こういか",pic:"038"),(name:"たこ",pic:"039"),(name:"生たこ",pic:"040")],
         [(name:"こはだ",pic:"041"), (name:"〆さば",pic:"042"),(name:"〆さば(ゴマねぎ)",pic:"043"),(name:"焼き鯖",pic:"044"),(name:"〆イワシ",pic:"045")],
         [(name:"つぶ貝",pic:"046"), (name:"赤貝",pic:"047"),(name:"ほっき貝",pic:"048"),(name:"ほたて貝柱",pic:"049"),(name:"黒みる貝",pic:"050"),(name:"白とり貝",pic:"051")]],
        //握り2
        [[(name:"うなぎ",pic:"052"), (name:"穴子",pic:"053"),(name:"炙り穴子",pic:"054"),(name:"一本穴子",pic:"055")],
         [(name:"生ハム",pic:"056"), (name:"生ハムモッツアレラ",pic:"057"),(name:"牛塩カルビ",pic:"058"),(name:"和牛さし",pic:"059")],
         [(name:"たまご",pic:"060"), (name:"キス天ぷら",pic:"061"),(name:"なす漬物",pic:"062")]],
        //ぐんかん・巻物・いなり
        [[(name:"まぐろたたき",pic:"063"), (name:"山かけ",pic:"064"),(name:"まぐろユッケ",pic:"065"),(name:"イカおくら",pic:"066"),(name:"えびマヨ",pic:"067"),(name:"カニみそ",pic:"068")],
         [(name:"いくら",pic:"069"),(name:"コーンマヨ",pic:"070"),(name:"ツナ",pic:"071")],
         [(name:"鉄火巻き",pic:"072"), (name:"かっぱ巻き",pic:"073"),(name:"かんぴょう巻き",pic:"074"),(name:"うなきゅう",pic:"075"), (name:"季節のいなり",pic:"076")]],
        //サイドメニュー
        [[(name:"コク旨まぐろ醤油ラーメン",pic:"077"), (name:"鯛だし塩ラーメン",pic:"078"),(name:"濃厚えび味噌ワンタンメン",pic:"079"),(name:"あさりと筍のおうどん",pic:"080"),(name:"かけうどん",pic:"081"),(name:"エビ天うどん",pic:"082")],
         [(name:"あおさと海苔の赤だし",pic:"083"),(name:"あさりの赤だし",pic:"084"),(name:"魚のアラの赤だし",pic:"085"),(name:"あおさと海苔の味噌汁",pic:"086"),(name:"あさりの味噌汁",pic:"087")],
         [(name:"なんこつ唐揚げ",pic:"088"), (name:"フライドポテト",pic:"089"),(name:"たこの唐揚げ",pic:"090"),(name:"天ぷら盛り合わせ",pic:"091"),(name:"かぼちゃの天ぷら",pic:"092"),(name:"鶏モモの唐揚げ",pic:"093")],
         [(name:"枝豆",pic:"094"), (name:"しらすとパンチェッタのサラダ",pic:"095"),(name:"茶碗蒸し",pic:"096"),(name:"だし巻き卵",pic:"097")]],
        //デザート
        [[(name:"練乳いちごパフェ",pic:"098"), (name:"チョコムースバナナパフェ",pic:"099"),(name:"カタラーナアイスブリュレ",pic:"100"),(name:"北海道ミルクレープメルバ",pic:"101"),(name:"わらびもち",pic:"102"),(name:"大学いも",pic:"103")],
         [(name:"ショコラケーキリッチ",pic:"104"),(name:"ニューヨークイチゴケーキ",pic:"105"),(name:"北海道ミルクレープ",pic:"106"),(name:"とろっとプリン",pic:"107"),(name:"北海道バニラアイス",pic:"108"),(name:"ベルギーショコラアイス",pic:"109")],
         [(name:"フローズンマンゴー",pic:"110"),(name:"懐かしのメロンシャーベット",pic:"111")]],
        //ソフトドリンク・アルコール
        [[(name:"生ビール",pic:"112"), (name:"角ハイボール",pic:"113"),(name:"レモンサワー",pic:"114"),(name:"大吟醸",pic:"115"),(name:"生貯蔵酒",pic:"116"),(name:"ノンアルコールビール",pic:"117")],
         [(name:"りんごジュース",pic:"118"),(name:"アイスコーヒー",pic:"119"),(name:"アイスカフェラテ",pic:"120"),(name:"ホットコーヒー",pic:"121"),(name:"ホットカフェラテ",pic:"122")]],
]

//カウント用変数
var i = 0

//商品選択後
func st(sn:String,pn:String){
    if i < 3{
        if box[0].name == ""{
            i = 0
            box[i].name = sn
            box[i].qty = 1
            box[i].view = pn
        }else if  box[1].name == ""{
            i = 1
            box[i].name = sn
            box[i].qty = 1
            box[i].view = pn
        }else if  box[2].name == ""{
            i = 2
            box[i].name = sn
            box[i].qty = 1
            box[i].view = pn
        }
        count_t[0].now = "off"
        count_t[1].now = "off"
        count_t[2].now = "off"
    }
}

class Menu: UIViewController,UITextFieldDelegate,UITabBarDelegate {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let myInputImage = CIImage(image: UIImage(named: "second.jpeg")!)
    var addTimer = Timer()
    var timerCount = 0
    
    //メソッド作成
    //スワイプの最大
    func tag_max(choise:Int)->Int{
        var tag_max = 0
        tag_max = date[choise].count
        return (tag_max)
    }
    // レフトスワイプ時に実行される
    @objc func leftSwipeView(sender: UISwipeGestureRecognizer) {
        let tag_flag1 = appDelegate.choise
        if tag_flag2 < tag_max(choise: tag_flag1)-1{
            tag_flag2 = tag_flag2 + 1
            viewDidLoad()
        }
    }
    // ライトスワイプ時に実行される
    @objc func rightSwipeView(sender: UISwipeGestureRecognizer) {
        if tag_flag2  > 0{
            tag_flag2 = tag_flag2 - 1
            viewDidLoad()
        }
    }
    //タイマー
    @objc func timerCall() {
        viewDidLoad()
        // タイマーを無効にする
        addTimer.invalidate()
    }
    //viewの設定
    func viewSetting(SViewController:UIViewController){
        //アニメーションを設定する.
        SViewController.modalTransitionStyle = .flipHorizontal
        //Viewの移動する.
        SViewController.modalPresentationStyle = .fullScreen
        self.present(SViewController, animated: true, completion: nil)
    }
    //メソッド終わり
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tag_flag1 = appDelegate.choise
        //クラスをインスタンス化
        let button = makeButton()//m:backgrand,e:picture,e:border
        let label = makeLabel()//o:border,o1:backgrand,o2:0でalpha無効,ic:300でむテキスト無効
        //        let qrc = makeQrc()
        
        // UIImageViewを作成する.
        myImageView = UIImageView(frame: CGRect(x: 0,y: 0,width: 1024,height: 768))
        myImageView.image = UIImage(ciImage: myInputImage!)
        self.view.addSubview(myImageView)
        
        //写真ボタン作成
        for d in 0..<date[tag_flag1][tag_flag2].count{
            var e = 0
            if d <= 2{e=0}else{e=1}
            self.view.addSubview(button.make(xv:30+(220*d)-(660*e),yv:225+(220*e),wv:200,hv:200,f:20,b:date[tag_flag1][tag_flag2][d].pic,c:0+d,d:0,e:1,m:0))
        }
        //共通ボタン作成
        self.view.addSubview(button.make(xv:30,yv:700,wv:100,hv:50,f:50,b:"戻る",c:6,d:1,e:0,m:1))
        self.view.addSubview(button.make(xv:950,yv:290,wv:60,hv:60,f:50,b:"➕",c:7,d:1,e:0,m:1))
        self.view.addSubview(button.make(xv:790,yv:290,wv:60,hv:60,f:50,b:"➖",c:8,d:1,e:0,m:1))
        self.view.addSubview(button.make(xv:650,yv:700,wv:100,hv:50,f:50,b:"注文",c:9,d:1,e:0,m:1))
        //商品名（1段目)
        if box[0].name == ""{
        }else{
            self.view.addSubview(button.make(xv:750,yv:450,wv:200,hv:60,f:35,b:"\(box[0].name)",c:13,d:0,e:0,m:0))
        }
        //商品名（2段目)
        if box[1].name == ""{
        }else{
            self.view.addSubview(button.make(xv:750,yv:510,wv:200,hv:60,f:35,b:"\(box[1].name)",c:14,d:0,e:0,m:0))
        }
        //商品名（2段目)
        if box[2].name == ""{
        }else{
            self.view.addSubview(button.make(xv:750,yv:570,wv:200,hv:60,f:35,b:"\(box[2].name)",c:15,d:0,e:0,m:0))
        }
        //tag1用ボタンの作成
        for k in 0...8{
            self.view.addSubview(button.make(xv:5+(80*k),yv:5,wv:80,hv:70,f:20,b:tag1[k],c:16+k,d:1,e:0,m:1))
        }
        //tag1 選択ラベル
        let r1 = (appDelegate.choise*80)
        self.view.addSubview(label.make(xv:5+r1,yv:5,wv:80,hv:70,f:50,o:0,o1:2,o2:0.3,ic:""))
        
        //tag2ボタン(tag2がある物だけ作成)
        for d in 0..<date[tag_flag1].count{
            self.view.addSubview(button.make(xv:5+(115*d),yv:90,wv:110,hv:70,f:25,b:tag2[tag_flag1][d],c:25+d,d:1,e:0,m:1))
        }
        //tag2 選択ラベル
        let r2 = (tag_flag2*115)
        self.view.addSubview(label.make(xv:5+r2,yv:90,wv:110,hv:70,f:50,o:0,o1:2,o2:0.3,ic:""))
        
        //数量用（共通)
        self.view.addSubview(label.make(xv:870,yv:290,wv:60,hv:60,f:50,o:2,o1:0,o2:0,ic:"\(box[i].qty)"))
        //数量用（1段目)
        self.view.addSubview(label.make(xv:960,yv:450,wv:60,hv:60,f:50,o:0,o1:0,o2:0,ic:"\(box[0].qty)"))
        //数量用（2段目)
        self.view.addSubview(label.make(xv:960,yv:510,wv:60,hv:60,f:50,o:0,o1:0,o2:0,ic:"\(box[1].qty)"))
        //数量用（3段目)
        self.view.addSubview(label.make(xv:960,yv:570,wv:60,hv:60,f:50,o:0,o1:0,o2:0,ic:"\(box[2].qty)"))
        
        //商品マスク用view
        if  count_t[0].now == "on"{
            self.view.addSubview(label.make(xv:752,yv:445,wv:212,hv:60,f:50,o:0,o1:3,o2:0.5,ic:""))
        }
        if  count_t[1].now == "on"{
            self.view.addSubview(label.make(xv:752,yv:505,wv:212,hv:60,f:50,o:0,o1:3,o2:0.5,ic:""))
        }
        if  count_t[2].now == "on"{
            self.view.addSubview(label.make(xv:752,yv:565,wv:212,hv:60,f:50,o:0,o1:3,o2:0.5,ic:""))
        }
        //一度に4皿までメッセージ
        let mess = UIImageView(frame: CGRect(x:CGFloat(100), y: CGFloat(390), width: CGFloat(550), height: CGFloat(700)))
        mess.image = UIImage(named: "mess1.png")!
        if box[0].name == ""{
            self.view.addSubview(mess)
        }
        
        //右上view
        if box[0].view != ""{
            let view1 = UIImageView(frame: CGRect(x:CGFloat(770), y: CGFloat(80), width: CGFloat(250), height: CGFloat(200)))
            let v_Image:UIImage = UIImage(named: box[i].view)!
            view1.backgroundColor = UIColor.black
            view1.image = v_Image
            self.view.addSubview(view1)
        }
        // viewにジェスチャーを登録
        // スワイプを定義
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(Menu.leftSwipeView(sender:)))  //Swift3
        // ライトスワイプのみ反応するようにする
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
        // スワイプを定義
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(Menu.rightSwipeView(sender:)))  //Swift3
        // ライトスワイプのみ反応するようにする
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    //ボタンイベント処理
    @objc func selection(sender: UIButton){
        let label = makeLabel()//o:border,o1:backgrand,o2:alpha
        let tag_flag1 = appDelegate.choise
        if sender.tag<=5{
            k = sender.tag
        }
        if sender.tag>=16 && sender.tag<=24{
            j = sender.tag
        }
        if sender.tag>=25{
            l = sender.tag
        }
        switch sender.tag{
        case k://写真ボタンを押した時
            st(sn:date[tag_flag1][tag_flag2][k].name,pn:date[tag_flag1][tag_flag2][k].pic)
            loadView()
            viewDidLoad()
            audioPlayerInstance.play()
        case 4:
            let SViewController: UIViewController = order()
            viewSetting(SViewController: SViewController)
            audioPlayerInstance.play()
        case 6://戻る
            //tag2の初期化
            tag_flag2 = 0
            self.dismiss(animated: false, completion: nil)
            loadView()
            viewDidLoad()
        case 7:// +ボタン
            if box[i].qty < 4{
                box[i].qty =  box[i].qty+1
                viewDidLoad()
                audioPlayerInstance.play()
            }else if box[i].qty == 4{
                // 画像を設定する.
                let myInputImage = CIImage(image: UIImage(named: "over.jpeg")!)
                // ImageViewを定義する.
                var myImageView: UIImageView!
                // UIImageViewを作成する.
                myImageView = UIImageView(frame: UIScreen.main.bounds)
                myImageView.image = UIImage(ciImage: myInputImage!)
                self.view.addSubview(myImageView)
                // タイマーの設定（5秒間隔でメソッド「timerCall」を呼び出す）
                addTimer =  Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerCall), userInfo: nil, repeats: true)
            }
        case 8:// −ボタン
            if  box[i].qty != 0  && box[i].qty > 0{
                box[i].qty =  box[i].qty-1
            }
            viewDidLoad()
            audioPlayerInstance.play()
        case 9://注文ボタン
            i = 0
            tag_flag2 = 0 //tag2の初期化
            let SViewController: UIViewController = order()
            viewSetting(SViewController: SViewController)
        case 13://商品名(1段目)
            i = 0
            count_t[0].now = "on"
            count_t[1].now = "off"
            count_t[2].now = "off"
            self.view.addSubview(label.make(xv:752,yv:445,wv:212,hv:60,f:50,o:0,o1:2,o2:0.5,ic:"\(box[2].qty)"))
            viewDidLoad()
        case 14://商品名(2段目)
            i = 1
            count_t[0].now = "off"
            count_t[1].now = "on"
            count_t[2].now = "off"
            self.view.addSubview(label.make(xv:752,yv:505,wv:212,hv:60,f:50,o:0,o1:2,o2:0.5,ic:"\(box[2].qty)"))
            viewDidLoad()
        case 15://商品名(3段目)
            i = 2
            count_t[0].now = "off"
            count_t[1].now = "off"
            count_t[2].now = "on"
            self.view.addSubview(label.make(xv:752,yv:565,wv:212,hv:60,f:50,o:0,o1:2,o2:0.5,ic:"\(box[2].qty)"))
            viewDidLoad()
        case j://tag1
            appDelegate.choise = j-16
            tag_flag2 = 0
            viewDidLoad()
        case l://tag2
            tag_flag2 = (l-25)
            viewDidLoad()
        default:break
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//注文前画面クラス
class order: UIViewController,UITextFieldDelegate,UITabBarDelegate {
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
    //viewの設定
    func viewSetting(SViewController:UIViewController){
        //アニメーションを設定する.
        SViewController.modalTransitionStyle = .flipHorizontal
        //Viewの移動する.
        SViewController.modalPresentationStyle = .fullScreen
        self.present(SViewController, animated: true, completion: nil)
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
    
    //ボタン作成
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayerInstance.prepareToPlay()
        // UIImageViewを作成する.
        myImageView = UIImageView(frame: UIScreen.main.bounds)
        myImageView.image = UIImage(ciImage: myInputImage!)
        self.view.addSubview(myImageView)
        
        //作成用メソッド
        //タグ作成
        func makeButtonOrderTag(xv:Int,yv:Int,wv:Int,hv:Int,b:String,c:Int){
            let button: UIButton = UIButton(frame: CGRect(x:CGFloat(xv), y:CGFloat(yv), width: CGFloat(wv), height: CGFloat(hv)))
            let picture = UIImage(named: "\(b).png")
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.borderWidth = 1
            button.backgroundColor = UIColor.clear
            button.setTitle("\(b)", for: .normal)
            button.tag = c
            button.setImage(picture, for: .normal)
            button.layer.cornerRadius = 6
            button.addTarget(self, action: #selector(celection(sender:)), for: .touchUpInside)
            self.view.addSubview(button)
        }
        //ボタン作成
        func makeButtonBeforeOrder(xv:Int,yv:Int,wv:Int,hv:Int,f:Int,b:String,c:Int){
            let button: UIButton = UIButton(frame: CGRect(x:CGFloat(xv), y:CGFloat(yv), width: CGFloat(wv), height: CGFloat(hv)))
            button.backgroundColor = UIColor.white
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 1.5
            button.setTitle("\(b)", for: .normal)
            button.layer.cornerRadius = 6
            button.setTitleColor(UIColor.black, for: .normal)
            button.titleLabel?.numberOfLines = 2//0:無限改行,2:2行表示
            button.titleLabel?.font =  UIFont.systemFont(ofSize: 25)
            button.tag = c
            //button.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-CGFloat(yh))
            button.addTarget(self, action: #selector(celection(sender:)), for: .touchUpInside)
            // ボタンを追加する.
            self.view.addSubview(button)
        }
        //商品増減
        func countButton(xv:Int,yv:Int,wv:Int,hv:Int,f:Int,b:String,c:Int){
            let button: UIButton = UIButton(frame: CGRect(x:CGFloat(xv), y:CGFloat(yv), width: CGFloat(wv), height: CGFloat(hv)))
            let picture = UIImage(named: "button.jpeg")
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 0
            button.layer.cornerRadius = 3.0
            button.titleLabel?.numberOfLines = 2//0:無限改行,2:2行表示
            button.titleLabel?.font =  UIFont.systemFont(ofSize: 45)
            button.tag = c
            button.setBackgroundImage(picture, for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.setTitle("\(b)", for: .normal)
            button.addTarget(self, action: #selector(celection(sender:)), for: .touchUpInside)
            self.view.addSubview(button)
        }
        //商品名用
        func nameButton(button:UIButton,num:Int) -> UIButton{
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 1.5
            button.titleLabel?.font =  UIFont.systemFont(ofSize: 35)
            button.setTitle("\(box[num].name)", for: .normal)
            button.titleLabel?.numberOfLines = 1//0:無限改行,2:2行表示
            button.setTitleColor(UIColor.black, for: UIControl.State.normal)
            button.backgroundColor = UIColor.clear
            button.tag = 13
            button.addTarget(self, action: #selector(celection(sender:)), for: .touchUpInside)
            return button
        }

        
        
        //数量用
        func countLabel(label:UILabel,num:Int) -> UILabel{
            label.layer.borderColor = UIColor.black.cgColor
            label.layer.borderWidth = 1.5
            label.font = label.font.withSize(CGFloat(50))
            label.textAlignment = NSTextAlignment.center
            if box[num].name  != ""{
                label.text = ("\(box[num].qty)")
            }
            label.numberOfLines = 0
            label.backgroundColor = UIColor.clear
            return label
        }
        //種類用
        func typeLabel(label:UILabel,num:String){
            label.layer.borderColor = UIColor.black.cgColor
            label.layer.borderWidth = 1.5
            label.font = label.font.withSize(CGFloat(50))
            label.textAlignment = NSTextAlignment.center
            label.text = (num)
            label.numberOfLines = 0
            label.backgroundColor = UIColor.clear
            self.view.addSubview(label)
        }
        //メソッド終わり
        
        //ボタン作成
        //種類作成
        for i in 0...2{
            let label = UILabel(frame: CGRect(x:CGFloat(50), y: CGFloat(280 + i * 60), width: CGFloat(60), height: CGFloat(60)))
            typeLabel(label: label,num: String(i+1))
        }
        //商品名作成
        for i in 0...2{
            let button = UIButton(frame: CGRect(x:CGFloat(110), y: CGFloat(280 + i * 60), width: CGFloat(200), height: CGFloat(60)))
            self.view.addSubview(nameButton(button: button,num:i))
        }
        //数量作成
        for i in 0...2{
            let label = UILabel(frame: CGRect(x:CGFloat(310), y: CGFloat(280 + i * 60), width: CGFloat(60), height: CGFloat(60)))
            self.view.addSubview(countLabel(label: label,num:i))
        }
        //タグ作成
        for i in 0...8{
            makeButtonOrderTag(xv: 5 + 80 * i, yv: 5, wv: 80, hv: 70, b: "tag\(i)", c: 16)
        }
        //上部ボタン作成
        let cate:[String] = ["まぐろ","サーモン","たこ・えび","貝","いか","光物"]
        for i in 0...5{
            makeButtonBeforeOrder(xv: 5 + i * 115, yv: 90, wv: 110, hv: 70, f: 20, b: cate[i], c: 17)
        }
        makeButtonBeforeOrder(xv:30,yv:700,wv:100,hv:50,f:20,b:"戻る",c:1)
        makeButtonBeforeOrder(xv:550,yv:210,wv:170,hv:100,f:20,b:"注文する",c:18)
        //+-ボタン作成
        for i in 0...2{
            if box[i].name != ""{
                countButton(xv:390,yv:280+i*60,wv:60,hv:50,f:20,b:"+",c:i*2+2)
                countButton(xv:460,yv:280+i*60,wv:60,hv:50,f:20,b:"−",c:i*2+3)
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
        //数量用（合計)
        let sumLabel = UILabel(frame: CGRect(x:CGFloat(310), y: CGFloat(460), width: CGFloat(60), height: CGFloat(60)))
        _ = UILabel(frame: CGRect(x:CGFloat(310), y: CGFloat(460), width: CGFloat(60), height: CGFloat(60)))
        sumLabel.layer.borderColor = UIColor.black.cgColor
        sumLabel.layer.borderWidth = 1.5
        sumLabel.font = sumLabel.font.withSize(CGFloat(50))
        sumLabel.textAlignment = NSTextAlignment.center
        sumLabel.text = ("\(box[0].qty + box[1].qty + box[2].qty)")
        sumLabel.numberOfLines = 0
        sumLabel.backgroundColor = UIColor.clear
        self.view.addSubview(sumLabel)
    }
    
    //ボタンイベント処理
    @objc func celection(sender: UIButton){
        switch sender.tag{
        case 1://戻ボタン
            let SViewController: UIViewController = ViewController()
            viewSetting(SViewController: SViewController)
        case 2:// 一種類目+ボタン
            i = 0
            if box[i].qty < 4{
                box[i].qty =  box[i].qty+1
                viewDidLoad()
            }else if box[i].qty == 4{
                imageSetteng(picture: "over.jpg")
                // タイマーの設定（5秒間隔でメソッド「timerCall」を呼び出す）
                addTimer =  Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerCall), userInfo: nil, repeats: true)
            }
        case 3:// 一種類目−ボタン
            i = 0
            if  box[i].qty != 0 && box[i].qty > 0{
                box[i].qty =  box[i].qty-1
            }
            viewDidLoad()
        case 4:// 2種類目+ボタン
            i = 1
            if box[i].qty < 4{
                box[i].qty =  box[i].qty+1
                viewDidLoad()
            }else if box[i].qty == 4{
                imageSetteng(picture: "over.jpg")
                // タイマーの設定（5秒間隔でメソッド「timerCall」を呼び出す）
                addTimer =  Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerCall), userInfo: nil, repeats: true)
            }
        case 5:// 2種類目−ボタン
            i = 1
            if  box[i].qty != 0 && box[i].qty > 0{
                box[i].qty =  box[i].qty-1
            }
            viewDidLoad()
        case 6:// 3種類目+ボタン
            i = 2
            if box[i].qty < 4{
                box[i].qty =  box[i].qty+1
                viewDidLoad()
            }else if box[i].qty == 4{
                imageSetteng(picture: "over.jpg")
                // タイマーの設定（5秒間隔でメソッド「timerCall」を呼び出す）
                addTimer =  Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerCall), userInfo: nil, repeats: true)
            }
        case 7:// 3種類目−ボタン
            i = 2
            if  box[i].qty != 0 && box[i].qty > 0{
                box[i].qty =  box[i].qty-1
            }
            viewDidLoad()
        case 13://商品名(1段目)
            i = 0
            count_t[0].now = "on"
            count_t[1].now = "off"
            count_t[2].now = "off"
            viewDidLoad()
        case 14://商品名(2段目)
            i = 1
            count_t[0].now = "off"
            count_t[1].now = "on"
            count_t[2].now = "off"
            viewDidLoad()
        case 15://商品名(3段目)
            i = 2
            count_t[0].now = "off"
            count_t[1].now = "off"
            count_t[2].now = "on"
            viewDidLoad()
        case 18://注文
            appDelegate.dishSum += box[0].qty + box[1].qty + box[2].qty
            appDelegate.qr_string = "注文は\(appDelegate.dishSum)皿で会計金額は\(appDelegate.dishSum * 110)円です"
            
            for i in 0...2{
                if "\(box[i].name)" != ""{
                    let history = (name:"\(box[i].name)", num:box[i].qty)
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
            count_t = [(0,""),(0,""),(0,"")]
            box = [("",0,"kara.png"),("",0,"kara.png"),("",0,"kara.png")]
            i = 0
            //遅延処理
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                let SViewController: UIViewController = ViewController()
                self.viewSetting(SViewController: SViewController)
            }
        default:break
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
