//
//  ViewController.swift
//  coreDataDemo
//
//  Created by MSC_INDIA on 06/06/24.
//

import UIKit
class ViewController: UIViewController {
    var employees: [Employee] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "labelcell")

            // Set the table view's style to .subtitle
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 44 // Or set a proper estimated row height
            tableView.separatorStyle = .none
        
        createEmployee()
        
        //updateEmployee()
       fetchEmployee()
       let indexPath = IndexPath(row: 0, section: 0) // Example index path, replace it with the actual index path you want to delete
        //deleteEmployee(at: indexPath)
       //fetchEmployee()
    }
    func createEmployee()
    {
        let employee=Employee(context:PersistentStorage.shared.context)
        employee.name="swathi"
        employee.salary = 9000000
        employee.id=1
        employee.age=22
        PersistentStorage.shared.saveContext()
    }
    @IBOutlet weak var tableView: UITableView!
    func fetchEmployee() {
        do {
            guard let result = try PersistentStorage.shared.context.fetch(Employee.fetchRequest()) as? [Employee] else {
                return
            }
            self.employees = result // Store fetched results into the class-level array
            self.tableView.reloadData() // Reload table view to reflect changes
        } catch let error {
            debugPrint(error)
        }
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelcell", for: indexPath)
        let employee = employees[indexPath.row]
        
        // Set name
        cell.textLabel?.text = employee.name
        
        // Set detail text
        let detailText = "ID: \(employee.id ?? 0), Salary: \(employee.salary ?? 0), Age: \(employee.age ?? 0)"
        cell.detailTextLabel?.text = detailText
        
        // Set text color
        cell.textLabel?.textColor = .black // Or any other color you prefer
        
        // Set font style
        cell.textLabel?.font = UIFont.systemFont(ofSize: 25, weight: .regular) // Adjust font size and weight as needed
        
        // Set background color
        cell.backgroundColor = .clear // Clear background color
        
        // Add rounded corners and shadow
        cell.contentView.layer.cornerRadius = 30 // Adjust corner radius as needed
        cell.contentView.layer.masksToBounds = true
        
        cell.contentView.layer.borderWidth = 1.0 // Add border
        cell.contentView.layer.borderColor = UIColor.systemPink.cgColor // Border color
        
        // Add shadow
        cell.layer.shadowColor = UIColor.blue.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowOpacity = 0.3
        cell.layer.shadowRadius = 9.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }
    
    func updateEmployee() {
        // For demonstration purposes, let's update the first employee in the array
        
        // Update employee's name
        let employee=Employee(context:PersistentStorage.shared.context)
        employee.name = "bharathi"
        
        // Save changes
        PersistentStorage.shared.saveContext()
        
        // Reload table view
        tableView.reloadData()
    }
    
    func deleteEmployee(at indexPath: IndexPath) {
        let employee = employees[indexPath.row] // Retrieve the employee object from the array
        
        // Remove employee from the array
        employees.remove(at: indexPath.row)
        
        // Delete employee from Core Data context
        PersistentStorage.shared.context.delete(employee)
        
        // Save changes
        PersistentStorage.shared.saveContext()
    }
}


