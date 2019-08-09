//
//  NameViewController.swift
//  TestCoreData
//
//  Created by Trieu Quy Tam on 8/9/19.
//  Copyright © 2019 Trieu Quy Tam. All rights reserved.
//

import UIKit

class NameViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var nameArray : [Info] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.fetchData()
        self.tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let oneRecord = nameArray[indexPath.row]
        cell.textLabel!.text = oneRecord.nameOne! + " " + oneRecord.nameTwo! + " " + oneRecord.nameThree!
        return cell
    }
    
    func fetchData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            nameArray = try context.fetch(Info.fetchRequest())
            
        } catch {
            print(error)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
