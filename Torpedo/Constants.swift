//
//  Constants.swift
//  Torpedo
//
//  Created by Sergey Silak on 10.05.2021.
//

import Foundation
import SpriteKit

struct Constants{
    
    let SOUNDBACKGROUND_KEY:String = "SOUNDBACKGROUND_KEY"
    let SOUNDEFFECTS_KEY:String = "SOUNDEFFECTS_KEY"
    let HARD_KEY:String = "HARD_KEY"
    let DESTROYED_KEY:String = "DESTROYED_KEY"
    let STRIKE_KEY:String = "STRIKE_KEY"
    let DEFINE_BOAT_WIDTH:CGFloat = 180
    let DEFINE_MOVE_TORPEDO:Int = 5
    let PORTRAIT:String = "Portrait"
    let LANDSCAPE:String = "Landscape"
    let FROM_RIGHT:String = "fromRight"
    let FROM_LEFT:String = "fromLeft"
    
    let BINOKLE1_NAME:String = "binokle1"
    let BINOKLE_NAME:String = "binokle"
    
    let BINOKLE_NAME_MAIN:String = "binokle"
    
    let ROCK_WIDTH:CGFloat = 200
    let ROCK_HEIGHT: CGFloat = 200 / 1.66
    
    let FLASH:CGFloat = 70
    
    let SMOKE_WIDTH:CGFloat = 70
    let SMOKE_HEIGHT:CGFloat = 70
    
    let YES_KEY:String = "YES"
    let NO_KEY:String = "NO"
    
    let LAUNCH:String = "launch"
    let EXPLOSION:String = "explosion"
    
    let DLINABUTTON:CGFloat = 200
    let VISOTABUTTON:CGFloat = 200/3
    
    
    let ARRAY_BOAT_WIDTH = [100,105, 110, 115, 120, 125, 130, 135, 140, 145, 150, 155, 160, 165, 170, 175, 180]
    
    let ARRAY_BOATS_RIGHT = ["boat2_r", "boat3_r", "boat4_r", "boat5_r", "boat6_r", "boat7_r", "boat8_r", "boat9_r", "boat10_r", "boat11_r", "boat12_r", "boat13_r", "boat14_r", "boat15_r", "boat16_r", "boat17_r", "boat18_r", "boat19_r", "boat20_r"]


    let ARRAY_BOATS_LEFT = ["boat2_l", "boat3_l", "boat4_l", "boat5_l", "boat6_l", "boat7_l", "boat8_l", "boat9_l", "boat10_l", "boat11_l", "boat12_l", "boat13_l", "boat14_l", "boat15_l", "boat16_l", "boat17_l", "boat18_l", "boat19_l", "boat20_l"]

    let ARRAY_DURATION_TORPEDO = [5,6, 7, 8, 9]

    
    let MAIN_BOAT_NAME_R:String = "boat1_r"
    let MAIN_BOAT_NAME_L:String = "boat1_l"
    
    
    let sizeBOAT:CGFloat = 0.75
}


struct ranks_RUSize{
    
    let visotaO:CGFloat = 150
    let shirinaO:CGFloat = 150/2
    
    let visotaO_p:CGFloat = 100
    let shirinaO_p:CGFloat = 100/2
    
    let visotaA:CGFloat = 160
    let shirinaA:CGFloat = 160/2.58
    
    let visotaA_p:CGFloat = 100
    let shirinaA_p:CGFloat = 100/2.58
    
    let otstup:CGFloat = 90
    let otstup_p:CGFloat = 7.5
    
    
}

struct ranksSize{

        let visotaO:CGFloat = 140
        let shirinaO:CGFloat = 140/2
            
        let visotaO_p:CGFloat = 100
        let shirinaO_p:CGFloat = 100/2
            
        let visotaA:CGFloat = 160
        let shirinaA:CGFloat = 160/2.34
            
        let visotaA_p:CGFloat = 100
        let shirinaA_p:CGFloat = 100/2.34
            
        let otstup:CGFloat = 90
        let otstup_p:CGFloat = 4.5
}


struct menuButtonSize{
    let dlinaButton:Int=200
    let visotaButton:Int = 200/3
    let visota:Int=50
}

struct AwardsSize{
    let visotaO:Int = 170
    let shirinaO:Int = 170/2
}

struct TextMessages{
    
    let TEXT_SETTINGS_MENU: String! = "Settings"
    let TEXT_SETTINGS_MENU_MUSIC: String! = "Music"
    let TEXT_SETTINGS_MENU_SOUND_EFFECTS: String! = "Sound effects"
    let TEXT_SETTINGS_MENU_HARD_MODE: String! = "Hard mode"
    
    let TEXT_RATING_MENU: String! = "Ranks and awards"
    
    let TEXT_INFORMATION_ORDER: String! = "Order"
    
    let TEXT_ABOUT_MENU: String! = "About"
    let TEXT_ABOUT_GAME: String! = "The game is based on the \"Torpedo attack\" slot machine. It is intended solely for entertainment and does not purport to be historical realism. More than 20 silhouettes of real ships and submarines from around the world are presented.\n\nPurpose of the game: Hit the target ship twice.\n\nEnjoy."  
}


struct Ranks{
    let TEXT_RANK_1: String! = "Ensign"
    let TEXT_RANK_2: String! = "Lieutenant(junior grade)"
    let TEXT_RANK_3: String! = "Lieutenant"
    let TEXT_RANK_4: String! = "Lieutenant commander"
    let TEXT_RANK_5: String! = "Commander"
    let TEXT_RANK_6: String! = "Captain"
    let TEXT_RANK_7: String! = "Rear admiral (lower half)"
    let TEXT_RANK_8: String! = "Rear admiral"
    let TEXT_RANK_9: String! = "Vice admiral"
    let TEXT_RANK_10: String! = "Admiral"
    let TEXT_RANK_11: String! = "Fleet admiral"
    
}
struct Awards{
    let TEXT_AWARDS_1: String! = "Navy and Marine Corps Achievement Medal"
    let TEXT_AWARDS_2: String! = "Navy and Marine Corps Commendation Medal"
    let TEXT_AWARDS_3: String! =  "Navy Distinguished Service Medal"
    let TEXT_AWARDS_4: String! = "Navy Cross"
    let TEXT_AWARDS_5: String! = "Medal of Honor"
    
    
}

struct Orders{
    let TEXT_ORDERS_1: String! = "You have been awarded the next military rank Ensign.\n\nMove forward into a given square and begin a combat mission."
    let TEXT_ORDERS_2: String! = "You have been awarded the next military rank Lieutenant (junior grade). To award the Navy and Marine Corps Achievement Medal for achievements in combat or non-combat situations.\n\nMove forward to a given square and begin a combat mission."
    let TEXT_ORDERS_3: String! =  "You have been awarded the next military rank Lieutenant.\n\nMove forward into the given square and begin the combat mission."
    let TEXT_ORDERS_4: String! = "You have been awarded the next military rank Lieutenant commander.\n\nMove forward into the given square and begin the combat mission."
    let TEXT_ORDERS_5: String! = "You have been awarded the next military rank Commander. To award the Navy and Marine Corps Commendation Medal for heroism.\n\nMove forward into a given square and begin a combat mission."
    let TEXT_ORDERS_6: String! = "You have been awarded the next military rank Captain.\n\nMove forward into the given square and begin the combat mission."
    let TEXT_ORDERS_7: String! = "You have been awarded the next military rank Rear admiral (lower half).\n\nMove forward into the given square and begin the combat mission."
    let TEXT_ORDERS_8: String! = "You have been awarded the next military rank Rear admiral. To award the Navy Distinguished Service Medal for exceptionally dignified service within the framework of great responsibility.\n\nMove forward into the given square and begin the combat mission."
    let TEXT_ORDERS_9: String! = "You have been awarded the next military rank Vice admiral.\n\nMove forward into the given square and begin the combat mission."
    let TEXT_ORDERS_10: String! = "You have been awarded the next military rank Admiral. Award the Navy Cross for extraordinary heroism in battle.\n\nMove forward into the given square and begin the combat mission."
    let TEXT_ORDERS_11: String! = "You have been awarded the next military rank Fleet admiral. To award the Medal of Honor for outstanding courage and courage at the risk of life and exceeding duty.\n\nMove forward into the given square and begin the combat mission."
}
