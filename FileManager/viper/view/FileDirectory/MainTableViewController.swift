//
//  MainTableViewController.swift
//  FileManager
//
//  Created by Гузель on 02/03/2019.
//  Copyright © 2019 Гузель. All rights reserved.
//

import UIKit
import RealmSwift

class MainTableViewController: UITableViewController, FileDirectoryInput {

    @IBOutlet weak var nameOfDirectoryNavigationItem: UINavigationItem!
    var presenter: FileDirectoryOutput!
    var mainFolder: FolderModel!
    var item: FolderModel!
    var items: [Object] = []
    var cellText = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloading()
        pullToRefresh()
    }
    
    func pullToRefresh(){
        
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action:  #selector(reloading), for: UIControl.Event.valueChanged)
    }
    
    @objc func reloading() {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if item == nil {
            print(mainFolder)
            presenter.getMainFolder()
        }
    }

    // MARK: - Table view data source
    
    //5
    func initMainFolder(mainFolder: FolderModel) {
        self.mainFolder = mainFolder
        initItem(item: mainFolder)
    }
    //6
    func initItem(item: FolderModel) {
        
        items = []
        self.item = item
        self.items = (Array(item.folders!) as [Object])
            + (Array(item.media!) as [Object])
            + (Array(item.textFiles!) as [Object])
        self.nameOfDirectoryNavigationItem.title = item.name
        self.tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let folder = items[indexPath.row] as? FolderModel {
            
            cell.nameLabel?.text = folder.name
            cell.timeLabel?.text = dateFormatter.string(from: folder.time)
            cell.typeLabel.text = (Type.folder).rawValue
        }
        if let text = items[indexPath.row] as? TextFileModel {
            
            cell.nameLabel?.text = text.name
            cell.timeLabel?.text = dateFormatter.string(from: text.time)
            cell.typeLabel.text = (Type.text).rawValue
        }
        if let media = items[indexPath.row] as? MediaModel {
            
            cell.nameLabel?.text = media.name
            cell.timeLabel?.text = dateFormatter.string(from: media.time)
            cell.typeLabel.text = (Type.media).rawValue
        }
        presenter.obtainWeight(item: items[indexPath.row])
        cell.weightLabel.text = cellText + "KБ"
        
        return cell
    }
    
    func initCellWeight(text: String) {
        self.cellText = text
    }
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        presenter.showAlert(item: item)
        print(item)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
        
        switch cell.typeLabel.text {
            
        case (Type.folder).rawValue:
            presenter.showFolder(item: items[indexPath.row] as! FolderModel)
        case (Type.text).rawValue:
            presenter.showText(item: items[indexPath.row] as! TextFileModel)
        case (Type.media).rawValue:
            presenter.showMedia(item: items[indexPath.row] as! MediaModel)
        default:
            return
        }
    }
    

    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            self.presenter.deleteItem(self.items[indexPath.row], self.item)
            self.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPaths) in
            self.presenter.showEditNameAlert(self.items[indexPath.row], self.item)
            tableView.reloadData()
        }
        
        return [delete, edit]
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
