//
//  MemoViewController.swift
//  thisisfinal
//
//  Created by Arisa Muto on 2019/06/21.
//  Copyright © 2019 Arisa Muto. All rights reserved.
//

import UIKit

class MemoViewController: UIViewController, UITableViewDataSource,UITableViewDelegate  {
    
    @IBOutlet var memoTableView: UITableView!
     var memoArray = [String]()
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
