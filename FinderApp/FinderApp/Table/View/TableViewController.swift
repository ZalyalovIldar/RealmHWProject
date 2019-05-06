//
//  TableViewController.swift
//  FinderApp
//
//  Created by Александр Арсенюк on 26/02/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import UIKit
import Realm
import Photos
import MobileCoreServices
import AVKit

class TableViewController: UIViewController,
                           UITableViewDelegate,
                           UITableViewDataSource,
UIImagePickerControllerDelegate,UINavigationControllerDelegate, TableViewInputProtocol{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var emptyTableView: UITableView!
    var imagePicker: UIImagePickerController!
    var newImage: UIImage?
    var videoURL: URL?
    var isImage: Bool?
    var globalURL: URL?
    
    var dbManager: DataBaseManagerProtocol!
    var dataManager: OperationsWithDataProtocol!
    var presenter: TableViewOutputProtocol!
   
    let currentFolder = Folder()
    let cellIdentifier = "cell"
    let selfIdentifier = "self"
    let detailIdentifier = "detail"
    let folderType = "folder"
    
    
    override func viewDidLoad() {
       super.viewDidLoad()
       
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
     }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let models: [TypeOfObject]  = dbManager.obtaimModelsWithId(id: currentFolder.id)
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let models: [TypeOfObject]  = dbManager.obtaimModelsWithId(id: currentFolder.id)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
        let customCell = models[indexPath.row]
        
        cell.cellImage.image = dataManager.unarchive(object: customCell.picture, with: UIImage())
        cell.nameLabel.text = customCell.name
        cell.sizeOfContent.text = customCell.content.discribe()
        cell.dateOfCreate.text = String(customCell.dateOfCreate.description.dropLast(6))
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == detailIdentifier, let model = sender as? TypeOfObject {
            let destinationController = segue.destination as! DetailViewController
            destinationController.model = model
        }
        if segue.identifier == selfIdentifier, let model = sender as? TypeOfObject {
            let destinationController = segue.destination as! TableViewController
            
            destinationController.currentFolder.id = model.id
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let models: [TypeOfObject]  = dbManager.obtaimModelsWithId(id: currentFolder.id)
        if editingStyle == .delete {
            dbManager.removeModel(model: models[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
       
        return true
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let models: [TypeOfObject]  = dbManager.obtaimModelsWithId(id: currentFolder.id)
        let cell = models[indexPath.row]
        
        if cell.type == folderType {
            performSegue(withIdentifier: selfIdentifier, sender: cell)
        } else {
         performSegue(withIdentifier: detailIdentifier, sender: cell)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
       
        return true
    }
    
  
    func updateTableView(models: [Any]) {
        
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath(row: models.count - 1, section: 0)], with: UITableView.RowAnimation.top)
        self.tableView.endUpdates()
    }
    
    func obtainFolderImage() -> UIImage { return #imageLiteral(resourceName: "folder") }
    
    func obtainPictureImage() -> UIImage { return #imageLiteral(resourceName: "photo") }
    
    func obtainVideoImage() -> UIImage { return #imageLiteral(resourceName: "video") }
    
    func obtainNoteImage() -> UIImage { return #imageLiteral(resourceName: "pen") }
    
    func obtainTableVIew() -> UITableView {
        
        return self.tableView
    }
   
    @IBAction func createFolderButton(_ sender: Any) {
        
        presenter.requestForNewFolder()
    }
    
    @IBAction func createPictureButton(_ sender: Any) {
     
        presenter.requestForNewImage()
    }
    
    @IBAction func createVideoButton(_ sender: Any) {
       
        presenter.requestForNewVideo()
    }

    @IBAction func createNoteButton(_ sender: Any) {
        
        presenter.requestForNewNote()
    }
    @IBAction func clearAllButtonPressed(_ sender: Any) {
        
        dbManager.clearAll()
        tableView.reloadData()
    }
    
}

