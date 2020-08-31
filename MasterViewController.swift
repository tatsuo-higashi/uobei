//
//  MasterViewController.swift
//  yhj
//
//  Created by 東竜生 on 2020/03/10.
//  Copyright © 2020年 東竜生. All rights reserved.
//

/*import UIKit

struct Section {
    var title: String
    var items: [String]
}

extension Section {
 
 static func make() -> [Section]  {
 return [
 Section(title: "アカウント", items: ["席番号", "到着時間"]),
 Section(title: "二次元コード", items: ["バーコード", "QRコード"]),
 Section(title: "サウンド", items: ["アカウント", "二次元コード", "サウンド"]),
 ]
 }
 }

class MasterViewController: UITableViewController {
    var sections = Section.make()
    var detailViewController: splitViewController2? = nil
    var objects = [Any]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem
        

        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? splitViewController2
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
   /* @objc
    func insertNewObject(_ sender: Any) {
        objects.insert(NSDate(), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }*/
    
    // MARK: - Segues
    
  /*  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! NSDate
                let controller = (segue.destination as! UINavigationController).topViewController as! splitViewController2
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
 }*/
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //objects.countでだめ
        print(objects.count)
        return objects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let object = objects[indexPath.row] as! NSDate
        cell.textLabel!.text = object.description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    
}*/
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
        let _: CGFloat = UIScreen.main.bounds.width      //画面の幅
        let _: CGFloat = UIScreen.main.bounds.height//画面の高さ
        tableView = UITableView(frame: CGRect(x:0, y: 0, width: 1024, height: 768), style: .grouped)
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
        appDelegate.view_setting = "アカウント"
        
       case "二次元コード":
        appDelegate.view_setting = "二次元コード"

       case "サウンド":
        appDelegate.view_setting = "サウンド"

       default:
        print("その他")
        }
        let SViewController: UIViewController = test()
  
        //Viewの移動する.
        SViewController.modalPresentationStyle = .fullScreen
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

