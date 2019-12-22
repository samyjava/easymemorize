//
//  CardServiceTest.swift
//  EasyMemorizeTests
//
//  Created by Yasaman Farahani Saba on 12/21/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import XCTest
import RxSwift
import RealmSwift
import RxBlocking
@testable import EasyMemorize

class CardServiceTest: XCTestCase {
    var lessonService: LessonServiceType! = nil
    var cardService: CardServiceType! = nil
    var lessonForTest: LessonItem! = nil
    var cardForTest: CardItem! = nil
    var realm = try! Realm()

    override func setUp() {
        super.setUp()
        self.lessonService = LessonService()
        self.cardService = CardService()
        _ = self.lessonService.createLesson(title: "kadfft", image: nil, language: "en-us").toBlocking()
        self.lessonForTest = self.realm.objects(LessonItem.self).filter{$0.title == "kadfft"}.first!
        _ = self.cardService.createCard(word: "shdifluaif", definition: "LGIYDGFuytf", Lesson: lessonForTest).toBlocking()
        self.cardForTest = self.realm.objects(CardItem.self).filter{$0.word == "shdifluaif" && $0.definition == "LGIYDGFuytf"}.first!
        
    }

    override func tearDown() {
        lessonService = nil
        cardService = nil
        lessonForTest = nil
        cardForTest = nil
        super.tearDown()
    }
    
    func testCreateCard() {
        // Given
        _ = self.cardService.createCard(word: "zdfhjfxfjhgjg", definition: "jsdhfy", Lesson: self.lessonForTest).toBlocking()
        // When
        let testCard = realm.objects(CardItem.self).filter{$0.word == "zdfhjfxfjhgjg"}.first!
        // Then
        XCTAssertTrue(realm.objects(CardItem.self).contains(testCard), "Card found")
        XCTAssertEqual(testCard.lesson, self.lessonForTest, "Lesson property is equal")
        
        try! realm.write {
            realm.delete(testCard)
        }
    }
    
    func testEditCard() {
        // Given
        _ = self.lessonService.createLesson(title: "sjfdhafuahi", image: nil, language: "en-gb").toBlocking()
        let lessonForTest2 = self.realm.objects(LessonItem.self).filter{$0.title == "sjfdhafuahi"}.first!
        // When
        let editWord = try! self.cardService.edit(card: cardForTest, word: "liuYEFGASDG", definition: nil, lesson: nil).toBlocking().first()!
        let editDefinition = try! self.cardService.edit(card: cardForTest, word: nil, definition: "asdglfhjkgfhg", lesson: nil).toBlocking().first()!
        let editLesson = try! self.cardService.edit(card: cardForTest, word: nil, definition: nil, lesson: lessonForTest2).toBlocking().first()!
        // Then
        XCTAssertEqual(editWord.word, "liuYEFGASDG")
        XCTAssertEqual(editDefinition.definition, "asdglfhjkgfhg")
        XCTAssertEqual(editLesson.lesson, lessonForTest2)
        self.lessonService.delete(lesson: lessonForTest2)
    }
    
    func testDeleteCard() {
        // Given
        _ = self.cardService.createCard(word: "vligiSGDGFYSD", definition: "vligiSGDGFYSD", Lesson: self.lessonForTest).toBlocking()
        let cardForDeleteTest = self.realm.objects(CardItem.self).filter{$0.word == "vligiSGDGFYSD" && $0.definition == "vligiSGDGFYSD"}.first!
        // When
        self.cardService.delete(card: cardForDeleteTest)
        // Then
        XCTAssertTrue(self.realm.objects(CardItem.self).filter{$0.word == "vligiSGDGFYSD" && $0.definition == "vligiSGDGFYSD"}.count == 0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
