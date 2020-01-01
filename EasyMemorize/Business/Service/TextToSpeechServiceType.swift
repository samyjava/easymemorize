//
//  TextToSpeech.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 1/1/20.
//  Copyright © 2020 Dream Catcher. All rights reserved.
//

import Foundation
import RxSwift

protocol TextToSpeechServiceType {
    @discardableResult
    func textToSpeech() -> Completable
}
