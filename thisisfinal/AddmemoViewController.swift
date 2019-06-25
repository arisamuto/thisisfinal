//
//  AddmemoViewController.swift
//  thisisfinal
//
//  Created by Arisa Muto on 2019/06/21.
//  Copyright © 2019 Arisa Muto. All rights reserved.
//

import UIKit

class AddmemoViewController: UIViewController {
    
    @IBOutlet var back2: UIButton!
    @IBOutlet var memoTextview: UITextView!
    var text1: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ステイタスバーを非表示
        self.setNeedsStatusBarAppearanceUpdate()
        //ボタン
        back2.layer.borderColor = UIColor.blue.cgColor
        back2.layer.borderWidth = 1.0
        back2.layer.cornerRadius = 10
        
    }
    
    @IBAction func save(_sender: Any) {
        
        let inputText = memoTextview.text
        let ud = UserDefaults.standard
        let alert = UIAlertController(
            title: "保存完了", message: "メモ追加しました", preferredStyle: .alert
        )
  
        
        
        if ud.array(forKey: "memoArray") != nil{
            var saveMemoArray = ud.array(forKey: "memoArray") as! [String]
            if inputText != nil{
                saveMemoArray.append(inputText!)
            }else{
                print("何も入力されていません。")
            }
            ud.set(saveMemoArray, forKey: "memoArray")
        }else{
            var newMemoArray = [String]()
            //nilを強制アンラップはエラーが出るから
            if inputText != nil{
                //inputtextはoptional型だから強制アンラップ
                newMemoArray.append(inputText!)
            }else{
                print("何も入っていません。")
            }
            ud.set(newMemoArray, forKey: "memoArray")
        }
        ud.synchronize()
        present(alert,animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
