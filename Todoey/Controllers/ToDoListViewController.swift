//
//  ViewController.swift
//  Todoey
//
//  Created by POST MD on 5/30/18.
//  Copyright © 2018 Grinning Zen Media and Design. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    var selectedCategory : Category? {
        didSet{
            //loadItems()

        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
    }
    
    

    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //ternary operator
        //value = condition ? valueIftrue : valueIfFalse
        //cell.accessoryType = item.done == true ? .checkmark : .none
        
        cell.accessoryType = item.done  ? .checkmark : .none

        
        //the code above equals the code below.
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//
//        }
        
        
        return cell
    }
    
    //MARK: - TableView Delagate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        
        //this code below it to delete and then remove checked items from core data. 
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        self.saveItems()
        
        //the code below is the same as the line of code above. the ! = not operator.
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
    var textField = UITextField()
        
    let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
        
        // what will happen once the user clicks the add item button on our UIAlert
        
//with the code below. the ITEM = NS Magaged object column. the TITLE Field = row as do any others. It then saves in CONTEXT, the temporary/staging/intermediate area before saving to the the actual persistent container/core data.
        
//        let newItem = Item(context: self.context)
//        newItem.title = textField.text!
//        newItem.done = false
//        newItem.parentCategory = self.selectedCategory
//       self.itemArray.append(newItem)
        
        self.saveItems()
        
        print("saved")

        //let encoder = PropertyListEncoder()
        
//        do {
//            let data = try encoder.encode(self.itemArray)
//            try data.write(to: self.dataFilePath!)
//        } catch {
//            print("Error Encoding item array \(error) ")
//        }
        
        self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Model Manipulation Methods
    
    func saveItems() {
        
        do {
           try  context.save()
        } catch {
            print("Error saving context\(error)")
        }
        
        self.tableView.reloadData()

    }
    
//    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
//
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let additionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//        } else {
//            request.predicate = categoryPredicate
//        }
//
//        do {
//            itemArray = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
//
//            tableView.reloadData()
//    }
   
    }


//MARK: - Search Bar Methods
//extension ToDoListViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        //print(searchBar.text!)
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadItems(with: request, predicate: predicate)
//    }
//
//        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//            if searchBar.text?.count == 0 {
//            loadItems()
//
//                DispatchQueue.main.async {
//                    searchBar.resignFirstResponder()
//                }
//
//        }
//
//    }



    

    




