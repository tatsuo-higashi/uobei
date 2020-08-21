
import UIKit
import AVFoundation//オーディオがらみ
import AVKit
import Foundation
import RealmSwift
import CoreImage
var isFirst = true // 最初の処理かどうか
var myImageView: UIImageView!
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
    [("デザート1"), ("デザート2"),("デザート3")],
    [("アルコール"), ("ソフトドリンク")],//ドリンク・アルコール
]

var tag_flag2 = 0//0:まぐろ,1:さーもん
let date: [[[(name: String, pic: String)]]] =
//
[[[(name:"蟹の豪華盛り",pic:"001"), (name:"生タコ梅キュウ",pic:"002"),(name:"よだれ鶏にぎり",pic:"003"),(name:"匠の本格海老マヨ",pic:"004"),(name:"すりながしカレーうどん",pic:"005")]],
//
[[(name:"どか盛りホタテ",pic:"006"), (name:"どか盛りいくらサーモン",pic:"007"),(name:"どか盛り甘えび",pic:"008"),(name:"どか盛りびんとろ",pic:"009"),(name:"ローストビーフマウンテン",pic:"010"),(name:"Wかつお",pic:"011")],[(name:"どか盛りねぎとろ",pic:"012")]],
//おすすめ握り
[[(name:"生ほっき貝",pic:"013"), (name:"生本まぐろ",pic:"014"),(name:"生本まぐろ大とろ",pic:"015"),(name:"特大天然車えび",pic:"016"),(name:"特大ジャンボほたて",pic:"017")]],
//握り1
[[(name:"まぐろ",pic:"018"), (name:"漬けまぐろ",pic:"019"),(name:"びんとろ",pic:"020"),(name:"中とろ",pic:"021"),(name:"大トロ",pic:"022")],
 [(name:"サーモン",pic:"023"), (name:"オニオンサーモン",pic:"024"),(name:"焼サーモン",pic:"025"),(name:"おろしサーモン",pic:"026"),(name:"サーモンモッツアレラ",pic:"027"),(name:"生サーモン",pic:"028")],
 [(name:"赤えび",pic:"029"), (name:"えび",pic:"030"),(name:"生えび",pic:"031"),(name:"えびチーズ",pic:"032"),(name:"えびバジルチーズ",pic:"033"),(name:"えびアボカド",pic:"034")],
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

var i = 0


func make_b3(xv:Int,yv:Int,wv:Int,hv:Int,f:Int,b:String,c:Int){
    
    let button: UIButton = UIButton(frame: CGRect(x:CGFloat(xv), y:CGFloat(yv), width: CGFloat(wv), height: CGFloat(hv)))
    if box[0].qty == 0{
        //UIButtonを非表示
        button.isHidden = true
        //UIButtonを無効化
        button.isEnabled = false
    }
    else{//UIButtonを表示
        button.isHidden = false
        //UIButtonを有効化
        button.isEnabled = true
        UIView.animate(withDuration: 0.6,//ワンサイクルの時間
            delay: 1.0,
            options: .repeat,//繰り返し
            animations: {
                button.alpha = 0.4//0にすると完全に点滅
                
        }) { (_) in
            button.alpha = 1.0
            
            
        }
        
    }
    
    
    button.backgroundColor = UIColor.white
    button.layer.borderColor = UIColor.black.cgColor
    button.layer.borderWidth = 1.5
    button.setTitle("\(b)", for: .normal)
    button.layer.cornerRadius = 3.0
    button.setTitleColor(UIColor.black, for: .normal)
    button.titleLabel?.numberOfLines = 2//0:無限改行,2:2行表示
    button.titleLabel?.font =  UIFont.systemFont(ofSize: 50)
    button.tag = c

    
}

func st(sn:String,pn:String){
    if i < 3{
        if box[0].name == ""{
            i = 0
            print("1段目きた")
            box[i].name = sn
            box[i].qty = 1
            print("pnは\(pn)")
            box[i].view = pn
            print("box[0].viewに\(box[i].view)をセット ")

        }else if  box[1].name == ""{
            i = 1
            print("2段目きた")
            box[i].name = sn
            box[i].qty = 1
            box[i].view = pn
            print("box[1].viewに\(box[i].view)をセット ")
        }else if  box[2].name == ""{
            i = 2
            print("3段目きた")
            box[i].name = sn
            box[i].qty = 1
            box[i].view = pn
            print("box[2].viewに\(box[i].view)をセット ")
        }
    count_t[0].now = "off"
    count_t[1].now = "off"
    count_t[2].now = "off"
    }else{
        print("商品欄はいっぱいです")
    }
    
}
class menu: UIViewController,UITextFieldDelegate,UITabBarDelegate {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let myInputImage = CIImage(image: UIImage(named: "second.jpeg")!)
    
     var addTimer = Timer()
    var timerCount = 0


    override func viewDidLoad() {
        super.viewDidLoad()

        let tag_flag1 = appDelegate.choise
        //print("tag_maxは\(tag_max(choise:tag_flag1))")
        print("apppは\(appDelegate.choise)")
        print("tag_flag1は\(tag_flag1),tag_flag2は\(tag_flag2)")
        print("iは\(i)です")
        //配列を数える時は0から結果は1らから
        //("寿司の数は\(date[tag_flag1][tag_flag2].count)")

       
        // UIImageViewを作成する.
        myImageView = UIImageView(frame: self.view.frame)
        myImageView.image = UIImage(ciImage: myInputImage!)
        self.view.addSubview(myImageView)
        
        
        ////audioPlayerInstance.prepareToPlay()
       // audioPlayerInstance.volume = appDelegate.volume
        
        //クラスをインスタンス化
        
        let button = make_button()//m:backgrand,e:picture,e:border
        let label = make_label()//o:border,o1:backgrand,o2:0でalpha無効,ic:300でむテキスト無効
        let qrc = make_qrc()

        //写真ボタン作成
        //print("tag_maxは\(tag_max(choise: tag_flag1))")
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
        
        //席番号ラベル
        //self.view.addSubview(label.make(xv:850,yv:5,wv:80,hv:70,f:50,o:0,o1:0,o2:0,ic:"\(save_seat)"))
        
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
        //tag選択ラベル

       
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
        // UIImageViewを作成.
        let mess = UIImageView(frame: CGRect(x:CGFloat(100), y: CGFloat(390), width: CGFloat(550), height: CGFloat(700)))
        // UIImageを作成.
        let myImage: UIImage = UIImage(named: "mess1.png")!
        // 画像をUIImageViewに設定する.
        mess.image = myImage
        // UIImageViewをViewに追加する
        if box[0].name == ""{
        self.view.addSubview(mess)
        }
        
        //右上view
        if box[0].view == ""{
            
        }else{
        // UIImageViewを作成.
        let view1 = UIImageView(frame: CGRect(x:CGFloat(770), y: CGFloat(80), width: CGFloat(250), height: CGFloat(200)))
        // UIImageを作成.
        print("右上vieを\(box[i].view)に更新")
        let v_Image: UIImage = UIImage(named: box[i].view)!
        view1.backgroundColor = UIColor.black
        // 画像をUIImageViewに設定する.
        view1.image = v_Image
        // UIImageViewをViewに追加する
        self.view.addSubview(view1)
        }
        // viewにジェスチャーを登録
        // スワイプを定義
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(menu.leftSwipeView(sender:)))  //Swift3
        // ライトスワイプのみ反応するようにする
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
        // スワイプを定義
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(menu.rightSwipeView(sender:)))  //Swift3
        // ライトスワイプのみ反応するようにする
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isFirst {
            isFirst = false
            let ab = r_data()
            let date = Date()
            let dateAndTime = date.formattedDateWith(style: .time)
            ab.time_in = dateAndTime

            // (1)Realmのインスタンスを生成する
            let realm = try! Realm()
            // (2)書き込みトランザクション内でデータを追加する
            try! realm.write {
                realm.add(ab)
            }

        }
    }

    
    func tag_max(choise:Int)->Int{
        print("ここにきた")
        var tag_max = 0
        tag_max = date[choise].count
        return (tag_max)
    }
    
    /// レフトスワイプ時に実行される
    @objc func leftSwipeView(sender: UISwipeGestureRecognizer) {
        let tag_flag1 = appDelegate.choise
        if tag_flag2 < tag_max(choise: tag_flag1)-1{
       tag_flag2 = tag_flag2 + 1
        viewDidLoad()
        }
    }
    /// ライトスワイプ時に実行される
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

    @objc func B3(sender: UIButton){
    let label = make_label()//o:border,o1:backgrand,o2:alpha
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
            //audioPlayerInstance.currentTime = 0         // 再生箇所を頭に移す
            audioPlayerInstance.play()                  //viewDidLoad()の後でないと駄目
           
        case 6:
            tag_flag2 = 0 //tag2の初期化
            self.dismiss(animated: false, completion: nil)
             loadView()//videoplayerを破棄 画面遷移なしで
            viewDidLoad()

        case 7:
            // +ボタン
           if box[i].qty < 4{
            box[i].qty =  box[i].qty+1
            viewDidLoad()
            //audioPlayerInstance.currentTime = 0         // 再生箇所を頭に移す
            audioPlayerInstance.play()                  //viewDidLoad()の後でないと駄目
            }else if box[i].qty == 4{
            //audioPlayerInstance.currentTime = 0         // 再生箇所を頭に移す
            //audioPlayerInstance.play()
                // 画像を設定する.
                let myInputImage = CIImage(image: UIImage(named: "over.jpeg")!)
                // ImageViewを.定義する.
                var myImageView: UIImageView!
                // UIImageViewを作成する.
                myImageView = UIImageView(frame: self.view.frame)
                myImageView.image = UIImage(ciImage: myInputImage!)
                self.view.addSubview(myImageView)
                // タイマーの設定（5秒間隔でメソッド「timerCall」を呼び出す）
                addTimer =  Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerCall), userInfo: nil, repeats: true)
                
                print("over")
            }

            
        case 8:
             // −ボタン
            if  box[i].qty == 0{
                
            }else{
            if  box[i].qty > 0{
             box[i].qty =  box[i].qty-1
                //audioPlayerInstance.currentTime = 0         // 再生箇所を頭に移す
                //audioPlayerInstance.play()                  //viewDidLoad()の後でないと駄目
            }
            }
            viewDidLoad()
            //audioPlayerInstance.currentTime = 0         // 再生箇所を頭に移す
    //audioPlayerInstance.play()                  //viewDidLoad()の後でないと駄目
        case 4:
            print("ok")
            let SViewController: UIViewController = menu()
            //アニメーションを設定する.
            SViewController.modalTransitionStyle = .flipHorizontal
            //Viewの移動する.
            self.present(SViewController, animated: true, completion: nil)
        case 9://注文ボタン
            i = 0
            tag_flag2 = 0 //tag2の初期化
            
            let SViewController: UIViewController = order()
            //アニメーションを設定する.
            SViewController.modalTransitionStyle = .flipHorizontal
            //Viewの移動する.
            self.present(SViewController, animated: true, completion: nil)
            
       
        case 12:
            print("ok")

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
           print("ここにきた")
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

class order: UIViewController,UITextFieldDelegate,UITabBarDelegate {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var myTabBar:UITabBar!
    // 画像を設定する.
    let myInputImage = CIImage(image: UIImage(named: "order.jpeg")!)
    // ImageViewを.定義する.
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
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // AVAudioPlayerのインスタンスを作成,ファイルの読み込み
      //  do {
       //     audioPlayerInstance = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
       // } catch {
          //  print("AVAudioPlayerインスタンス作成でエラー")
        //}
        // 再生準備
        audioPlayerInstance.prepareToPlay()

        // UIImageViewを作成する.
        myImageView = UIImageView(frame: self.view.frame)
        myImageView.image = UIImage(ciImage: myInputImage!)
        self.view.addSubview(myImageView)
        
        func make_b4(xv:Int,yv:Int,wv:Int,hv:Int,f:Int,b:String,c:Int){
            
            let button: UIButton = UIButton(frame: CGRect(x:CGFloat(xv), y:CGFloat(yv), width: CGFloat(wv), height: CGFloat(hv)))
            let picture = UIImage(named: "\(b).png")
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.borderWidth = 1
            button.backgroundColor = UIColor.clear
            button.setTitle("\(b)", for: .normal)
            button.tag = c
            button.setImage(picture, for: .normal)
            button.layer.cornerRadius = 6
            //button.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-CGFloat(yh))
            button.addTarget(self, action: #selector(B1(sender:)), for: .touchUpInside)
            // ボタンを追加する.
            self.view.addSubview(button)
            
        }
        make_b4(xv:5,yv:5,wv:80,hv:70,f:20,b:"tag1",c:16)
        make_b4(xv:85,yv:5,wv:80,hv:70,f:20,b:"tag1",c:16)
        make_b4(xv:170,yv:5,wv:80,hv:70,f:20,b:"tag1",c:16)
        make_b4(xv:255,yv:5,wv:80,hv:70,f:20,b:"tag1",c:16)
        make_b4(xv:340,yv:5,wv:80,hv:70,f:20,b:"tag1",c:16)
        make_b4(xv:425,yv:5,wv:80,hv:70,f:20,b:"tag1",c:16)
        make_b4(xv:510,yv:5,wv:80,hv:70,f:20,b:"tag1",c:16)
        make_b4(xv:595,yv:5,wv:80,hv:70,f:20,b:"tag1",c:16)
        make_b4(xv:680,yv:5,wv:80,hv:70,f:20,b:"tag1",c:16)
        
        
        func make_b(xv:Int,yv:Int,wv:Int,hv:Int,f:Int,b:String,c:Int){
            
            let button: UIButton = UIButton(frame: CGRect(x:CGFloat(xv), y:CGFloat(yv), width: CGFloat(wv), height: CGFloat(hv)))
            let picture = UIImage(named: "\(b).png")
            button.backgroundColor = UIColor.clear
            button.setTitle("\(b)", for: .normal)
            button.layer.cornerRadius = 3.0
            button.tag = c
            button.setImage(picture, for: .normal)
            //button.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-CGFloat(yh))
            button.addTarget(self, action: #selector(B1(sender:)), for: .touchUpInside)
            // ボタンを追加する.
            self.view.addSubview(button)
            
        }
        
        //メッセージ
        // UIImageViewを作成.
        let mess = UIImageView(frame: CGRect(x:CGFloat(100), y: CGFloat(390), width: CGFloat(550), height: CGFloat(700)))
        // UIImageを作成.
        let myImage: UIImage = UIImage(named: "mess1.png")!
        // 画像をUIImageViewに設定する.
        mess.image = myImage
        // UIImageViewをViewに追加する
        if box[0].name == ""{
            self.view.addSubview(mess)
        }
        
       
        
        
        
        func make_b2(xv:Int,yv:Int,wv:Int,hv:Int,f:Int,b:String,c:Int){
            
            let button: UIButton = UIButton(frame: CGRect(x:CGFloat(xv), y:CGFloat(yv), width: CGFloat(wv), height: CGFloat(hv)))
            let picture = UIImage(named: "button.jpeg")
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 1.5
            button.layer.cornerRadius = 3.0
            button.titleLabel?.numberOfLines = 2//0:無限改行,2:2行表示
            button.titleLabel?.font =  UIFont.systemFont(ofSize: 45)
            button.tag = c
            button.setBackgroundImage(picture, for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.setTitle("\(b)", for: .normal)
            //button.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-CGFloat(yh))
            button.addTarget(self, action: #selector(B1(sender:)), for: .touchUpInside)
            // ボタンを追加する.
            self.view.addSubview(button)
            
        }
        
        if box[0].qty != 0{
        make_b2(xv:390,yv:280,wv:60,hv:50,f:20,b:"+",c:2)
        make_b2(xv:460,yv:280,wv:60,hv:50,f:20,b:"−",c:3)
        }
        if box[1].qty != 0{
            make_b2(xv:390,yv:340,wv:60,hv:50,f:20,b:"+",c:4)
            make_b2(xv:460,yv:340,wv:60,hv:50,f:20,b:"−",c:5)
        }
        if box[2].qty != 0{
            make_b2(xv:390,yv:400,wv:60,hv:50,f:20,b:"+",c:6)
            make_b2(xv:460,yv:400,wv:60,hv:50,f:20,b:"−",c:7)
        }
        
        
        
        
        func make_b3(xv:Int,yv:Int,wv:Int,hv:Int,f:Int,b:String,c:Int){
            
            let button: UIButton = UIButton(frame: CGRect(x:CGFloat(xv), y:CGFloat(yv), width: CGFloat(wv), height: CGFloat(hv)))
            if box[0].qty == 0{
                //UIButtonを非表示
                button.isHidden = true
                //UIButtonを無効化
                button.isEnabled = false
            }
            else{//UIButtonを表示
                button.isHidden = false
                //UIButtonを有効化
                button.isEnabled = true
                UIView.animate(withDuration: 0.6,//ワンサイクルの時間
                    delay: 1.0,
                    options: .repeat,//繰り返し
                    animations: {
                        button.alpha = 0.4//0にすると完全に点滅
                        
                }) { (_) in
                    button.alpha = 1.0
                    
                    
                }
                
            }
            
            
            button.backgroundColor = UIColor.white
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 1.5
            button.setTitle("\(b)", for: .normal)
            button.layer.cornerRadius = 3.0
            button.setTitleColor(UIColor.black, for: .normal)
            button.titleLabel?.numberOfLines = 2//0:無限改行,2:2行表示
            button.titleLabel?.font =  UIFont.systemFont(ofSize: 50)
            button.tag = c
            //button.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-CGFloat(yh))
            button.addTarget(self, action: #selector(B1(sender:)), for: .touchUpInside)
            // ボタンを追加する.
            self.view.addSubview(button)
            
        }
        

        
        func make_b5(xv:Int,yv:Int,wv:Int,hv:Int,f:Int,b:String,c:Int){
            
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
            button.addTarget(self, action: #selector(B1(sender:)), for: .touchUpInside)
            // ボタンを追加する.
            self.view.addSubview(button)
            
        }
        make_b5(xv:5,yv:90,wv:110,hv:70,f:20,b:"まぐろ",c:17)
        make_b5(xv:120,yv:90,wv:110,hv:70,f:20,b:"サーモン",c:17)
        make_b5(xv:235,yv:90,wv:110,hv:70,f:20,b:"たこ・えび",c:17)
        make_b5(xv:350,yv:90,wv:110,hv:70,f:20,b:"貝",c:17)
        make_b5(xv:465,yv:90,wv:110,hv:70,f:20,b:"いか",c:17)
        make_b5(xv:580,yv:90,wv:110,hv:70,f:20,b:"光物",c:17)
        make_b5(xv:30,yv:700,wv:100,hv:50,f:20,b:"戻る",c:1)
        make_b5(xv:550,yv:210,wv:170,hv:100,f:20,b:"注文する",c:18)
        
        
        
        
        func make(xv:Int,yv:Int,wv:Int,hv:Int,f:Int,b:String){
            
            let label = UILabel(frame: CGRect(x:CGFloat(xv), y: CGFloat(yv), width: CGFloat(wv), height: CGFloat(hv)))
            label.layer.borderWidth = 1.5
            label.layer.borderColor = UIColor.black.cgColor
            label.font = label.font.withSize(CGFloat(f))
            label.textAlignment = NSTextAlignment.center
            label.text = ("\(box[i].qty)")
            label.numberOfLines = 0
            label.layer.cornerRadius = 3.0
            label.backgroundColor = UIColor.clear
            self.view.addSubview(label)
            
        }
        
        
        func make2(xv:Int,yv:Int,wv:Int,hv:Int,f:Int,b:String){
            
            let label = UILabel(frame: CGRect(x:CGFloat(xv), y: CGFloat(yv), width: CGFloat(wv), height: CGFloat(hv)))
            if count == 0{
                //UIButtonを非表示
                label.isHidden = true
                //UIButtonを無効化
                label.isEnabled = false
            }
            else if count == 1{
                //UIButtonを表示
                label.isHidden = false
                //UIButtonを有効化
                label.isEnabled = true
                
                
            }
            else if count == 2{
                //UIButtonを表示
                label.isHidden = false
                //UIButtonを有効化
                label.isEnabled = true
                
            }
            else if count == 3{
                //UIButtonを表示
                label.isHidden = false
                //UIButtonを有効化
                label.isEnabled = true
                
            }
            
            
            label.font = label.font.withSize(CGFloat(f))
            label.textAlignment = NSTextAlignment.center
            label.text = ("\(name)")
            label.numberOfLines = 0
            label.layer.cornerRadius = 3.0
            label.backgroundColor = UIColor.clear
            self.view.addSubview(label)
            
            
        }
        //商品名(1段目)
        
        let button1: UIButton = UIButton(frame: CGRect(x:CGFloat(110), y:CGFloat(280), width: CGFloat(200), height: CGFloat(60)))
        button1.layer.borderColor = UIColor.black.cgColor
        button1.layer.borderWidth = 1.5
        button1.titleLabel?.font =  UIFont.systemFont(ofSize: 35)
        button1.setTitle("\(box[0].name)", for: .normal)
        button1.titleLabel?.numberOfLines = 1//0:無限改行,2:2行表示
        button1.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button1.backgroundColor = UIColor.clear
        button1.tag = 13
        button1.addTarget(self, action: #selector(B1(sender:)), for: .touchUpInside)
       
            self.view.addSubview(button1)
        
        
        //商品名(2段目)
        let button2: UIButton = UIButton(frame: CGRect(x:CGFloat(110), y:CGFloat(340), width: CGFloat(200), height: CGFloat(60)))
        button2.layer.borderColor = UIColor.black.cgColor
        button2.layer.borderWidth = 1.5
        button2.titleLabel?.font =  UIFont.systemFont(ofSize: 35)
        button2.setTitle("\(box[1].name)", for: .normal)
        button2.titleLabel?.numberOfLines = 1//0:無限改行,2:2行表示
        button2.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button2.backgroundColor = UIColor.clear
        button2.tag = 14
        button2.addTarget(self, action: #selector(B1(sender:)), for: .touchUpInside)

            self.view.addSubview(button2)
      
        //商品名(3段目)
        let button: UIButton = UIButton(frame: CGRect(x:CGFloat(110), y:CGFloat(400), width: CGFloat(200), height: CGFloat(60)))
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.5
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 35)
        button.setTitle("\(box[2].name)", for: .normal)
        button.titleLabel?.numberOfLines = 1//0:無限改行,2:2行表示
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.backgroundColor = UIColor.clear
        button.tag = 15
        button.addTarget(self, action: #selector(B1(sender:)), for: .touchUpInside)
         self.view.addSubview(button)
        //数量用（1段目)
        
        
        let label1 = UILabel(frame: CGRect(x:CGFloat(310), y: CGFloat(280), width: CGFloat(60), height: CGFloat(60)))
        label1.layer.borderColor = UIColor.black.cgColor
        label1.layer.borderWidth = 1.5
        label1.font = label1.font.withSize(CGFloat(50))
        label1.textAlignment = NSTextAlignment.center
        if box[0].qty  != 0{
        label1.text = ("\(box[0].qty)")
        }
        label1.numberOfLines = 0
        label1.backgroundColor = UIColor.clear
        self.view.addSubview(label1)
        
        //数量用（2段目)
        
        let label2 = UILabel(frame: CGRect(x:CGFloat(310), y: CGFloat(340), width: CGFloat(60), height: CGFloat(60)))
        label2.layer.borderColor = UIColor.black.cgColor
        label2.layer.borderWidth = 1.5
        label2.font = label2.font.withSize(CGFloat(50))
        label2.textAlignment = NSTextAlignment.center
        if box[1].qty  != 0{
        label2.text = ("\(box[1].qty)")
        }
        label2.numberOfLines = 0
        label2.backgroundColor = UIColor.clear
        self.view.addSubview(label2)
        
        //数量用（3段目)
        
        let label3 = UILabel(frame: CGRect(x:CGFloat(310), y: CGFloat(400), width: CGFloat(60), height: CGFloat(60)))
        label3.layer.borderColor = UIColor.black.cgColor
        label3.layer.borderWidth = 1.5
        label3.font = label3.font.withSize(CGFloat(50))
        label3.textAlignment = NSTextAlignment.center
        if box[2].qty  != 0{
        label3.text = ("\(box[2].qty)")
        }
        label3.numberOfLines = 0
        label3.backgroundColor = UIColor.clear
        self.view.addSubview(label3)
        
        //数量用（合計)
        
        let label4 = UILabel(frame: CGRect(x:CGFloat(310), y: CGFloat(460), width: CGFloat(60), height: CGFloat(60)))
        label4.layer.borderColor = UIColor.black.cgColor
        label4.layer.borderWidth = 1.5
        label4.font = label4.font.withSize(CGFloat(50))
        label4.textAlignment = NSTextAlignment.center
        label4.text = ("\(box[0].qty + box[1].qty + box[2].qty)")
        label4.numberOfLines = 0
        label4.backgroundColor = UIColor.clear
        self.view.addSubview(label4)
        
        //メッセージ（合計)
        
        let label5 = UILabel(frame: CGRect(x:CGFloat(190), y: CGFloat(460), width: CGFloat(120), height: CGFloat(60)))
        label5.layer.borderColor = UIColor.black.cgColor
        label5.layer.borderWidth = 1.5
        label5.font = label5.font.withSize(CGFloat(50))
        label5.textAlignment = NSTextAlignment.center
        label5.text = ("合計")
        label5.numberOfLines = 0
        label5.backgroundColor = UIColor.red
        self.view.addSubview(label5)
        
        //種類用（1段目)
        let label6 = UILabel(frame: CGRect(x:CGFloat(50), y: CGFloat(280), width: CGFloat(60), height: CGFloat(60)))
        label6.layer.borderColor = UIColor.black.cgColor
        label6.layer.borderWidth = 1.5
        label6.font = label6.font.withSize(CGFloat(50))
        label6.textAlignment = NSTextAlignment.center
        if box[0].qty  != 0{
        label6.text = ("1")
        }
        label6.numberOfLines = 0
        label6.backgroundColor = UIColor.clear
        self.view.addSubview(label6)
        
        //種類用（2段目)
        let label7 = UILabel(frame: CGRect(x:CGFloat(50), y: CGFloat(340), width: CGFloat(60), height: CGFloat(60)))
        label7.layer.borderColor = UIColor.black.cgColor
        label7.layer.borderWidth = 1.5
        label7.font = label7.font.withSize(CGFloat(50))
        label7.textAlignment = NSTextAlignment.center
        if box[1].qty  != 0{
        label7.text = ("2")
        }
        label7.numberOfLines = 0
        label7.backgroundColor = UIColor.clear
        self.view.addSubview(label7)
        
        //種類用（3段目)
        let label8 = UILabel(frame: CGRect(x:CGFloat(50), y: CGFloat(400), width: CGFloat(60), height: CGFloat(60)))
        label8.layer.borderColor = UIColor.black.cgColor
        label8.layer.borderWidth = 1.5
        label8.font = label8.font.withSize(CGFloat(50))
        label8.textAlignment = NSTextAlignment.center
        if box[2].qty  != 0{
        label8.text = ("3")
        }
        label8.numberOfLines = 0
        label8.backgroundColor = UIColor.clear
        self.view.addSubview(label8)
        
        print("更新")
        test2(xv:120,yv:90,wv:110,hv:70)
        
       
        
        
    }
    
    
    func test2(xv:Int,yv:Int,wv:Int,hv:Int){
        print("testoK")
        // UIImageViewを作成.
        let test2 = UIView(frame: CGRect(x:CGFloat(xv), y: CGFloat(yv), width: CGFloat(wv), height: CGFloat(hv)))
        test2.backgroundColor = UIColor.black
        test2.alpha = 0.3
        self.view.addSubview(test2)
        
    }

    
    //タイマー
    @objc func timerCall() {
       viewDidLoad()
        // タイマーを無効にする
        addTimer.invalidate()
    }
    @objc func timerCall2() {
        let test = UIView(frame: CGRect(x:CGFloat(50), y: CGFloat(50), width: CGFloat(200), height: CGFloat(200)))
        test.backgroundColor = UIColor.yellow
        test.alpha = 0.3
        self.view.addSubview(test)

        addTimer.invalidate()
    }

    @objc func B1(sender: UIButton){
        //let SViewController: UIViewController
         //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        switch sender.tag{
        case 1:
            //戻ボタン
            let SViewController: UIViewController = ViewController()
            //アニメーションを設定する.
            SViewController.modalTransitionStyle = .flipHorizontal
            //Viewの移動する.
            self.present(SViewController, animated: true, completion: nil)
        case 2:
            // 一種類目+ボタン
            i = 0
            if box[i].qty < 4{
                box[i].qty =  box[i].qty+1
                viewDidLoad()
                //audioPlayerInstance.currentTime = 0         // 再生箇所を頭に移す
                //audioPlayerInstance.play()                  //viewDidLoad()の後でないと駄目
            }else if box[i].qty == 4{
                //audioPlayerInstance.currentTime = 0         // 再生箇所を頭に移す
                //audioPlayerInstance.play()                  //viewDidLoad()の後でないと駄目
                // 画像を設定する.
                let myInputImage = CIImage(image: UIImage(named: "over.jpeg")!)
                // ImageViewを.定義する.
                var myImageView: UIImageView!
                // UIImageViewを作成する.
                myImageView = UIImageView(frame: self.view.frame)
                myImageView.image = UIImage(ciImage: myInputImage!)
                self.view.addSubview(myImageView)
                // タイマーの設定（5秒間隔でメソッド「timerCall」を呼び出す）
                addTimer =  Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerCall), userInfo: nil, repeats: true)
                
                print("over")
            }
            
            
            
        case 3:
            // 一種類目−ボタン
            i = 0
            if  box[i].qty == 0{
                
            }else{
                if  box[i].qty > 0{
                    box[i].qty =  box[i].qty-1
                }
            }
            viewDidLoad()
            //audioPlayerInstance.currentTime = 0         // 再生箇所を頭に移す
            ///audioPlayerInstance.play()                  //viewDidLoad()の後でないと駄目
        case 4:
            // 2種類目+ボタン
            i = 1
            if box[i].qty < 4{
                box[i].qty =  box[i].qty+1
                viewDidLoad()
                //audioPlayerInstance.currentTime = 0         // 再生箇所を頭に移す
                //audioPlayerInstance.play()                  //viewDidLoad()の後でないと駄目
            }else if box[i].qty == 4{
                //audioPlayerInstance.currentTime = 0         // 再生箇所を頭に移す
               // audioPlayerInstance.play()                  //viewDidLoad()の後でないと駄目
                // 画像を設定する.
                let myInputImage = CIImage(image: UIImage(named: "over.jpeg")!)
                // ImageViewを.定義する.
                var myImageView: UIImageView!
                // UIImageViewを作成する.
                myImageView = UIImageView(frame: self.view.frame)
                myImageView.image = UIImage(ciImage: myInputImage!)
                self.view.addSubview(myImageView)
                // タイマーの設定（5秒間隔でメソッド「timerCall」を呼び出す）
                addTimer =  Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerCall), userInfo: nil, repeats: true)
                
                print("over")
            }
        case 5:
            // 2種類目−ボタン
            i = 1
            if  box[i].qty == 0{
                
            }else{
                if  box[i].qty > 0{
                    box[i].qty =  box[i].qty-1
                }
            }
            viewDidLoad()
            //audioPlayerInstance.currentTime = 0         // 再生箇所を頭に移す
            //audioPlayerInstance.play()                  //viewDidLoad()の後でないと駄目
            
        case 6:
            // 3種類目+ボタン
            i = 2
            if box[i].qty < 4{
                box[i].qty =  box[i].qty+1
                viewDidLoad()
                //audioPlayerInstance.currentTime = 0         // 再生箇所を頭に移す
                //audioPlayerInstance.play()                  //viewDidLoad()の後でないと駄目
            }else if box[i].qty == 4{
                //audioPlayerInstance.currentTime = 0         // 再生箇所を頭に移す
                //audioPlayerInstance.play()                  //viewDidLoad()の後でないと駄目
                // 画像を設定する.
                let myInputImage = CIImage(image: UIImage(named: "over.jpeg")!)
                // ImageViewを.定義する.
                var myImageView: UIImageView!
                // UIImageViewを作成する.
                myImageView = UIImageView(frame: self.view.frame)
                myImageView.image = UIImage(ciImage: myInputImage!)
                self.view.addSubview(myImageView)
                // タイマーの設定（5秒間隔でメソッド「timerCall」を呼び出す）
                addTimer =  Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerCall), userInfo: nil, repeats: true)
                
                print("over")
            }
        case 7:
            // 3種類目−ボタン
            i = 2
            if  box[i].qty == 0{
                
            }else{
                if  box[i].qty > 0{
                    box[i].qty =  box[i].qty-1
                }
            }
            viewDidLoad()
            //audioPlayerInstance.currentTime = 0         // 再生箇所を頭に移す
           // audioPlayerInstance.play()                  //viewDidLoad()の後でないと駄目
        case 8:
            count = 1
            count2 = count2+1
            if box[0].name == ""{
                box[0].name = "焼サーモン"
                box[0].qty = 1
                box[0].view = "008.png"
                i = i+0
            }else if  box[1].name == ""{
                box[1].name = "焼サーモン"
                box[1].qty = 1
                box[1].view = "008.png"
                i = i+1
            }else if  box[2].name == ""{
                box[2].name = "焼サーモン"
                box[2].qty = 1
                box[2].view = "008.png"
                i = i+1
            }
            count_t[0].now = "off"
            count_t[1].now = "off"
            count_t[2].now = "off"
            viewDidLoad()
            //audioPlayerInstance.currentTime = 0         // 再生箇所を頭に移す
            //audioPlayerInstance.play()                  //viewDidLoad()の後でないと駄目
        case 9:
            count = 1
            count2 = count2+1
            if box[0].name == ""{
                box[0].name = "おろしサーモン"
                box[0].qty = 1
                box[0].view = "009.png"
                i = i+0
            }else if  box[1].name == ""{
                box[1].name = "おろしサーモン"
                box[1].qty = 1
                box[1].view = "009.png"
                i = i+1
            }else if  box[2].name == ""{
                box[2].name = "おろしサーモン"
                box[2].qty = 1
                box[2].view = "009.png"
                i = i+1
            }
            count_t[0].now = "off"
            count_t[1].now = "off"
            count_t[2].now = "off"
            viewDidLoad()
            //audioPlayerInstance.currentTime = 0         // 再生箇所を頭に移す
           // audioPlayerInstance.play()                  //viewDidLoad()の後でないと駄目
        case 10:
            count = 1
            count2 = count2+1
            if box[0].name == ""{
                box[0].name = "サーモンモッツアレラ"
                box[0].qty = 1
                box[0].view = "010.png"
                i = i+0
            }else if  box[1].name == ""{
                box[1].name = "サーモンモッツアレラ"
                box[1].qty = 1
                box[1].view = "010.png"
                i = i+1
            }else if  box[2].name == ""{
                box[2].name = "サーモンモッツアレラ"
                box[2].qty = 1
                box[2].view = "010.png"
                i = i+1
            }
            count_t[0].now = "off"
            count_t[1].now = "off"
            count_t[2].now = "off"
            viewDidLoad()
            //audioPlayerInstance.currentTime = 0         // 再生箇所を頭に移す
            //audioPlayerInstance.play()                  //viewDidLoad()の後でないと駄目
        case 11:
            count = 1
            count2 = count2+1
            if box[0].name == ""{
                box[0].name = "生サーモン"
                box[0].qty = 1
                box[0].view = "011.png"
                i = i+0
            }else if  box[1].name == ""{
                box[1].name = "生サーモン"
                box[1].qty = 1
                box[1].view = "011.png"
                i = i+1
            }else if  box[2].name == ""{
                box[2].name = "生サーモン"
                box[2].qty = 1
                box[2].view = "011.png"
                i = i+1
            }
            count_t[0].now = "off"
            count_t[1].now = "off"
            count_t[2].now = "off"
            viewDidLoad()
            //audioPlayerInstance.currentTime = 0         // 再生箇所を頭に移す
            //audioPlayerInstance.play()                  //viewDidLoad()の後でないと駄目
        case 12:
            print("ok")
            
            
            //case 5:
            //print("ok")
            // let SViewController: UIViewController = seisankannri()
            // アニメーションを設定する.
            //SViewController.modalTransitionStyle = .flipHorizontal
            // Viewの移動する.
            //self.present(SViewController, animated: true, completion: nil)
            
        case 13://商品名(1段目)
            i = 0
            count_t[0].now = "on"
            count_t[1].now = "off"
            count_t[2].now = "off"
           
            print("\(box[i].qty)")
            print("\( count_t[0].now)")
            viewDidLoad()
            
        case 14://商品名(2段目)
            i = 1
            count_t[0].now = "off"
            count_t[1].now = "on"
            count_t[2].now = "off"
            
            print("\(box[i].qty)")
            viewDidLoad()
        case 15://商品名(3段目)
            i = 2
            count_t[0].now = "off"
            count_t[1].now = "off"
            count_t[2].now = "on"
          
            print("\(box[i].qty)")
            viewDidLoad()
        case 17://タグ＿まぐろ
            let SViewController: UIViewController = menu()
            // アニメーションを設定する.
            //SViewController.modalTransitionStyle = .partialCurl
            // Viewの移動する.
            self.present(SViewController, animated: false, completion: nil)
            
        case 18://注文
            appDelegate.qr_string = "注文は\(box[0].qty + box[1].qty + box[2].qty)皿で会計金額は\((box[0].qty + box[1].qty + box[2].qty)*110)円です"

            let myInputImage = CIImage(image: UIImage(named: "end.jpeg")!)
            // ImageViewを.定義する.
            var myImageView: UIImageView!
            // UIImageViewを作成する.
            myImageView = UIImageView(frame: self.view.frame)
            myImageView.image = UIImage(ciImage: myInputImage!)
            self.view.addSubview(myImageView)
            count_t = [
                (0,""),
                (0,""),
                (0,"")]
            box = [
                ("",0,"kara.png"),
                ("",0,"kara.png"),
                ("",0,"kara.png")]
            i = 0
            print("iは\(i)です")
            //遅延処理
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
               
                let SViewController: UIViewController = ViewController()
                //アニメーションを設定する.
                SViewController.modalTransitionStyle = .flipHorizontal
                //Viewの移動する.
                self.present(SViewController, animated: true, completion: nil)
            }
        case 25:
          print("ok")
        case 26:
            print("ok")
        default:break
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

