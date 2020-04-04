//
//  ScaffoldingCalc.swift
//  scaffCalc
//
//  Created by Alessio on 2020-02-22.
//  Copyright © 2020 Alessio. All rights reserved.
//
/**
 This code has been sort of ported to swift from a JavaScript calculator belonging to AluStep. The code has been almost entirely rewritten  and improved with more detailed calculations and the ability to include toeboards, stairs, ladders including edited images to display them.
 I have been given permission to use the images but want to clarify that any copyrighted material belongs solely to the copyright holders and no infringement is intended.
 Images of the scaffolding icons are from Assco Futuro and they are the sole copyright holders of these images.

 If you want to contact me regarding any unintended copyright issues feel free to contact me at alessio.diimperio @ gmail.com
 
 **/

import UIKit
//import Darwin

class ScaffoldingCalc {
        
    var topLevelPlatformHeight:Int
    var totalLength:Double
    var totalLevelsWithPlatforms:Int
    var hasStairs:Bool
    var hasLadders:Bool
    var isFarFromWall:Bool
    
    //'Magic Number' variables - To make code more readable and editable
    let sectionHeight = 2
    let sectionWidth = 3.07
    let guardRailHeight = 1
    let oneMeter = 1
    let twoMeters = 2
    let threeMeters = 3
    let topLevel = 1
    let bottomLevel = 1
    let topAndBottomLevel = 2
    let firstSection = 1
    let firstAndLastSection = 2
    let maxBeamDistance = 2
    let maxAnchorDistance = 2
    let firstAnchorDistance = 4
    let maxDiagonalDistance = 5
    let platformsPerSection = 2
    
    init(width: Double = 3.07, height: Int = 2, workLevels: Int = 1, stairs: Bool = false, ladders: Bool = false, over30cm:Bool = false) {
        self.topLevelPlatformHeight = height
        self.totalLength = width
        self.totalLevelsWithPlatforms = workLevels
        hasStairs = stairs
        hasLadders = ladders
        isFarFromWall = over30cm
    }
    func getNumberOfSections() -> Int {
        return Int(totalLength / sectionWidth)
    }
    func getNumberOfLevels() -> Int {
        return Int((topLevelPlatformHeight + sectionHeight) / sectionHeight)
    }
    func getLevelsWithPlatforms() -> Int {
        return totalLevelsWithPlatforms
    }
    func getNumberOfSpirPar() -> Int {
        return getNumberOfSections() + 1 // plus one for outer pair
    }
    func get3mSpirorForHeight() -> Int {
        return Int((topLevelPlatformHeight + guardRailHeight) / threeMeters)
    }
    func get2mSpirorForHeight() -> Int {
        let alreadyCalculatedHeight = get3mSpirorForHeight() * threeMeters
        
        return Int(((topLevelPlatformHeight + guardRailHeight) - alreadyCalculatedHeight) / twoMeters)
    }
    func get1mSpirorForHeight() -> Int {

        let alreadyCalculatedHeight = (get3mSpirorForHeight() * threeMeters) + (get2mSpirorForHeight() * twoMeters)
               
        return Int(((topLevelPlatformHeight + guardRailHeight) - alreadyCalculatedHeight))
    }
    func getSpiror3mWithoutGuardrail() -> Int {
        return Int(topLevelPlatformHeight / threeMeters)
    }
    func getSpiror2mWithoutGuardrail() -> Int {
        let alreadyCalculatedHeight = getSpiror3mWithoutGuardrail() * threeMeters
        return Int((topLevelPlatformHeight - alreadyCalculatedHeight) / twoMeters)
    }
    func getSpiror1mWithoutGuardrail() -> Int {
        let alreadyCalculatedHeight = (getSpiror3mWithoutGuardrail() * threeMeters) + (getSpiror2mWithoutGuardrail() * twoMeters)
        
        return Int(topLevelPlatformHeight - alreadyCalculatedHeight)
    }
    func getOuterAnkers() -> Int {
        return Int((topLevelPlatformHeight / maxAnchorDistance) * 2)
    }
    func getAnkers2m() -> Int {
        return Int((getNumberOfSpirPar() - 2) / 2) * Int(topLevelPlatformHeight / maxAnchorDistance)
    }
    func getAnkers4m() -> Int {
        return Int((getNumberOfSpirPar() - 2) / 2) * Int(topLevelPlatformHeight / firstAnchorDistance)
    }
    func getShortbeamPerSection() -> Int {
        return Int((topLevelPlatformHeight / maxBeamDistance) + 1) // 1 = outer section
    }
    func getTotalShortbeam() -> Int {
        return Int(getNumberOfSpirPar() * getShortbeamPerSection())
    }
    func getLongbeamPerSection() -> Int {
        return Int((topLevelPlatformHeight / maxBeamDistance) + 1) // 1 = outer section
    }
    func getLongbeams() -> Int {
        return Int(getNumberOfSections() * getLongbeamPerSection() * 2) // 2 = inner and outer frames
    }
    func getDiagonals() -> Int {
        return Int(((getNumberOfSections() - firstAndLastSection) / maxDiagonalDistance) + firstAndLastSection) * Int(topLevelPlatformHeight / sectionHeight)
    }
    func getPlatforms() -> Int {
        return getNumberOfSections() * totalLevelsWithPlatforms * platformsPerSection
    }
    func getToeBoards() -> Int {
        return getNumberOfSections() * totalLevelsWithPlatforms
    }
    func getStartkrans() -> Int {
        return getNumberOfSpirPar() * 2 // 2 = inner and outer
    }
    func calcTotal1mSpiror() -> Int {
        let forOuterSpiror1m = (getNumberOfSpirPar() + 2) * get1mSpirorForHeight()
        let forInnerSpiror1m = (getNumberOfSpirPar() - 2) * getSpiror1mWithoutGuardrail()
        let forStairsSpiror1m = 2 * get1mSpirorForHeight()
        
        switch true {
        case hasStairs:
            return forOuterSpiror1m + forInnerSpiror1m + forStairsSpiror1m + 1
        default:
            return  forOuterSpiror1m + forInnerSpiror1m
        }
    }
    func calcTotal2mSpiror() -> Int {
        let forOuterSpiror2m = (getNumberOfSpirPar() + 2) * get2mSpirorForHeight()
        let forInnerSpiror2m = (getNumberOfSpirPar() - 2) * getSpiror2mWithoutGuardrail()
        let forStairsSpiror2m = 2 * get2mSpirorForHeight()
        
        switch true {
        case hasStairs:
            return forOuterSpiror2m + forInnerSpiror2m + forStairsSpiror2m
        default:
            return forOuterSpiror2m + forInnerSpiror2m
        }
    }
    func calcTotal3mSpiror() -> Int {
        let forOuterSpiror3m = (getNumberOfSpirPar() + 2) * get3mSpirorForHeight()
        let forInnerSpiror3m = (getNumberOfSpirPar() - 2) * getSpiror3mWithoutGuardrail()
        let forStairsSpiror3m = 2 * get3mSpirorForHeight()
        
        switch true {
        case hasStairs:
            return forOuterSpiror3m + forInnerSpiror3m + forStairsSpiror3m
        default:
            return forOuterSpiror3m + forInnerSpiror3m
        }
    }
    func calcTotalStartkrans() -> Int {
        switch true {
        case hasStairs:
            return (getNumberOfSpirPar() * 2) + 2
        default:
            return getNumberOfSpirPar() * 2
        }
    }
    func calcTotalBottenskruv() -> Int {
        switch true {
        case hasStairs:
            print("bottenskruv has stairs")
            return (getNumberOfSpirPar() * 2) + 2
        default:
            return getNumberOfSpirPar() * 2
        }
    }
    func calcTotalShortbeam() -> Int {
        let shortbeamForScaffold = getTotalShortbeam()
        let shortbeamForStairCase = getShortbeamPerSection() * 2
        let shortbeamForPlatformLvls = totalLevelsWithPlatforms * 4
        let shortbeamForLadderLvls = getNumberOfLevels() * 4 - shortbeamForPlatformLvls
        let shortbeamForStairLvls = getNumberOfLevels() * 8 - shortbeamForPlatformLvls
        
        switch true {
        case hasLadders && hasStairs:
            return shortbeamForScaffold + shortbeamForStairCase + shortbeamForStairLvls + shortbeamForLadderLvls + shortbeamForPlatformLvls - calcUBalk()
        case hasStairs:
            return shortbeamForScaffold + shortbeamForStairCase + shortbeamForStairLvls + shortbeamForPlatformLvls - calcUBalk()
        case hasLadders:
            return shortbeamForScaffold + shortbeamForPlatformLvls + shortbeamForLadderLvls - calcUBalk()
        default:
            return shortbeamForScaffold + shortbeamForPlatformLvls - calcUBalk()
        }
    }
    func calcUBalk()->Int {
        let ubalkForPlatforms = getNumberOfSpirPar() * getLevelsWithPlatforms()
        let ubalkForStairs = ((getNumberOfLevels() - topAndBottomLevel) * 4) + 2
        let ubalkForLadders = (getNumberOfLevels() * 2)
        
        switch true {
        case hasLadders && hasStairs:
            if getNumberOfSections() > 1 {
                return ubalkForPlatforms + ubalkForStairs + ubalkForLadders
            } else {
                return ubalkForPlatforms + ubalkForStairs
            }
        case hasStairs:
            return ubalkForPlatforms + ubalkForStairs
        case hasLadders:
            return ubalkForPlatforms + ubalkForLadders
        default:
            return ubalkForPlatforms
        }
    }
    func calcTotalLongbeam()->Int{
        let longbeamForScaffold = getLongbeams()
        let longbeamForStairCase = getLongbeamPerSection()
        let longbeamForPlatformGuardRail = totalLevelsWithPlatforms * getNumberOfSections() * 2
        var longbeamForLadderLvlGuardRail = 0
        var longbeamForStairLvlGuardRail = 0
        
        if isFarFromWall {
            longbeamForLadderLvlGuardRail = ((getNumberOfLevels() - bottomLevel) * 4) - (totalLevelsWithPlatforms * 4)
            longbeamForStairLvlGuardRail = ((getNumberOfLevels() - bottomLevel) * 2) - (totalLevelsWithPlatforms * 2)
        } else {
            longbeamForLadderLvlGuardRail = ((getNumberOfLevels() - bottomLevel) * 2) - (totalLevelsWithPlatforms * 2)
        }
        
        switch true {
        case hasLadders && hasStairs:
            return longbeamForScaffold + longbeamForStairCase + (longbeamForPlatformGuardRail - 2) + longbeamForLadderLvlGuardRail + longbeamForStairLvlGuardRail // -2 as top level guard rail is a smaller size to let for opening
        case hasStairs:
            return longbeamForScaffold + (longbeamForPlatformGuardRail - 2) + longbeamForStairCase + longbeamForStairLvlGuardRail
        case hasLadders:
            return longbeamForScaffold + longbeamForPlatformGuardRail + longbeamForLadderLvlGuardRail
        default:
            return longbeamForScaffold + longbeamForPlatformGuardRail
        }
    }
    func calcTotalStairs() -> Int{
        if hasStairs {
         return (getNumberOfLevels() - topLevel)
        } else {
            return 0
        }
    }
    func calcTotalStairGuardRails() -> Int {
        if hasStairs {
            return (getNumberOfLevels() - topLevel) * 2
        }
            return 0
    }
    func calcTotalDiagonals()->Int{
        
        let sectionsWithDiagonals = floor(Double(getNumberOfSections()) - 2.0) / 5 + 2
        let levelsWithDiagonals = floor(Double(topLevelPlatformHeight) / 2.0)
        let totalDiagonals = sectionsWithDiagonals * levelsWithDiagonals
        
        return Int(totalDiagonals)
    }
    func calcTotalAnkers() -> Int {
        return Int(getAnkers2m() + getAnkers4m() + getOuterAnkers())
    }
    func calcTotalPlatforms()->Int{
        let platformsForStairLvl = (getNumberOfLevels() - topAndBottomLevel) * 2
        let replacedPlatformsWithLadder = totalLevelsWithPlatforms * 2
        let platformsForStaircase = ((getNumberOfLevels() - topAndBottomLevel) * 2)
        
        switch true {
        case hasStairs && hasLadders:
            return (getPlatforms() - replacedPlatformsWithLadder) + platformsForStairLvl
        case hasStairs:
            return getPlatforms() + platformsForStaircase
        case hasLadders:
            return getPlatforms() - replacedPlatformsWithLadder
        default:
            return getPlatforms()
        }
    }
    func calcTotalToeboards()->Int{
        let toeboardsOnPlatformLvls = getNumberOfSections() * totalLevelsWithPlatforms
        var toeboardsOnLadderLvls = getNumberOfLevels() - topAndBottomLevel
        var toeboardsOnStairsLvls = getNumberOfLevels() - topAndBottomLevel
        
        if isFarFromWall {
            toeboardsOnLadderLvls = (getNumberOfLevels() - topAndBottomLevel) * 2
            toeboardsOnStairsLvls = (getNumberOfLevels() - topAndBottomLevel) * 2
        } else {
            toeboardsOnLadderLvls = getNumberOfLevels() - topAndBottomLevel
            toeboardsOnStairsLvls = getNumberOfLevels() - topAndBottomLevel
        }
        
        switch true {
        case hasStairs && hasLadders:
            return toeboardsOnPlatformLvls + toeboardsOnLadderLvls + toeboardsOnStairsLvls
        case hasStairs:
            return toeboardsOnPlatformLvls + toeboardsOnStairsLvls
        case hasLadders:
            return toeboardsOnPlatformLvls + toeboardsOnLadderLvls
        default:
            return toeboardsOnPlatformLvls
        }
    }
    func calcTotalEndToeboards()->Int{
        let endToeboardsOnPlatformLvls = getLevelsWithPlatforms() * 2
        let endToeboardsOnStairsLvls = ((getNumberOfLevels() - topAndBottomLevel) * 4) + topLevel
        var endToeBoardsOnLadderLvls = 0
        
        //Avoid doubling if ladders and stairs are in same section
        if getNumberOfSections() > 2 {
        endToeBoardsOnLadderLvls = (getNumberOfLevels() - topAndBottomLevel) * 2
        }
        switch true {
        case hasStairs && hasLadders:
            return endToeboardsOnPlatformLvls + endToeBoardsOnLadderLvls + endToeboardsOnStairsLvls
        case hasStairs:
            return endToeboardsOnPlatformLvls + endToeboardsOnStairsLvls
        case hasLadders:
            return endToeboardsOnPlatformLvls + endToeBoardsOnLadderLvls
        default:
            return endToeboardsOnPlatformLvls
        }
    }
    func calcLongbeam2m()->Int{
        if hasStairs {
            return 2
        } else {
            return 0
        }
    }
    func calcSpirstart() -> Int {
        if hasStairs {
            return 1
        } else {
            return 0
        }
    }
    func calcLadders() -> Int {
        if hasLadders {
            return getNumberOfLevels()
        } else {
            return 0
        }
    }
    func calcToeboardKonsol() -> Int {
        let toeboardKonsolPlatformLvls = (getNumberOfSpirPar() + 2) * totalLevelsWithPlatforms
        var toeboardKonsolStairLvls = 0
        var toeboardKonsolLadderLvls = 0
        
        if isFarFromWall {
            toeboardKonsolStairLvls = (getNumberOfLevels() - topAndBottomLevel) * 6
            toeboardKonsolLadderLvls = (getNumberOfLevels() - topAndBottomLevel) * 6
        } else {
            toeboardKonsolLadderLvls = (getNumberOfLevels() - topAndBottomLevel) * 4
            toeboardKonsolStairLvls = (getNumberOfLevels() - topAndBottomLevel) * 4
        }
        
        switch true {
        case hasStairs && hasLadders:
            return toeboardKonsolPlatformLvls + toeboardKonsolLadderLvls + toeboardKonsolStairLvls
        case hasStairs:
            return toeboardKonsolPlatformLvls + toeboardKonsolStairLvls
        case hasLadders:
            return toeboardKonsolPlatformLvls + toeboardKonsolLadderLvls
        default:
            return toeboardKonsolPlatformLvls
        }
    }
}
