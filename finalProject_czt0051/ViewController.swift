//
//  MasterViewController.swift
//  finalProject_czt0051
//
//  Created by Casandra Torres on 7/3/22.
//

import UIKit

class MasterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var newFlag = false;
    var objects: [[String:String]] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func NewItemButton(_ sender: UIButton) {
    }
    
    @IBAction func EditButton(_ sender: UIButton) {
        tableView.isEditing = !tableView.isEditing
        if sender.currentTitle == "Done"{
            sender.setTitle("Edit", for: .normal)
        }
        else{
            sender.setTitle("Done", for: .normal)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let object = objects[indexPath.row]
        cell.textLabel!.text = object["Item"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let objectToBeMoved = objects[sourceIndexPath.row]
        objects.remove(at: sourceIndexPath.row)
        objects.insert(objectToBeMoved, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    func dataFileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var url:URL?
        url = URL(fileURLWithPath: "")
        url = urls.first!.appendingPathComponent("data.plist")
        return url!
    }
    
    @objc func applicationWillResignActive(notification: NSNotification) {
        let fileUrl = self.dataFileURL()
        let array = (self.objects as NSArray)
        array.write(to: fileUrl as URL, atomically: true)
        print("Data has been saved!")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let file = dataFileURL()
        print (file)
        if (FileManager.default.fileExists(atPath: file.path)){
            objects = ((NSArray(contentsOfFile: file.path)) as? [[String:String]])!
        }
        else{
            print("No File Found")
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillResignActive(notification:)), name:
            UIApplication.willResignActiveNotification, object: nil)
    }
    
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue){
        //tableView.reloadData()
    }
    
    @IBOutlet weak var RandomLabel: UILabel!
    
    @IBAction func RandomButton(_ sender: UIButton) {
        //let randomIndex = Int(arc4random_uniform(UInt32(objects.count)))
        //let randomItem = self.objects[randomIndex]
        //let randomItem = objects.randomElement()

        if objects.isEmpty == false {
            let randomIndex = Int(arc4random_uniform(UInt32(objects.count)))
            let randomItem = self.objects[randomIndex]
            print(randomItem)
            //RandomLabel.text = "\(String(describing: randomItem))"
            //let randomText = RandomLabel.text
            //let randomText = String(decoding: randomItem!, as: UTF8.self)
            let msg = "\(String(describing: randomItem))"
            let controller2 = UIAlertController(title: "Your Item is: ", message: msg, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            controller2.addAction(okAction)
            self.present(controller2,animated: true, completion: nil)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let controller = (segue.destination as! DetailViewController)
        controller.masterViewController = self
        if segue.identifier == "ShowDetail" {
            if let indexPath = tableView.indexPathForSelectedRow{
                controller.itemIndex = indexPath.row
            }
        }
        else { // New Segue
            controller.itemIndex = 0
            objects.insert(["Item": "New Item"], at: 0)
            newFlag = true
        }
    }


}
