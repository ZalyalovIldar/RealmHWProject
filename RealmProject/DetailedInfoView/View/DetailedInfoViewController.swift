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

class DetailedInfoViewController:
    UIViewController,
    DetailedInfoViewInput,
    UITextViewDelegate,
    UINavigationControllerDelegate {

    /// Edit button
    @IBOutlet weak var editButton: UIButton!
    
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
            break
            
        case .Video:
            
            if let video = currentObject as? Video {
                detailedInfoPresenter.attachNewVideo(videoId: video.id)
            }
            break
            
        default:
            break
        }
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        guard let note = currentObject as? Note else { return }
        detailedInfoPresenter.attachNewText(noteId: note.id, text: textView.text)
    }
    
    // MARK: - styles setters
    
    func configureView() {
        
        if let photo = currentObject as? Photo {
            
            hideTextView()
            self.navigationItem.title = photo.title
            currentMediaType = .Photo
            mediaImageView.image = UIImage(data: photo.imageData)
        }
        else if let video = currentObject as? Video {
            
            hideTextView()
            self.navigationItem.title = video.title
            currentMediaType = .Video
            guard let imagePreview = videoSnapshot(filePathLocal: video.videoPath) else { return }
            mediaImageView.image = imagePreview
        }
        else if let note = currentObject as? Note {
            
            hideMediaImageView()
            self.navigationItem.title = note.title
            currentMediaType = .Note
            textView.text = note.text
        }
    }
    
    
    /// Prepares view for text content
    func hideMediaImageView() {
        
        mediaImageView.isHidden = true
        textView.isHidden = false
        editButton.isHidden = true
    }
    
    
    /// Prepares view for media content
    func hideTextView() {
        
        mediaImageView.isHidden = false
        textView.isHidden = true
        editButton.isHidden = false
    }
    
    
    /// Returns video snapshot
    ///
    /// - Parameter filePathLocal: path to video
    /// - Returns: UIImage snapshot
    func videoSnapshot(filePathLocal: String) -> UIImage? {
    
        let vidURL = URL(fileURLWithPath:filePathLocal as String)
        let asset = AVURLAsset(url: vidURL)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        
        do {
            let imageRef = try generator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
            return UIImage(cgImage: imageRef)
        }
        catch let error as NSError
        {
            print("\nImage generation failed with error \(error)")
            return nil
        }
    }
}
