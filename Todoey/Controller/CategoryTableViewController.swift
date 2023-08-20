//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by 潘鹤群 on 2023/8/11.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import UIKit

import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
//    let defaults = UserDefaults.standard
    
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    
    
    var categories = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategoies()
    }
    //MARK: - TableView DataSource Methodes
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text  = categories[indexPath.row].name
        
        return cell
        
    }
    
    //MARK: - Data Manipulation Methods
    func saveCategory() {
        do{
            try context.save()
        } catch {
            print("Error in saving category\(error)")
        }
      tableView.reloadData()
    }
    
    func loadCategoies(){
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do{
            categories = try  context.fetch(request)
        } catch {
            print("error londing Categories \(error)")
        }
        tableView.reloadData()
    }
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
         
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
    
        let action = UIAlertAction(title: "Add Category", style: .default) { action in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categories.append(newCategory)
            
            self.saveCategory()
           
        }
        alert.addAction(action)
        
        alert.addTextField {  field in
            textField = field
            textField.placeholder = "Add a new category"
        }
        present(alert, animated:true, completion: nil)
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    
}

