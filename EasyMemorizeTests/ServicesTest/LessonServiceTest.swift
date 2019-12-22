//
//  EasyMemorizeTests.swift
//  EasyMemorizeTests
//
//  Created by Yasaman Farahani Saba on 11/25/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import XCTest
import Foundation
import RxTest
import RxBlocking
import RealmSwift
@testable import EasyMemorize

class LessonServiceTest: XCTestCase {
    var lessonService: LessonServiceType! = nil
    var lessonForTest: LessonItem! = nil
    var cardService: CardServiceType! = nil
    
    var realm = try! Realm()

    override func setUp() {
        super.setUp()
        self.lessonService = LessonService()
        self.cardService = CardService()
        _ = self.lessonService.createLesson(title: "Tjhlfiayftyugf", image: nil, language: "en-gb").toBlocking()
        self.lessonForTest = realm.objects(LessonItem.self).filter{$0.title == "Tjhlfiayftyugf"}.first!
    }

    override func tearDown() {
        _ = lessonService.delete(lesson: lessonForTest).toBlocking()
        lessonService = nil
        lessonForTest = nil
        cardService = nil
        super.tearDown()
    }
    
    func testCreateLesson() {
        var randomTitle = "jgkjgkhgkgkjgkjgkj"
        _ = self.lessonService.createLesson(title: randomTitle, image: nil, language: "en-us").toBlocking()
        let lesson = realm.objects(LessonItem.self).filter{$0.title == randomTitle}.first!
        defer {
            do {
                try realm.write {
                    realm.delete(lesson)
                }
            }
            catch let error {
                print(error)
            }
        }
        XCTAssertNil(lesson.image)
        XCTAssertEqual(lesson.title, randomTitle)
        XCTAssertEqual(lesson.language, "en-us")
        
    }
    
    func testEditLesson() {
        let _ = self.lessonService.createLesson(title: "hGkuysdkuyf", image: nil, language: "en-gb").toBlocking()
        let lesson = realm.objects(LessonItem.self).filter {$0.title == "hGkuysdkuyf"}.first!
        self.lessonService.edit(lesson: lesson, title: "jhsdga", image: nil, language: "de-de")
        let editedLesson = realm.objects(LessonItem.self).filter {$0.title == "jhsdga"}
        XCTAssert(realm.objects(LessonItem.self).filter {$0.title == "hGkuysdkuyf"}.count == 0)
        XCTAssert(editedLesson.count == 1)
        try! realm.write {
            realm.delete(editedLesson)
            realm.delete(lesson)
        }
    }
    
    func testDeleteLesson() {
        let _ = self.lessonService.createLesson(title: "hkhaskdh", image: nil, language: "en-us").toBlocking()
        let lesson = realm.objects(LessonItem.self).filter {$0.title == "hkhaskdh"}.first!
        do {
            let _ = try self.lessonService.delete(lesson: lesson).toBlocking().first()
        } catch LessonServiceError.deletionFailed(let lesson2){
            XCTAssertEqual(lesson.id, lesson2.id)
        } catch {
            XCTFail()
        }
        XCTAssert(realm.objects(LessonItem.self).filter{$0.title == "hkhaskdh"}.count == 0)
    }
    
    func testFetchAllLesson() {
        let allLesson = try! self.lessonService.fetchAllLesson().toBlocking().first()
        let lessons = self.realm.objects(LessonItem.self)
        XCTAssertEqual(allLesson!.count, lessons.count)
    }
    
    func testAssignCardToLesson() {
        // Given
        _ = self.cardService.createCard(word: "gdyufg", definition: "ahaiutey", Lesson: self.lessonForTest).toBlocking()
        // When
        let cardForTest = realm.objects(CardItem.self).filter{$0.word == "gdyufg"}.first!
        // Then
        XCTAssertTrue(lessonForTest.cards.contains(cardForTest))
        
        try! realm.write {
            realm.delete(cardForTest)
        }
    }
    


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
