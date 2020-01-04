//
//  TextToSpeechServiceTest.swift
//  EasyMemorizeTests
//
//  Created by Yasaman Farahani Saba on 1/1/20.
//  Copyright © 2020 Dream Catcher. All rights reserved.
//

import XCTest
import RxSwift
@testable import EasyMemorize

class TextToSpeechServiceTest: XCTestCase {
    
    var textToSpeechService: TextToSpeechServiceType! = nil

    override func setUp() {
        super.setUp()
        self.textToSpeechService = TextToSpeechService()
    }

    override func tearDown() {
        textToSpeechService = nil
        super.tearDown()
    }
    
    /*func testTextToSpeech() {
        // Given
        // When
        do {
        let x = try self.textToSpeechService.textToSpeech(for: "Hello my dear sam", language: "en-us").toBlocking().first()
        } catch {
            XCTFail()
        }
        // Then
        
    }*/

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
