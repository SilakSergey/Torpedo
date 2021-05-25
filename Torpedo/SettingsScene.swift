//
//  SettingsScene.swift
//  Torpedo
//
//  Created by Sergey Silak on 11.05.2021.
//

import SpriteKit



class SettingsScene: SKScene, CanReceiveTransitionEvents {
    
     var BackgroundSprite:SKSpriteNode!
     var backButtonSprite:SKSpriteNode!
     var menuBack:SKSpriteNode!
     var switcherMusicSprite:SKSpriteNode!
     var switcherEffectsSprite:SKSpriteNode!
     var switcherHardModeSprite:SKSpriteNode!
     var LabelMenu:SKLabelNode!
     var LabelMenuSoundMusic:SKLabelNode!
     var LabelMenuSoundEffects:SKLabelNode!
     var LabelMenuHardMode:SKLabelNode!
     var orientation:String!
     var texture:SKTexture!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    override func didMove(to view: SKView) {

        makeBackgroundSprite()
        makeBackButtonSprite()
        changeSpritesPositions(orientation: CurrentOrientation())

    }



    func viewWillTransition(to size: CGSize)
    {
        changeSpritesPositions(orientation: CurrentOrientation())
    }
  


    func makeBackgroundSprite() {
        texture = SKTexture (imageNamed: "backMenuWithFon")
        BackgroundSprite = SpriteKit.SKSpriteNode (texture: texture)
        BackgroundSprite.size = self.frame.size // Задаем размер.
        BackgroundSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5) //задаем начальную точку.
        BackgroundSprite.name = "BackgroundSprite"// задаем имя.
        BackgroundSprite.scene?.scaleMode = .aspectFill
        BackgroundSprite.zPosition = -1
        addChild(BackgroundSprite)
    }
    
    func makeBackButtonSprite() {

        texture = SKTexture (imageNamed: "buttonBack")

        if NSLocale.current.identifier.contains("ru_RU") {

            texture = SKTexture (imageNamed: "buttonBack_RU")

        }

        //Создаем наш SKSpriteNode и инициализируем его. В качестве параметра передаем объект типа SKTexture, который мы создали выше.
        backButtonSprite = SpriteKit.SKSpriteNode(texture: texture)
        backButtonSprite.size =  CGSize(width: menuButtonSize().dlinaButton, height: menuButtonSize().visotaButton)
        backButtonSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5) //задаем начальную точку.
        backButtonSprite.position = CGPoint(x: self.frame.midX, y: -self.frame.size.height/2+100)
        backButtonSprite.name = "menuBackButtonSprite"// задаем имя.
        backButtonSprite.scene?.scaleMode = .aspectFill
        backButtonSprite.zPosition=0
        addChild(backButtonSprite)
    }

    
    func changeSpritesPositions(orientation:String) {
    
        if (LabelMenu != nil)  {LabelMenu.removeFromParent()}
        if (LabelMenuSoundMusic != nil)  {LabelMenuSoundMusic.removeFromParent()}
        if (LabelMenuSoundEffects != nil)  {LabelMenuSoundEffects.removeFromParent()}
        if (LabelMenuHardMode != nil)  {LabelMenuHardMode.removeFromParent()}

        var XLabel1:Int
        var XLabel2:Int
        var XLabel3:Int


        if orientation == Constants().PORTRAIT {

            //P
            XLabel1 = -170
            XLabel2 = -120
            XLabel3 = -140

            if NSLocale.current.identifier.contains("ru_RU") {

                XLabel1 = -160
                XLabel2 = -80
                XLabel3 = -90
            }

        } else {

            XLabel1 = 282
            XLabel2 = 355
            XLabel3=330

            if NSLocale.current.identifier.contains("ru_RU") {

                XLabel1=282
                XLabel2=400
                XLabel3=385
            }
        }


        LabelMenu = SKLabelNode(text: String(format:"%@", NSLocalizedString(TextMessages().TEXT_SETTINGS_MENU, comment: "")))
        LabelMenu.position = CGPoint(x: 0, y: self.frame.size.height/2-120)

        if orientation == Constants().PORTRAIT {

            LabelMenu.fontSize = 50

        } else {

            LabelMenu.fontSize = 70
        }


        LabelMenu.fontColor = UIColor.black
        LabelMenu.fontName="Capture it(RUS BY LYAJKA)"
        LabelMenu.name = "Label"
        LabelMenu.zPosition=1
        BackgroundSprite.addChild(LabelMenu)

        LabelMenuSoundMusic = SKLabelNode(text: String(format:"%@", NSLocalizedString(TextMessages().TEXT_SETTINGS_MENU_MUSIC, comment: "")))
        if orientation == Constants().PORTRAIT {

            LabelMenuSoundMusic.position = CGPoint(x: XLabel1, y: 50)
            LabelMenuSoundMusic.fontSize = 25

        } else {

            LabelMenuSoundMusic.position = CGPoint(x: Int(self.frame.origin.x)+XLabel1, y: 50)
            LabelMenuSoundMusic.fontSize = 35
        }

        LabelMenuSoundMusic.fontName="Capture it(RUS BY LYAJKA)"
        LabelMenuSoundMusic.name = "LabelMenuSoundMusic"
        LabelMenuSoundMusic.fontColor = UIColor.black
        LabelMenuSoundMusic.zPosition=1
        BackgroundSprite.addChild(LabelMenuSoundMusic)


        LabelMenuSoundEffects = SKLabelNode(text: String(format:"%@", NSLocalizedString(TextMessages().TEXT_SETTINGS_MENU_SOUND_EFFECTS, comment: "")))
        if orientation == Constants().PORTRAIT {


            LabelMenuSoundEffects.position = CGPoint(x: XLabel2, y: -50)
            LabelMenuSoundEffects.fontSize = 25

        } else {

            LabelMenuSoundEffects.position = CGPoint(x: Int(self.frame.origin.x)+XLabel2, y: -50)
            LabelMenuSoundEffects.fontSize = 35

        }


        LabelMenuSoundEffects.fontName="Capture it(RUS BY LYAJKA)"
        LabelMenuSoundEffects.name = "LabelMenuSoundEffects"
        LabelMenuSoundEffects.fontColor = UIColor.black
        LabelMenuSoundEffects.zPosition=1
        BackgroundSprite.addChild(LabelMenuSoundEffects)


        LabelMenuHardMode = SKLabelNode(text: String(format:"%@", NSLocalizedString(TextMessages().TEXT_SETTINGS_MENU_HARD_MODE, comment: "")))
        if orientation == Constants().PORTRAIT {

            LabelMenuHardMode.position = CGPoint(x: XLabel3, y: -150)
            LabelMenuHardMode.fontSize = 25

        } else {

            LabelMenuHardMode.position = CGPoint(x: Int(self.frame.origin.x)+XLabel3, y: -150)
            LabelMenuHardMode.fontSize = 35
        }


        LabelMenuHardMode.fontName="Capture it(RUS BY LYAJKA)"
        LabelMenuHardMode.name = "LabelMenuHardMode"
        LabelMenuHardMode.fontColor = UIColor.black
        LabelMenuHardMode.zPosition=1
        BackgroundSprite.addChild(LabelMenuHardMode)

        self.addSound()
        self.addEffects()
        self.addHardMode()
    }


    func addSound() {

        if (switcherMusicSprite != nil) {switcherMusicSprite.removeFromParent()}


        var Texture:SKTexture!

        if (UserDefaults.standard.object(forKey: Constants().SOUNDBACKGROUND_KEY) as! String == "ON"){
           
            Texture = SKTexture (imageNamed: "onButton")
        } else {

            Texture = SKTexture (imageNamed: "offButton")
        }

        //Создаем наш SKSpriteNode и инициализируем его. В качестве параметра передаем объект типа SKTexture, который мы создали выше.
        switcherMusicSprite = SpriteKit.SKSpriteNode(texture: Texture)
        switcherMusicSprite.size = CGSize(width: 95, height: 50)
        switcherMusicSprite.position = CGPoint(x: 200, y: self.frame.size.height/2-35)
        switcherMusicSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5) //задаем начальную точку.
        switcherMusicSprite.name = "switcherMusicSprite"// задаем имя.
        switcherMusicSprite.scene?.scaleMode = .aspectFill
        switcherMusicSprite.zPosition = 1
        backButtonSprite.addChild(switcherMusicSprite)//добавляем наш объект на нашу сцену.
    }

    func addEffects() {

        if (switcherEffectsSprite != nil)  {switcherEffectsSprite.removeFromParent()}

        var Texture:SKTexture!

        if (UserDefaults.standard.object(forKey: Constants().SOUNDEFFECTS_KEY) as! String == "ON"){

            Texture = SKTexture (imageNamed: "onButton")
        } else {

            Texture = SKTexture (imageNamed: "offButton")
        }

        //Создаем наш SKSpriteNode и инициализируем его. В качестве параметра передаем объект типа SKTexture, который мы создали выше.
        switcherEffectsSprite = SpriteKit.SKSpriteNode(texture: Texture)
        switcherEffectsSprite.size = CGSize(width: 95, height: 50)
        switcherEffectsSprite.position = CGPoint(x: 200, y: self.frame.size.height/2-135)
        switcherEffectsSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5) //задаем начальную точку.
        switcherEffectsSprite.name = "switcherEffectsSprite"// задаем имя.
        switcherEffectsSprite.scene?.scaleMode = .aspectFill
        switcherEffectsSprite.zPosition=1
        backButtonSprite.addChild(switcherEffectsSprite)//добавляем наш объект на нашу сцену.
    }


    func addHardMode() {

        if (switcherHardModeSprite != nil) {switcherHardModeSprite.removeFromParent()}

        var Texture:SKTexture!

        if (UserDefaults.standard.object(forKey: Constants().HARD_KEY) as! String == "ON"){

            Texture = SKTexture (imageNamed: "onButton")
        } else {

            Texture = SKTexture (imageNamed: "offButton")
        }

        //Создаем наш SKSpriteNode и инициализируем его. В качестве параметра передаем объект типа SKTexture, который мы создали выше.
        switcherHardModeSprite = SpriteKit.SKSpriteNode(texture:Texture)
        switcherHardModeSprite.size = CGSize(width: 95, height: 50)
        switcherHardModeSprite.position = CGPoint(x: 200, y: self.frame.size.height/2-235)
        switcherHardModeSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5) //задаем начальную точку.
        switcherHardModeSprite.name = "switcherHardMode"// задаем имя.
        switcherHardModeSprite.scene?.scaleMode = .aspectFill
        switcherHardModeSprite.zPosition=1
        backButtonSprite.addChild(switcherHardModeSprite)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let node = self.atPoint(positionInScene)


     if (node.name == "menuBackButtonSprite") {
         self.loadMainMenu()
     }


        if (node.name == "switcherMusicSprite") {

            if (UserDefaults.standard.object(forKey: Constants().SOUNDBACKGROUND_KEY) as! String == "ON"){

                UserDefaults.standard.set("OFF", forKey:Constants().SOUNDBACKGROUND_KEY)

               playSound.stop()
                
            } else {

                UserDefaults.standard.set("ON", forKey:Constants().SOUNDBACKGROUND_KEY)
            }

            UserDefaults.standard.synchronize()

            switcherMusicSprite.removeFromParent()

            self.addSound()
        }

        if (node.name == "switcherEffectsSprite") {

            if (UserDefaults.standard.object(forKey: Constants().SOUNDEFFECTS_KEY) as! String == "ON"){
                

                UserDefaults.standard.set("OFF", forKey:Constants().SOUNDEFFECTS_KEY)

            } else {

                UserDefaults.standard.set("ON", forKey:Constants().SOUNDEFFECTS_KEY)

            }


            UserDefaults.standard.synchronize()

            if (switcherEffectsSprite != nil) {switcherEffectsSprite.removeFromParent()}

            addEffects()
        }


        if (node.name == "switcherHardMode") {

            if (UserDefaults.standard.object(forKey: Constants().HARD_KEY) as! String == "ON"){

                UserDefaults.standard.set("OFF", forKey:Constants().HARD_KEY)

            } else {

                UserDefaults.standard.set("ON", forKey:Constants().HARD_KEY)

            }


            UserDefaults.standard.synchronize()

            if (switcherHardModeSprite != nil) {switcherHardModeSprite.removeFromParent()}

            addHardMode()
        }


    }

    func loadMainMenu() {

        let scene = SKScene(fileNamed: "MainMenuScene")
        scene?.scaleMode = .aspectFill
        view?.presentScene(scene)

    }
}
