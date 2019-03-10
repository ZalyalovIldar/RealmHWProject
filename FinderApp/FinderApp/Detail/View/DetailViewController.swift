//
//  DetailViewController.swift
//  FinderApp
//
//  Created by Александр Арсенюк on 27/02/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import UIKit
import AVKit

class DetailViewController: UIViewController, DetailViewInputProtocol {
   

    @IBOutlet weak var textView: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var presenter: DetailViewOutputProtocol!
    var model: TypeOfObject?
    var dataManger: OperationsWithData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.unarchiveIncomingData(model: model!)
    }
    
    func setIncomingImage(image: Data) {
     
        imageView.image = dataManger.unarchive(object: image, with: UIImage())
    }
    
    func setIncomingText(text: String) {
       
        textView.text = text
    }
    
    func setIncomingVideo(video: Data) {
        
        imageView.image = dataManger.unarchive(object: video, with: UIImage())
    }
    
    @IBAction func editNameBarButtonItem(_ sender: Any) {
        
        presenter.editName(model: model!)
    }
    
    @IBAction func editContentBarButtonItem(_ sender: Any) {
        
        presenter.editContent(model: model!)
    }
    
    func presentAlert(alert: UIAlertController) {
        
        present(alert, animated: true, completion: nil)
    }
 }
