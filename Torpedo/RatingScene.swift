//
//  RatingScene.m
//  Torpedo attack
//
//  Created by Sergey Silak on 27.01.2021.
//

import SpriteKit

var  RU_1_R_Sprite:SKSpriteNode!,RU_2_R_Sprite:SKSpriteNode!, RU_3_R_Sprite:SKSpriteNode!,   RU_4_R_Sprite:SKSpriteNode!, RU_5_R_Sprite:SKSpriteNode!, RU_6_R_Sprite:SKSpriteNode!, RU_7_R_Sprite:SKSpriteNode!,RU_8_R_Sprite:SKSpriteNode!, RU_9_R_Sprite:SKSpriteNode!, RU_10_R_Sprite:SKSpriteNode!, RU_11_R_Sprite:SKSpriteNode!

var RU_1_Sprite:SKSpriteNode!, RU_2_Sprite:SKSpriteNode!, RU_3_Sprite:SKSpriteNode!, RU_4_Sprite:SKSpriteNode!, RU_5_Sprite:SKSpriteNode!

var  US_1_R_Sprite:SKSpriteNode!, US_2_R_Sprite:SKSpriteNode!, US_3_R_Sprite:SKSpriteNode!, US_4_R_Sprite:SKSpriteNode!, US_5_R_Sprite:SKSpriteNode!, US_6_R_Sprite:SKSpriteNode!, US_7_R_Sprite:SKSpriteNode!, US_8_R_Sprite:SKSpriteNode!, US_9_R_Sprite:SKSpriteNode!, US_10_R_Sprite:SKSpriteNode!, US_11_R_Sprite:SKSpriteNode!

var  US_1_Sprite:SKSpriteNode!, US_2_Sprite:SKSpriteNode!, US_3_Sprite:SKSpriteNode!, US_4_Sprite:SKSpriteNode!, US_5_Sprite:SKSpriteNode!
var texture: SKTexture!

class RatingScene : SKScene, CanReceiveTransitionEvents  {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
        
    }
    
     
    override func didMove(to view: SKView) {
        // Setup your scene here
        DispatchQueue.main.async {
            self.createBackground()
            self.createLabelMenu()
            self.createLabelInfo()
            self.createBackButton()
            self.createRanksAndAward()
            
        }
    }

    func viewWillTransition(to size: CGSize)
    {
        DispatchQueue.main.async {
            self.removeAllChildren()
            self.createBackground()
            self.createLabelMenu()
            self.createLabelInfo()
            self.createBackButton()
            self.createRanksAndAward()
        }
    }
    
    func createBackground (){
        //Создаём background
        makeBackgroundSprite()
    }
    
    func createLabelMenu(){
         //Создаём labeMenu
         makeLabelMenu(orientation: CurrentOrientation())
    }
    
    func createLabelInfo(){
        //Создаём labelInfo
        makeLabelInfo()
    }
    
    func createBackButton(){
        //Создаём backButton
        makeBackButtonSprite()
    }
    
    func createRanksAndAward() {
        //Создаём makeRanks
        makeRanks()
    }
    
    
    /*--------------------------------------touchesBegan------------------------------*/

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let node = self.atPoint(positionInScene)
        
        if (node.name == "menuBackButtonSprite") {
            self.loadMainMenu()
        }
        
        switch node.name {
        case "RU_1_R_SpriteName": self.setLabelInfoText(text:NSLocalizedString(Ranks().TEXT_RANK_1, comment: "Младший лейтенант"))
        case "RU_2_R_SpriteName": self.setLabelInfoText(text:NSLocalizedString(Ranks().TEXT_RANK_2, comment: "Лейтенант"))
        case "RU_3_R_SpriteName": self.setLabelInfoText(text:NSLocalizedString(Ranks().TEXT_RANK_3, comment: "Старший лейтенант"))
        case "RU_4_R_SpriteName": self.setLabelInfoText(text:NSLocalizedString(Ranks().TEXT_RANK_4, comment: "Капитан - лейтенант"))
        case "RU_5_R_SpriteName": self.setLabelInfoText(text:NSLocalizedString(Ranks().TEXT_RANK_5, comment: "Капитан 3-го ранга"))
        case "RU_6_R_SpriteName": self.setLabelInfoText(text:NSLocalizedString(Ranks().TEXT_RANK_6, comment: "Капитан 2-го ранга"))
        case "RU_7_R_SpriteName": self.setLabelInfoText(text:NSLocalizedString(Ranks().TEXT_RANK_7, comment: "Капитан 1-го ранга"))
        case "RU_8_R_SpriteName": self.setLabelInfoText(text:NSLocalizedString(Ranks().TEXT_RANK_8, comment: "Контр - адмирал"))
        case "RU_9_R_SpriteName": self.setLabelInfoText(text:NSLocalizedString(Ranks().TEXT_RANK_9, comment: "Вице - адмирал"))
        case "RU_10_R_SpriteName": self.setLabelInfoText(text:NSLocalizedString(Ranks().TEXT_RANK_10, comment: "Адмирал"))
        case "RU_11_R_SpriteName": self.setLabelInfoText(text:NSLocalizedString(Ranks().TEXT_RANK_11, comment: "Адмирал флота"))
        case "RU_1_SpriteName": self.setLabelInfoText(text: NSLocalizedString(Awards().TEXT_AWARDS_1, comment: "Медаль Жукова"))
        case "RU_2_SpriteName": self.setLabelInfoText(text: NSLocalizedString(Awards().TEXT_AWARDS_2, comment: "Медаль Ушакова"))
        case "RU_3_SpriteName": self.setLabelInfoText(text: NSLocalizedString(Awards().TEXT_AWARDS_3, comment: "Орден Нахимова"))
        case "RU_4_SpriteName": self.setLabelInfoText(text: NSLocalizedString(Awards().TEXT_AWARDS_4, comment: "Орден Ушакова"))
        case "RU_5_SpriteName": self.setLabelInfoText(text: NSLocalizedString(Awards().TEXT_AWARDS_5, comment: "Герой Российской Федерации"))
        case "US_1_R_SpriteName": self.setLabelInfoText(text:NSLocalizedString(Ranks().TEXT_RANK_1, comment: "Ensign"))
        case "US_2_R_SpriteName": self.setLabelInfoText(text:NSLocalizedString(Ranks().TEXT_RANK_2, comment: "Lieutenant(junior grade)"))
        case "US_3_R_SpriteName": self.setLabelInfoText(text:NSLocalizedString(Ranks().TEXT_RANK_3, comment: "Lieutenant"))
        case "US_4_R_SpriteName": self.setLabelInfoText(text:NSLocalizedString(Ranks().TEXT_RANK_4, comment: "Lieutenant commander"))
        case "US_5_R_SpriteName": self.setLabelInfoText(text:NSLocalizedString(Ranks().TEXT_RANK_5, comment: "Commander"))
        case "US_6_R_SpriteName": self.setLabelInfoText(text:NSLocalizedString(Ranks().TEXT_RANK_6, comment: "Captain"))
        case "US_7_R_SpriteName": self.setLabelInfoText(text:NSLocalizedString(Ranks().TEXT_RANK_7, comment: "Rear admiral (lower half)"))
        case "US_8_R_SpriteName": self.setLabelInfoText(text:NSLocalizedString(Ranks().TEXT_RANK_8, comment: "Rear admiral"))
        case "US_9_R_SpriteName": self.setLabelInfoText(text:NSLocalizedString(Ranks().TEXT_RANK_9, comment: "Vice admiral"))
        case "US_10_R_SpriteName": self.setLabelInfoText(text:NSLocalizedString(Ranks().TEXT_RANK_10, comment: "Admiral"))
        case "US_11_R_SpriteName": self.setLabelInfoText(text:NSLocalizedString(Ranks().TEXT_RANK_11, comment: "Fleet admiral"))
        case "US_1_SpriteName": self.setLabelInfoText(text: NSLocalizedString(Awards().TEXT_AWARDS_1, comment: "Navy and Marine Corps Achievement Medal"))
        case "US_2_SpriteName": self.setLabelInfoText(text: NSLocalizedString(Awards().TEXT_AWARDS_2, comment: "Navy and Marine Corps Commendation Medal"))
        case "US_3_SpriteName": self.setLabelInfoText(text: NSLocalizedString(Awards().TEXT_AWARDS_3, comment: "Navy Distinguished Service Medal"))
        case "US_4_SpriteName": self.setLabelInfoText(text: NSLocalizedString(Awards().TEXT_AWARDS_4, comment: "Navy Cross"))
        case "US_5_SpriteName": self.setLabelInfoText(text: NSLocalizedString(Awards().TEXT_AWARDS_5, comment: "Medal of Honor"))
        default: break
        }
    }
        

    func loadMainMenu() {
        let scene = SKScene(fileNamed: "MainMenuScene")
        scene?.scaleMode = .aspectFill
        view?.presentScene(scene)
    }

/*--------------------------------------*/
    func makeBackgroundSprite() {
        var BackgroundSprite:SKSpriteNode!
        
        if CurrentOrientation() == Constants().LANDSCAPE {
            texture = SKTexture (imageNamed: "fon")
            BackgroundSprite = SKSpriteNode(texture: texture)
            BackgroundSprite.size = self.frame.size
        } else {
            texture = SKTexture (imageNamed: "fon_p")
            BackgroundSprite = SKSpriteNode(texture: texture)
            BackgroundSprite.size = CGSize(width: self.frame.size.height, height:self.frame.size.height)
        }
        BackgroundSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        BackgroundSprite.name = "BackgroundSprite"
        BackgroundSprite.scene?.scaleMode = .aspectFill
        BackgroundSprite.zPosition = -1
        addChild(BackgroundSprite)
    }
/*--------------------------------------LabelMenu-------------------------------*/
    func makeLabelMenu(orientation:String) {
        var labelMenu:SKLabelNode!
        labelMenu = SKLabelNode(text: String(format:"%@", NSLocalizedString(TextMessages().TEXT_RATING_MENU, comment: "")))
        labelMenu.fontSize = 50
        if CurrentOrientation() == Constants().LANDSCAPE {
        labelMenu.fontSize = 70
        }
        labelMenu.position = CGPoint(x: 0, y: self.frame.size.height/2-120)
        labelMenu.fontColor = UIColor.white
        labelMenu.fontName="Capture it(RUS BY LYAJKA)"
        labelMenu.name = "LabelMenu"
        labelMenu.zPosition=0
        addChild(labelMenu)
    }

        
    var labelInfo: SKLabelNode!
    /*--------------------------------------LabelInfo-------------------------------*/
    func makeLabelInfo() {
        labelInfo = SKLabelNode(text: "")
        labelInfo.fontSize = 20
        if CurrentOrientation() == Constants().LANDSCAPE {
        labelInfo.fontSize = 25
        }
        labelInfo.position = CGPoint(x: 0, y: -28)
        labelInfo.fontColor = UIColor.black
        labelInfo.fontName="Capture it(RUS BY LYAJKA)"
        labelInfo.name = "labelInfo"
        labelInfo.zPosition = 0
        addChild(labelInfo)
    }
    
    func setLabelInfoText(text:String){
        labelInfo.text = text
        }

    /*---------------------------------------BackButtonSprite----------------------*/
    func makeBackButtonSprite() {
            var backButtonSprite : SKSpriteNode!
            texture = SKTexture (imageNamed: "buttonBack")
        
        if NSLocale.current.identifier.contains("ru_RU") {
            texture = SKTexture (imageNamed: "buttonBack_RU")
        }
            backButtonSprite = SKSpriteNode(texture: texture)
            backButtonSprite.size =  CGSize(width: Constants().DLINABUTTON, height: Constants().VISOTABUTTON)
            backButtonSprite.position = CGPoint(x: self.frame.midX, y: -self.frame.size.height/2+100)
            backButtonSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            backButtonSprite.name = "menuBackButtonSprite"
            backButtonSprite.scene?.scaleMode = .aspectFill
            backButtonSprite.zPosition=0
            addChild(backButtonSprite)
    }

  
    /*--------------------------------------makeRanks------------------------------*/
    func makeRanks(){
        if NSLocale.current.identifier.contains("ru_RU") {
            
            makeRU_RANKS()
        } else {
            makeUS_RANKS()
        }
    }
    
    /*--------------------------------------makeRU------------------------------*/
    func makeRU_RANKS(){

        let destroyedUD = UserDefaults.standard.object(forKey: Constants().DESTROYED_KEY) as! Int

        if destroyedUD>=0 {show_RU_1_R()}
         //50-100
         if destroyedUD>=50 {
            show_RU_2_R()
            show_RU_1 ()
         }
         //100-150
        if destroyedUD>=100 {show_RU_3_R()}
         //150-200
         if destroyedUD>=150 {show_RU_4_R()}
         //200-300
         if destroyedUD>=200 {
            show_RU_5_R()
            show_RU_2 ()
         }
         //300-400
         if destroyedUD>=300 {show_RU_6_R()}
         //400-500
         if destroyedUD>=400 {show_RU_7_R()}

         //500-750
         if destroyedUD>=500 {
            show_RU_8_R()
            show_RU_3 ()
         }
         //750-1000
         if destroyedUD>=750 {show_RU_9_R()}
         //1000-2000
         if destroyedUD>=1000 {
            show_RU_10_R()
            show_RU_4 ()
         }
         //2000-выше
         if destroyedUD>=2000 {
            show_RU_11_R()
            show_RU_5 ()
         }
    }
    
    /*--------------------------------------SHOW_RU------------------------------*/
        func show_RU_1_R (){
            
            texture = SKTexture (imageNamed: "RU_1_R")
            RU_1_R_Sprite = SKSpriteNode(texture: texture)
            RU_1_R_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

             if CurrentOrientation() == Constants().PORTRAIT {
                RU_1_R_Sprite.size = CGSize(width: ranks_RUSize().shirinaA_p, height: ranks_RUSize().visotaA_p)
                RU_1_R_Sprite.position = CGPoint(x: -220+ranks_RUSize().otstup_p, y: self.frame.size.height/2-240)

            } else {
                RU_1_R_Sprite.size = CGSize(width: ranks_RUSize().shirinaA, height: ranks_RUSize().visotaA)
                RU_1_R_Sprite.position = CGPoint(x: -self.frame.size.width/2+RU_1_R_Sprite.frame.size.width/2+60, y: self.frame.size.height/2-200)
            }

            RU_1_R_Sprite.name = "RU_1_R_SpriteName"
            RU_1_R_Sprite.scene?.scaleMode = .aspectFill
            RU_1_R_Sprite.zPosition=0
            addChild(RU_1_R_Sprite)
        }
    
        //50-100
        func show_RU_2_R (){

            texture = SKTexture (imageNamed: "RU_2_R")
            RU_2_R_Sprite = SKSpriteNode(texture: texture)
            RU_2_R_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

             if CurrentOrientation() == Constants().PORTRAIT {
                RU_2_R_Sprite.size = CGSize(width: ranks_RUSize().shirinaA_p, height: ranks_RUSize().visotaA_p)
                RU_2_R_Sprite.position = CGPoint(x: RU_1_R_Sprite.frame.origin.x+RU_1_R_Sprite.frame.size.width*2+CGFloat(ranks_RUSize().otstup_p), y: self.frame.size.height/2-240)
            } else {
                RU_2_R_Sprite.size = CGSize(width: ranks_RUSize().shirinaA, height: ranks_RUSize().visotaA)
                RU_2_R_Sprite.position = CGPoint(x: RU_1_R_Sprite.frame.origin.x+ranks_RUSize().shirinaA+CGFloat(ranks_RUSize().otstup), y: self.frame.size.height/2-200)

            }
            
            RU_2_R_Sprite.name = "RU_2_R_SpriteName"
            RU_2_R_Sprite.scene?.scaleMode = .aspectFill
            RU_2_R_Sprite.zPosition=0
            addChild(RU_2_R_Sprite)
        }

        //100-150
        func show_RU_3_R (){

            texture = SKTexture (imageNamed: "RU_3_R")
            RU_3_R_Sprite = SKSpriteNode(texture: texture)
            RU_3_R_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

             if CurrentOrientation() == Constants().PORTRAIT {
                RU_3_R_Sprite.size = CGSize(width: ranks_RUSize().shirinaA_p, height: ranks_RUSize().visotaA_p)
                RU_3_R_Sprite.position = CGPoint(x: RU_2_R_Sprite.frame.origin.x+RU_2_R_Sprite.frame.size.width*2+CGFloat(ranks_RUSize().otstup_p), y: self.frame.size.height/2-240)
            } else {
                RU_3_R_Sprite.size = CGSize(width: ranks_RUSize().shirinaA, height: ranks_RUSize().visotaA)
                RU_3_R_Sprite.position = CGPoint(x: RU_2_R_Sprite.frame.origin.x+ranks_RUSize().shirinaA+ranks_RUSize().otstup, y: self.frame.size.height/2-200)
            }

            RU_3_R_Sprite.name = "RU_3_R_SpriteName"
            RU_3_R_Sprite.scene?.scaleMode = .aspectFill
            RU_3_R_Sprite.zPosition=0
            addChild(RU_3_R_Sprite)
        }


        //150-200
        func show_RU_4_R (){

            texture = SKTexture (imageNamed: "RU_4_R")
            RU_4_R_Sprite = SKSpriteNode(texture: texture)
            RU_4_R_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

             if CurrentOrientation() == Constants().PORTRAIT {
                RU_4_R_Sprite.size = CGSize(width: ranks_RUSize().shirinaA_p, height: ranks_RUSize().visotaA_p)
                RU_4_R_Sprite.position = CGPoint(x: RU_3_R_Sprite.frame.origin.x+RU_3_R_Sprite.frame.size.width*2+CGFloat(ranks_RUSize().otstup_p), y: self.frame.size.height/2-240)
            } else {
                RU_4_R_Sprite.size = CGSize(width: ranks_RUSize().shirinaA, height: ranks_RUSize().visotaA)
                RU_4_R_Sprite.position = CGPoint(x: RU_3_R_Sprite.frame.origin.x+ranks_RUSize().shirinaA+ranks_RUSize().otstup, y: self.frame.size.height/2-200)
            }

            RU_4_R_Sprite.name = "RU_4_R_SpriteName"
            RU_4_R_Sprite.scene?.scaleMode = .aspectFill
            RU_4_R_Sprite.zPosition=0
            addChild(RU_4_R_Sprite)
        }


        //200-300
        func show_RU_5_R (){

            texture = SKTexture (imageNamed: "RU_5_R")
            RU_5_R_Sprite = SKSpriteNode(texture: texture)
            RU_5_R_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

             if CurrentOrientation() == Constants().PORTRAIT {
                RU_5_R_Sprite.size = CGSize(width: ranks_RUSize().shirinaA_p, height: ranks_RUSize().visotaA_p)
                RU_5_R_Sprite.position = CGPoint(x: RU_4_R_Sprite.frame.origin.x+RU_4_R_Sprite.frame.size.width*2+CGFloat(ranks_RUSize().otstup_p), y: self.frame.size.height/2-240)
            } else {
                RU_5_R_Sprite.size = CGSize(width: ranks_RUSize().shirinaA, height: ranks_RUSize().visotaA)
                RU_5_R_Sprite.position = CGPoint(x: RU_4_R_Sprite.frame.origin.x+ranks_RUSize().shirinaA+ranks_RUSize().otstup, y: self.frame.size.height/2-200)
            }

            RU_5_R_Sprite.name = "RU_5_R_SpriteName"
            RU_5_R_Sprite.scene?.scaleMode = .aspectFill
            RU_5_R_Sprite.zPosition=0
            addChild(RU_5_R_Sprite)
        }


        //300-400
        func show_RU_6_R (){

            texture = SKTexture (imageNamed: "RU_6_R")
            RU_6_R_Sprite = SKSpriteNode(texture: texture)
            RU_6_R_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

             if CurrentOrientation() == Constants().PORTRAIT {
                RU_6_R_Sprite.size = CGSize(width: ranks_RUSize().shirinaA_p, height: ranks_RUSize().visotaA_p)
                RU_6_R_Sprite.position = CGPoint(x: RU_5_R_Sprite.frame.origin.x+RU_5_R_Sprite.frame.size.width*2+CGFloat(ranks_RUSize().otstup_p), y: self.frame.size.height/2-240)
            } else {
                RU_6_R_Sprite.size = CGSize(width: ranks_RUSize().shirinaA, height: ranks_RUSize().visotaA)
                RU_6_R_Sprite.position = CGPoint(x: RU_5_R_Sprite.frame.origin.x+ranks_RUSize().shirinaA+ranks_RUSize().otstup, y: self.frame.size.height/2-200)
            }

            RU_6_R_Sprite.name = "RU_6_R_SpriteName"
            RU_6_R_Sprite.scene?.scaleMode = .aspectFill
            RU_6_R_Sprite.zPosition=0
            addChild(RU_6_R_Sprite)
        }


        //400-500
        func show_RU_7_R (){

            texture = SKTexture (imageNamed: "RU_7_R")
            RU_7_R_Sprite = SKSpriteNode(texture: texture)
            RU_7_R_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

             if CurrentOrientation() == Constants().PORTRAIT {
                RU_7_R_Sprite.size = CGSize(width: ranks_RUSize().shirinaA_p, height: ranks_RUSize().visotaA_p)
                RU_7_R_Sprite.position = CGPoint(x: RU_6_R_Sprite.frame.origin.x+RU_6_R_Sprite.frame.size.width*2+CGFloat(ranks_RUSize().otstup_p), y: self.frame.size.height/2-240)
            } else {
                RU_7_R_Sprite.size = CGSize(width: ranks_RUSize().shirinaA, height: ranks_RUSize().visotaA)
                RU_7_R_Sprite.position = CGPoint(x: RU_6_R_Sprite.frame.origin.x+ranks_RUSize().shirinaA+ranks_RUSize().otstup, y: self.frame.size.height/2-200)
            }

            RU_7_R_Sprite.name = "RU_7_R_SpriteName"
            RU_7_R_Sprite.scene?.scaleMode = .aspectFill
            RU_7_R_Sprite.zPosition=0
            addChild(RU_7_R_Sprite)
        }

        //500-750
        func show_RU_8_R (){

            texture = SKTexture (imageNamed: "RU_8_R")
            RU_8_R_Sprite = SKSpriteNode(texture: texture)
            RU_8_R_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

             if CurrentOrientation() == Constants().PORTRAIT {
                RU_8_R_Sprite.size = CGSize(width: ranks_RUSize().shirinaA_p, height: ranks_RUSize().visotaA_p)
                RU_8_R_Sprite.position = CGPoint(x: RU_7_R_Sprite.frame.origin.x+RU_7_R_Sprite.frame.size.width*2+CGFloat(ranks_RUSize().otstup_p), y: self.frame.size.height/2-240)
            } else {
                RU_8_R_Sprite.size = CGSize(width: ranks_RUSize().shirinaA, height: ranks_RUSize().visotaA)
                RU_8_R_Sprite.position = CGPoint(x: RU_7_R_Sprite.frame.origin.x+ranks_RUSize().shirinaA+ranks_RUSize().otstup, y: self.frame.size.height/2-200)
            }

            RU_8_R_Sprite.name = "RU_8_R_SpriteName"
            RU_8_R_Sprite.scene?.scaleMode = .aspectFill
            RU_8_R_Sprite.zPosition=0
            addChild(RU_8_R_Sprite)
        }


        //750-1000
        func show_RU_9_R (){

            texture = SKTexture (imageNamed: "RU_9_R")
            RU_9_R_Sprite = SKSpriteNode(texture: texture)
            RU_9_R_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

             if CurrentOrientation() == Constants().PORTRAIT {
                RU_9_R_Sprite.size = CGSize(width: ranks_RUSize().shirinaA_p, height: ranks_RUSize().visotaA_p)
                RU_9_R_Sprite.position = CGPoint(x: RU_8_R_Sprite.frame.origin.x+RU_8_R_Sprite.frame.size.width*2+CGFloat(ranks_RUSize().otstup_p), y: self.frame.size.height/2-240)
            } else {
                RU_9_R_Sprite.size = CGSize(width: ranks_RUSize().shirinaA, height: ranks_RUSize().visotaA)
                RU_9_R_Sprite.position = CGPoint(x: RU_8_R_Sprite.frame.origin.x+ranks_RUSize().shirinaA+ranks_RUSize().otstup, y: self.frame.size.height/2-200)
            }

            RU_9_R_Sprite.name = "RU_9_R_SpriteName"
            RU_9_R_Sprite.scene?.scaleMode = .aspectFill
            RU_9_R_Sprite.zPosition=0
            addChild(RU_9_R_Sprite)
        }


        //1000-2000
        func show_RU_10_R (){

            texture = SKTexture (imageNamed: "RU_10_R")
            RU_10_R_Sprite = SKSpriteNode(texture: texture)
            RU_10_R_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

             if CurrentOrientation() == Constants().PORTRAIT {
                RU_10_R_Sprite.size = CGSize(width: ranks_RUSize().shirinaA_p, height: ranks_RUSize().visotaA_p)
                RU_10_R_Sprite.position = CGPoint(x: RU_9_R_Sprite.frame.origin.x+RU_9_R_Sprite.frame.size.width*2+CGFloat(ranks_RUSize().otstup_p), y: self.frame.size.height/2-240)
            } else {
                RU_10_R_Sprite.size = CGSize(width: ranks_RUSize().shirinaA, height: ranks_RUSize().visotaA)
                RU_10_R_Sprite.position = CGPoint(x: RU_9_R_Sprite.frame.origin.x+ranks_RUSize().shirinaA+ranks_RUSize().otstup, y: self.frame.size.height/2-200)
            }

            RU_10_R_Sprite.name = "RU_10_R_SpriteName"
            RU_10_R_Sprite.scene?.scaleMode = .aspectFill
            RU_10_R_Sprite.zPosition=0
            addChild(RU_10_R_Sprite)
        }


        //2000-выше
        func show_RU_11_R (){

            texture = SKTexture (imageNamed: "RU_11_R")
            RU_11_R_Sprite = SKSpriteNode(texture: texture)
            RU_11_R_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

             if CurrentOrientation() == Constants().PORTRAIT {
                RU_11_R_Sprite.size = CGSize(width: ranks_RUSize().shirinaA_p, height: ranks_RUSize().visotaA_p)
                RU_11_R_Sprite.position = CGPoint(x: RU_10_R_Sprite.frame.origin.x+RU_10_R_Sprite.frame.size.width*2+CGFloat(ranks_RUSize().otstup_p), y: self.frame.size.height/2-240)
            } else {
                RU_11_R_Sprite.size = CGSize(width: ranks_RUSize().shirinaA, height: ranks_RUSize().visotaA)
                RU_11_R_Sprite.position = CGPoint(x: RU_10_R_Sprite.frame.origin.x+ranks_RUSize().shirinaA+ranks_RUSize().otstup, y: self.frame.size.height/2-200)
            }

            RU_11_R_Sprite.name = "RU_11_R_SpriteName"
            RU_11_R_Sprite.scene?.scaleMode = .aspectFill
            RU_11_R_Sprite.zPosition=0
            addChild(RU_11_R_Sprite)
        }


        func show_RU_1 (){

            texture = SKTexture (imageNamed: "RU_1")
            RU_1_Sprite = SKSpriteNode(texture: texture)
            RU_1_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

             if CurrentOrientation() == Constants().PORTRAIT {
                RU_1_Sprite.size = CGSize(width: ranks_RUSize().shirinaO_p, height: ranks_RUSize().visotaO_p)
                RU_1_Sprite.position = CGPoint(x: -173, y: -90)
            } else {
                RU_1_Sprite.size = CGSize(width: ranks_RUSize().shirinaO, height: ranks_RUSize().visotaO)
                RU_1_Sprite.position = CGPoint(x: -250, y: -75)
            }

            RU_1_Sprite.name = "RU_1_SpriteName"
            RU_1_Sprite.scene?.scaleMode = .aspectFill
            RU_1_Sprite.zPosition=0
            addChild(RU_1_Sprite)
        }

        func show_RU_2 (){

            texture = SKTexture (imageNamed: "RU_2")
            RU_2_Sprite = SKSpriteNode(texture: texture)
            RU_2_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

             if CurrentOrientation() == Constants().PORTRAIT {
                RU_2_Sprite.size = CGSize(width: ranks_RUSize().shirinaO_p, height: ranks_RUSize().visotaO_p)
                RU_2_Sprite.position = CGPoint(x: RU_1_Sprite.frame.origin.x+148, y: -90)
            } else {
                RU_2_Sprite.size = CGSize(width: ranks_RUSize().shirinaO, height: ranks_RUSize().visotaO)
                RU_2_Sprite.position = CGPoint(x: RU_1_Sprite.frame.origin.x+215, y: -75)
            }

            RU_2_Sprite.name = "RU_2_SpriteName"
            RU_2_Sprite.scene?.scaleMode = .aspectFill
            RU_2_Sprite.zPosition=0
            addChild(RU_2_Sprite)
        }


        func show_RU_3 (){

            texture = SKTexture (imageNamed: "RU_3")
            RU_3_Sprite = SKSpriteNode(texture: texture)
            RU_3_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

                 if CurrentOrientation() == Constants().PORTRAIT {
                    RU_3_Sprite.size = CGSize(width: ranks_RUSize().shirinaO_p, height: ranks_RUSize().visotaO_p)
                    RU_3_Sprite.position = CGPoint(x: RU_2_Sprite.frame.origin.x+150, y: -90)
                } else {
                    RU_3_Sprite.size = CGSize(width: ranks_RUSize().shirinaO, height: ranks_RUSize().visotaO)
                    RU_3_Sprite.position = CGPoint(x: RU_2_Sprite.frame.origin.x+215, y: -75)
                }

            RU_3_Sprite.name = "RU_3_SpriteName"
            RU_3_Sprite.scene?.scaleMode = .aspectFill
            RU_3_Sprite.zPosition=0
            addChild(RU_3_Sprite)
        }


        func show_RU_4 (){

            texture = SKTexture (imageNamed: "RU_4")
            RU_4_Sprite = SKSpriteNode(texture: texture)
            RU_4_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

                 if CurrentOrientation() == Constants().PORTRAIT {
                    RU_4_Sprite.size = CGSize(width: ranks_RUSize().shirinaO_p, height: ranks_RUSize().visotaO_p)
                    RU_4_Sprite.position = CGPoint(x: RU_3_Sprite.frame.origin.x+150, y: -90)
                } else {
                    RU_4_Sprite.size = CGSize(width: ranks_RUSize().shirinaO, height: ranks_RUSize().visotaO)
                    RU_4_Sprite.position = CGPoint(x: RU_3_Sprite.frame.origin.x+215, y: -75)
                }

            RU_4_Sprite.name = "RU_4_SpriteName"
            RU_4_Sprite.scene?.scaleMode = .aspectFill
            RU_4_Sprite.zPosition=0
            addChild(RU_4_Sprite)
        }

        func show_RU_5 (){

            texture = SKTexture (imageNamed: "RU_5")
            RU_5_Sprite = SKSpriteNode(texture: texture)
            RU_5_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

                 if CurrentOrientation() == Constants().PORTRAIT {
                    RU_5_Sprite.size = CGSize(width: ranks_RUSize().shirinaO_p, height: ranks_RUSize().visotaO_p)
                    RU_5_Sprite.position = CGPoint(x: RU_4_Sprite.frame.origin.x+150, y: -90)
                } else {
                    RU_5_Sprite.size = CGSize(width: ranks_RUSize().shirinaO, height: ranks_RUSize().visotaO)
                    RU_5_Sprite.position = CGPoint(x: RU_4_Sprite.frame.origin.x+215, y: -75)
                }

            RU_5_Sprite.name = "RU_5_SpriteName"
            RU_5_Sprite.scene?.scaleMode = .aspectFill
            RU_5_Sprite.zPosition=0
            addChild(RU_5_Sprite)
        }
    

    
    /*--------------------------------------makeUS_NAVY------------------------------*/
    func makeUS_RANKS(){
        
        let destroyedUD = UserDefaults.standard.object(forKey: Constants().DESTROYED_KEY) as! Int

        if destroyedUD>=0 {show_US_1_R()}
         //50-100
         if destroyedUD>=50 {
            show_US_2_R()
            show_US_1 ()
         }
         //100-150
        if destroyedUD>=100 {show_US_3_R()}
         //150-200
         if destroyedUD>=150 {show_US_4_R()}
         //200-300
         if destroyedUD>=200 {
            show_US_5_R()
            show_US_2 ()
         }
         //300-400
         if destroyedUD>=300 {show_US_6_R()}
         //400-500
         if destroyedUD>=400 {show_US_7_R()}

         //500-750
         if destroyedUD>=500 {
            show_US_8_R()
            show_US_3 ()
         }
         //750-1000
         if destroyedUD>=750 {show_US_9_R()}
         //1000-2000
         if destroyedUD>=1000 {
            show_US_10_R()
            show_US_4 ()
         }
         //2000-выше
         if destroyedUD>=2000 {
            show_US_11_R()
            show_US_5 ()
         }
    }
        
        
    /*--------------------------------------SHOW_US_NAVY------------------------------*/
        func show_US_1_R (){
            texture = SKTexture (imageNamed: "US_1_R")
            US_1_R_Sprite = SKSpriteNode(texture: texture)
            US_1_R_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

             if CurrentOrientation() == Constants().PORTRAIT {
               US_1_R_Sprite.size = CGSize(width: ranksSize().shirinaA_p, height: ranksSize().visotaA_p)
               US_1_R_Sprite.position = CGPoint(x: -220+ranksSize().otstup_p, y: self.frame.size.height/2-240)

            } else {
               US_1_R_Sprite.size = CGSize(width: ranksSize().shirinaA, height: ranksSize().visotaA)
                US_1_R_Sprite.position = CGPoint(x: -self.frame.size.width/2+US_1_R_Sprite.frame.size.width/2+60, y: self.frame.size.height/2-200)
            }


            US_1_R_Sprite.name = "US_1_R_SpriteName"
            US_1_R_Sprite.scene?.scaleMode = .aspectFill
            US_1_R_Sprite.zPosition=0
            addChild(US_1_R_Sprite)
        }
    
        func show_US_2_R() {
            texture = SKTexture (imageNamed: "US_2_R")
            US_2_R_Sprite = SKSpriteNode(texture: texture)
            US_2_R_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

             if CurrentOrientation() == Constants().PORTRAIT {
                US_2_R_Sprite.size = CGSize(width: ranksSize().shirinaA_p, height: ranksSize().visotaA_p)
               US_2_R_Sprite.position = CGPoint(x: US_1_R_Sprite.frame.origin.x+US_1_R_Sprite.frame.size.width*2+ranksSize().otstup_p, y: self.frame.size.height/2-240)

            } else {
               US_2_R_Sprite.size = CGSize(width: ranksSize().shirinaA, height: ranksSize().visotaA)
               US_2_R_Sprite.position = CGPoint(x: US_1_R_Sprite.frame.origin.x+ranksSize().shirinaA+ranksSize().otstup, y: self.frame.size.height/2-200)
            }

            US_2_R_Sprite.name = "US_2_R_SpriteName"
            US_2_R_Sprite.scene?.scaleMode = .aspectFill
            US_2_R_Sprite.zPosition=0
            addChild(US_2_R_Sprite)
        }
    
    
        func show_US_3_R() {
            texture = SKTexture (imageNamed: "US_3_R")
            US_3_R_Sprite = SKSpriteNode(texture: texture)
            US_3_R_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

             if CurrentOrientation() == Constants().PORTRAIT {
                US_3_R_Sprite.size = CGSize(width: ranksSize().shirinaA_p, height: ranksSize().visotaA_p)
               US_3_R_Sprite.position = CGPoint(x: US_2_R_Sprite.frame.origin.x+US_2_R_Sprite.frame.size.width*2+ranksSize().otstup_p, y: self.frame.size.height/2-240)

            } else {
               US_3_R_Sprite.size = CGSize(width: ranksSize().shirinaA, height: ranksSize().visotaA)
               US_3_R_Sprite.position = CGPoint(x: US_2_R_Sprite.frame.origin.x+ranksSize().shirinaA+ranksSize().otstup, y: self.frame.size.height/2-200)
            }

            US_3_R_Sprite.name = "US_3_R_SpriteName"
            US_3_R_Sprite.scene?.scaleMode = .aspectFill
            US_3_R_Sprite.zPosition=0
            addChild(US_3_R_Sprite)
        }
    
        func show_US_4_R() {
            texture = SKTexture (imageNamed: "US_4_R")
            US_4_R_Sprite = SKSpriteNode(texture: texture)
            US_4_R_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

             if CurrentOrientation() == Constants().PORTRAIT {
                US_4_R_Sprite.size = CGSize(width: ranksSize().shirinaA_p, height: ranksSize().visotaA_p)
               US_4_R_Sprite.position = CGPoint(x: US_3_R_Sprite.frame.origin.x+US_3_R_Sprite.frame.size.width*2+ranksSize().otstup_p, y: self.frame.size.height/2-240)

            } else {
               US_4_R_Sprite.size = CGSize(width: ranksSize().shirinaA, height: ranksSize().visotaA)
               US_4_R_Sprite.position = CGPoint(x: US_3_R_Sprite.frame.origin.x+ranksSize().shirinaA+ranksSize().otstup, y: self.frame.size.height/2-200)
            }

            US_4_R_Sprite.name = "US_4_R_SpriteName"
            US_4_R_Sprite.scene?.scaleMode = .aspectFill
            US_4_R_Sprite.zPosition=0
            addChild(US_4_R_Sprite)
        }
        
    
        func show_US_5_R() {
            texture = SKTexture (imageNamed: "US_5_R")
            US_5_R_Sprite = SKSpriteNode(texture: texture)
            US_5_R_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

             if CurrentOrientation() == Constants().PORTRAIT {
                US_5_R_Sprite.size = CGSize(width: ranksSize().shirinaA_p, height: ranksSize().visotaA_p)
               US_5_R_Sprite.position = CGPoint(x: US_4_R_Sprite.frame.origin.x+US_4_R_Sprite.frame.size.width*2+ranksSize().otstup_p, y: self.frame.size.height/2-240)

            } else {
               US_5_R_Sprite.size = CGSize(width: ranksSize().shirinaA, height: ranksSize().visotaA)
               US_5_R_Sprite.position = CGPoint(x: US_4_R_Sprite.frame.origin.x+ranksSize().shirinaA+ranksSize().otstup, y: self.frame.size.height/2-200)
            }

            US_5_R_Sprite.name = "US_5_R_SpriteName"
            US_5_R_Sprite.scene?.scaleMode = .aspectFill
            US_5_R_Sprite.zPosition=0
            addChild(US_5_R_Sprite)
        }
        
        func show_US_6_R() {
            texture = SKTexture (imageNamed: "US_6_R")
            US_6_R_Sprite = SKSpriteNode(texture: texture)
            US_6_R_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

             if CurrentOrientation() == Constants().PORTRAIT {
                US_6_R_Sprite.size = CGSize(width: ranksSize().shirinaA_p, height: ranksSize().visotaA_p)
               US_6_R_Sprite.position = CGPoint(x: US_5_R_Sprite.frame.origin.x+US_5_R_Sprite.frame.size.width*2+ranksSize().otstup_p, y: self.frame.size.height/2-240)

            } else {
               US_6_R_Sprite.size = CGSize(width: ranksSize().shirinaA, height: ranksSize().visotaA)
               US_6_R_Sprite.position = CGPoint(x: US_5_R_Sprite.frame.origin.x+ranksSize().shirinaA+ranksSize().otstup, y: self.frame.size.height/2-200)
            }

            US_6_R_Sprite.name = "US_6_R_SpriteName"
            US_6_R_Sprite.scene?.scaleMode = .aspectFill
            US_6_R_Sprite.zPosition=0
            addChild(US_6_R_Sprite)
        }
    
        func  show_US_7_R() {
            texture = SKTexture (imageNamed: "US_7_R")
            US_7_R_Sprite = SKSpriteNode(texture: texture)
            US_7_R_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

             if CurrentOrientation() == Constants().PORTRAIT {
                US_7_R_Sprite.size = CGSize(width: ranksSize().shirinaA_p, height: ranksSize().visotaA_p)
               US_7_R_Sprite.position = CGPoint(x: US_6_R_Sprite.frame.origin.x+US_6_R_Sprite.frame.size.width*2+ranksSize().otstup_p, y: self.frame.size.height/2-240)

            } else {
               US_7_R_Sprite.size = CGSize(width: ranksSize().shirinaA, height: ranksSize().visotaA)
               US_7_R_Sprite.position = CGPoint(x: US_6_R_Sprite.frame.origin.x+ranksSize().shirinaA+ranksSize().otstup, y: self.frame.size.height/2-200)
            }

            US_7_R_Sprite.name = "US_7_R_SpriteName"
            US_7_R_Sprite.scene?.scaleMode = .aspectFill
            US_7_R_Sprite.zPosition=0
            addChild(US_7_R_Sprite)
        }
    
        func show_US_8_R() {
            texture = SKTexture (imageNamed: "US_8_R")
            US_8_R_Sprite = SKSpriteNode(texture: texture)
            US_8_R_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

             if CurrentOrientation() == Constants().PORTRAIT {
                US_8_R_Sprite.size = CGSize(width: ranksSize().shirinaA_p, height: ranksSize().visotaA_p)
               US_8_R_Sprite.position = CGPoint(x: US_7_R_Sprite.frame.origin.x+US_7_R_Sprite.frame.size.width*2+ranksSize().otstup_p, y: self.frame.size.height/2-240)

            } else {
               US_8_R_Sprite.size = CGSize(width: ranksSize().shirinaA, height: ranksSize().visotaA)
               US_8_R_Sprite.position = CGPoint(x: US_7_R_Sprite.frame.origin.x+ranksSize().shirinaA+ranksSize().otstup, y: self.frame.size.height/2-200)
            }

            US_8_R_Sprite.name = "US_8_R_SpriteName"
            US_8_R_Sprite.scene?.scaleMode = .aspectFill
            US_8_R_Sprite.zPosition=0
            addChild(US_8_R_Sprite)

        }
        func  show_US_9_R() {
            texture = SKTexture (imageNamed: "US_9_R")
            US_9_R_Sprite = SKSpriteNode(texture: texture)
            US_9_R_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

             if CurrentOrientation() == Constants().PORTRAIT {
                US_9_R_Sprite.size = CGSize(width: ranksSize().shirinaA_p, height: ranksSize().visotaA_p)
               US_9_R_Sprite.position = CGPoint(x: US_8_R_Sprite.frame.origin.x+US_8_R_Sprite.frame.size.width*2+ranksSize().otstup_p, y: self.frame.size.height/2-240)

            } else {
               US_9_R_Sprite.size = CGSize(width: ranksSize().shirinaA, height: ranksSize().visotaA)
               US_9_R_Sprite.position = CGPoint(x: US_8_R_Sprite.frame.origin.x+ranksSize().shirinaA+ranksSize().otstup, y: self.frame.size.height/2-200)
            }

            US_9_R_Sprite.name = "US_9_R_SpriteName"
            US_9_R_Sprite.scene?.scaleMode = .aspectFill
            US_9_R_Sprite.zPosition=0
            addChild(US_9_R_Sprite)
        }
    
        func show_US_10_R(){
            texture = SKTexture (imageNamed: "US_10_R")
            US_10_R_Sprite = SKSpriteNode(texture: texture)
            US_10_R_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

             if CurrentOrientation() == Constants().PORTRAIT {
                US_10_R_Sprite.size = CGSize(width: ranksSize().shirinaA_p, height: ranksSize().visotaA_p)
               US_10_R_Sprite.position = CGPoint(x: US_9_R_Sprite.frame.origin.x+US_9_R_Sprite.frame.size.width*2+ranksSize().otstup_p, y: self.frame.size.height/2-240)

            } else {
               US_10_R_Sprite.size = CGSize(width: ranksSize().shirinaA, height: ranksSize().visotaA)
               US_10_R_Sprite.position = CGPoint(x: US_9_R_Sprite.frame.origin.x+ranksSize().shirinaA+ranksSize().otstup, y: self.frame.size.height/2-200)
            }

            US_10_R_Sprite.name = "US_10_R_SpriteName"
            US_10_R_Sprite.scene?.scaleMode = .aspectFill
            US_10_R_Sprite.zPosition=0
            addChild(US_10_R_Sprite)
        }
        func show_US_11_R(){
            texture = SKTexture (imageNamed: "US_11_R")
            US_11_R_Sprite = SKSpriteNode(texture: texture)
            US_11_R_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

             if CurrentOrientation() == Constants().PORTRAIT {
                US_11_R_Sprite.size = CGSize(width: ranksSize().shirinaA_p, height: ranksSize().visotaA_p)
               US_11_R_Sprite.position = CGPoint(x: US_10_R_Sprite.frame.origin.x+US_10_R_Sprite.frame.size.width*2+ranksSize().otstup_p, y: self.frame.size.height/2-240)

            } else {
               US_11_R_Sprite.size = CGSize(width: ranksSize().shirinaA, height: ranksSize().visotaA)
               US_11_R_Sprite.position = CGPoint(x: US_10_R_Sprite.frame.origin.x+ranksSize().shirinaA+ranksSize().otstup, y: self.frame.size.height/2-200)
            }

            US_11_R_Sprite.name = "US_11_R_SpriteName"
            US_11_R_Sprite.scene?.scaleMode = .aspectFill
            US_11_R_Sprite.zPosition=0
            addChild(US_11_R_Sprite)
        }
        func show_US_1(){
            texture = SKTexture (imageNamed: "US_1")
            US_1_Sprite = SKSpriteNode(texture: texture)
            US_1_Sprite.anchorPoint = CGPoint(x: 1, y: 1)


             if CurrentOrientation() == Constants().PORTRAIT {
                US_1_Sprite.size = CGSize (width: ranksSize().shirinaO_p, height: ranksSize().visotaO_p)
                US_1_Sprite.position = CGPoint(x: -173, y: -90)
            } else {
               US_1_Sprite.size = CGSize (width: ranksSize().shirinaO, height: ranksSize().visotaO)
                US_1_Sprite.position = CGPoint(x: -250, y: -75)
            }


            US_1_Sprite.name = "US_1_SpriteName"
            US_1_Sprite.scene?.scaleMode = .aspectFill
            US_1_Sprite.zPosition=0
            addChild(US_1_Sprite)
        }
    
        func show_US_2(){
            texture = SKTexture (imageNamed: "US_2")
            US_2_Sprite = SKSpriteNode(texture: texture)
            US_2_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

             if CurrentOrientation() == Constants().PORTRAIT {
               US_2_Sprite.size = CGSize(width: ranksSize().shirinaO_p, height: ranksSize().visotaO_p)
                US_2_Sprite.position = CGPoint(x: US_1_Sprite.frame.origin.x+148, y: -90)
            } else {
               US_2_Sprite.size = CGSize(width: ranksSize().shirinaO, height: ranksSize().visotaO)
                US_2_Sprite.position = CGPoint(x: US_1_Sprite.frame.origin.x+210, y: -75)
            }

            US_2_Sprite.name = "US_2_SpriteName"
            US_2_Sprite.scene?.scaleMode = .aspectFill
            US_2_Sprite.zPosition=0
            addChild(US_2_Sprite)
        }
    
    
        func show_US_3(){
            texture = SKTexture (imageNamed: "US_3")
            US_3_Sprite = SKSpriteNode(texture: texture)
            US_3_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

                 if CurrentOrientation() == Constants().PORTRAIT {
                   US_3_Sprite.size = CGSize(width: ranksSize().shirinaO_p, height: ranksSize().visotaO_p)
                    US_3_Sprite.position = CGPoint(x: US_2_Sprite.frame.origin.x+148, y: -90)
                } else {
                   US_3_Sprite.size = CGSize(width: ranksSize().shirinaO, height: ranksSize().visotaO)
                    US_3_Sprite.position = CGPoint(x: US_2_Sprite.frame.origin.x+210, y: -75)
                }

            US_3_Sprite.name = "US_3_SpriteName"
            US_3_Sprite.scene?.scaleMode = .aspectFill
            US_3_Sprite.zPosition=0
            addChild(US_3_Sprite)
        }
    
        func show_US_4(){
            texture = SKTexture (imageNamed: "US_4")
            US_4_Sprite = SKSpriteNode(texture: texture)
            US_4_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

                 if CurrentOrientation() == Constants().PORTRAIT {
                   US_4_Sprite.size = CGSize(width: ranksSize().shirinaO_p, height: ranksSize().visotaO_p)
                    US_4_Sprite.position = CGPoint(x: US_3_Sprite.frame.origin.x+148, y: -90)
                } else {
                   US_4_Sprite.size = CGSize(width: ranksSize().shirinaO, height: ranksSize().visotaO)
                    US_4_Sprite.position = CGPoint(x: US_3_Sprite.frame.origin.x+210, y: -75)
                }

            US_4_Sprite.name = "US_4_SpriteName"
            US_4_Sprite.scene?.scaleMode = .aspectFill
            US_4_Sprite.zPosition=0
            addChild(US_4_Sprite)
        }
    
        func show_US_5() {
            texture = SKTexture (imageNamed: "US_5")
            US_5_Sprite = SKSpriteNode(texture: texture)
            US_5_Sprite.anchorPoint = CGPoint(x: 1, y: 1)

                 if CurrentOrientation() == Constants().PORTRAIT {
                   US_5_Sprite.size = CGSize(width: ranksSize().shirinaO_p, height: ranksSize().visotaO_p)
                    US_5_Sprite.position = CGPoint(x: US_4_Sprite.frame.origin.x+155, y: -90)
                } else {
                   US_5_Sprite.size = CGSize(width: ranksSize().shirinaO, height: ranksSize().visotaO)
                    US_5_Sprite.position = CGPoint(x: US_4_Sprite.frame.origin.x+215, y: -75)
                }

            US_5_Sprite.name = "US_5_SpriteName"
            US_5_Sprite.scene?.scaleMode = .aspectFill
            US_5_Sprite.zPosition=0
            addChild(US_5_Sprite)
        }
    }
