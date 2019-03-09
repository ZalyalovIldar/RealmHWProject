//
//  FilesViewController.swift
//  RealmProject
//
//  Created by Петр on 27/02/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import UIKit
import RealmSwift

class FilesViewController:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate,
    FilesViewInput {
    
    /// Table view
    @IBOutlet weak var tableView: UITableView!
    
    /// Presenter
    var filesPresenter: FilesViewOutput!
    
    /// Cell spacing
    let cellSpacingHeight: CGFloat = 5
    
    /// Row height
    let estimatedRowHeight = 120
    
    /// Current folder id
    var currentFolderId: String? 
    
    /// Data for cells
    var items: [Object]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = CGFloat(estimatedRowHeight)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if currentFolderId == nil {
            filesPresenter.getRootFolder()
        }
        else {
            getDataForCells()
        }
    }
    
    
    // MARK: - Buttons handler
    
    @IBAction func editButtonPressed(_ sender: Any) {
        tableView.isEditing = !tableView.isEditing
    }
    
    @IBAction func addFolderButtonPressed(_ sender: Any) {
        filesPresenter.addFolder(folderId: currentFolderId)
    }
    
    @IBAction func addNoteButtonPressed(_ sender: Any) {
        filesPresenter.addNote(folderId: currentFolderId)
    }
    
    @IBAction func addPhotoButtonPressed(_ sender: Any) {
        filesPresenter.handleAddMediaButtonPressed(type: .Photo)
    }
    
    @IBAction func addVideoButtonPressed(_ sender: Any) {
        filesPresenter.handleAddMediaButtonPressed(type: .Video)
    }
    
    
    // MARK: - Table data configurator
    
    func getDataForCells() {
        filesPresenter.getFolder(with: currentFolderId)
    }
    
    
    // MARK: - Files View Input
    
    func setFolder(folder: Folder?) {
        
        guard let currentFolder = folder else { return }
        
        currentFolderId = currentFolder.id
        
        if currentFolder.isRootFolder {
            self.navigationItem.title = rootFolderTitle
        }
        else {
            self.navigationItem.title = currentFolder.title
        }
        
        DispatchQueue.main.async {[weak self] in
            
            guard let self = self else { return }
            
            self.items = (Array(currentFolder.folders) as [Object])
                + (Array(currentFolder.photos) as [Object])
                + (Array(currentFolder.videos) as [Object])
                + (Array(currentFolder.notes) as [Object])
            
            self.tableView.reloadData()
        }
        
    }

    
    // MARK: - Table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifires.Cell.rawValue, for: indexPath) as! FilesTableViewCell
        
        cell.configureCell(object: items[indexPath.row])
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentObject = items[indexPath.row]
        
        if let folder = currentObject as? Folder {
            
            let viewController = storyboard?.instantiateViewController(withIdentifier: Identifires.FilesViewController.rawValue) as! FilesViewController
            viewController.currentFolderId = folder.id
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        else {
            
            let viewController = storyboard?.instantiateViewController(withIdentifier: Identifires.DetailedInfoViewController.rawValue) as! DetailedInfoViewController
            viewController.currentObject = currentObject
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            filesPresenter.deleteObject(object: items[indexPath.row])
            self.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}
