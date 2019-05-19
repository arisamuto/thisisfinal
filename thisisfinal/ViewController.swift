//
//  ViewController.swift
//  thisisfinal
//
//  Created by Arisa Muto on 2019/05/11.
//  Copyright © 2019 Arisa Muto. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    //写真表示用ImageView
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var pictures: UIButton!
    
    //スクロール機能
    @IBOutlet var scrollview: UIScrollView!
    
    let days: [String] = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ステイタスバーを非表示
        self.setNeedsStatusBarAppearanceUpdate()
        
        scrollview.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height * 7)
        scrollview.isPagingEnabled = true
        let size = scrollview.frame.size
        //ラベルを最前面に移動
        self.view.bringSubviewToFront(myLabel)
        
    
                for i in 0..<7 {
            let contentView: UIView = UIView(frame: CGRect(x: 0, y: size.height*CGFloat(i), width: size.width, height: size.height))
            
            contentView.backgroundColor = UIColor(red: 0.1*CGFloat(i), green: 0.8, blue: 1.0-0.1*CGFloat(i), alpha: 1.0)
            
            let label = UILabel(frame: CGRect(x: 0, y: 100, width: size.width, height: 100))
            label.textAlignment = .center
            //フォント変える
            label.font = UIFont(name: "Chalkboard SE", size: 70)
            label.text = days[i]
            
            contentView.addSubview(label)
            self.scrollview.addSubview(contentView)
            
        }
        }
    //ステイタスバーを非表示にするためにオーバービューする
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //「アルバム」ボタンを押した時に呼ばれるメソッド
    @IBAction func onTappedAlbumButton() {
        presentPickerController(sourceType: .photoLibrary)
        
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
        photoImageView.image = info[.originalImage]as? UIImage
    }
}
