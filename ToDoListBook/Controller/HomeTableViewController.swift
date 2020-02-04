//
//  ViewController.swift
//  ToDoListBook
//
//  Created by Mac on 1/25/20.
//  Copyright © 2020 JaKhushiTai. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var items = [ChecklistItem]()
    
    let dataFIlePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
     
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item1 = ChecklistItem()
        item1.text = "Walk the dog"
        items.append(item1)
        
        let item2 = ChecklistItem()
        item2.text = "Brush my teeth"
        item2.checked = true
        items.append(item2)
        
        let item3 = ChecklistItem()
        item3.text = "Learn iOS development"
        item3.checked = true
        items.append(item3)
        
        let item4 = ChecklistItem()
        item4.text = "Soccer practice"
        items.append(item4)
        
        let item5 = ChecklistItem()
        item5.text = "Eat ice cream"
        items.append(item5)
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String )
        print(items[0].text)
       
        //loadItem()
        // Do any additional setup after loading the view.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(items.count)
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lists", for: indexPath)
        let item = items[indexPath.row]
        // cell.textLabel?.text = "Cool Effects \(indexPath.row)"
//        let label = cell.viewWithTag(1000) as! UILabel
        cell.accessoryType = item.checked ? .checkmark : .none
        cell.textLabel?.text = item.text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let item  = items[indexPath.row]
        item.checked = !item.checked
        saveItem()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
//    func configureCheckmark( for cell: UITableViewCell, at indexPath: IndexPath){
//
//        let item  = items[indexPath.row]
//        item.checked = !item.checked
//        saveItem()
//        tableView.deselectRow(at: indexPath, animated: true)
//
//    }
    
    func saveItem() {
             let encoder = PropertyListEncoder()
              
             do {
                  let data = try encoder.encode(items)
                 try data.write(to: dataFIlePath!)
             } catch {
                 print("Error in saving item : \(error)")
             }

             self.tableView.reloadData()
         }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
           var textField = UITextField()
           let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
           let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
               if let text = textField.text {
                   let newItem = ChecklistItem()
                   newItem.text = text
                   self.items.append(newItem)
                   print("Success!")
                self.saveItem()

               }
                        
                    }
                    alert.addTextField { (alertTextField) in
                        alertTextField.placeholder = "Create new item"
                        textField = alertTextField
                    }
                    alert.addAction(action)
                    present(alert, animated: true, completion: nil)
                    
           
                }
    func loadItem() {
        if let data = try? Data(contentsOf: dataFIlePath!) {
            let decoder = PropertyListDecoder()
            do {
                items = try decoder.decode([ChecklistItem].self, from: data)
            } catch {
                print("Error in load item : \(error)")
            }
        }
        
        self.tableView.reloadData()
    }
                
}


        





