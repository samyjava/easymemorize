//
//  TextToSpeech.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 1/1/20.
//  Copyright © 2020 Dream Catcher. All rights reserved.
//

import Foundation
import Action
import AVFoundation

enum TextToSpeechServiceTypeError: Error {
    case urlError
    case playAudioError
}

protocol TextToSpeechServiceType {
    @discardableResult
    func textToSpeech() -> Action<TextToSpeechRequest,AVAudioPlayer?>
}
