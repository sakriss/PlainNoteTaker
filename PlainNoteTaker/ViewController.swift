//
//  ViewController.swift
//  PlainNoteTaker
//
//  Created by Scott Kriss on 5/1/17.
//  Copyright © 2017 Scott Kriss. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var table: UITableView!
    var data:[String] = []
    var file:String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Nizotes"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = editButtonItem
        
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        file = docDir[0].appending("notes.txt")
        
        load()
    }
    
    func addNote(){
        if (table.isEditing) {
            return
        }
        let name:String = "Row \(data.count + 1)"
        data.insert(name, at: 0)
        let indexPath:IndexPath = IndexPath(row: 0, section: 0)
        table.insertRows(at: [indexPath], with: .automatic)
        save()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        table.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        data.remove(at: indexPath.row)
        table.deleteRows(at: [indexPath], with: .fade)
        save()
    }
    
    func save(){
        //UserDefaults.standard.set(data, forKey: "notes")
        //UserDefaults.standard.synchronize()
        
        let newData:NSArray = NSArray(array:data)
        newData.write(toFile: file, atomically: true)
    }
    
    func load(){
        if let loadedData = NSArray(contentsOfFile:file) as? [String]{
            data = loadedData
            table.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

