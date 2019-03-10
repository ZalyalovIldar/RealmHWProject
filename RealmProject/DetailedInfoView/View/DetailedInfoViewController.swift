//
//  DetailedInfoViewController.swift
//  RealmProject
//
//  Created by Петр on 28/02/2019.
//  Copyright © 2019 DreamTeam. All rights reserved.
//

import UIKit
import RealmSwift
import AVKit
import AVFoundation

class DetailedInfoViewController:
    UIViewController,
    DetailedInfoViewInput,
    UITextViewDelegate,
    UINavigationControllerDelegate {

    /// Edit button
    @IBOutlet weak var editButton: UIButton!
    
    /// Play video button
    @IBOutlet weak var playVideoButton: UIButton!
    
    /// Displays image
    @IBOutlet weak var mediaImageView: UIImageView!
    
    /// Displays current note
    @IBOutlet weak var textView: UITextView!
    
    /// Presenter
    var detailedInfoPresenter: DetailedInfoViewOutput!
    
    /// Current object
    var currentObject: Object!
    
    /// Current media type
    var currentMediaType: MediaType!
    
    /// Cache
    lazy var cachedDataSource: NSCache<AnyObject, UIImage> = {
    
        let cache = NSCache<AnyObject, UIImage>()
        return cache
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureView()
    }
    
    
    @IBAction func onEditButtonPressed(_ sender: Any) {
        
        guard let mediaType = currentMediaType else { return }
        
        switch mediaType {
            
        case .Photo:
            
            if let photo = currentObject as? Photo {
                detailedInfoPresenter.attachNewPhoto(photoId: photo.id)
            }
            
        case .Video:
            
            if let video = currentObject as? Video {
                detailedInfoPresenter.attachNewVideo(videoId: video.id)
            }
            
        default:
            break
        }
    }
    
    /// Handles play video button click
    ///
    /// - Parameter sender: button
    @IBAction func playVideoButtonPressed(_ sender: Any) {
        
        guard let video = currentObject as? Video else { return }

        let videoUrlPath = URL(fileURLWithPath: videoDirectoryPath).appendingPathComponent(video.videoPath)
        let player = AVPlayer(url: videoUrlPath)
        let vcPlayer = AVPlayerViewController()
        vcPlayer.player = player
        self.present(vcPlayer, animated: true, completion: nil)
    }
    
    
    /// Handles textview's editing
    ///
    /// - Parameter textView: text view
    func textViewDidEndEditing(_ textView: UITextView) {
        
        guard let note = currentObject as? Note else { return }
        detailedInfoPresenter.attachNewText(noteId: note.id, text: textView.text)
    }
  
    
    // MARK: - styles setters
    
    func configureView() {
        
        if let photo = currentObject as? Photo {
            
            self.navigationItem.title = photo.title
            currentMediaType = .Photo
            
            if let imagePath = photo.imageUrl {
                
                if let image = cachedDataSource.object(forKey: imagePath as AnyObject) {
                    mediaImageView.image = image
                }
                else {
                    detailedInfoPresenter.getImage(with: imagePath)
                }
            }
            else {
                mediaImageView.image = UIImage(data: photo.imageData)
            }
            
        }
        else if let video = currentObject as? Video {
            
            self.navigationItem.title = video.title
            currentMediaType = .Video
        }
        else if let note = currentObject as? Note {
            
            self.navigationItem.title = note.title
            currentMediaType = .Note
            textView.text = note.text
        }
        
        prepareView()
    }
    
    func prepareView() {
        
        guard let mediaType = currentMediaType else { return }
        
        switch mediaType {
            
        case .Note:
            mediaImageView.isHidden = true
            textView.isHidden = false
            playVideoButton.isHidden = true
            editButton.isHidden = true
            break
            
        case .Photo:
            mediaImageView.isHidden = false
            textView.isHidden = true
            playVideoButton.isHidden = true
            editButton.isHidden = false
            break
            
        case .Video:
            mediaImageView.isHidden = true
            textView.isHidden = true
            playVideoButton.isHidden = false
            editButton.isHidden = false
            break
        }
 
    }
    
    
    // MARK: - View Input
    
    func setImage(imageData: Data?, imageUrl: String?) {
        
        guard let currentImageData = imageData, let photoUrl = imageUrl else { return }
        
        let image = UIImage(data: currentImageData)
        cachedDataSource.setObject(image!, forKey: photoUrl as AnyObject)
        
        DispatchQueue.main.async {[weak self] in
            self?.mediaImageView.image = image
        }
        
    }

}
