import UIKit
struct Section2 {
    var title: String
    var items: [String]
}
extension Section2 {
    static func make() -> [Section] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        switch appDelegate.view_setting{
        case "アカウント":
            return[Section(title: "アカウント", items: ["席番号", "到着時間"])]//sections[0].count=1
        case "二次元コード":
            return[Section(title: "二次元コード", items: ["バーコード", "QRコード"])]//sections[0].count=1
        case "サウンド":
            return[Section(title: "サウンド", items: ["タッチ音", "スクリーンセーバ"]),//sections[0].count=3,sections[2][0].items.count=1
                Section(title: "サウンドON-OFF", items: ["タッチ音", "スクリーンセーバ"]),//sections[2][1].items.count=4
                Section(title: "音量", items: ["タッチ音", "スクリーンセーバ"])]//sections[2][2].items.count=2
        default:
            return[Section(title: "アカウント", items: ["席番号", "到着時間"])]//sections[0].count=1
        }
    }
}
/*extension Section2 {
 static func make() -> [[Section]] {
 return [
 //sections.count = 3
 [Section(title: "アカウント", items: ["席番号", "到着時間"])],//sections[0].count=1
 [Section(title: "二次元コード", items: ["バーコード", "QRコード","バーコード"])],//sections[0].count=1
 [Section(title: "サウンド", items: ["タッチ音"]),//sections[0].count=3,sections[2][0].items.count=1
 Section(title: "サウンドON-OFF", items: ["タッチ音", "スクリーンセーバ","バーコード", "QRコード"]),//sections[2][1].items.count=4
 Section(title: "音量", items: ["タッチ音", "スクリーンセーバ"])//sections[2][2].items.count=2
 ]
 ]
 }
 }*/
class splitViewController2: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //pickerView関連
    let pickerView1 = UIPickerView()
 
        let pickerView2 = UIPickerView()
    
    
    var label = UILabel()
    let dataList1 = [
        "button01a","button01b","button01c"
    ]
    let dataList2 = [
        "movie01","movie02","movie03"
    ]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int ) -> Int {
        if pickerView == pickerView1{
            return dataList1.count
        }else{
            return dataList2.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerView1{
            return dataList1[row]
        }else{
            return dataList2[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerView1{
        print("pickerview1")
        print("row: \(row)")
            appDelegate.sound_num=dataList1[row]
            appDelegate.pickerView1Ini = row
        }else{
            print("pickerview2")
            print("row: \(row)")
            appDelegate.movie_num=dataList2[row]
             appDelegate.pickerView2Ini = row
        }
    }
    private var tableView = UITableView()
    private var sections = Section2.make()
    //一旦終わり
    override func viewDidLoad() {
        super.viewDidLoad()
        //picker関連
        // ViewContorller 背景色
        self.view.backgroundColor = UIColor.white
        // PickerView のサイズと位置
        pickerView1.frame = CGRect(x: 0, y: 0, width: 200, height: 600)
      
         pickerView2.frame = CGRect(x: 0, y: 0, width: 200, height: 600)
        pickerView1.backgroundColor = UIColor.white
         pickerView2.backgroundColor = UIColor.white
        // PickerViewはスクリーンの中央に設定
        pickerView1.center = self.view.center
          pickerView2.center = self.view.center
        // Delegate設定
        pickerView1.delegate = self
        pickerView1.dataSource = self
        pickerView2.delegate = self
        pickerView2.dataSource = self
        pickerView1.selectRow(appDelegate.pickerView1Ini, inComponent: 0, animated: true)
        pickerView2.selectRow(appDelegate.pickerView2Ini, inComponent: 0, animated: true)
        
        
     
        // フォントサイズを大きく
        label.font = UIFont.systemFont(ofSize: 60)
        // テキストを中央寄せにする
        label.textAlignment = NSTextAlignment.center
        //終わり
        view.backgroundColor = UIColor(red: 239 / 255, green: 239 / 255, blue: 244 / 255, alpha: 1)
        let screenWidth: CGFloat = UIScreen.main.bounds.width //画面の幅
        let screenHeight: CGFloat = UIScreen.main.bounds.height//画面の高さ
        tableView = UITableView(frame: CGRect(x:65, y: 0, width: screenWidth/2, height: screenHeight), style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        var doneBarButtonItem: UIBarButtonItem!
        doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneBarButtonTapped(_:)))
        // ③バーボタンアイテムの追加
        self.navigationItem.rightBarButtonItems = [doneBarButtonItem]
    }
}
extension splitViewController2: UITableViewDataSource {
    //セクション数
    func numberOfSections(in tableView: UITableView) -> Int {
        /*let appDelegate = UIApplication.shared.delegate as! AppDelegate
         switch appDelegate.view_setting {
         case "アカウント":
         print("一回しか通らないはず")
         return sections[0].count
         case "二次元コード":
         return sections[1].count
         case "サウンド":
         return sections[2].count
         default:
         return 1
         }*/
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*let appDelegate = UIApplication.shared.delegate as! AppDelegate
         switch appDelegate.view_setting {
         case "アカウント":
         print("アカウントにきた回数")
         return sections[0][0].items.count
         case "二次元コード":
         print("二次元コードにきた回数")
         return sections[1][0].items.count
         case "サウンド":
         print("サウンドに来た回数")
         return sections[2][section].items.count
         default:
         return 1//sections[section].countこれはOK
         }*/
        return sections[section].items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = sections[indexPath.section].items[indexPath.row]
        //角を丸める処理
        let cornerRadius:CGFloat = 20
        let sectionCount = tableView.numberOfRows(inSection: indexPath.section)
        let shapeLayer = CAShapeLayer()
        cell.layer.mask = nil
        if sectionCount > 1 {
            switch indexPath.row {
            case 0:
                var bounds = cell.bounds
                bounds.origin.y += 1.0
                let bezierPath = UIBezierPath(roundedRect: bounds,
                                              byRoundingCorners: [.topLeft,.topRight],
                                              cornerRadii: CGSize(width: cornerRadius,height: cornerRadius))
                shapeLayer.path = bezierPath.cgPath
                cell.layer.mask = shapeLayer
            case sectionCount - 1:
                var bounds = cell.bounds
                bounds.size.height -= 1.0
                let bezierPath = UIBezierPath(roundedRect: bounds,
                                              byRoundingCorners: [.bottomLeft,.bottomRight],
                                              cornerRadii: CGSize(width: cornerRadius,height: cornerRadius))
                shapeLayer.path = bezierPath.cgPath
                cell.layer.mask = shapeLayer
            default:
                break
            }
        }
        else {
            let bezierPath = UIBezierPath(roundedRect:
                cell.bounds.insetBy(dx: 0.0, dy: 2.0),
                                          cornerRadius: cornerRadius)
            shapeLayer.path = bezierPath.cgPath
            cell.layer.mask = shapeLayer
        }
        if cell.accessoryView == nil {
        }
        /* let tf2 : UITextField = UITextField.init() as UITextField
         tf2.delegate = self
         tf2.frame = CGRect(x:400,y:3,width:50,height: 40)
         //tf2.backgroundColor = UIColor(red:0, green:0, blue:0.3, alpha:0.6)
         //tf1.center = CGPoint(x: view.bounds.width / 2.0-90, y: cellHeight / 2.0)
         if count-1 <= indexPath.row{
         tf2.placeholder = "納期"
         tf2.tag = indexPath.row
         cell.addSubview(tf2)*/
        if appDelegate.view_setting == "アカウント" {
            if indexPath.row == 0{
                cell.accessoryView = UISwitch()
            }
            if indexPath.row == 1{
                cell.accessoryView = UISwitch()
            }
        }
        if appDelegate.view_setting == "二次元コード" {
            if indexPath.row == 0{
                // UISwitch値が変更された時に呼び出すメソッドの設定
                let testSwitch:UISwitch = UISwitch()
                testSwitch.addTarget(self, action: #selector(changeSwitch), for: UIControl.Event.valueChanged)
                // UISwitchの状態をオンに設定
                if appDelegate.qr_sta == "qr"{
                    testSwitch.isOn = false
                }else{
                    testSwitch.isOn = true
                }
                testSwitch.tag=0;
                cell.accessoryView = testSwitch
            }
            if indexPath.row == 1{
                // UISwitch値が変更された時に呼び出すメソッドの設定
                let testSwitch:UISwitch = UISwitch()
                testSwitch.addTarget(self, action: #selector(changeSwitch), for: UIControl.Event.valueChanged)
                // UISwitchの状態をオンに設定
                if appDelegate.qr_sta == "qr"{
                    testSwitch.isOn = true
                }else{
                    testSwitch.isOn = false
                }
                testSwitch.tag=1;
                cell.accessoryView = testSwitch
            }
        }
        if appDelegate.view_setting == "サウンド" {
            if indexPath.section==0 && indexPath.row == 0{
                cell.accessoryView = pickerView1
            }
            if indexPath.section==0 && indexPath.row == 1{
                cell.accessoryView = pickerView2
            }
            if indexPath.section==1 && indexPath.row == 0{
                let testSwitch:UISwitch = UISwitch()
                testSwitch.addTarget(self, action: #selector(changeSwitch), for: UIControl.Event.valueChanged)
                // UISwitchの状態をオンに設定
                if appDelegate.touch_volume != 0{
                    testSwitch.isOn = true
                }else{
                    testSwitch.isOn = false
                }
                testSwitch.tag=2;
                cell.accessoryView = testSwitch
            }
            if indexPath.section==1 && indexPath.row == 1{
                let testSwitch:UISwitch = UISwitch()
                testSwitch.addTarget(self, action: #selector(changeSwitch), for: UIControl.Event.valueChanged)
                // UISwitchの状態をオンに設定
                if appDelegate.movie_volume != 0{
                    testSwitch.isOn = true
                }else{
                    testSwitch.isOn = false
                }
                testSwitch.tag=3;
                cell.accessoryView = testSwitch
            }
            if indexPath.section==2 && indexPath.row == 0{
                let slider = UISlider(frame: CGRect(x:200, y: 20, width: 300, height:20))
                slider.minimumValue = 0.0
                slider.maximumValue = 1.0
                slider.value = appDelegate.touch_volume
                slider.addTarget(self, action: #selector(sliderDidEndSliding_t(_:)), for: [.touchUpInside, .touchUpOutside])
                cell.accessoryView = slider
            }
            if indexPath.section==2 && indexPath.row == 1{
                let slider = UISlider(frame: CGRect(x:200, y: 20, width: 300, height:20))
                slider.minimumValue = 0.0
                slider.maximumValue = 1.0
                slider.value = appDelegate.movie_volume
                slider.addTarget(self, action: #selector(sliderDidEndSliding_m(_:)), for: [.touchUpInside, .touchUpOutside])
                cell.accessoryView = slider
            }
        }
        /*if indexPath.row == 0{
         let slider = UISlider(frame: CGRect(x:100, y: 20, width: 400, height:20))
         cell.addSubview(slider)
         }
         if indexPath.row == 1{
         cell.accessoryView = UISwitch()
         }*/
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
}
extension splitViewController2: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(sections[indexPath.section].items[indexPath.row])
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    override func viewWillAppear(_ animated: Bool) {
        //view.backgroundColor = UIColor(red: 239 / 255, green: 239 / 255, blue: 244 / 255, alpha: 1)
        super.viewWillAppear(animated)
    }
    
     @objc func dateChanged(_ sender: UIDatePicker) {
      print("ちゃん来てる")
    }
    //doneタップ時
    @objc func doneBarButtonTapped(_ sender: UIBarButtonItem) {
        let SViewController: UIViewController = ViewController()
        //アニメーションを設定する.
        SViewController.modalTransitionStyle = .flipHorizontal
        //Viewの移動する.
        SViewController.modalPresentationStyle = .fullScreen
        self.present(SViewController, animated: true, completion: nil)
    }
    @objc func sliderDidEndSliding_t(_ sender: UISlider) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        print("end sliding")
        print("タッチ音sliderの値:",sender.value)
        appDelegate.touch_volume = sender.value
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        //　Storyboardを指定
        // rootViewControllerに入れる
        appDelegate.window?.rootViewController = test()
        // 表示
        appDelegate.window?.makeKeyAndVisible()
    }
    @objc func sliderDidEndSliding_m(_ sender: UISlider) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        print("end sliding")
        print("スクリーンセーバーsliderの値:",sender.value)
        appDelegate.movie_volume = sender.value
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        //　Storyboardを指定
        // rootViewControllerに入れる
        appDelegate.window?.rootViewController = test()
        // 表示
        appDelegate.window?.makeKeyAndVisible()
    }
    @objc func changeSwitch(sender: UISwitch) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // UISwitch値を取得
        switch sender.tag{
        case 0://バーコードの値が変わった時
            if appDelegate.qr_sta == "qr"{
                print("二次元コードはバーコードを選択")
                appDelegate.qr_sta = "bc"
            }else{
                print("二次元コードはQRコードを選択")
                appDelegate.qr_sta = "qr"
            }
            appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
            //　Storyboardを指定
            // rootViewControllerに入れる
            appDelegate.window?.rootViewController = test()
            // 表示
            appDelegate.window?.makeKeyAndVisible()
        case 1://QRコードの値が変わった時
            if appDelegate.qr_sta == "qr"{
                print("二次元コードはバーコードを選択")
                appDelegate.qr_sta = "bc"
            }else{
                print("二次元コードはQRコードを選択")
                appDelegate.qr_sta = "qr"
            }
            appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
            //　Storyboardを指定
            // rootViewControllerに入れる
            appDelegate.window?.rootViewController = test()
            // 表示
            appDelegate.window?.makeKeyAndVisible()
        case 2://サウンドON-OFFのタッチ音値が変わった時
            if appDelegate.touch_volume == 0{
                appDelegate.touch_volume = 0.5
                print("タッチ音量を初期化")
            }else{
                appDelegate.touch_volume = 0.0
                print("タッチ音量を0に設定")
            }
            appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
            //　Storyboardを指定
            // rootViewControllerに入れる
            appDelegate.window?.rootViewController = test()
            // 表示
            appDelegate.window?.makeKeyAndVisible()
        case 3://サウンドON-OFFのスクリーン音値が変わった時
            if appDelegate.movie_volume == 0{
                appDelegate.movie_volume = 0.5
                print("スクリーンセーバ音量を初期化")
            }else{
                appDelegate.movie_volume = 0.0
                print("スクリーンセーバ音量を0に設定")
            }
            appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
            //　Storyboardを指定
            // rootViewControllerに入れる
            appDelegate.window?.rootViewController = test()
            // 表示
            appDelegate.window?.makeKeyAndVisible()
        default:break
        }
    }
}
