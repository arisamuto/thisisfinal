//
//  AddmemoViewController.swift
//  thisisfinal
//
//  Created by Arisa Muto on 2019/06/21.
//  Copyright © 2019 Arisa Muto. All rights reserved.
//

import UIKit

class AddmemoViewController: UIViewController {
    
    @IBOutlet var memoTextview: UITextView!
    var text1: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func save(_sender: Any) {
        
        let inputText = memoTextview.text
        let ud = UserDefaults.standard
        if ud.array(forKey: "memoArray") != nil {
            //saveMemoArrayに取得
            var saveMemoArray = ud.array(forKey: "memoArrat") as![String]
            if inputText != ""{
                saveMemoArray.append(inputText!)
                ud.set(saveMemoArray, forKey: "memoArray")
            }else{
                _ = UIAlertController(
                    title: "TextBOX", message: "何も入力されていません", preferredStyle: .alert)
            }
            
        }else{
            //最初何も書かれていない場合
            var newMemoArray = [String]()
            //nilを強制アンラップはエラーが出るから
            if inputText != ""{
                //inputtextはoptional型だから強制アンラップ
                newMemoArray.append(inputText!)
                ud.set(newMemoArray, forKey: "memoArray")
            }else{
                _ = UIAlertController(
                    title: "保存完了", message: "Good Joob!!", preferredStyle: .alert)
                ud.synchronize()
                self.dismiss(animated: true, completion: nil)
            }
            
        }
    }
}
