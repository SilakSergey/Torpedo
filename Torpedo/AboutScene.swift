//
//  AboutScene.m
//  Torpedo attack
//
//  Created by Sergey Silak on 20.01.2021.
//

import SpriteKit

class AboutScene: SKScene, CanReceiveTransitionEvents {
    
     var BackgroundSprite:SKSpriteNode!
     var menuBack:SKSpriteNode!
     var backButtonSprite:SKSpriteNode!
     var LabelMenu:SKLabelNode!
     var textView:UITextView!
     var orientation:String!
     var exture:SKTexture!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    override func didMove(to view: SKView) {
        
        makeBackgroundSprite()
        makeLabelMenu()
        makeTextView()
        makeBackButtonSprite()
    }


    func viewWillTransition(to size: CGSize)
    {
      
        removeAll()
        makeLabelMenu()
        makeTextView()
    }

    func removeAll(){
        LabelMenu.removeFromParent()
        textView.removeFromSuperview()
    }

    func makeLabelMenu() {
        LabelMenu = SKLabelNode(text: String(format:"%@", NSLocalizedString(TextMessages().TEXT_ABOUT_MENU, comment: "")))
        LabelMenu.position = CGPoint(x: 0, y: self.frame.size.height/2-120)
        LabelMenu.fontSize = 50
        if CurrentOrientation() == Constants().LANDSCAPE {
            LabelMenu.fontSize = 70
        }
        LabelMenu.fontColor = UIColor.black
        LabelMenu.fontName="Capture it(RUS BY LYAJKA)"
        LabelMenu.name = "Label"
        LabelMenu.zPosition=1
        addChild(LabelMenu)
    }
    
   
    func makeTextView() {
       
        if CurrentOrientation() == Constants().LANDSCAPE {

            textView = UITextView(frame:CGRect(x: 90, y: 85, width: 300, height: 170))
            
        } else {

            textView = UITextView(frame:CGRect(x: 10, y: 155, width: 300, height: 170))
        }
        

       if  UIDevice.current.userInterfaceIdiom  == UIUserInterfaceIdiom.pad{
        
        if CurrentOrientation() == Constants().LANDSCAPE {

            textView = UITextView(frame:CGRect(x: 210, y: 250, width: 600, height: 270))
            
        } else {

            textView = UITextView(frame:CGRect(x: 90, y: 400, width: 600, height: 270))
        }
        
            textView.font = UIFont(name: "Capture it(RUS BY LYAJKA)", size:25)
        }
        
        textView.font = UIFont(name: "Capture it(RUS BY LYAJKA)", size:11)
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor(red:255, green:255, blue:255, alpha:0.0)
        textView.isEditable = false
        textView.isSelectable=false
        textView.text = NSLocalizedString(TextMessages().TEXT_ABOUT_GAME, comment: "")
        self.view!.addSubview(textView)
    }
    
   
    

    func makeBackgroundSprite() {

        texture = SKTexture(imageNamed: "backMenuWithFon")
        BackgroundSprite = SKSpriteNode(texture: texture)
        BackgroundSprite.size = self.frame.size
        BackgroundSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        BackgroundSprite.name = "BackgroundSprite"
        BackgroundSprite.scene?.scaleMode = .aspectFill
        BackgroundSprite.zPosition = -1
        addChild(BackgroundSprite)
    }
    
    func makeBackButtonSprite() {

        texture = SKTexture(imageNamed: "buttonBack")

        if NSLocale.current.identifier.contains("ru_RU") {

            texture = SKTexture(imageNamed: "buttonBack_RU")

        }

        //Создаем наш SKSpriteNode и инициализируем его. В качестве параметра передаем объект типа SKTexture, который мы создали выше.
        backButtonSprite = SKSpriteNode (texture: texture)
        backButtonSprite.size =  CGSize(width: menuButtonSize().dlinaButton, height: menuButtonSize().visotaButton)
        backButtonSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5) //задаем начальную точку.
        backButtonSprite.position = CGPoint(x: self.frame.midX, y: -self.frame.size.height/2+100)
        backButtonSprite.name = "menuBackButtonSprite"// задаем имя.
        backButtonSprite.scene?.scaleMode = .aspectFill
        backButtonSprite.zPosition = 0
        addChild(backButtonSprite)
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let node = self.atPoint(positionInScene)

     if (node.name == "menuBackButtonSprite") {
         self.loadMainMenu()
     }


    }

    func loadMainMenu() {

        textView.removeFromSuperview()
        let scene = SKScene(fileNamed: "MainMenuScene")
        scene?.scaleMode = .aspectFill
        view?.presentScene(scene)
    }
}
