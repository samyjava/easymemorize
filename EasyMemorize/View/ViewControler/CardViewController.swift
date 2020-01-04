//
//  CardViewController.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 1/4/20.
//  Copyright © 2020 Dream Catcher. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import Action
import AVFoundation

class CardViewController: UIViewController {
    
    let bag = DisposeBag()
    
    @IBOutlet weak var frontText: UITextView!
    @IBOutlet weak var textToSpeech: UIStackView!
    var textToSpeechAction: Action<TextToSpeechRequest,AVAudioPlayer?>!
    var language: String!
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textToSpeech.rx.tapGesture().subscribe(onNext: {_ in
            let textToSpeechRequest = TextToSpeechRequest(text: self.frontText.text, language: self.language)
            self.textToSpeechAction.execute(textToSpeechRequest).subscribe(onNext: {player in
                self.player = player
                self.player.play()
            }).disposed(by: self.bag)
            }).disposed(by: bag)
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
