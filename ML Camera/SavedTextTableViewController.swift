//
//  SavedTextTableViewController.swift
//  ML Camera
//
//  Created by Saurabh Jaiswal on 4/24/19.
//  Copyright © 2019 Saurabh Jaiswal. All rights reserved.
//

import UIKit
import CoreData

class SavedTextTableViewController: UITableViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    
    var savedTextArr: [Textclass] = []
    var selectedRow: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.managedObjectContext = appDelegate.persistentContainer.viewContext
    

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        intializeTextSavedInDatabase()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return savedTextArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedTextCellIdentifier", for: indexPath)

        // Configure the cell...
 
        let row = indexPath.row
        let text = savedTextArr[row]
        cell.textLabel?.text = text.textInDatabase

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let textNote = savedTextArr[indexPath.row]
            let textNoteObject = textNote.textObjectID!
            
            
            let textFromCoreDatabase = managedObjectContext.object(with: textNoteObject)
            
            
            
            self.managedObjectContext.delete(textFromCoreDatabase)
            
            self.appDelegate.saveContext()
            savedTextArr.remove(at: indexPath.row)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
        performSegue(withIdentifier: "toViewText", sender: nil)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toViewText" {
            let viewTextVC = segue.destination as! ViewTextViewController
            viewTextVC.completeTextReceivedFromSegue = savedTextArr[self.selectedRow]
        }
    }
    
    func intializeTextSavedInDatabase() {
        var textData: Textclass!
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SavedText")
        
        var savedTextEntityData: [NSManagedObject]!
        do {
            savedTextEntityData = try self.managedObjectContext.fetch(fetchRequest)
            
        }
            
        catch {
            print("questionEntityData error: \(error)")
        }
        for data in savedTextEntityData {
            
            textData = Textclass()
           
        textData.textInDatabase =   data.value(forKey: "text") as! String
            
            textData.textObjectID = data.objectID
        
            
            
           
            savedTextArr.append(textData)
            
            
        }
    }
    
}
