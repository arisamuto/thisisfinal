//
//  DetailViewController.swift
//  thisisfinal
//
//  Created by Arisa Muto on 2019/06/21.
//  Copyright © 2019 Arisa Muto. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var memoTextview: UITextView!
    var selectedroll: Int!
    var selectedmemo: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memoTextview.text = selectedmemo
        // Do any additional setup after loading the view.
    }
    @IBAction func deleteMemo(_ sender: Any) {
        let ud = UserDefaults.standard
        if ud.array(forKey: "memoArray") != nil{
            var saveMemoArray = ud.array(forKey: "memoArray") as![String]
            saveMemoArray.remove(at: selectedroll)
            ud.set(saveMemoArray, forKey: "memoArray" )
            ud.synchronize()
            //画面遷移
            
            self.navigationController?.popViewController(animated: true)
            
        }


}
}
