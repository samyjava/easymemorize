//
//  TextToSpeechService.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 1/1/20.
//  Copyright © 2020 Dream Catcher. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import AVFoundation
import Action


struct TextToSpeechRequest {
    let text: String
    let language: String
}


struct TextToSpeechService: TextToSpeechServiceType {
    
    let bag = DisposeBag()
    let baseURL = "https://api.voicerss.org/"
    let apiKey = "3b0090e839cc40619ce40d7ec46d727c"
    
    func textToSpeech() -> Action<TextToSpeechRequest,AVAudioPlayer?> {
        return Action { request -> Observable<AVAudioPlayer?> in
            guard var urlComponents = URLComponents(string: self.baseURL) else {
                return Observable.just(nil)
            }
            let keyQuery = URLQueryItem(name: "key", value: self.apiKey)
            let hlQuery = URLQueryItem(name: "hl", value: request.language)
            let cQuery = URLQueryItem(name: "c", value: "MP3")
            let srcQuery = URLQueryItem(name: "src", value: request.text)
            
            urlComponents.queryItems = [keyQuery, hlQuery,cQuery, srcQuery]
            
            guard let url = urlComponents.url else {
                return Observable.just(nil)
            }
            
            let subject = PublishSubject<AVAudioPlayer?>()
            var player: AVAudioPlayer!
            URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
                guard let data = data , error == nil else {
                    subject.onNext(nil)
                    return
                }
                if let response = urlResponse as? HTTPURLResponse, response.statusCode == 200 {
                    do {
                        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                        try AVAudioSession.sharedInstance().setActive(true)
                        
                        player = try AVAudioPlayer(data: data, fileTypeHint: AVFileType.mp3.rawValue)
                        
                        subject.onNext(player)
                    } catch {
                        subject.onNext(nil)
                    }
                }else {
                    subject.onNext(nil)
                }
            }.resume()
            return subject.asObserver()
        }
    }
}
