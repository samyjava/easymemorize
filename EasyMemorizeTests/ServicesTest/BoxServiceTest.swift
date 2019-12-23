//
//  BoxServiceTest.swift
//  EasyMemorizeTests
//
//  Created by Yasaman Farahani Saba on 12/22/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import XCTest
import RxSwift
import RealmSwift
import RxBlocking
@testable import EasyMemorize

class BoxServiceTest: XCTestCase {
    var boxService: BoxServiceType! = nil
    var cardService: CardServiceType! = nil
    var lessonService: LessonServiceType! = nil
    var lessonForTest: LessonItem! = nil
    var realm: Realm! = nil

    override func setUp() {
        super.setUp()
        self.realm = try! Realm()
        self.boxService = BoxService()
        self.cardService = CardService()
        self.lessonService = LessonService()
        _ = self.lessonService.createLesson(title: "dgdfsjsfhkfhjll", image: nil, language: "en-us").toBlocking()
        self.lessonForTest = self.realm.objects(LessonItem.self).filter{$0.title == "dgdfsjsfhkfhjll"}.first!
    }

    override func tearDown() {
        boxService = nil
        cardService = nil
        lessonService = nil
        lessonForTest = nil
        realm = nil
        super.tearDown()
    }
    
    func testCreateBox() {
        // Given
        _ = self.boxService.createBox(no: 1000, waitingTime: 20000).toBlocking()
        // When
        let box1000 = self.realm.objects(BoxItem.self).filter{$0.boxNumber == 1000 && $0.waitingTime == 20000}.first!
        // Then
        XCTAssertTrue(self.realm.objects(BoxItem.self).filter{$0.boxNumber == 1000}.count == 1)
        XCTAssertTrue(self.realm.objects(BoxItem.self).filter{$0.waitingTime == 20000}.count == 1)
        
        try! self.realm.write {
            realm.delete(box1000)
        }
    }
    
    func testResetBoxes() {
        // Given
        _ = self.boxService.createBox(no: 8001, waitingTime: 800).toBlocking() //create Box8001
        _ = self.boxService.createBox(no: 8002, waitingTime: 820).toBlocking() //create Box8002
        _ = self.boxService.createBox(no: 8003, waitingTime: 830).toBlocking() //create Box8003
        _ = self.boxService.createBox(no: 8004, waitingTime: 840).toBlocking() //create Box8004
        _ = self.boxService.createBox(no: 8005, waitingTime: 850).toBlocking() //create Box8005
        
        _ = self.cardService.createCard(word: "sdfkjahjf", definition: "dhfuyag", Lesson: self.lessonForTest) // create Card
        _ = self.cardService.createCard(word: "hsdlfhias", definition: "jflheyg", Lesson: self.lessonForTest) // create Card
        _ = self.cardService.createCard(word: "sxbcvmdsjf", definition: "hdgfytc", Lesson: self.lessonForTest) // create Card
        
        let box8001 = self.realm.objects(BoxItem.self).filter{$0.boxNumber == 8001 && $0.waitingTime == 800}.first!
        // fetch box8001 from realm
        let box8002 = self.realm.objects(BoxItem.self).filter{$0.boxNumber == 8002 && $0.waitingTime == 820}.first!
        // fetch box8002 from realm
        let box8003 = self.realm.objects(BoxItem.self).filter{$0.boxNumber == 8003 && $0.waitingTime == 830}.first!
        // fetch box8003 from realm
        let box8004 = self.realm.objects(BoxItem.self).filter{$0.boxNumber == 8004 && $0.waitingTime == 840}.first!
        // fetch box8004 from realm
        let box8005 = self.realm.objects(BoxItem.self).filter{$0.boxNumber == 8005 && $0.waitingTime == 850}.first!
        // fetch box8005 from realm
        
        let card1ForTest = self.realm.objects(CardItem.self).filter{$0.word == "sdfkjahjf" && $0.definition == "dhfuyag"}.first! // fetch card1
        let card2ForTest = self.realm.objects(CardItem.self).filter{$0.word == "hsdlfhias" && $0.definition == "jflheyg"}.first! // fetch card2
        let card3ForTest = self.realm.objects(CardItem.self).filter{$0.word == "sxbcvmdsjf" && $0.definition == "hdgfytc"}.first! // fetch card3
        
        // When
        _ = self.boxService.transferCardTo(box: box8002.id, card: card1ForTest).toBlocking()
        _ = self.boxService.transferCardTo(box: box8003.id, card: card2ForTest).toBlocking()
        _ = self.boxService.transferCardTo(box: box8005.id, card: card3ForTest).toBlocking()
        XCTAssertTrue(self.realm.objects(BoxItem.self).count >= 5)
        XCTAssertGreaterThanOrEqual(self.realm.objects(BoxCardItem.self).count, 3)
        
        // Then
        self.boxService.resetBoxes()
        XCTAssertTrue(self.realm.objects(BoxCardItem.self).count == 0, "Boxes successfully reset")
        
        try! self.realm.write {
            realm.delete([box8001, box8002, box8003, box8004, box8005])
            realm.delete([card1ForTest, card2ForTest, card3ForTest])
        }
    }
    
    func testTransferCardToBox() {
        // Given
        _ = self.boxService.createBox(no: 9001, waitingTime: 900).toBlocking() //create Box9001
        _ = self.boxService.createBox(no: 9002, waitingTime: 920).toBlocking() //create Box9002
        _ = self.boxService.createBox(no: 9003, waitingTime: 930).toBlocking() //create Box9003
        _ = self.boxService.createBox(no: 9004, waitingTime: 940).toBlocking() //create Box9004
        _ = self.boxService.createBox(no: 9005, waitingTime: 950).toBlocking() //create Box9005
        
        _ = self.cardService.createCard(word: "gcgaskkyf", definition: "jhdlfhal", Lesson: self.lessonForTest).toBlocking()  // create Card
        _ = self.cardService.createCard(word: "hdjhhsdg", definition: "bjhgkcjhf", Lesson: self.lessonForTest).toBlocking()  // create Card
        _ = self.cardService.createCard(word: "udgcgcds", definition: "haidggfd", Lesson: self.lessonForTest).toBlocking()  // create Card
        _ = self.cardService.createCard(word: "hwegyfdsa", definition: "aheguygy", Lesson: self.lessonForTest).toBlocking()  // create Card
        _ = self.cardService.createCard(word: "eyiogvbv", definition: "jhagfguli", Lesson: self.lessonForTest).toBlocking()  // create Card
        
        let box9001 = self.realm.objects(BoxItem.self).filter{$0.boxNumber == 9001 && $0.waitingTime == 900}.first!
        // fetch box9001 from realm
        let box9002 = self.realm.objects(BoxItem.self).filter{$0.boxNumber == 9002 && $0.waitingTime == 920}.first!
        // fetch box9002 from realm
        let box9003 = self.realm.objects(BoxItem.self).filter{$0.boxNumber == 9003 && $0.waitingTime == 930}.first!
        // fetch box9003 from realm
        let box9004 = self.realm.objects(BoxItem.self).filter{$0.boxNumber == 9004 && $0.waitingTime == 940}.first!
        // fetch box9004 from realm
        let box9005 = self.realm.objects(BoxItem.self).filter{$0.boxNumber == 9005 && $0.waitingTime == 950}.first!
        // fetch box9005 from realm
        
        let card1ForTest = self.realm.objects(CardItem.self).filter{$0.word == "gcgaskkyf" && $0.definition == "jhdlfhal"}.first! // fetch card1
        let card2ForTest = self.realm.objects(CardItem.self).filter{$0.word == "hdjhhsdg" && $0.definition == "bjhgkcjhf"}.first! // fetch card2
        let card3ForTest = self.realm.objects(CardItem.self).filter{$0.word == "udgcgcds" && $0.definition == "haidggfd"}.first! // fetch card3
        let card4ForTest = self.realm.objects(CardItem.self).filter{$0.word == "hwegyfdsa" && $0.definition == "aheguygy"}.first! // fetch card4
        let card5ForTest = self.realm.objects(CardItem.self).filter{$0.word == "eyiogvbv" && $0.definition == "jhagfguli"}.first! // fetch card5
        // When
        XCTAssertEqual(self.realm.objects(BoxCardItem.self).filter{$0.boxId == box9001.id && $0.cardId == card1ForTest.id}.count , 0)
        _ = self.boxService.transferCardTo(box: box9001.id, card: card1ForTest).toBlocking()
        XCTAssertTrue(self.realm.objects(BoxCardItem.self).filter{$0.boxId == box9002.id && $0.cardId == card2ForTest.id}.count == 0)
        _ = self.boxService.transferCardTo(box: box9002.id, card: card2ForTest).toBlocking()
        XCTAssertTrue(self.realm.objects(BoxCardItem.self).filter{$0.boxId == box9003.id && $0.cardId == card3ForTest.id}.count == 0)
        _ = self.boxService.transferCardTo(box: box9003.id, card: card3ForTest).toBlocking()
        XCTAssertTrue(self.realm.objects(BoxCardItem.self).filter{$0.boxId == box9004.id && $0.cardId == card4ForTest.id}.count == 0)
        _ = self.boxService.transferCardTo(box: box9004.id, card: card4ForTest).toBlocking()
        XCTAssertTrue(self.realm.objects(BoxCardItem.self).filter{$0.boxId == box9005.id && $0.cardId == card5ForTest.id}.count == 0)
        _ = self.boxService.transferCardTo(box: box9005.id, card: card5ForTest).toBlocking()
        // Then
        XCTAssertGreaterThanOrEqual(self.realm.objects(BoxCardItem.self).filter{$0.boxId == box9001.id && $0.cardId == card1ForTest.id}.count, 1)
        XCTAssertGreaterThanOrEqual(self.realm.objects(BoxCardItem.self).filter{$0.boxId == box9002.id && $0.cardId == card2ForTest.id}.count, 1)
        XCTAssertGreaterThanOrEqual(self.realm.objects(BoxCardItem.self).filter{$0.boxId == box9003.id && $0.cardId == card3ForTest.id}.count, 1)
        XCTAssertGreaterThanOrEqual(self.realm.objects(BoxCardItem.self).filter{$0.boxId == box9004.id && $0.cardId == card4ForTest.id}.count, 1)
        XCTAssertGreaterThanOrEqual(self.realm.objects(BoxCardItem.self).filter{$0.boxId == box9005.id && $0.cardId == card5ForTest.id}.count, 1)
        try! self.realm.write {
            realm.delete(realm.objects(BoxCardItem.self).filter{
                $0.boxId == box9001.id ||
                $0.boxId == box9002.id ||
                $0.boxId == box9003.id ||
                $0.boxId == box9004.id ||
                $0.boxId == box9005.id
            })
            realm.delete([box9001, box9002, box9003, box9004, box9005])
            realm.delete([card1ForTest, card2ForTest, card3ForTest, card4ForTest, card5ForTest])
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
