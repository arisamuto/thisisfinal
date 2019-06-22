//
//  ViewController.swift
//  thisisfinal
//
//  Created by Arisa Muto on 2019/05/11.
//  Copyright © 2019 Arisa Muto. All rights reserved.
//
import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    

    @IBOutlet var album: UIButton!
    @IBOutlet var memo: UIButton!
    @IBOutlet var scrollview: UIScrollView!
    
    
    let days: [String] = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    
    //写真のからの配列
    var picture: [UIImageView] = []
    var pictureImages:[UIImage] = [UIImage(), UIImage(), UIImage(), UIImage(), UIImage(), UIImage(), UIImage()]
    var saveArray: Array! = [NSData]()
    var pictureHasImages:[Bool] = [false, false, false, false, false, false, false]
    
    
    let saveData = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ステイタスバーを非表示
        self.setNeedsStatusBarAppearanceUpdate()
        
        scrollview.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height * 7)
        scrollview.isPagingEnabled = true
        let size = scrollview.frame.size
        
        //曜日を入れる
        for i in 0..<7 {
            let contentView: UIView = UIView(frame: CGRect(x: 0, y: size.height*CGFloat(i), width: size.width, height: size.height))
            
            
            contentView.backgroundColor = UIColor(red: 0.1*CGFloat(i), green: 0.8, blue: 1.0-0.1*CGFloat(i), alpha: 1.0)
            
            let label = UILabel(frame: CGRect(x: 0, y: 30, width: size.width, height: 200))
            label.textAlignment = .center
            //フォント変える
            label.font = UIFont(name: "Chalkboard SE", size: 70)
            label.text = days[i]
            
            //その日の曜日
            let addingpictures = UIImageView(frame: CGRect(x: 0, y: 300, width: size.width, height: 350))
            
            picture.append(addingpictures)
            
            contentView.addSubview(label)
            contentView.addSubview(addingpictures)
            self.scrollview.addSubview(contentView)
            self.view.addSubview(scrollview)
            
            //ボタンを最前面に移動
            self.view.bringSubviewToFront(album)
            //ボタンを最前面に移動
            self.view.bringSubviewToFront(memo)
        }
        
        //ボタンの文字の色の設定
        album.setTitleColor(UIColor.yellow, for: UIControl.State.normal)
        memo.setTitleColor(UIColor.orange, for: UIControl.State.normal)
        //ボタンの周りのボックスの色の設定
        album.layer.borderColor = UIColor.blue.cgColor
        memo.layer.borderColor = UIColor.blue.cgColor
        album.layer.borderWidth = 1.0
        memo.layer.borderWidth = 1.0
        album.layer.cornerRadius = 10 //丸みを数値でか変更
        memo.layer.cornerRadius = 10
        
        loadPicture()
    }
    //ステイタスバーを非表示にするためにオーバービューする
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //「アルバム」ボタンを押した時に呼ばれるメソッド
    @IBAction func onTappedAlbumButton() {
        presentPickerController(sourceType: .photoLibrary)
    }
    @IBAction func onTappedMemoButton(_sender: UIButton) {
        performSegue(withIdentifier: "tomemo", sender: nil)
    }
    //アルバムの呼び出しメゾット(アルバムのソースタイプが引数
    func presentPickerController(sourceType: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated:true,completion:nil)
        }
    }
    
    //写真が選択された時に呼ばれるメソッド
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey:Any]) {
        self.dismiss(animated: true, completion: nil)
        
    //画像を出力
        let n = Int(scrollview.contentOffset.y / view.frame.height)
        picture[n].image = info[.originalImage] as? UIImage
        pictureHasImages[n] = true
        pictureImages[n] = (info[.originalImage] as? UIImage)!
        savePicture()
        
        //        //return image as PNG. MAy return nil if image has no CGImagRef or invalid bitmao format
        //        public func UIImagePNGRepresentation(image: UIImage); NSData?()
        //
        //        //return image as JPEG. May return nil if image has no CGImageRef or invalid bitmap format. compression is 0(most)..1(least)
        //        public func UIImageJPEGRepresentation(image: UIImage, _ compressionQuality: CGFloat) -> NSData?
        //
        //        let data: NSData? = UIImagePNGRepresentation(UIImage)
        //        let data: NSData? = UIImageJPEGRepresentation(UIImage)
        //
        //        public init?(data: NSData)
        //        let image: UIImage = UIImage(data: data)
        //        let image: UIImage? = data.floatMap(UIImage.init)
        
    }
    
    func savePicture(){
        //saveData.set(pictureImages, forKey: "pictureImages")
        saveData.set(pictureHasImages, forKey: "pictureHasImages")
        saveArray = []
        for i in 0..<7{
            if pictureHasImages[i] == true{
                let image:UIImage = pictureImages[i]
                let data = image.pngData()! as NSData
                saveArray.append(data)
            }
        }
        saveData.set(saveArray, forKey: "saveImage")
        saveData.synchronize()
    }
    
    func loadPicture(){
        if saveData.array(forKey: "pictureHasImages") != nil {
            pictureHasImages = saveData.array(forKey: "pictureHasImages") as! [Bool]
            print(pictureHasImages)
            
            if saveData.object(forKey: "saveImage") != nil {
                let objects = saveData.object(forKey: "saveImage") as? NSArray
                //配列としてUserDefaultsに保存した時の値と処理後の値が変わってしまうのでremoveAll()
                saveArray.removeAll()
                for data in objects! {
                    saveArray.append(data as! NSData)
                }
                var count = 0
                for i in 0..<7{
                    if pictureHasImages[i] == true{
                        pictureImages[i] = UIImage(data: saveArray[count] as Data)!
                        count += 1
                    }
                }
            }
            for i in 0..<7 {
                if pictureHasImages[i] == true{
                    picture[i].image = pictureImages[i]
                }
            }
        }
    }
}
