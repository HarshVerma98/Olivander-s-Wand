//
//  SpellDetailViewController.swift
//  The_Olivander's Wand
//
//  Created by Harsh Verma on 19/05/20.
//  Copyright © 2020 Harsh Verma. All rights reserved.
//

import UIKit
import AVFoundation
class SpellDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var spellData: SpellData!
    var sudioPlayer: AVAudioPlayer!
    var nameX: CGFloat!
    var descriptionX: CGFloat!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if spellData == nil {
            spellData = SpellData(name: "", description: "", soundFile: "")
        }
        nameX = nameLabel.frame.origin.x
        descriptionX = descriptionLabel.frame.origin.x
        nameLabel.frame.origin.x = self.view.frame.width
        descriptionLabel.frame.origin.x = self.view.frame.width
        
        updateUI()
        
    }
    
    func updateUI() {
        
        nameLabel.text = spellData.name
        descriptionLabel.text = spellData.description
        UIView.animate(withDuration: 0.5, animations: {self.nameLabel.frame.origin.x = self.nameX})
        
        UIView.animate(withDuration: 0.5, animations: {self.descriptionLabel.frame.origin.x = self.descriptionX})
    }
    
    func playSound(name: String) {
        
        if let sound = NSDataAsset(name: name) {
            
            do {
                sudioPlayer = try AVAudioPlayer(data: sound.data)
                sudioPlayer.play()
            }catch {
                print(error.localizedDescription)
            }
            
        } else {
            print("Error:- Cant read from assets\(name)")
        }
        
    }
    
    func castSpell() {
        playSound(name: spellData.soundFile)
        UIView.animate(withDuration: 0.1, delay: 1.0, animations: {self.view.backgroundColor = UIColor.red}) { (done) in
            self.view.backgroundColor = .white
        }
        
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        castSpell()
    }
    
    @IBAction func swipeGesture(_ sender: UISwipeGestureRecognizer) {
        
        castSpell()
    }
}
