//
//  GameScene.m
//  Torpedo attack
//
//  Created by Sergey Silak on 14.01.2021.
//durationTorpedo

import SpriteKit
import UIKit

class GameScene:SKScene, CanReceiveTransitionEvents {
    
    
    var torpedoSpriteInWater:SKSpriteNode!
    var flashSprite:SKSpriteNode!
    var smokeSprite:SKSpriteNode!
    var countdownTimerTorpedoCount:Timer!
    var countdownTimerBoat:Timer!
    var secondsCountTorpedoCount:Int! = 0
    var secondsCountBoat:Int! = 0
    var DURATION_TORPEDO_GLOBAL:Int!
    
    var boatSprite,binokleSprite, BackgroundSprite,BackgroundWaterSprite,RockSpriteLeft,RockSpriteRight, menuButtonSprite, movePointerSprite, strikePinterSprite, destroyPointerSprite,launchButtonSprite, launchButtonSpriteOFF, strikePointerSprite :SKSpriteNode!
    
    var LabelScoresPhysics, LabelInfo, LabelDetonation :SKLabelNode!
    
    var DIRACTION_GLOBAL:String!
    var BOAT_NAME_GLOBAL:String!
    var BOAT_WIDTH_GLOBAL:CGFloat!
    var binokleName: String!
    
    private var runTexture: [SKTexture] = []

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
        
    }
    
    
    //Логика игры
    /*------------------------------------------------Подготовка ИГРЫ------------------------------*/
    override func didMove(to view: SKView) {
            
            //настройки звука
            self.sceneSetting()

            /*------------------------------------------------Загрузка природы------------------------------*/
            /*Загружаем море*/
            //SKTexture
            self.addSea()
            
            //SKTextureAtlas
      //      self.addSeaAtlas()
            
                
            /*Загружаем небо*/
            self.addSky()
            /*Загружаем скалы*/
            //Левая
            self.addLeftRock()
            //Правая
            self.addRightRock()

            /*------------------------------------------------Загрузка элементов главного экрана ------------*/
            /*Загружаем  sprite монокуляра*/
            self.addBinokle()
            /*Загружаем sprites menu и подсказок к кнопкам на sprite Binokle*/
            self.addMenuButton()
            self.addStrikePointer()
            self.addDestroyPointerSprite()
            self.addMovePointerSprite()
            /*Загружаем Label вывода потопленных кораблей*/
            self.addLabelScoresPhysics()
            /*Загружаем Label вывода информации о движении монокля*/
            self.addLabelInfo()

            /*Загружаем кнопку ГОТОВ К СТРЕЛЬБЕ*/
            self.createLaunchON()

            /*------------------------------------------------Загрузка ИГРЫ------------------------------*/
            //Добавляем новый корабль
            self.addBoat()
            /*время движения торпеды*/
            DURATION_TORPEDO_GLOBAL = self.generateTorpedoCount(randomBoat: self.getHardModeStatus())
            /*Загружаем Label времени движения торпеды*/
            self.createLabelDetonation()
    }

    /*------------------------------------------------Начало ИГРЫ------------------------------*/
    // MARK: StartBtn
    func startBtn() {
        //-------------------------------------------------------------- Нажата кнопка пуск торпеды
        self.launchButtonSpriteRemove()
        self.createLaunchOFF()
        self.soundEffects(fileName: Constants().LAUNCH)
        self.setTimer(seconds: DURATION_TORPEDO_GLOBAL)
        self.createTorpedoSpriteInWater()
        self.moveTorpedo(durationTorpedo: Double(DURATION_TORPEDO_GLOBAL))
    }
    
    // MARK: checkCollisions - Проверка попаданий
    func checkCollisions() {
        //-------------------------------------------------------------- Если попадание
        
        let boat_start: Int! = (Int(boatSprite.position.x) - Int(BOAT_WIDTH_GLOBAL/2) + 20)
        let boat_end: Int! = (Int(boatSprite.position.x) + Int(BOAT_WIDTH_GLOBAL/2) - 20)
        let torpedo_center: Int! = Int(torpedoSpriteInWater.position.x)
        
        if (torpedo_center >= boat_start && torpedo_center <= boat_end) {
       //      NSLog(@"BOOM!!!")
            //-------------------------------------------------------------- +1 к попаданию
            self.addStrikeCollision()
            //--------------------------------------------------------------Звук взрыва
            self.soundEffects(fileName: Constants().EXPLOSION)
            //--------------------------------------------------------------вспышка
            self.createFlashEffect()
            //--------------------------------------------------------------убираем вспышку
            self.removeFlashEffect()
            //--------------------------------------------------------------дым
            self.createSmoke()
            //-------------------------------------------------------------- Синхронизация движения дыма и корабля
            self.sinhronizeSmokeBoat()
            //-------------------------------------------------------------- Проверка - Если утопили
            self.ifDestroyedCheck()
        }
    }
    
    // MARK: ifDestroyedCheck - Если утопили
    func ifDestroyedCheck() {

            if getStrikeKey() == 2  {

                    //удаляем строку со счетом
                    labelScoresPhysicsRemove()
                    //удаляем дым
                    smokeRemove()
                    //останавливаем таймер
                    countdownTimerBoatInvalidate()
                    //очищаем количество попаданий в один корабль
                    clearStrikeCount()

                   //+1 потопленный корабль
                    addDestroyedBoatCount()
                    //Корабль тонет
                    boatSlowlyDown()
                    // Добавим строку со счетом потопленных кораблей
                    addLabelScoresPhysics()

            
                    //Проверка вывода приказов
                   if getDestroyed(destroyed: UserDefaults.standard.object(forKey: Constants().DESTROYED_KEY) as! Int) ==  Constants().YES_KEY {
                       //-------------------------------------------------------------- Если ключевые потопленные корабли - вывод сообщений о наградах
                       self.loadInformation()

                   } else {

                       //-------------------------------------------------------------- Добавляем новый корабль и двигаем его
                       self.addBoat()
                       //-------------------------------------------------------------- Расчёт нового времени движения торпеды
                       /*время движения торпеды*/
                        DURATION_TORPEDO_GLOBAL = self.generateTorpedoCount(randomBoat: self.getHardModeStatus())
                       /*Загружаем Label времени движения торпеды*/
                       setLabelDetonation(text: String(format:"%d",DURATION_TORPEDO_GLOBAL))

                   }
            }
    }
    
    //--------------------------------------------------------------Конец логики игры--------------------------------------------------
    

   
    
    
    
    
    func addSky() {
        texture = SKTexture (imageNamed: "sky")
        BackgroundSprite = SKSpriteNode(texture: texture)
        BackgroundSprite.size = self.frame.size
        BackgroundSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        BackgroundSprite.name = "BackgroundSprite"
        BackgroundSprite.scene?.scaleMode = .aspectFill
        BackgroundSprite.zPosition=1
        addChild(BackgroundSprite)
    }
    
    //MARK: SEA
    //------------------------------------------------
    func addSea(){
        self.addSeaSettings()
        self.textureSeaArray()
        self.animateSea()
    }
    func addSeaSettings() {
            BackgroundWaterSprite = SKSpriteNode(texture: SKTexture(imageNamed: "1.png"))
            BackgroundWaterSprite.position = CGPoint(x: -self.frame.size.width/2, y: -self.frame.size.height/2+135)
            BackgroundWaterSprite.anchorPoint = CGPoint(x: 0, y: 0)
            BackgroundWaterSprite.name = "BackgroundWaterSprite"
            BackgroundWaterSprite.scene?.scaleMode = .aspectFill
            BackgroundWaterSprite.size = CGSize(width: 1024, height: 250)
            BackgroundWaterSprite.zPosition=5
            addChild(BackgroundWaterSprite)
        }
    func textureSeaArray (){
        for i in 0...119 {
            runTexture.append(SKTexture(imageNamed: "\(i).png"))
        }
    }
    func animateSea(){
        if BackgroundWaterSprite.action(forKey: "moveWater") == nil {
            BackgroundWaterSprite.run(SKAction.repeatForever(SKAction.animate(with: runTexture, timePerFrame: 0.06,resize: true,restore: false)), withKey:"moveWater")
        }
    }
    //------------------------------------------------
    //MARK: END SEA
    

    
    //MARK: SEA (ATLAS)
    //------------------------------------------------
    func addSeaAtlas(){
        self.addSeaSettingsAtlas()
        textureSeaArrayAtlas()
    }
   
    func addSeaSettingsAtlas() {
            BackgroundWaterSprite = SKSpriteNode(imageNamed: "1.png")
            BackgroundWaterSprite.position = CGPoint(x: -self.frame.size.width/2, y: -self.frame.size.height/2+135)
            BackgroundWaterSprite.anchorPoint = CGPoint(x: 0, y: 0)
            BackgroundWaterSprite.name = "BackgroundWaterSprite"
            BackgroundWaterSprite.scene?.scaleMode = .aspectFill
            BackgroundWaterSprite.size = CGSize(width: 1024, height: 250)
            BackgroundWaterSprite.zPosition=5
            addChild(BackgroundWaterSprite)
        }
    func textureSeaArrayAtlas (){
        var seaFrames: [SKTexture] = []
        DispatchQueue.main.async {
                for i in 0...119 {
                    seaFrames.append(Assets.sharedInstance.sprites.textureNamed("\(i).png"))
                }
            self.animateSeaAtlas(seaFrames: seaFrames)
        }

            }
    func animateSeaAtlas(seaFrames: [SKTexture]){
        if BackgroundWaterSprite.action(forKey: "moveWater") == nil {
            DispatchQueue.main.async {
                self.BackgroundWaterSprite.run(SKAction.repeatForever(SKAction.animate(with: seaFrames, timePerFrame: 0.06,resize: false, restore: true)), withKey:"moveWater")
            }
        }
    }
    //------------------------------------------------
    //MARK: END SEA
    
    
 

    func addLeftRock() {
        texture = SKTexture (imageNamed: "rockLeft")
        RockSpriteLeft = SKSpriteNode(texture: texture)
        RockSpriteLeft.size = CGSize (width: Constants().ROCK_WIDTH, height: Constants().ROCK_HEIGHT)
        RockSpriteLeft.position = CGPoint(x: -self.frame.size.width/2 + Constants().ROCK_WIDTH/2, y: self.frame.midY+Constants().ROCK_HEIGHT/2)
        RockSpriteLeft.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        RockSpriteLeft.name = "RockSpriteLeft"
        RockSpriteLeft.scene?.scaleMode = .aspectFill
        RockSpriteLeft.zPosition=5
        addChild(RockSpriteLeft)
    }

    func addRightRock() {
        texture = SKTexture (imageNamed: "rockRight")
        RockSpriteRight = SKSpriteNode(texture: texture)
        RockSpriteRight.size = CGSize(width: Constants().ROCK_WIDTH, height: Constants().ROCK_HEIGHT)
        RockSpriteRight.position = CGPoint(x: self.frame.size.width/2-Constants().ROCK_WIDTH/2, y: self.frame.midY+Constants().ROCK_HEIGHT/2)
        RockSpriteRight.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        RockSpriteRight.name = "RockSpriteRight"
        RockSpriteRight.scene?.scaleMode = .aspectFill
        RockSpriteRight.zPosition=5
        addChild(RockSpriteRight)
    }

    func addBinokle() {
      
        binokleName = Constants().BINOKLE_NAME_MAIN
        texture = SKTexture (imageNamed: binokleName)
        binokleSprite = SKSpriteNode(texture: texture)
        binokleSprite.size = CGSize(width:self.frame.size.width, height: self.frame.size.width)
        if (CurrentOrientation() == Constants().PORTRAIT) {
            binokleSprite.size = CGSize(width: self.frame.size.height, height: self.frame.size.height)
        }
        binokleSprite.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        binokleSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        binokleSprite.scene?.scaleMode = .aspectFill
        binokleSprite.name = "binokleSprite"
        binokleSprite.zPosition=10
        addChild(binokleSprite)
    }


    func addMenuButton() {
        texture = SKTexture (imageNamed:NSLocalizedString("buttonMenu", comment: ""))
        menuButtonSprite = SKSpriteNode(texture: texture)
        if (CurrentOrientation() == Constants().PORTRAIT) {
       //portrait
            menuButtonSprite.size = CGSize(width: 120, height: 40)
            menuButtonSprite.position = CGPoint(x: -250, y: 330)
        } else {
            menuButtonSprite.size = CGSize(width: 180, height: 60)
            menuButtonSprite.position = CGPoint(x: self.frame.origin.x+10, y: self.frame.size.height/2-120)
        }
        
        menuButtonSprite.anchorPoint = CGPoint(x: 0, y: 0)
        menuButtonSprite.name = "menuButtonSprite"
        menuButtonSprite.scene?.scaleMode = .aspectFill
        menuButtonSprite.zPosition=11
        addChild(menuButtonSprite)
    }


    func addStrikePointer() {
        texture = SKTexture (imageNamed:NSLocalizedString("strikePointer", comment: ""))
        strikePointerSprite = SKSpriteNode(texture: texture)
        strikePointerSprite.anchorPoint = CGPoint(x: 0, y: 0)
        strikePointerSprite.name = "strikePointerSprite"
        strikePointerSprite.scene?.scaleMode = .aspectFill
        strikePointerSprite.zPosition=11
        strikePointerSprite.size = CGSize(width: 200, height: 70)
        strikePointerSprite.position = CGPoint(x: self.frame.origin.x+20, y: -35)
        if (CurrentOrientation() == Constants().PORTRAIT) {
       //portrait
            strikePointerSprite.size = CGSize(width: 115, height: 40)
            strikePointerSprite.position = CGPoint(x: -250, y: self.frame.size.height/2-250)
        }
        addChild(strikePointerSprite)
    }


    func addDestroyPointerSprite() {
        
        texture = SKTexture (imageNamed:NSLocalizedString("destroyPointer", comment: ""))
        destroyPointerSprite = SKSpriteNode(texture: texture)
        destroyPointerSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        destroyPointerSprite.name = "destroyPointerSprite"
        destroyPointerSprite.scene?.scaleMode = .aspectFill
        destroyPointerSprite.zPosition=11
        destroyPointerSprite.size = CGSize(width: 200, height: 70)
        destroyPointerSprite.position = CGPoint(x: self.frame.size.width/2-120, y: self.frame.size.height/2-170)
        if (CurrentOrientation() == Constants().PORTRAIT) {
       //portrait
            destroyPointerSprite.size = CGSize(width: 115, height: 40)
            destroyPointerSprite.position = CGPoint(x: 170, y: self.frame.size.height/2-70)
        }
        addChild(destroyPointerSprite)
    }


    func addMovePointerSprite() {
        texture = SKTexture (imageNamed:"movePointer")
        movePointerSprite = SKSpriteNode(texture: texture)
        movePointerSprite.anchorPoint = CGPoint(x: 0, y: 0)
        movePointerSprite.name = "movePointerSprite"
        movePointerSprite.scene?.scaleMode = .aspectFill
        movePointerSprite.zPosition=11
        movePointerSprite.size = CGSize(width: 200, height: 70)
        movePointerSprite.position = CGPoint(x: self.frame.origin.x+20, y: -self.frame.size.height/2+75)
        if (CurrentOrientation() == Constants().PORTRAIT) {
       //portrait
            movePointerSprite.size = CGSize(width: 140, height: 50)
            movePointerSprite.position = CGPoint(x: -250, y: -self.frame.size.height/2+25)
        }
        addChild(movePointerSprite)
    }


    func addLabelScoresPhysics() {
        
        let destroyedUD:Int = UserDefaults.standard.object(forKey: Constants().DESTROYED_KEY) as! Int
        
        LabelScoresPhysics = SKLabelNode(text: String(format:"%@%d",self.getStringCountZero(destroyed: destroyedUD), destroyedUD ))
        LabelScoresPhysics.fontName="HouseBrokenRoughHQ"
        LabelScoresPhysics.name = "LabelScores"
        LabelScoresPhysics.zPosition=11
        LabelScoresPhysics.fontColor=UIColor.white
        LabelScoresPhysics.position = CGPoint(x: self.frame.size.width/2-120, y: self.frame.size.height/2-120)
        LabelScoresPhysics.fontSize = 60
        if (Constants().BINOKLE_NAME_MAIN == Constants().BINOKLE1_NAME){LabelScoresPhysics.fontColor=UIColor.black}
        
        if (CurrentOrientation() == Constants().PORTRAIT) {
            LabelScoresPhysics.position = CGPoint(x: self.frame.size.height/2-215, y: self.frame.size.height/2-40)
            LabelScoresPhysics.fontSize = 40
        }
        addChild(LabelScoresPhysics)
    }

    
    func getStringCountZero(destroyed:Int) -> String{
        
        var count_zero:String! = ""
        
        switch (destroyed) {
            case 0 ... 9:
                count_zero = "000"
                break
                
            case 10 ... 99:
                count_zero = "00"
                break
            
            case 100 ... 999:
                count_zero = "0"
                break
                
            default:
                break
        }
        
        return count_zero
    }

    
    
    func addLabelInfo() {
        
        LabelInfo = SKLabelNode(text: "0")
        LabelInfo.fontName="Helvetica"
        LabelInfo.name = "LabelInfo"
        LabelInfo.zPosition=11
        LabelInfo.fontColor=UIColor.black
        
        
        if (CurrentOrientation() == Constants().PORTRAIT) {

            if (Constants().BINOKLE_NAME_MAIN == Constants().BINOKLE1_NAME) {
                LabelInfo.position = CGPoint(x: 30, y: 90)
            } else {
                LabelInfo.position = CGPoint(x: 30, y: 100)
            }

            LabelInfo.fontSize = 17

        } else {

            if (Constants().BINOKLE_NAME_MAIN == Constants().BINOKLE1_NAME) {
                LabelInfo.position = CGPoint(x: 30, y: 120)
            } else {
                LabelInfo.position = CGPoint(x: 30, y: 130)
            }
            LabelInfo.fontSize = 20
        }
        self.addChild(LabelInfo)
    }


    func addBoat() {
        //выбор направления движения корабля
        DIRACTION_GLOBAL = self.generateDirectionBoat()
        //выбор размера в зависимости от сложности игры
        BOAT_WIDTH_GLOBAL = self.generateBoatWidth(randomBoat: self.getHardModeStatus())
        //создаем sprite корабля
        self.createBoatSprite()
        //двигаем его
        self.moveSprite(timerInterval: Int(arc4random_uniform(60 - 30) + 30), spriteName: boatSprite)
    }
    

    func generateDirectionBoat() -> String! {
        //-------------------------------------------------------------- Выбор направления движения корабля
        if Int.random(in: 0..<2) == 0 {
            //движение справа
            let arrayBoatsRight:[String] = Constants().ARRAY_BOATS_RIGHT
            BOAT_NAME_GLOBAL = arrayBoatsRight.randomElement()
            DIRACTION_GLOBAL = Constants().FROM_RIGHT
        } else{
            //движение слева
            let arrayBoatsLeft:[String] = Constants().ARRAY_BOATS_LEFT
            BOAT_NAME_GLOBAL = arrayBoatsLeft.randomElement()
            DIRACTION_GLOBAL = Constants().FROM_LEFT
        }
        return DIRACTION_GLOBAL
    }


    func generateBoatWidth(randomBoat:String!) -> CGFloat {
        //размер корабля
        BOAT_WIDTH_GLOBAL = Constants().DEFINE_BOAT_WIDTH
        if (randomBoat == Constants().YES_KEY) {
            BOAT_WIDTH_GLOBAL = CGFloat (Constants().ARRAY_BOAT_WIDTH.randomElement() ?? Int(Constants().DEFINE_BOAT_WIDTH))
        }
        return BOAT_WIDTH_GLOBAL
    }


    func createBoatSprite() {
        //-------------------------------------------------------------- Создаем и добавляем на сцену спрайт корабля
        texture = SKTexture (imageNamed: BOAT_NAME_GLOBAL)
        boatSprite = SKSpriteNode(texture: texture)
        boatSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        boatSprite.name = "boatSprite"
        
        if (CurrentOrientation() == Constants().PORTRAIT) {

            boatSprite.size = CGSize (width: BOAT_WIDTH_GLOBAL * Constants().sizeBOAT, height: BOAT_WIDTH_GLOBAL*Constants().sizeBOAT/3)

            if (DIRACTION_GLOBAL == Constants().FROM_RIGHT) {
                boatSprite.position = CGPoint (x: -self.frame.size.width/2 + BOAT_WIDTH_GLOBAL * Constants().sizeBOAT/2, y: self.frame.midY + BOAT_WIDTH_GLOBAL * Constants().sizeBOAT/3/2)
        } else {
            boatSprite.position = CGPoint (x: self.frame.size.width/2 - BOAT_WIDTH_GLOBAL * Constants().sizeBOAT/2, y: self.frame.midY + BOAT_WIDTH_GLOBAL * Constants().sizeBOAT/3/2)
        }

    } else{
        boatSprite.size = CGSize (width: BOAT_WIDTH_GLOBAL, height: BOAT_WIDTH_GLOBAL/3)
        if (DIRACTION_GLOBAL == Constants().FROM_RIGHT) {
            boatSprite.position = CGPoint (x: -self.frame.size.width - self.frame.size.width/2+BOAT_WIDTH_GLOBAL/2, y: self.frame.midY+BOAT_WIDTH_GLOBAL/3/2)
        } else {
            boatSprite.position = CGPoint (x: self.frame.size.width/2 - BOAT_WIDTH_GLOBAL/2, y: self.frame.midY+BOAT_WIDTH_GLOBAL/3/2)
        }
    }
        boatSprite.zPosition = 2

        boatSprite.scene?.scaleMode = .aspectFill
        BackgroundSprite.addChild(boatSprite)
    }


    // MARK: GENERATE TORPEDO DURATION

    func generateTorpedoCount(randomBoat:String!) -> Int {
        //время торпеды
        DURATION_TORPEDO_GLOBAL = Constants().DEFINE_MOVE_TORPEDO
        if (randomBoat == Constants().YES_KEY) {
            DURATION_TORPEDO_GLOBAL = Constants().ARRAY_DURATION_TORPEDO.randomElement() ?? 5
        }
        return  DURATION_TORPEDO_GLOBAL
    }


    // MARK: CHANGE SPRITES FRAME ORIENTATION

    func cspBinokle() {
        if (CurrentOrientation() == Constants().PORTRAIT) {

            binokleSprite.size = CGSize(width: self.frame.size.height, height: self.frame.size.height)
        } else {
            binokleSprite.size = CGSize(width: self.frame.size.width, height: self.frame.size.width)
            }
    }

    func cspmenuButtonSprite() {
        if (CurrentOrientation() == Constants().PORTRAIT) {
       //portrait
            menuButtonSprite.size = CGSize(width: 120, height:40)
            menuButtonSprite.position = CGPoint(x: -250, y: 330)
        } else {
            menuButtonSprite.size = CGSize(width: 180, height:60)
            menuButtonSprite.position = CGPoint(x: self.frame.origin.x+10, y: self.frame.size.height/2-120)
            }
    }

    func cspmovePointerSprite() {
        if (CurrentOrientation() == Constants().PORTRAIT) {
       //portrait
            movePointerSprite.size = CGSize(width: 140, height: 50)
            movePointerSprite.position = CGPoint(x: -250, y: -self.frame.size.height/2+25)
        } else {
            movePointerSprite.size = CGSize(width: 200, height: 70)
            movePointerSprite.position = CGPoint(x: self.frame.origin.x+20, y: -self.frame.size.height/2+75)
            }
    }

    func cspstrikePointerSprite() {
        if (CurrentOrientation() == Constants().PORTRAIT) {
       //portrait
            strikePointerSprite.size = CGSize(width: 115, height:40)
            strikePointerSprite.position = CGPoint(x: -250, y: self.frame.size.height/2-250)
        } else {
            strikePointerSprite.size = CGSize(width: 200, height:70)
            strikePointerSprite.position = CGPoint(x: self.frame.origin.x+20, y: -35)
            }
    }


    func cspdestroyPointerSprite() {
        if (CurrentOrientation() == Constants().PORTRAIT) {
       //portrait
            destroyPointerSprite.size = CGSize(width: 115, height: 40)
            destroyPointerSprite.position = CGPoint(x: 170, y: self.frame.size.height/2-70)
        } else {
            destroyPointerSprite.size = CGSize(width: 200, height: 70)
            destroyPointerSprite.position = CGPoint(x: self.frame.size.width/2-120, y: self.frame.size.height/2-170)
        }
    }


    func cspLabelScoresPhysics() {
        if (CurrentOrientation() == Constants().PORTRAIT) {
            LabelScoresPhysics.position = CGPoint(x: self.frame.size.height/2-215, y: self.frame.size.height/2-40)
            LabelScoresPhysics.fontSize = 40
        } else {
            LabelScoresPhysics.position = CGPoint(x: self.frame.size.width/2-120, y: self.frame.size.height/2-120)
            LabelScoresPhysics.fontSize = 60
            }
        }


    func csplaunchButtonSprite() {
        if let _ = scene?.childNode(withName:"//*launchButtonSprite*"){
        if (CurrentOrientation() == Constants().PORTRAIT) {
            launchButtonSprite.size = CGSize(width: 130, height: 130)
            launchButtonSprite.position = CGPoint(x: 120, y: -self.frame.size.height/2+25)
        } else {
            launchButtonSprite.size = CGSize(width: 150, height: 150)
            launchButtonSprite.position = CGPoint(x: self.frame.size.width/2-180, y: -self.frame.size.height/2+75)
            }
        }
    }

    func csplaunchButtonSpriteOFF() {
        if let _ = scene?.childNode(withName:"//*launchButtonSpriteOFF*"){
        if (CurrentOrientation() == Constants().PORTRAIT) {
            launchButtonSpriteOFF.size = CGSize(width: 130, height: 130)
            launchButtonSpriteOFF.position = CGPoint(x: 120, y: -self.frame.size.height/2+25)
        } else {
            launchButtonSpriteOFF.size = CGSize(width: 150, height: 150)
            launchButtonSpriteOFF.position = CGPoint(x: self.frame.size.width/2-180, y: -self.frame.size.height/2+75)
            }
        }
    }


    func cspLabelDetonation() {
    if (CurrentOrientation() == Constants().PORTRAIT) {

        LabelDetonation.position = CGPoint(x: -190, y: self.frame.size.height/2-200)
        LabelDetonation.fontSize = 60
    } else{
        LabelDetonation.fontSize = 80
        LabelDetonation.position = CGPoint(x: self.frame.origin.x+120, y: 50)
            }
        }


    func cspLabelInfo() {

        if (CurrentOrientation() == Constants().PORTRAIT) {

            if (binokleName == Constants().BINOKLE1_NAME) {
                LabelInfo.position = CGPoint(x: 30, y: 90)
            } else {
                LabelInfo.position = CGPoint(x: 30, y: 100)
            }

            LabelInfo.fontSize = 17

        } else {

            if (binokleName == Constants().BINOKLE1_NAME) {
                LabelInfo.position = CGPoint(x: 30, y: 120)
            } else {
                LabelInfo.position = CGPoint(x: 30, y: 130)
            }

            LabelInfo.fontSize = 20
        }
    }


    func cspboatSprite() {
        //корабль
        if (CurrentOrientation() == Constants().PORTRAIT) {
       //portrait
            boatSprite.size = CGSize(width: BOAT_WIDTH_GLOBAL * Constants().sizeBOAT, height: BOAT_WIDTH_GLOBAL*Constants().sizeBOAT/3)

            if (DIRACTION_GLOBAL == Constants().FROM_RIGHT) {
                boatSprite.position = CGPoint (x: -self.frame.size.width/2 + BOAT_WIDTH_GLOBAL * Constants().sizeBOAT/2, y: self.frame.midY + BOAT_WIDTH_GLOBAL * Constants().sizeBOAT/3/2)
            } else {
                boatSprite.position = CGPoint (x: self.frame.size.width/2 - BOAT_WIDTH_GLOBAL * Constants().sizeBOAT/2, y :self.frame.midY + BOAT_WIDTH_GLOBAL * Constants().sizeBOAT/3/2)
            }

        } else {
            boatSprite.size = CGSize (width: BOAT_WIDTH_GLOBAL, height: BOAT_WIDTH_GLOBAL/3)

            if (DIRACTION_GLOBAL == Constants().FROM_RIGHT) {
                boatSprite.position = CGPoint (x: -self.frame.size.width/2 + BOAT_WIDTH_GLOBAL/2, y:self.frame.midY + BOAT_WIDTH_GLOBAL/3/2)
            } else {
                boatSprite.position = CGPoint (x: self.frame.size.width/2 - BOAT_WIDTH_GLOBAL/2, y: self.frame.midY + BOAT_WIDTH_GLOBAL/3/2)
                }
            }
        }

    // MARK: addLaunchON

    func createLaunchON() {
        texture = SKTexture (imageNamed: "launchON")
        launchButtonSprite = SKSpriteNode (texture: texture)
        launchButtonSprite.size = CGSize(width: 150, height: 150)
        launchButtonSprite.position = CGPoint(x: self.frame.size.width/2-180, y: -self.frame.size.height/2+75)
        if (CurrentOrientation() == Constants().PORTRAIT) {
            launchButtonSprite.size = CGSize(width: 130, height: 130)
            launchButtonSprite.position = CGPoint(x: 120, y: -self.frame.size.height/2+25)
        }
        launchButtonSprite.anchorPoint = CGPoint(x: 0, y: 0)
        launchButtonSprite.name = "launchButtonSprite"
        launchButtonSprite.scene?.scaleMode = .aspectFill
        launchButtonSprite.zPosition=11
        addChild(launchButtonSprite)
    }


    // MARK: addLaunchOFF
    func createLaunchOFF() {
        texture = SKTexture (imageNamed: "launchOFF")
        launchButtonSpriteOFF = SKSpriteNode(texture: texture)
        
        if (CurrentOrientation() == Constants().PORTRAIT) {
            launchButtonSpriteOFF.size = CGSize(width: 130, height: 130)
            launchButtonSpriteOFF.position = CGPoint(x: 120, y: -self.frame.size.height/2+25)
        } else {
            launchButtonSpriteOFF.size = CGSize(width: 150, height: 150)
            launchButtonSpriteOFF.position = CGPoint(x: self.frame.size.width/2-180, y: -self.frame.size.height/2+75)
        }
        launchButtonSpriteOFF.anchorPoint = CGPoint(x: 0, y: 0)
        launchButtonSpriteOFF.name = "launchButtonSpriteOFF"
        launchButtonSpriteOFF.scene?.scaleMode = .aspectFill
        launchButtonSpriteOFF.zPosition=11
        addChild(launchButtonSpriteOFF)
    }


    // MARK: addTorpedoFire

    func createTorpedoSpriteInWater() {
        texture = SKTexture(imageNamed: "torpedo_in_water")
        torpedoSpriteInWater = SKSpriteNode(texture: texture)
        torpedoSpriteInWater.size = CGSize(width: 2, height: 10)
        torpedoSpriteInWater.position = CGPoint(x: -BackgroundSprite.position.x, y: -self.frame.size.height)
        torpedoSpriteInWater.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        torpedoSpriteInWater.zPosition = 2
        torpedoSpriteInWater.name = "torpedoInWaterSprite"
        BackgroundSprite.addChild(torpedoSpriteInWater)
    }


    // MARK: moveTorpedo

    func moveTorpedo(durationTorpedo:Double) {
        torpedoSpriteInWater.run(SKAction.repeatForever(SKAction.sequence([SKAction.moveTo(y: 0, duration: durationTorpedo)])))
    }



    // MARK: soundEffects

    func soundEffects(fileName:String!) {
        if UserDefaults.standard.value(forKey: Constants().SOUNDEFFECTS_KEY) as! String == "ON" {
            if (fileName == Constants().LAUNCH) {playLaunch.play()}
            if (fileName == Constants().EXPLOSION) {playExplosion.play()}
        }
    }

    // MARK: setTimer

    func setTimer(seconds:Int) {
        secondsCountTorpedoCount = seconds
        countdownTimerTorpedoCount = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(runTimerAddTorpedo), userInfo: nil, repeats: true)
    }

    // MARK: setTimerSprite

    func setTimerSprite(seconds:Int) {
        secondsCountBoat = seconds
        countdownTimerBoat = Timer.scheduledTimer(timeInterval: 0.05, target:self, selector: #selector(runTimerRemoveSprite), userInfo:nil, repeats:true)
    }


    // MARK: addLabelDetonation

    func createLabelDetonation() {

        if (LabelDetonation == nil) {
            LabelDetonation = SKLabelNode(text: String(format:"%d",secondsCountTorpedoCount))

            if (CurrentOrientation() == Constants().PORTRAIT) {

                LabelDetonation.position = CGPoint(x: -190, y:  self.frame.size.height/2-200)
                LabelDetonation.fontSize = 60
            } else{
                LabelDetonation.fontSize = 80
                LabelDetonation.position = CGPoint(x: self.frame.origin.x+120, y: 50)
            }

            if (binokleName == Constants().BINOKLE1_NAME) {
                    LabelDetonation.fontColor=UIColor.black
               } else {
                   LabelDetonation.fontColor=UIColor.white
               }

            LabelDetonation.fontName="HouseBrokenRoughHQ"
            LabelDetonation.name = "LabelTorpedo"
            LabelDetonation.zPosition=11
        
            setLabelDetonation(text: String(format:"%d",DURATION_TORPEDO_GLOBAL))
        
            addChild(LabelDetonation)

        } else {
            if (CurrentOrientation() == Constants().PORTRAIT) {

                LabelDetonation.position = CGPoint(x: -190, y: self.frame.size.height/2-200)
                LabelDetonation.fontSize = 60
            } else{
                LabelDetonation.fontSize = 80
                LabelDetonation.position = CGPoint(x: self.frame.origin.x+120, y: 50)
            }
            setLabelDetonation(text: String(format:"%d",secondsCountTorpedoCount))
        }
    }

    // MARK: RunTimerAddTorpedo

    @objc func runTimerAddTorpedo() {

        secondsCountTorpedoCount=secondsCountTorpedoCount-1

        self.createLabelDetonation()

        //если время отсчета закончилось
        if secondsCountTorpedoCount==0 {
            //-------------------------------------------------------------- Проверяем попадание
            self.checkCollisions()
            //--------------------------------------------------------------
            //Убираем торпеду
            torpedoRemove()
            //убираем неактивную кнопку ПУСК
            launchButtonSpriteOFFRemove()
            //останавливаем таймер Торпеды
            countdownTimerTorpedoCount.invalidate()
            // добавляем активную кнопку ПУСК
            createLaunchON()
            
            setLabelDetonation(text: String(format:"%d",DURATION_TORPEDO_GLOBAL))
        }
    }

    //MARK: RemoveSprites
    
    func torpedoRemove (){
        if let _ = scene?.childNode(withName:"//*torpedoSpriteInWater*"){
            torpedoSpriteInWater.removeFromParent()
        }
    }
        
    func launchButtonSpriteRemove (){
        if let _ = scene?.childNode(withName:"//*launchButtonSprite*"){
            launchButtonSprite.removeFromParent()
        }
    }
        
    func launchButtonSpriteOFFRemove () {
        if let _ = scene?.childNode(withName:"//*launchButtonSpriteOFF*"){
            launchButtonSpriteOFF.removeFromParent()
        }
    }
    
    func labelScoresPhysicsRemove (){
            LabelScoresPhysics.removeFromParent()
    }
    
    
    func boatSlowlyDown(){
        boatSprite.run(SKAction.sequence([SKAction.moveTo(y: -30, duration: 10), SKAction.removeFromParent()]))
    }
    
    
    
    //MARK: GETS
    
    func getStrikeKey() ->Int{
        
       return UserDefaults.standard.value(forKey: Constants().STRIKE_KEY) as! Int
    }
    
    func getDestroyed(destroyed:Int) -> String!{
        var awardMessage: String!
        
        switch destroyed {
        case 50, 100, 150, 200, 300, 400, 500, 750, 1000, 2000:
            awardMessage  = Constants().YES_KEY
        default:
            awardMessage = Constants().NO_KEY
        }
        
        return awardMessage
    }
    
    
    //MARK: Move Sprites

    func moveSprite(timerInterval:Int, spriteName:SKSpriteNode!) {
        //-------------------------------------------------------------- Двигаем sprite (корабль или дым)

        if (DIRACTION_GLOBAL == Constants().FROM_RIGHT) {
            
            spriteName.run(SKAction.sequence([SKAction.moveTo(x: self.frame.size.width/2, duration: TimeInterval(timerInterval))]), withKey: "moving")

        } else{

            spriteName.run(SKAction.sequence([SKAction.moveTo(x: -self.frame.size.width, duration: TimeInterval(timerInterval))]), withKey: "moving")
        }
        //при движении корабля проверяем не скрылся ли он за скалами таймер на 100 сек
        self.setTimerSprite(seconds: 100)
    }


    // MARK: sinhronizeSmokeBoat - Синхронизация корабля и дыма

    func sinhronizeSmokeBoat() {
        //останавливаем корабль
        boatSprite.removeAction(forKey: "moving")
        //запускаем корабль и дым с одной скоростью
        let tInterval = arc4random_uniform(180 - 60) + 30
        self.moveSprite(timerInterval: Int(tInterval), spriteName: boatSprite)
        self.moveSprite(timerInterval: Int(tInterval), spriteName: smokeSprite)
    }

  

    // MARK: Очистка количества попаданий в корабль
    func clearStrikeCount() {
        UserDefaults.standard.setValue(0, forKey: Constants().STRIKE_KEY)
        UserDefaults.standard.synchronize()
    }

    // MARK: +1 к потопленным кораблям
    func addDestroyedBoatCount() {
        let  destroyed_plus_1 = UserDefaults.standard.value(forKey: (Constants().DESTROYED_KEY)) as! Int + 1
        UserDefaults.standard.setValue(destroyed_plus_1, forKey: Constants().DESTROYED_KEY)
        UserDefaults.standard.synchronize()
    }

    // MARK: Вспышка
    func createFlashEffect() {
        //-------------------------------------------------------------- Вспышка
        texture = SKTexture (imageNamed: "flash")
        flashSprite = SKSpriteNode(texture: texture)
        flashSprite.size = CGSize (width: Constants().FLASH, height: Constants().FLASH)
        flashSprite.position = CGPoint(x: torpedoSpriteInWater.position.x+2, y: torpedoSpriteInWater.position.y+10)
        flashSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        flashSprite.name = "flashSprite"
        flashSprite.zPosition=3
        BackgroundSprite.addChild(flashSprite)
      
    }
    
    func removeFlashEffect() {
        flashSprite.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.2), SKAction.removeFromParent()]))
    }
    


    // MARK: Дым
    func createSmoke() {
        //-------------------------------------------------------------- Дым
        if UserDefaults.standard.object(forKey: Constants().STRIKE_KEY) as! Int == 1  {

            if (DIRACTION_GLOBAL == Constants().FROM_RIGHT) {
                texture = SKTexture(imageNamed: "smokeR")
            } else {
                texture = SKTexture (imageNamed: "smokeL")
            }
            
            smokeSprite = SKSpriteNode(texture: texture)
            smokeSprite.size =  CGSize (width: Constants().SMOKE_WIDTH, height: Constants().SMOKE_HEIGHT)
            smokeSprite.position = CGPoint (x: torpedoSpriteInWater.position.x, y: Constants().SMOKE_HEIGHT/2+3)
            smokeSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            smokeSprite.name = "smokeSprite"
            smokeSprite.zPosition=2
            BackgroundSprite.addChild(smokeSprite)
        }
    }


    // MARK: Корабль скрылся сбоку
 @objc  func runTimerRemoveSprite() {

        //-------------------------------------------------------------- корабль скрылся сбоку
        if (DIRACTION_GLOBAL == Constants().FROM_RIGHT) && (boatSprite.position.x >= self.frame.size.width/2 - BOAT_WIDTH_GLOBAL/2)
            {
                newCicleGame()
            }
    
        if (DIRACTION_GLOBAL == Constants().FROM_LEFT) && (self.boatSprite.position.x <= -self.frame.size.width/2 + self.BOAT_WIDTH_GLOBAL/2)
        
            {
                newCicleGame()
                    
            }
}
    
    
    func newCicleGame(){
        
        self.removeBoatSmokeTimerBoatStrikeCount()

        //Добавляем новый корабль
        self.addBoat()
        /*время движения торпеды*/
        DURATION_TORPEDO_GLOBAL = self.generateTorpedoCount(randomBoat: self.getHardModeStatus())
        /*Загружаем Label времени движения торпеды*/
        self.setLabelDetonation(text: String(format:"%d",self.DURATION_TORPEDO_GLOBAL))
        
    }
    
    
    
    func setLabelDetonation(text:String!){
        
        LabelDetonation.text = text
    }

    // MARK: Убираем корабль, дым, останавливаем таймер и очищаем счетчик попаданий
    func removeBoatSmokeTimerBoatStrikeCount() {
        boatRemove()
        smokeRemove()
        countdownTimerBoatInvalidate()
        clearStrikeCount()
    }
    
    func boatRemove(){if let _ = scene?.childNode(withName:"//*boatSprite*"){boatSprite.removeFromParent()}}
    
    func smokeRemove(){if let _ = scene?.childNode(withName:"//*smokeSprite*"){smokeSprite.removeFromParent()}}
    
    func countdownTimerBoatInvalidate(){countdownTimerBoat.invalidate()}

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let node = self.atPoint(positionInScene)

        if (node.name == "launchButtonSprite") {
            self.startBtn()
        }

        if (node.name == "menuButtonSprite") {
            self.loadMenu()
        }
    }

    func loadMenu() {
        self.clearStrikeCount()
        
        let scene = SKScene(fileNamed: "MainMenuScene")
        scene?.scaleMode = .aspectFill
        view?.presentScene(scene)
    }

    func loadInformation() {
        let scene = SKScene (fileNamed: "InformationScene")
        scene?.scaleMode = .aspectFill
        view?.presentScene(scene)
    }

    // MARK: +1 к попаданиям
    func addStrikeCollision() {
        let  strike_plus_1 = UserDefaults.standard.value(forKey: (Constants().STRIKE_KEY)) as! Int + 1
        UserDefaults.standard.setValue(strike_plus_1, forKey: Constants().STRIKE_KEY)
        UserDefaults.standard.synchronize()
    }
    
    func viewWillTransition(to size: CGSize) {
        self.cspBinokle()
        self.cspLabelInfo()
        self.cspLabelDetonation()
        self.cspLabelScoresPhysics()
        self.cspboatSprite()
        self.cspmovePointerSprite()
        self.cspmenuButtonSprite()
        self.cspstrikePointerSprite()
        self.cspdestroyPointerSprite()
        self.csplaunchButtonSprite()
        self.csplaunchButtonSpriteOFF()
    }



    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let previousPosition = touch.previousLocation(in: self)
    
        let translation = CGPoint(x: positionInScene.x - previousPosition.x, y: BackgroundSprite.position.y)
        
        if (BackgroundSprite.position.x + translation.x > -self.frame.size.width/2 + Constants().ROCK_WIDTH && BackgroundSprite.position.x + translation.x < self.frame.size.width/2 - Constants().ROCK_WIDTH) {
            BackgroundSprite.position = CGPoint(x: BackgroundSprite.position.x + translation.x, y: BackgroundSprite.position.y)
            BackgroundWaterSprite.position = CGPoint(x: BackgroundWaterSprite.position.x + translation.x, y: BackgroundWaterSprite.position.y)
        }

        RockSpriteLeft.position = CGPoint(x: BackgroundSprite.frame.origin.x + Constants().ROCK_WIDTH/2, y: RockSpriteLeft.position.y)
        RockSpriteRight.position = CGPoint(x: BackgroundSprite.frame.origin.x+BackgroundSprite.frame.size.width - Constants().ROCK_WIDTH/2 , y: RockSpriteRight.position.y)
        setLabelInfo(text: String(format:"%ld", lroundf(Float(BackgroundSprite.position.x + translation.x))))
    }
    
    func setLabelInfo(text: String!){
        LabelInfo.text = text
    }


    func sceneSetting() {
        if UserDefaults.standard.value(forKey: Constants().SOUNDBACKGROUND_KEY) as! String == "ON"{
            playSound.play()
        } else {
            playSound.stop()
        }
    }


    // MARK: Статус сложного режима игры
    func getHardModeStatus() -> String! {
        var randomBoat:String! = Constants().NO_KEY

        if UserDefaults.standard.object(forKey: Constants().HARD_KEY) as! String == "ON" {
            randomBoat = Constants().YES_KEY
        }
        return randomBoat
    }
}
