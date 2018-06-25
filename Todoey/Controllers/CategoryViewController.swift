//
//  CategoryViewController.swift
//  Todoey
//
//  Created by POST MD on 6/9/18.
//  Copyright © 2018 Grinning Zen Media and Design. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categoryArray = [Category]()

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadCategories()

    }
    
    //MARK: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name

        
        //cell.textLabel?.text = categories[indexPath.row].name
        
        return cell

    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
            
        }
    }
    
    
    
    //MARK: - Data Manipulation Methods
    //for CRUD
    func save(category: Category) {
            
            do {
                try  realm.write {
                     realm.add(category)
                }
            } catch {
                print("Error saving category\(error)")
            }
            
            self.tableView.reloadData()
            
        }
    
    //IN Video, Angela's solution
   
    
    func loadCategories() {
//    let request : NSFetchRequest<Category> = Category.fetchRequest()
//
//    do {
//    categoryArray = try context.fetch(request)
//    } catch {
//    print("Error loading categories \(error)")
//    }
//
//    tableView.reloadData()
    
        //my solution, BUT this solution worked
//        func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
//
//            do {
//                categoryArray = try context.fetch(request)
//            } catch {
//                print("Error loading categories \(error)")
//            }
//
//            tableView.reloadData()
        }

    
    //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.categoryArray.append(newCategory)
            
            self.save(category: newCategory)
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add new category"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        }

    
    
    
    
    
    
}



