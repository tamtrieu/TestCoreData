//
//  ViewController.swift
//  TestCoreData
//
//  Created by Trieu Quy Tam on 8/9/19.
//  Copyright © 2019 Trieu Quy Tam. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    @IBOutlet weak var name1Text: UITextField!
    @IBOutlet weak var name2Text: UITextField!
    @IBOutlet weak var name3Text: UITextField!
    @IBOutlet weak var searchFor: UITextField!
    @IBOutlet weak var searchResult: UILabel!
    
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    //getting values from text
    @IBAction func saveBtn(_ sender: Any) {
        let nameOne = self.name1Text!.text
        let nameTwo = self.name2Text!.text
        let nameThree = self.name3Text!.text
        
    //validate input values
        if(nameOne?.isEmpty)!{
            self.name1Text.layer.borderColor = UIColor.red.cgColor
        }else{
            self.name1Text.layer.borderColor = UIColor.black.cgColor
        }
        if(nameTwo?.isEmpty)!{
            self.name2Text.layer.borderColor = UIColor.red.cgColor
        }else{
            self.name2Text.layer.borderColor = UIColor.black.cgColor
        }
        if(nameThree?.isEmpty)!{
            self.name3Text.layer.borderColor = UIColor.red.cgColor
        }else{
            self.name3Text.layer.borderColor = UIColor.black.cgColor
        }
        
        let newName = NSEntityDescription.insertNewObject(forEntityName: "Info", into: context)
        newName.setValue(self.name1Text!.text, forKey: "nameOne")
        newName.setValue(self.name2Text!.text, forKey: "nameTwo")
        newName.setValue(self.name3Text!.text, forKey: "nameThree")
        
        do{
            try context.save()
            self.name1Text!.text = ""
            self.name2Text!.text = ""
            self.name3Text!.text = ""
        }catch{
            print(error)
        }
    }
    
    @IBAction func searchBtn(_ sender: Any) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Info")
        let searchString = self.searchFor?.text
        //request.predicate = NSPredicate(format: "cityName CONTAINS[cd] %@", searchString!) // contains case insensitive
        //request.predicate = NSPredicate(format: "cityName CONTAINS %@", searchString!) // contains case sensitive
        //request.predicate = NSPredicate(format: "cityName LIKE[cd] %@", searchString!) // like case insensitive
        //request.predicate = NSPredicate(format: "cityName ==[cd] %@", searchString!)  // equal case insensitive
        request.predicate = NSPredicate(format: "nameOne == %@ OR nameTwo == %@ OR nameThree == %@", searchString!,searchString!,searchString!)

        
        
        // equal case sensitive
        var outputStr = ""
        do {
            let result = try context.fetch(request)
            if result.count > 0 {
                for online in result {
                    let firstName = (online as AnyObject).value(forKey: "nameOne") as! String
                    let midName = (online as AnyObject).value(forKey: "nameTwo") as! String
                    let lastName = (online as AnyObject).value(forKey: "nameThree") as! String
                    
                    outputStr += firstName + " " + midName + " " + lastName + "\n"
                }
            } else {
                outputStr = "No Match Found!"
            }
            self.searchResult?.text = outputStr
        } catch {
            print(error)
        }
    }
    
    
}

