import UIKit

class camera: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func button(_ sender: Any) {
        //アルバムを起動
        changeImage()
    }
    
    func changeImage() {
        //アルバムを指定
        //SourceType.camera：カメラを指定
        //SourceType.photoLibrary：アルバムを指定
        let sourceType:UIImagePickerController.SourceType = UIImagePickerController.SourceType.photoLibrary
        //アルバムを立ち上げる
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            //アルバム画面を開く
            self.present(cameraPicker, animated: true, completion: nil)
        }
    }
        
    //アルバム画面で写真を選択した時
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //imageにアルバムで選択した画像が格納される
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //ImageViewに表示
            self.imageView.image = image
            //アルバム画面を閉じる
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
}
