
import UIKit

class nigiri3: UIViewController,UITextFieldDelegate,UITabBarDelegate {
    
    var myTabBar:UITabBar!
    // 画像を設定する.
    let myInputImage = CIImage(image: UIImage(named: "second.jpeg")!)
    // ImageViewを.定義する.
    var myImageView: UIImageView!
    var selectView: UIView! = nil
    var image0: UIImageView!
    var count = 0
    var count2 = 0
    var i = 0
    var name = ""
    var label2: UILabel!
    var box: [(name: String, qty: Int ,view: String)] = [
        ("",0,""),
        ("",0,""),
        ("",0,"")]
    var addTimer = Timer()
    var timerCount = 0
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // スワイプを定義
        //let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(SwipeCodeViewController.leftSwipeView(_:)))  //Swit2.2以前
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(nigiri2.leftSwipeView(sender:)))  //Swift3
        // レフトスワイプのみ反応するようにする
        leftSwipe.direction = .left
        // viewにジェスチャーを登録
        self.view.addGestureRecognizer(leftSwipe)
        
        
        // スワイプを定義
        //let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(SwipeCodeViewController.rightSwipeView(_:)))  //Swit2.2以前
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(nigiri2.rightSwipeView(sender:)))  //Swift3
        // ライトスワイプのみ反応するようにする
        rightSwipe.direction = .right
        // viewにジェスチャーを登録
        self.view.addGestureRecognizer(rightSwipe)
        
        
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
        make_b(xv:30,yv:250,wv:200,hv:200,f:20,b:"001",c:6)
        make_b(xv:250,yv:250,wv:200,hv:200,f:20,b:"002",c:7)
        make_b(xv:470,yv:250,wv:200,hv:200,f:20,b:"003",c:8)
        make_b(xv:30,yv:470,wv:200,hv:200,f:20,b:"004",c:9)
        make_b(xv:250,yv:470,wv:200,hv:200,f:20,b:"005",c:10)
        
        
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
        
        if box[0].view == ""{
            
        }else{
            // UIImageViewを作成.
            let view1 = UIImageView(frame: CGRect(x:CGFloat(770), y: CGFloat(80), width: CGFloat(250), height: CGFloat(200)))
            // UIImageを作成.
            let v_Image: UIImage = UIImage(named: "\(box[i].view)")!
            // 画像をUIImageViewに設定する.
            view1.image = v_Image
            // UIImageViewをViewに追加する
            
            self.view.addSubview(view1)
        }
        
        
        
        func make_b2(xv:Int,yv:Int,wv:Int,hv:Int,f:Int,b:String,c:Int){
            
            let button: UIButton = UIButton(frame: CGRect(x:CGFloat(xv), y:CGFloat(yv), width: CGFloat(wv), height: CGFloat(hv)))
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
        
        make_b2(xv:30,yv:700,wv:100,hv:50,f:20,b:"戻る",c:1)
        make_b2(xv:950,yv:290,wv:60,hv:60,f:20,b:"➕",c:2)
        make_b2(xv:870,yv:290,wv:60,hv:60,f:20,b:"➖",c:3)
        make_b2(xv:650,yv:700,wv:100,hv:50,f:20,b:"注文",c:5)
        
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
        
        
        
        
        func make_L(xv:Int,yv:Int,wv:Int,hv:Int,f:Int,b:String){
            
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
        make_L(xv:790,yv:290,wv:60,hv:60,f:50,b:"3")//数量用（共通)
        
        
        
        //数量用（1段目)
        
        
        let label1 = UILabel(frame: CGRect(x:CGFloat(960), y: CGFloat(450), width: CGFloat(60), height: CGFloat(60)))
        label1.font = label1.font.withSize(CGFloat(50))
        label1.textAlignment = NSTextAlignment.center
        label1.text = ("\(box[0].qty)")
        label1.numberOfLines = 0
        label1.layer.cornerRadius = 3.0
        label1.backgroundColor = UIColor.clear
        self.view.addSubview(label1)
        
        //数量用（2段目)
        
        let label2 = UILabel(frame: CGRect(x:CGFloat(960), y: CGFloat(510), width: CGFloat(60), height: CGFloat(60)))
        label2.font = label2.font.withSize(CGFloat(50))
        label2.textAlignment = NSTextAlignment.center
        label2.text = ("\(box[1].qty)")
        label2.numberOfLines = 0
        label2.layer.cornerRadius = 3.0
        label2.backgroundColor = UIColor.clear
        self.view.addSubview(label2)
        
        //数量用（3段目)
        
        let label3 = UILabel(frame: CGRect(x:CGFloat(960), y: CGFloat(570), width: CGFloat(60), height: CGFloat(60)))
        label3.font = label3.font.withSize(CGFloat(50))
        label3.textAlignment = NSTextAlignment.center
        label3.text = ("\(box[2].qty)")
        label3.numberOfLines = 0
        label3.layer.cornerRadius = 3.0
        label3.backgroundColor = UIColor.clear
        self.view.addSubview(label3)
        
        
        func make_L2(xv:Int,yv:Int,wv:Int,hv:Int,f:Int,b:String){
            
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
        
        let button1: UIButton = UIButton(frame: CGRect(x:CGFloat(750), y:CGFloat(450), width: CGFloat(200), height: CGFloat(60)))
        button1.titleLabel?.font =  UIFont.systemFont(ofSize: 35)
        button1.setTitle("\(box[0].name)", for: .normal)
        button1.titleLabel?.numberOfLines = 1//0:無限改行,2:2行表示
        button1.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button1.backgroundColor = UIColor.clear
        button1.tag = 13
        button1.addTarget(self, action: #selector(B1(sender:)), for: .touchUpInside)
        if box[0].name == ""{
        }else{
            self.view.addSubview(button1)
        }
        
        //商品名(2段目)
        let button2: UIButton = UIButton(frame: CGRect(x:CGFloat(750), y:CGFloat(510), width: CGFloat(200), height: CGFloat(60)))
        button2.titleLabel?.font =  UIFont.systemFont(ofSize: 35)
        button2.setTitle("\(box[1].name)", for: .normal)
        button2.titleLabel?.numberOfLines = 1//0:無限改行,2:2行表示
        button2.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button2.backgroundColor = UIColor.clear
        button2.tag = 14
        button2.addTarget(self, action: #selector(B1(sender:)), for: .touchUpInside)
        if box[1].name == ""{
        }else{
            self.view.addSubview(button2)
        }
        //商品名(3段目)
        let button3: UIButton = UIButton(frame: CGRect(x:CGFloat(750), y:CGFloat(570), width: CGFloat(200), height: CGFloat(60)))
        button3.titleLabel?.font =  UIFont.systemFont(ofSize: 35)
        button3.setTitle("\(box[2].name)", for: .normal)
        button3.titleLabel?.numberOfLines = 1//0:無限改行,2:2行表示
        button3.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button3.backgroundColor = UIColor.clear
        button3.tag = 15
        button3.addTarget(self, action: #selector(B1(sender:)), for: .touchUpInside)
        if box[2].name == ""{
        }else{
            self.view.addSubview(button3)
        }
        test2(xv:5,yv:90,wv:110,hv:70)
        print("更新")
        print("\( count_t[0].now)")
        if  count_t[0].now == "on"{
            test(xv:750,yv:450,wv:200,hv:60)
        }
        if  count_t[1].now == "on"{
            test(xv:750,yv:510,wv:200,hv:60)
        }
        if  count_t[2].now == "on"{
            test(xv:750,yv:570,wv:200,hv:60)
        }
        
        
        
    }
    
    
    /// レフトスワイプ時に実行される
    @objc func leftSwipeView(sender: UISwipeGestureRecognizer) {
        print("left Swipe")
        let SViewController: UIViewController = nigiri4()
        // アニメーションを設定する.
        //SViewController.modalTransitionStyle = .partialCurl
        // Viewの移動する.
        self.present(SViewController, animated: false, completion: nil)
    }
    
    /// ライトスワイプ時に実行される
    @objc func rightSwipeView(sender: UISwipeGestureRecognizer) {
        print("right Swipe")
        let SViewController: UIViewController = nigiri2()
        // アニメーションを設定する.
        //SViewController.modalTransitionStyle = .partialCurl
        // Viewの移動する.
        self.present(SViewController, animated: false, completion: nil)
    }
    
    func test(xv:Int,yv:Int,wv:Int,hv:Int){
        print("testoK")
        // UIImageViewを作成.
        let test = UIView(frame: CGRect(x:CGFloat(xv), y: CGFloat(yv), width: CGFloat(wv), height: CGFloat(hv)))
        test.backgroundColor = UIColor.yellow
        test.alpha = 0.3
        self.view.addSubview(test)
        
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
    
    @objc func B1(sender: UIButton){
        //let SViewController: UIViewController
        
        switch sender.tag{
        case 1:
            //戻ボタン
            let SViewController: UIViewController = ViewController()
            //アニメーションを設定する.
            SViewController.modalTransitionStyle = .flipHorizontal
            //Viewの移動する.
            self.present(SViewController, animated: true, completion: nil)
        case 2:
            // +ボタン
            if box[i].qty < 4{
                box[i].qty =  box[i].qty+1
                viewDidLoad()
            }else if box[i].qty == 4{
                
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
            // −ボタン
            if  box[i].qty == 0{
                
            }else{
                if  box[i].qty > 0{
                    box[i].qty =  box[i].qty-1
                }
            }
            viewDidLoad()
        case 4:
            print("ok")
            let SViewController: UIViewController = nigiri1()
            //アニメーションを設定する.
            SViewController.modalTransitionStyle = .flipHorizontal
            //Viewの移動する.
            self.present(SViewController, animated: true, completion: nil)
        case 5:
            print("ok")
            
        case 6:
            count = 1
            count2 = count2+1
            if box[0].name == ""{
                box[0].name = "まぐろ"
                box[0].qty = 1
                box[0].view = "001.png"
                i = i+0
            }else if  box[1].name == ""{
                box[1].name = "まぐろ"
                box[1].qty = 1
                box[1].view = "001.png"
                i = i+1
            }else if  box[2].name == ""{
                box[2].name = "まぐろ"
                box[2].qty = 1
                box[2].view = "001.png"
                i = i+1
            }
            count_t[0].now = "off"
            count_t[1].now = "off"
            count_t[2].now = "off"
            
            viewDidLoad()
        case 7:
            count = 1
            count2 = count2+1
            if box[0].name == ""{
                box[0].name = "漬けまぐろ"
                box[0].qty = 1
                box[0].view = "002.png"
                i = i+0
                print("\(i)")
            }else if  box[1].name == ""{
                box[1].name = "漬けまぐろ"
                box[1].qty = 1
                box[1].view = "002.png"
                i = i+1
                print("\(i)")
            }else if  box[2].name == ""{
                box[2].name = "漬けまぐろ"
                box[2].qty = 1
                box[2].view = "002.png"
                i = i+1
                print("\(i)")
            }
            count_t[0].now = "off"
            count_t[1].now = "off"
            count_t[2].now = "off"
            
            viewDidLoad()
        case 8:
            count = 1
            count2 = count2+1
            if box[0].name == ""{
                box[0].name = "びんとろ"
                box[0].qty = 1
                box[0].view = "003.png"
                i = i+0
            }else if  box[1].name == ""{
                box[1].name = "びんとろ"
                box[1].qty = 1
                box[1].view = "003.png"
                i = i+1
            }else if  box[2].name == ""{
                box[2].name = "びんとろ"
                box[2].qty = 1
                box[2].view = "003.png"
                i = i+1
            }
            count_t[0].now = "off"
            count_t[1].now = "off"
            count_t[2].now = "off"
            viewDidLoad()
        case 9:
            count = 1
            count2 = count2+1
            if box[0].name == ""{
                box[0].name = "中とろ"
                box[0].qty = 1
                box[0].view = "004.png"
                i = i+0
            }else if  box[1].name == ""{
                box[1].name = "中とろ"
                box[1].qty = 1
                box[1].view = "004.png"
                i = i+1
            }else if  box[2].name == ""{
                box[2].name = "中とろ"
                box[2].qty = 1
                box[2].view = "004.png"
                i = i+1
            }
            count_t[0].now = "off"
            count_t[1].now = "off"
            count_t[2].now = "off"
            viewDidLoad()
        case 10:
            count = 1
            count2 = count2+1
            if box[0].name == ""{
                box[0].name = "大とろ"
                box[0].qty = 1
                box[0].view = "005.png"
                i = i+0
            }else if  box[1].name == ""{
                box[1].name = "大とろ"
                box[1].qty = 1
                box[1].view = "005.png"
                i = i+1
            }else if  box[2].name == ""{
                box[2].name = "大とろ"
                box[2].qty = 1
                box[2].view = "005.png"
                i = i+1
            }
            count_t[0].now = "off"
            count_t[1].now = "off"
            count_t[2].now = "off"
            viewDidLoad()
        case 11:
            print("ok")
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
            test(xv:750,yv:450,wv:200,hv:60)
            print("\(box[i].qty)")
            print("\( count_t[0].now)")
            viewDidLoad()
            
        case 14://商品名(2段目)
            i = 1
            count_t[0].now = "off"
            count_t[1].now = "on"
            count_t[2].now = "off"
            test(xv:750,yv:510,wv:200,hv:60)
            print("\(box[i].qty)")
            viewDidLoad()
        case 15://商品名(3段目)
            i = 2
            count_t[0].now = "off"
            count_t[1].now = "off"
            count_t[2].now = "on"
            test(xv:750,yv:570,wv:200,hv:60)
            print("\(box[i].qty)")
            viewDidLoad()
            
        case 17://タグ＿サーモン
            let SViewController: UIViewController = nigiri2()
            // アニメーションを設定する.
            //SViewController.modalTransitionStyle = .partialCurl
            // Viewの移動する.
            self.present(SViewController, animated: false, completion: nil)
            
        default:break
            
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
class nigiri4: UIViewController,UITextFieldDelegate,UITabBarDelegate {
    
    var myTabBar:UITabBar!
    // 画像を設定する.
    let myInputImage = CIImage(image: UIImage(named: "second.jpeg")!)
    // ImageViewを.定義する.
    var myImageView: UIImageView!
    var selectView: UIView! = nil
    var image0: UIImageView!
    var count = 0
    var count2 = 0
    var i = 0
    var name = ""
    var label2: UILabel!
    var box: [(name: String, qty: Int ,view: String)] = [
        ("",0,""),
        ("",0,""),
        ("",0,"")]
    var addTimer = Timer()
    var timerCount = 0
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // スワイプを定義
        //let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(SwipeCodeViewController.leftSwipeView(_:)))  //Swit2.2以前
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(nigiri3.leftSwipeView(sender:)))  //Swift3
        // レフトスワイプのみ反応するようにする
        leftSwipe.direction = .left
        // viewにジェスチャーを登録
        self.view.addGestureRecognizer(leftSwipe)
        
        
        // スワイプを定義
        //let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(SwipeCodeViewController.rightSwipeView(_:)))  //Swit2.2以前
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(nigiri3.rightSwipeView(sender:)))  //Swift3
        // ライトスワイプのみ反応するようにする
        rightSwipe.direction = .right
        // viewにジェスチャーを登録
        self.view.addGestureRecognizer(rightSwipe)
        
        
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
        make_b(xv:30,yv:250,wv:200,hv:200,f:20,b:"006",c:6)
        make_b(xv:250,yv:250,wv:200,hv:200,f:20,b:"007",c:7)
        make_b(xv:470,yv:250,wv:200,hv:200,f:20,b:"008",c:8)
        make_b(xv:30,yv:470,wv:200,hv:200,f:20,b:"009",c:9)
        make_b(xv:250,yv:470,wv:200,hv:200,f:20,b:"010",c:10)
        make_b(xv:470,yv:470,wv:200,hv:200,f:20,b:"011",c:11)
        
        
        
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
        
        if box[0].view == ""{
            
        }else{
            // UIImageViewを作成.
            let view1 = UIImageView(frame: CGRect(x:CGFloat(770), y: CGFloat(80), width: CGFloat(250), height: CGFloat(200)))
            // UIImageを作成.
            let v_Image: UIImage = UIImage(named: "\(box[i].view)")!
            // 画像をUIImageViewに設定する.
            view1.image = v_Image
            // UIImageViewをViewに追加する
            
            self.view.addSubview(view1)
        }
        
        
        
        func make_b2(xv:Int,yv:Int,wv:Int,hv:Int,f:Int,b:String,c:Int){
            
            let button: UIButton = UIButton(frame: CGRect(x:CGFloat(xv), y:CGFloat(yv), width: CGFloat(wv), height: CGFloat(hv)))
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
        
        make_b2(xv:30,yv:700,wv:100,hv:50,f:20,b:"戻る",c:1)
        make_b2(xv:950,yv:290,wv:60,hv:60,f:20,b:"➕",c:2)
        make_b2(xv:870,yv:290,wv:60,hv:60,f:20,b:"➖",c:3)
        make_b2(xv:650,yv:700,wv:100,hv:50,f:20,b:"注文",c:5)
        
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
        
        
        
        
        func make_L(xv:Int,yv:Int,wv:Int,hv:Int,f:Int,b:String){
            
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
        make_L(xv:790,yv:290,wv:60,hv:60,f:50,b:"3")//数量用（共通)
        
        
        
        //数量用（1段目)
        
        
        let label1 = UILabel(frame: CGRect(x:CGFloat(960), y: CGFloat(450), width: CGFloat(60), height: CGFloat(60)))
        label1.font = label1.font.withSize(CGFloat(50))
        label1.textAlignment = NSTextAlignment.center
        label1.text = ("\(box[0].qty)")
        label1.numberOfLines = 0
        label1.layer.cornerRadius = 3.0
        label1.backgroundColor = UIColor.clear
        self.view.addSubview(label1)
        
        //数量用（2段目)
        
        let label2 = UILabel(frame: CGRect(x:CGFloat(960), y: CGFloat(510), width: CGFloat(60), height: CGFloat(60)))
        label2.font = label2.font.withSize(CGFloat(50))
        label2.textAlignment = NSTextAlignment.center
        label2.text = ("\(box[1].qty)")
        label2.numberOfLines = 0
        label2.layer.cornerRadius = 3.0
        label2.backgroundColor = UIColor.clear
        self.view.addSubview(label2)
        
        //数量用（3段目)
        
        let label3 = UILabel(frame: CGRect(x:CGFloat(960), y: CGFloat(570), width: CGFloat(60), height: CGFloat(60)))
        label3.font = label3.font.withSize(CGFloat(50))
        label3.textAlignment = NSTextAlignment.center
        label3.text = ("\(box[2].qty)")
        label3.numberOfLines = 0
        label3.layer.cornerRadius = 3.0
        label3.backgroundColor = UIColor.clear
        self.view.addSubview(label3)
        
        
        func make_L2(xv:Int,yv:Int,wv:Int,hv:Int,f:Int,b:String){
            
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
        
        let button1: UIButton = UIButton(frame: CGRect(x:CGFloat(750), y:CGFloat(450), width: CGFloat(200), height: CGFloat(60)))
        button1.titleLabel?.font =  UIFont.systemFont(ofSize: 35)
        button1.setTitle("\(box[0].name)", for: .normal)
        button1.titleLabel?.numberOfLines = 1//0:無限改行,2:2行表示
        button1.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button1.backgroundColor = UIColor.clear
        button1.tag = 13
        button1.addTarget(self, action: #selector(B1(sender:)), for: .touchUpInside)
        if box[0].name == ""{
        }else{
            self.view.addSubview(button1)
        }
        
        //商品名(2段目)
        let button2: UIButton = UIButton(frame: CGRect(x:CGFloat(750), y:CGFloat(510), width: CGFloat(200), height: CGFloat(60)))
        button2.titleLabel?.font =  UIFont.systemFont(ofSize: 35)
        button2.setTitle("\(box[1].name)", for: .normal)
        button2.titleLabel?.numberOfLines = 1//0:無限改行,2:2行表示
        button2.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button2.backgroundColor = UIColor.clear
        button2.tag = 14
        button2.addTarget(self, action: #selector(B1(sender:)), for: .touchUpInside)
        if box[1].name == ""{
        }else{
            self.view.addSubview(button2)
        }
        //商品名(3段目)
        let button3: UIButton = UIButton(frame: CGRect(x:CGFloat(750), y:CGFloat(570), width: CGFloat(200), height: CGFloat(60)))
        button3.titleLabel?.font =  UIFont.systemFont(ofSize: 35)
        button3.setTitle("\(box[2].name)", for: .normal)
        button3.titleLabel?.numberOfLines = 1//0:無限改行,2:2行表示
        button3.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button3.backgroundColor = UIColor.clear
        button3.tag = 15
        button3.addTarget(self, action: #selector(B1(sender:)), for: .touchUpInside)
        if box[2].name == ""{
        }else{
            self.view.addSubview(button3)
        }
        print("更新")
        test2(xv:120,yv:90,wv:110,hv:70)
        print("\( count_t[0].now)")
        if  count_t[0].now == "on"{
            test(xv:750,yv:450,wv:200,hv:60)
        }
        if  count_t[1].now == "on"{
            test(xv:750,yv:510,wv:200,hv:60)
        }
        if  count_t[2].now == "on"{
            test(xv:750,yv:570,wv:200,hv:60)
        }
        
        
        
    }
    
    
    /// レフトスワイプ時に実行される
    @objc func leftSwipeView(sender: UISwipeGestureRecognizer) {
        print("left Swipe")
        let SViewController: UIViewController = ViewController()
        // アニメーションを設定する.
        //SViewController.modalTransitionStyle = .partialCurl
        // Viewの移動する.
        self.present(SViewController, animated: false, completion: nil)
    }
    
    /// ライトスワイプ時に実行される
    @objc func rightSwipeView(sender: UISwipeGestureRecognizer) {
        print("right Swipe")
        let SViewController: UIViewController = nigiri3()
        // アニメーションを設定する.
        //SViewController.modalTransitionStyle = .partialCurl
        // Viewの移動する.
        self.present(SViewController, animated: false, completion: nil)
    }
    
    func test(xv:Int,yv:Int,wv:Int,hv:Int){
        print("testoK")
        // UIImageViewを作成.
        let test = UIView(frame: CGRect(x:CGFloat(xv), y: CGFloat(yv), width: CGFloat(wv), height: CGFloat(hv)))
        test.backgroundColor = UIColor.yellow
        test.alpha = 0.3
        self.view.addSubview(test)
        
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
    
    @objc func B1(sender: UIButton){
        //let SViewController: UIViewController
        
        switch sender.tag{
        case 1:
            //戻ボタン
            let SViewController: UIViewController = ViewController()
            //アニメーションを設定する.
            SViewController.modalTransitionStyle = .flipHorizontal
            //Viewの移動する.
            self.present(SViewController, animated: true, completion: nil)
        case 2:
            // +ボタン
            if box[i].qty < 4{
                box[i].qty =  box[i].qty+1
                viewDidLoad()
            }else if box[i].qty == 4{
                
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
            // −ボタン
            if  box[i].qty == 0{
                
            }else{
                if  box[i].qty > 0{
                    box[i].qty =  box[i].qty-1
                }
            }
            viewDidLoad()
        case 4:
            print("ok")
            let SViewController: UIViewController = nigiri1()
            //アニメーションを設定する.
            SViewController.modalTransitionStyle = .flipHorizontal
            //Viewの移動する.
            self.present(SViewController, animated: true, completion: nil)
        case 5:
            print("ok")
            
        case 6:
            count = 1
            count2 = count2+1
            if box[0].name == ""{
                box[0].name = "サーモン"
                box[0].qty = 1
                box[0].view = "00.6png"
                i = i+0
            }else if  box[1].name == ""{
                box[1].name = "サーモン"
                box[1].qty = 1
                box[1].view = "006.png"
                i = i+1
            }else if  box[2].name == ""{
                box[2].name = "サーモン"
                box[2].qty = 1
                box[2].view = "006.png"
                i = i+1
            }
            count_t[0].now = "off"
            count_t[1].now = "off"
            count_t[2].now = "off"
            
            viewDidLoad()
        case 7:
            count = 1
            count2 = count2+1
            if box[0].name == ""{
                box[0].name = "オニオンサーモン"
                box[0].qty = 1
                box[0].view = "007.png"
                i = i+0
                print("\(i)")
            }else if  box[1].name == ""{
                box[1].name = "オニオンサーモン"
                box[1].qty = 1
                box[1].view = "007.png"
                i = i+1
                print("\(i)")
            }else if  box[2].name == ""{
                box[2].name = "オニオンサーモン"
                box[2].qty = 1
                box[2].view = "007.png"
                i = i+1
                print("\(i)")
            }
            count_t[0].now = "off"
            count_t[1].now = "off"
            count_t[2].now = "off"
            
            viewDidLoad()
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
            test(xv:750,yv:450,wv:200,hv:60)
            print("\(box[i].qty)")
            print("\( count_t[0].now)")
            viewDidLoad()
            
        case 14://商品名(2段目)
            i = 1
            count_t[0].now = "off"
            count_t[1].now = "on"
            count_t[2].now = "off"
            test(xv:750,yv:510,wv:200,hv:60)
            print("\(box[i].qty)")
            viewDidLoad()
        case 15://商品名(3段目)
            i = 2
            count_t[0].now = "off"
            count_t[1].now = "off"
            count_t[2].now = "on"
            test(xv:750,yv:570,wv:200,hv:60)
            print("\(box[i].qty)")
            viewDidLoad()
        case 17://タグ＿まぐろ
            let SViewController: UIViewController = nigiri1()
            // アニメーションを設定する.
            //SViewController.modalTransitionStyle = .partialCurl
            // Viewの移動する.
            self.present(SViewController, animated: false, completion: nil)
            
        default:break
            
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
}
