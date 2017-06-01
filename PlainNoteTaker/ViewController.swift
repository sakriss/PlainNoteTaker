//
//  ViewController.swift
//  PlainNoteTaker
//
//  Created by Scott Kriss on 5/1/17.
//  Copyright © 2017 Scott Kriss. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    @IBOutlet weak var table: UITableView!
    var data:[String] = []
    var selectedRow:Int = -1
    var file:String!
    var newRowText:String = ""
    var newNoteCellText:String = "---Tap to add a note---"
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Simple Notes"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = editButtonItem
        
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        file = docDir[0].appending("notes.txt")
        
        load()
        
        table.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if selectedRow == -1 {
            return
        }
        if !newRowText.isEmpty {
            if selectedRow < data.count {
                data[selectedRow] = newRowText
            }
            else {
                //data.append(newRowText)
                
                //makes sure to add the new row to the top every time even when added using the Add Note cell
                data.insert(newRowText, at: 0)
            }
        }
        table.reloadData()
        save()
    }
    
    func addNote(){
        if (table.isEditing) {
            return
        }
        let name:String = ""
        data.insert(name, at: 0)
        let indexPath:IndexPath = IndexPath(row: 0, section: 0)
        table.insertRows(at: [indexPath], with: .automatic)
        table.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        self.performSegue(withIdentifier: "detail", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count + 1
    }
    
    //this is setting up the table rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        if indexPath.row < data.count {
            cell.textLabel?.text = data[indexPath.row]
            cell.accessoryType = .disclosureIndicator //sets the > in each cell
        }
        else {
            cell.textLabel?.text = newNoteCellText
            cell.textLabel?.textAlignment = .center
            cell.contentView.backgroundColor = UIColor.yellow
        }
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    //        var lastCell = data.count+1
    //        cell.contentView.backgroundColor = UIColor.blue
    //
    //    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        if  data.isEmpty && !isEditing {
            return
        }
        super.setEditing(editing, animated: animated)
        table.setEditing(editing, animated: animated)
    }
    
    //this is setting the last row "Add Note" as not editable
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if indexPath.row < data.count {
            return .delete
        }
        else {
            return .none
        }
    }
    
    //this is setting the last row "Add Note" as not moveable
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row < data.count
    }
    
    //this is where we delete rows
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.row < data.count {
            data.remove(at: indexPath.row)
            table.deleteRows(at: [indexPath], with: .left)
        }
        save()
        if data.isEmpty {
            isEditing = false
        }
    }
    
    //this is to not allow the rows to be rearranged under the last row
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if proposedDestinationIndexPath.section == 0 && proposedDestinationIndexPath.row >= data.count {
            return IndexPath(row: data.count-1, section: 0)
        }
        return proposedDestinationIndexPath
    }
    
    //allows cells to be moved/arranged
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.data[sourceIndexPath.row]
        data.remove(at: sourceIndexPath.row)
        data.insert(movedObject, at: destinationIndexPath.row)
    }
    
    //this is for detecting if we're tapping on the "add note" cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row >= data.count {
            addNote()
        }else {
            self.performSegue(withIdentifier: "detail", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailView:DetailViewController = segue.destination as! DetailViewController
        selectedRow = table.indexPathForSelectedRow!.row
        detailView.masterView = self
        if selectedRow < data.count {
            detailView.setText(t: data[selectedRow])
        }
    }
    
    func save(){
        
        let newData:NSArray = NSArray(array:data)
        newData.write(toFile: file, atomically: true)
    }
    
    func load(){
        if let loadedData = NSArray(contentsOfFile:file) as? [String] {
            data = loadedData
            table.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

