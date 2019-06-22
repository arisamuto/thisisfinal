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
        
        self.dismiss(animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
