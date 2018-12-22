//
//  StudentTableViewController.swift
//  Tracker
//
//  Created by Carlos Mendez on 12/7/18.
//  Copyright © 2018 Carlos Mendez. All rights reserved.
//

import UIKit
import os.log
import RealmSwift

class StudentTableViewController: UITableViewController {
    
    var students = [StudentModel]()
    
    @IBAction func unwindToStudentList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? ViewController, let student = sourceViewController.student {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update
                students[selectedIndexPath.row] = student
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                //save
                let newIndexPath = IndexPath(row: students.count, section: 0)
                
                students.append(student)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                
                let studentDB = StudentDB()
                
                studentDB.name = student.name
                
                let realm = try! Realm()
                
                try! realm.write {
                    realm.add(studentDB)
                }
                
            }
                
        }
    }
        
    
    
    private func loadSampleStudents(){
        
        /*
        let photo1 = UIImage(named: "student1")
        let photo2 = UIImage(named: "student2")
        let photo3 = UIImage(named: "student3")
        
        guard let student1 = StudentModel(name: "Carlos", photo: photo1)
            else {
                fatalError("Unable to instantiate")
        }
        
        guard let student2 = StudentModel(name: "Natasha", photo: photo2)
            else {
                fatalError("Unable to instantiate")
        }
        
        guard let student3 = StudentModel(name: "Sofia", photo: photo3)
            else {
                fatalError("Unable to instantiate")
        }
 
        
        students += [student1,student2,student3]
         */
        
        let realm = try! Realm()
        
        var studentsDB = realm.objects(StudentDB.self)
        
        for item in studentsDB {
            students.append(StudentModel(name: item.name, photo: nil)!)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        loadSampleStudents()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return students.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "StudentTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? StudentTableViewCell
            else {
                fatalError("The dequeued cell is not an instance.")
        }
        
        let student  = students[indexPath.row]
        
        cell.lblName.text = student.name
        cell.imgPhoto.image = student.photo

        // Configure the cell...\

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        
        switch(segue.identifier ?? "") {
            
            case "AddItem":
                os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
            case "ShowDetail":
            
                guard let studentDetailViewController = segue.destination as? ViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
            
                guard let selectedStudentCell = sender as? StudentTableViewCell else {
                    fatalError("Unexpected sender: \(sender)")
                }
            
                guard let indexPath = tableView.indexPath(for: selectedStudentCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }
            
                let selectedStudent = students[indexPath.row]
                studentDetailViewController.student = selectedStudent
            
            
            default:
                fatalError("Unexpected Segue Identifier")
            }
        
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            students.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
