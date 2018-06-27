//
//  ViewController.swift
//  Todoey
//
//  Created by POST MD on 5/30/18.
//  Copyright © 2018 Grinning Zen Media and Design. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {
    
    var todoItems: Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet{
            loadItems()

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
    }
    
    

    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            
            //ternary operator
            //value = condition ? valueIftrue : valueIfFalse
            //cell.accessoryType = item.done == true ? .checkmark : .none
            
            cell.accessoryType = item.done  ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
                
            }
        return cell

        }
    
    //MARK: - TableView Delagate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            do {
            try realm.write {
                item.done = !item.done
            }
        } catch {
            print("error saving done status, \(error)")
        }
        
    }
    
    tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
    var textField = UITextField()
        
    let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
        
        if let currentCategory = self.selectedCategory {
            do {
            try self.realm.write {
                let newItem = Item()
                newItem.title = textField.text!
                newItem.dateCreated = Date()
                currentCategory.items.append(newItem)
             }
            } catch {
                print("error saving new items \(error)")
                print("saved")
            }
        }
        
        self.tableView.reloadData()


        //let encoder = PropertyListEncoder()
        
//        do {
//            let data = try encoder.encode(self.itemArray)
//            try data.write(to: self.dataFilePath!)
//        } catch {
//            print("Error Encoding item array \(error) ")
//        }
        
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Model Manipulation Methods
    
//    func saveItems() {
//
//        do {
//           try  context.save()
//        } catch {
//            print("Error saving context\(error)")
//        }
//
//        self.tableView.reloadData()
//
//    }
    
    func loadItems() {
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

            tableView.reloadData()
    }
   
    }


//MARK: - Search Bar Methods
extension ToDoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
        
    }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchBar.text?.count == 0 {
            loadItems()

                DispatchQueue.main.async {
                    searchBar.resignFirstResponder()
                }

        }

    }
}




//DIRECTIONS
// 1. new property ITEM Model
//2. save data when we create new item in ToDoListeViewController
//3. aplt the sort in search bar methods
//4. make the items decsending from first create to most recent. 




