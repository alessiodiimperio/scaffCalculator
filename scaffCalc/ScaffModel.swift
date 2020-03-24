//
//  ScaffModel.swift
//  scaffCalc
//
//  Created by Alessio on 2020-02-22.
//  Copyright © 2020 Alessio. All rights reserved.
//
// 

import UIKit

class ScaffModel {
    //Calc
    let scaff:ScaffoldingCalc!
    
    //Scaff item qtys
    var scaffItems:[ScaffPart] = []
    var scaffParts:[ScaffPart] = []
    
    var spiror3m:ScaffPart // 1 part
    var spiror2m:ScaffPart // 2 part
    var spiror1m:ScaffPart // 3 part
    var startkrans:ScaffPart // 4 part
    var bottenskruv:ScaffPart // 5 part
    var kortbalk:ScaffPart // 6 part
    var ubalk:ScaffPart // 7 part
    var langbalk:ScaffPart // 8 part
    var diagonaler:ScaffPart // 9 part
    var anchors:ScaffPart // 10 part
    var platforms:ScaffPart // 11 part
    var toeboard:ScaffPart // 12 part
    var endToeboard:ScaffPart // 13 part
    var stairs:ScaffPart // 14 part
    var spirstart:ScaffPart // 15 part
    var stairGuardRail:ScaffPart // 16 part
    var longbeam2m:ScaffPart // 17 part
    var ladders:ScaffPart // 18 part
    var toeboardKonsol:ScaffPart // 19 part
    
    
    //Scaff size and shape variables
    var sections:Int
    var levels:Int
    var levelsWithPlatforms:Int
    var topLevel:Int
    var hasDivide:Bool
    var hasStairs:Bool
    var hasLadders:Bool
    var middleSection:Int
    var sectionsToDraw:Int
    
    
    
    init() {
        //Scaffolding calculator and parts initialization
        scaff = ScaffoldingCalc()
        spiror1m = ScaffPart(title: "Spiror 1m", image: "spira", qty: 0)
        spiror2m = ScaffPart(title: "Spiror 2m", image: "spira", qty: 0)
        spiror3m = ScaffPart(title: "Spiror 3m", image: "spira", qty: 0)
        startkrans = ScaffPart(title: "Startkrans", image: "startkrans", qty: 0)
        bottenskruv = ScaffPart(title: "Bottenskruv", image: "bottenskruv", qty: 0)
        kortbalk = ScaffPart(title: "Kortbalk / Tvärbom", image: "kortbalk", qty: 0)
        ubalk = ScaffPart(title: "U-balk / U-Tvärbom", image: "ubalk", qty: 0)
        langbalk = ScaffPart(title: "Långbalk / Horisontalbalk", image: "langbalk", qty: 0)
        diagonaler = ScaffPart(title: "Diagonalstag", image: "diagonal", qty: 0)
        anchors = ScaffPart(title: "Väggfästen", image: "ankare", qty: 0)
        platforms = ScaffPart(title: "Stålplank", image: "stalplank", qty: 0)
        toeboard = ScaffPart(title: "Sparklister", image: "sparklist", qty: 0)
        endToeboard = ScaffPart(title: "Ändsparklister", image: "andsparklist", qty: 0)
        toeboardKonsol = ScaffPart(title: "Sparklist Konsol", image: "sparklistkonsol", qty: 0)
        stairs = ScaffPart(title: "Ställningstrappa", image: "stairs", qty: 0)
        stairGuardRail = ScaffPart(title: "Handledare för trappa", image: "guardrail", qty: 0)
        ladders = ScaffPart(title: "Plattform med stege", image: "ladders", qty: 0)
        spirstart = ScaffPart(title: "Spirtstart för skyddsräcke vid trapptorn", image: "spirstart", qty: 0)
        longbeam2m = ScaffPart(title: "Långbalk 2m för skyddsräcke vid trapptorn på översta bomlag", image: "langbalk", qty: 0)
        
        //Array of scaffolding parts. Containing, image-name, qty and title
        scaffItems = [bottenskruv, startkrans, spiror1m, spiror2m, spiror3m, kortbalk, ubalk, langbalk, diagonaler, anchors, platforms, toeboard, endToeboard, stairs, stairGuardRail, spirstart, longbeam2m, ladders, toeboardKonsol]
        
        //Scaffolding variable initialization
        sections = 0
        levels = 0
        levelsWithPlatforms = 0
        topLevel = 0
        hasDivide = false
        hasStairs = false
        hasLadders = false
        middleSection = 0
        sectionsToDraw = 0
        
    }
    
    func reloadAll(){
        //Empty array of tableview datasource
        scaffParts = []
        
        //Update all scaffolding detail quantities
        spiror1m.qty = scaff.calcTotal1mSpiror()
        spiror2m.qty = scaff.calcTotal2mSpiror()
        spiror3m.qty = scaff.calcTotal3mSpiror()
        startkrans.qty = scaff.calcTotalStartkrans()
        bottenskruv.qty = scaff.calcTotalBottenskruv()
        kortbalk.qty = scaff.calcTotalShortbeam()
        ubalk.qty = scaff.calcUBalk()
        langbalk.qty = scaff.calcTotalLongbeam()
        diagonaler.qty = scaff.calcTotalDiagonals()
        anchors.qty = scaff.calcTotalAnkers()
        platforms.qty = scaff.calcTotalPlatforms()
        toeboard.qty = scaff.calcTotalToeboards()
        endToeboard.qty = scaff.calcTotalEndToeboards()
        toeboardKonsol.qty = scaff.calcToeboardKonsol()
        stairGuardRail.qty = scaff.calcTotalStairGuardRails()
        stairs.qty = scaff.calcTotalStairs()
        longbeam2m.qty = scaff.calcLongbeam2m()
        spirstart.qty = scaff.calcSpirstart()
        ladders.qty = scaff.calcLadders()
       
        
        //Update scaffolding variables
        sections = scaff.getNumberOfSections()
        levels = scaff.getNumberOfLevels()
        levelsWithPlatforms = scaff.getLevelsWithPlatforms()
        topLevel = (scaff.getNumberOfLevels() - scaff.getLevelsWithPlatforms()) - 1
        hasStairs = scaff.hasStairs
        hasLadders = scaff.hasLadders
        
        if sections > 6 {
            hasDivide = true
        } else {
            hasDivide = false
        }
        sectionsToDraw = scaff.getNumberOfSections()
        if sectionsToDraw > 6 {
            sectionsToDraw = 6
        }
        
        //Append items to tableview but filter out items with 0 qty - DISABLED for debugging
        for item in scaffItems {
//            if item.qty > 0 {
                scaffParts.append(item)
//            }
        }
    }
}
