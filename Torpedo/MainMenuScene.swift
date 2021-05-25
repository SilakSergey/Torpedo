//
//  MainMenuScene.swift
//  Torpedo
//
//  Created by Sergey Silak on 10.05.2021.
//


import SpriteKit

protocol CanReceiveTransitionEvents {
    func viewWillTransition(to size: CGSize)
}

class MainMenuScene : SKScene, CanReceiveTransitionEvents{
    var BackgroundSprite:SKSpriteNode!
    var gameNameSprite:SKSpriteNode!
    var menuPlaySprite:SKSpriteNode!
    var menuSettingsSprite:SKSpriteNode!
    var menuAboutSprite:SKSpriteNode!
    var menuPlayButtonSprite:SKSpriteNode!
    var menuSettingsButtonSprite:SKSpriteNode!
    var menuAboutButtonSprite:SKSpriteNode!
    var menuRatingButtonSprite:SKSpriteNode!
    var orientation:String!
    var texture:SKTexture!
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
override func didMove(to view: SKView) {
       
        clearCollisions()
    
        makeBackgroundSprite()
        makeMenuPlayButtonSprite()
        makeMenuSettingsButtonSprite()
        makeMenuRatingButtonSprite()
        makeMenuAboutButtonSprite()
        makeGameNameSprite()
}
    
    func viewWillTransition(to size: CGSize) {
        makeGameNameSprite()
    }
    
    func clearCollisions(){
        //обнуляем количество попаданий
        UserDefaults.standard.setValue(0, forKey: Constants().STRIKE_KEY)
        UserDefaults.standard.synchronize()
    }

func makeBackgroundSprite(){
        texture = SKTexture (imageNamed: "backMenu")
        BackgroundSprite = SpriteKit.SKSpriteNode (texture: texture)
        BackgroundSprite.size = self.frame.size
        BackgroundSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        BackgroundSprite.name = "BackgroundSprite"
        BackgroundSprite.scene?.scaleMode = .aspectFill
        BackgroundSprite.zPosition = -1;
        addChild(BackgroundSprite)
}
  
func makeMenuPlayButtonSprite(){
        texture = SKTexture (imageNamed: "buttonPlay")
       
        if (NSLocale.current.identifier.contains("ru_RU")){
            
            texture = SKTexture (imageNamed: "buttonPlay_RU")
        }
        menuPlayButtonSprite = SpriteKit.SKSpriteNode (texture: texture)
        menuPlayButtonSprite.size = CGSize(width: menuButtonSize().dlinaButton, height: menuButtonSize().visotaButton)
        menuPlayButtonSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        menuPlayButtonSprite.position = CGPoint(x: self.frame.midX, y: self.frame.midY+50)
        menuPlayButtonSprite.name = "menuPlayButtonSprite"
        menuPlayButtonSprite.scene?.scaleMode = .aspectFill
        menuPlayButtonSprite.zPosition = 0
        addChild(menuPlayButtonSprite)
}

    func makeMenuSettingsButtonSprite(){
        texture = SKTexture (imageNamed: "buttonSettings")
        
        if (NSLocale.current.identifier .contains("ru_RU")){
            
            texture = SKTexture (imageNamed: "buttonSettings_RU")
        }
        menuSettingsButtonSprite = SpriteKit.SKSpriteNode (texture: texture)
        menuSettingsButtonSprite.size = CGSize(width: menuButtonSize().dlinaButton, height: menuButtonSize().visotaButton);
        menuSettingsButtonSprite.position = CGPoint(x: self.frame.midX, y: self.frame.midY-CGFloat(menuButtonSize().visota));
        menuSettingsButtonSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        menuSettingsButtonSprite.name = "menuSettingsButtonSprite"
        menuSettingsButtonSprite.scene?.scaleMode = .aspectFill;
        menuSettingsButtonSprite.zPosition = 0;
        addChild(menuSettingsButtonSprite)
    }
    
    func makeMenuRatingButtonSprite(){
        texture = SKTexture (imageNamed: "buttonRating")
        
        if (NSLocale.current.identifier .contains("ru_RU")){
            
            texture = SKTexture (imageNamed: "buttonRating_RU")
        }
        menuRatingButtonSprite = SpriteKit.SKSpriteNode (texture: texture)
        menuRatingButtonSprite.size = CGSize(width: menuButtonSize().dlinaButton, height: menuButtonSize().visotaButton);
        menuRatingButtonSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        menuRatingButtonSprite.position = CGPoint(x: self.frame.midX, y: self.frame.midY-CGFloat(menuButtonSize().visota)*2-50);
        menuRatingButtonSprite.name = "menuRatingButtonSprite"
        menuRatingButtonSprite.scene?.scaleMode = .aspectFill;
        menuRatingButtonSprite.zPosition = 0;
        addChild(menuRatingButtonSprite)
    }
        
    func makeMenuAboutButtonSprite(){
        texture = SKTexture (imageNamed: "buttonAbout")
        
        if (NSLocale.current.identifier .contains("ru_RU")){
            
            texture = SKTexture (imageNamed: "buttonAbout_RU")
        }
        menuAboutButtonSprite = SpriteKit.SKSpriteNode (texture: texture)
        menuAboutButtonSprite.size = CGSize(width: menuButtonSize().dlinaButton, height: menuButtonSize().visotaButton);
        menuAboutButtonSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        menuAboutButtonSprite.position = CGPoint(x: self.frame.midX, y: self.frame.midY-CGFloat(menuButtonSize().visota)*3-100);
        menuAboutButtonSprite.name = "menuAboutButtonSprite"
        menuAboutButtonSprite.scene?.scaleMode = .aspectFill;
        menuAboutButtonSprite.zPosition = 0;
        addChild(menuAboutButtonSprite)
}
     
    
    
    
    func makeGameNameSprite() {
            
        if let _ = scene?.childNode(withName:"//*gameNameSprite*"){
            gameNameSprite.removeFromParent()
        }
            
        if (CurrentOrientation() == Constants().PORTRAIT){
                    texture = SKTexture (imageNamed: "GameName_P")
                
                if (NSLocale.current.identifier .contains("ru_RU")){
                    texture = SKTexture (imageNamed: "GameName_P_RU")
                }
                
                gameNameSprite = SpriteKit.SKSpriteNode (texture: texture)
                gameNameSprite.position = CGPoint(x: self.frame.midX, y: self.frame.size.height/2-150);
                gameNameSprite.size =  CGSize(width: 533, height: 200);
           
            } else {
                    texture = SKTexture (imageNamed: "GameName")
                
                if (NSLocale.current.identifier .contains("ru_RU")){
                    
                    texture = SKTexture (imageNamed: "GameName_RU")
                }
                gameNameSprite = SpriteKit.SKSpriteNode (texture: texture)
                gameNameSprite.position = CGPoint(x: self.frame.midX, y: self.frame.size.height/2-200);
                gameNameSprite.size =  CGSize(width: 800, height: 300);
            }
            gameNameSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            gameNameSprite.name = "gameNameSprite"
            gameNameSprite.scene?.scaleMode = .aspectFill;
            gameNameSprite.zPosition = 0;
            addChild(gameNameSprite)
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
            let touch:UITouch = touches.first!
            let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            let name = touchedNode.name
            
            switch name {
            case "menuPlayButtonSprite":
            var sceneName: String!
                
            if (getDestroyedKeyUD() == 0){sceneName = "InformationScene"} else {sceneName = "GameScene"}
                
            loadMenu(fileNamed: sceneName)
                
            case "menuSettingsButtonSprite": loadMenu(fileNamed: "SettingsScene")
            case "menuRatingButtonSprite": loadMenu(fileNamed: "RatingScene")
            case "menuAboutButtonSprite": loadMenu(fileNamed: "AboutScene")
            default: break
            }
    }
    
    func getDestroyedKeyUD() -> Int{
        return UserDefaults.standard.object(forKey:Constants().DESTROYED_KEY) as! Int
    }
          
            
    func loadMenu(fileNamed:String) {
        let scene = SKScene(fileNamed: fileNamed)
        scene?.scaleMode = .aspectFill
        view?.presentScene(scene)
        }
    }
