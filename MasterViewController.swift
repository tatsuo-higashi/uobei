
import UIKit

struct Section {
    var title: String
    var items: [String]
}

extension Section {
    
    static func make() -> [Section]  {
        return [
            Section(title: "タブレットapp ", items: ["アカウント","二次元コード","サウンド"]),
            Section(title: "会計app", items: ["アカウント", "二次元コード", "その他"]),
            Section(title: "仕入・在庫app", items: ["設定1", "設定2", "設定3", "設定4"]),
            Section(title: "データベース", items: ["メニュー", "在庫", "分析"])
        ]
    }
}

class MasterViewController: UIViewController {
    
    private var tableView = UITableView()
    private var sections = Section.make()
    var ct = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.frame = view.bounds
        let screenWidth: CGFloat = UIScreen.main.bounds.width      //画面の幅
        let screenHeight: CGFloat = UIScreen.main.bounds.height//画面の高さ
        tableView = UITableView(frame: CGRect(x:-150, y: 0, width: screenWidth, height: screenHeight), style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
    }

}


extension MasterViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = sections[indexPath.section].items[indexPath.row]
        ct = ct+1
        cell.tag = ct
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
}

extension MasterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

       switch sections[indexPath.section].items[indexPath.row] {
       case "アカウント":
        if (indexPath.section==0){
        appDelegate.view_setting = "アカウント"
        print("アカウントを押した")
        print("appDelegate.view_setting：" + appDelegate.view_setting)
        }
        
       case "二次元コード":
        if (indexPath.section==0){
        appDelegate.view_setting = "二次元コード"
        print("二次元コードを押した")
        print("appDelegate.view_setting：" + appDelegate.view_setting)
        }
       case "サウンド":
        if (indexPath.section==0){
        appDelegate.view_setting = "サウンド"
        print("サウンドSを押した")
        print("appDelegate.view_setting：" + appDelegate.view_setting)
        }
       case "メニュー":
        if (indexPath.section==3){
            appDelegate.view_setting = "メニュー"
            print("メニューを押した")
            print("appDelegate.view_setting：" + appDelegate.view_setting)
        }
        
       default:
        print("その他")
        }
      
        let SViewController: UIViewController = test()
  
        //Viewの移動する.
        self.present(SViewController, animated: false, completion: nil)

       /* //AppDelegateクラスでローカル通知を受け取った際に、画面遷移させたいといった場合などはこの方法(しかしここではチラつく)
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        // rootViewControllerに入れる
        appDelegate.window?.rootViewController = test()
        // 表示
        if appDelegate.window?.rootViewController == test(){
        appDelegate.window?.makeKeyAndVisible()
    }*/
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}

