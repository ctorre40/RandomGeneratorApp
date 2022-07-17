//
//  DetailViewController.swift
//  finalProject_czt0051
//
//  Created by Casandra Torres on 7/3/22.
//

import UIKit

class DetailViewController: UIViewController, UINavigationControllerDelegate {

    var masterViewController: MasterViewController!
    var itemIndex = 0


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    @IBAction func CancelButton(_ sender: UIButton) {
        if masterViewController.newFlag == true {
            masterViewController.objects.remove(at: itemIndex)
            masterViewController.tableView.reloadData()
            masterViewController.newFlag = false
        }
    }
    @IBAction func DeleteButton(_ sender: UIButton) {
        masterViewController.objects.remove(at: itemIndex)
        masterViewController.tableView.reloadData()
    }
    
    @IBAction func SaveButton(_ sender: UIButton) {
        masterViewController.newFlag = false
        masterViewController.objects[itemIndex]["Item"] = ItemField.text
        
        masterViewController.tableView.reloadData()
    }
    @IBOutlet weak var ItemField: UITextField!
    
    
    override func viewWillAppear(_ animated: Bool) {
        ItemField.text = masterViewController.objects[itemIndex]["Item"]
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
