import Foundation
import AVFoundation
import UIKit


class Camera: UIViewController, AVCaptureMetadataOutputObjectsDelegate{
    // カメラやマイクの入出力を管理するオブジェクトを生成
    private let session = AVCaptureSession()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //ボタン作成
        let button = makeButton()//m:backgrand,e:picture,e:border
        let view = viewSetting()
        
        self.view.addSubview(button.make(xv:30,yv:700,wv:100,hv:50,f:50,b:"戻る",c:0,d:1,e:0,m:1))

        // カメラやマイクのデバイスそのものを管理するオブジェクトを生成（ここではワイドアングルカメラ・ビデオ・背面カメラを指定）
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera],
                                                mediaType: .video,
                                                position: .back)
        // ワイドアングルカメラ・ビデオ・背面カメラに該当するデバイスを取得
        let devices = discoverySession.devices
        //　該当するデバイスのうち最初に取得したものを利用する
        if let backCamera = devices.first {
            do {
                // QRコードの読み取りに背面カメラの映像を利用するための設定
                let deviceInput = try AVCaptureDeviceInput(device: backCamera)

                if self.session.canAddInput(deviceInput) {
                    self.session.addInput(deviceInput)

                    // 背面カメラの映像からQRコードを検出するための設定
                    let metadataOutput = AVCaptureMetadataOutput()

                    if self.session.canAddOutput(metadataOutput) {
                        self.session.addOutput(metadataOutput)

                        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                        metadataOutput.metadataObjectTypes = [.qr]

                        // 背面カメラの映像を画面に表示するためのレイヤーを生成
                        let previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
                        previewLayer.frame = CGRect(x: 0, y: 0, width: 1024, height: 680)
                        previewLayer.videoGravity = .resizeAspectFill
                        self.view.layer.addSublayer(previewLayer)

                        // 読み取り開始
                        self.session.startRunning()
                    }
                }
            } catch {
                self.present(view.viewSet(open: ViewController(),anime: .flipHorizontal), animated: true, completion: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
    let view = viewSetting()
    for metadata in metadataObjects as! [AVMetadataMachineReadableCodeObject] {
        // QRコードのデータかどうかの確認
        if metadata.type != .qr { continue }

        // QRコードの内容が空かどうかの確認
        if metadata.stringValue == nil { continue }

        /*
        このあたりで取得したQRコードを使ってゴニョゴニョする
        読み取りの終了・再開のタイミングは用途によって制御が異なるので注意
         */

        // URLかどうかの確認
        if URL(string: metadata.stringValue!) != nil {
            // 読み取り終了
            self.session.stopRunning()
            // QRコードに紐付いたURLをSafariで開く
            //UIApplication.shared.open(url, options: [:], completionHandler: nil)
            self.present(view.viewSet(open: First(),anime: .flipHorizontal), animated: true, completion: nil)
            break
        }else{
            self.session.stopRunning()
            self.present(view.viewSet(open: Accounting(),anime: .flipHorizontal), animated: true, completion: nil)
            break
        }
    }
}

    //戻るボタンイベント
    @objc func selection(sender: UIButton){
        let view = viewSetting()
        switch sender.tag{
            case 0:
                self.present(view.viewSet(open: ViewController(),anime: .flipHorizontal), animated: false, completion: nil)
            default: break
        }
    }
}
