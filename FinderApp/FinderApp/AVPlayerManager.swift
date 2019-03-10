//
//  AVPlayerManager.swift
//  FinderApp
//
//  Created by Александр Арсенюк on 03/03/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation
import AVKit

/// протокол работы с плеером
protocol AVPlayerManagerProtocol {
    
    /// создать плеер
    ///
    /// - Parameter data: передаваемая инфа для воспроизведения
    func setPlayer(data: Data)
    
}

class AVPlayerManager: AVPlayerManagerProtocol {
    
   
    weak var detailViewController: DetailViewController!
    weak var view: DetailViewInputProtocol!
    var dataManager: OperationsWithData!
    
    
    func setPlayer(data: Data) {
        
         let str = data.hashValue
       
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(String(str)+".mp4")
        print(paths)
        let url = URL(fileURLWithPath: paths)
        let player = AVPlayer(url: url )
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = detailViewController.view.bounds
        detailViewController.view.layer.addSublayer(playerLayer)
        player.play()
        
    }
}
