//
//  StudentTableViewController.swift
//  Tracker
//
//  Created by Carlos Mendez on 12/7/18.
//  Copyright © 2018 Carlos Mendez. All rights reserved.
//

import UIKit

class StudentTableViewController: UITableViewController {
    
    var students = [StudentModel]()
    
    
    private func loadSampleStudents(){
        
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
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSampleStudents()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
