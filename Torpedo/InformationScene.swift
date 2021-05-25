//
//  InformationScene.m
//  Torpedo attack
//
//  Created by Sergey Silak on 27.01.2021.
//

import SpriteKit


class InformationScene : SKScene, CanReceiveTransitionEvents {
    
     var texture:SKTexture!
     var LabelMenu:SKLabelNode!
     var RU_1_Sprite:SKSpriteNode!
     var RU_2_Sprite:SKSpriteNode!
     var RU_3_Sprite:SKSpriteNode!
     var RU_4_Sprite:SKSpriteNode!
     var RU_5_Sprite:SKSpriteNode!
     var US_1_Sprite:SKSpriteNode!
     var US_2_Sprite:SKSpriteNode!
     var US_3_Sprite:SKSpriteNode!
     var US_4_Sprite:SKSpriteNode!
     var US_5_Sprite:SKSpriteNode!

     var textView: UITextView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func didMove(to view: SKView) {
        // Setup your scene here
        
        makeBackgroundSprite()
        makeLabelMenu()
        makeTextView()
        textVewOrders()
        buttonPlaySprite()
    }

  

    func viewWillTransition(to size: CGSize)
    {
        self.removeAllChildren()
        makeBackgroundSprite()
        makeLabelMenu()
        textViewRemove()
        makeTextView()
        textVewOrders()
        buttonPlaySprite()
    }
    
    func makeBackgroundSprite() {
        texture = SKTexture(imageNamed: "list")
    let BackgroundSprite = SKSpriteNode(texture: texture)
        BackgroundSprite.size = self.frame.size
        BackgroundSprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        BackgroundSprite.name = "BackgroundSprite"
        BackgroundSprite.scene?.scaleMode = .aspectFill
        BackgroundSprite.zPosition = -1
        self.addChild(BackgroundSprite)
    }

    
    func makeTextView () {
        
        makeTextViewWithRectPhone()
        makeTextViewWithRectPad()
        
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor(red:255, green:255, blue:255, alpha:0.0)
        textView.isEditable = false
        textView.isSelectable=false
        
        self.view?.addSubview(textView)
    }
    
    
    func makeTextViewWithRectPhone(){
        
        textView = UITextView(frame:CGRect(x: 20, y: 110, width: 280, height: 150))
        
        if CurrentOrientation() == Constants().LANDSCAPE {
            textView = UITextView(frame:CGRect(x: 15, y: 70, width: 450, height: 100))
        }
        textView.font = UIFont(name: "Capture it(RUS BY LYAJKA)", size:11)
    }
    
    func makeTextViewWithRectPad(){
        
        if  UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad  {
    
            textView = UITextView(frame:CGRect(x: 40, y: 300, width: 700, height: 250))
            
            if CurrentOrientation() == Constants().LANDSCAPE {
                textView = UITextView(frame:CGRect(x: 100, y: 200, width: 800, height: 200))
            }
            
            textView.font = UIFont(name: "Capture it(RUS BY LYAJKA)", size:20)
        }
    }
    
    func setTextView (order:String){
        
        textView.text = order
    }
    
    func textViewRemove(){
        textView.removeFromSuperview()
    }
        
    

    func textVewOrders() {
       let destroyedUD = UserDefaults.standard.object(forKey: Constants().DESTROYED_KEY) as! Int
        
        switch destroyedUD {
        case 0: setTextView(order:NSLocalizedString(Orders().TEXT_ORDERS_1, comment: "") )
        case 50: setTextView(order: NSLocalizedString(Orders().TEXT_ORDERS_2, comment: "") )
            
                //imageNamed - RU_1, spriteName - RU_1_Sprite, name - RU_1_SpriteName int_y - 230
                makeAward(imageNamed: NSLocalizedString("US_1", comment: ""), spriteName: NSLocalizedString("US_1_Sprite", comment: ""), name: NSLocalizedString("US_1_SpriteName", comment: ""), int_y: NSLocalizedString("250", comment: ""))
            
        case 100: setTextView(order: NSLocalizedString(Orders().TEXT_ORDERS_3, comment: "") )

        case 150: setTextView(order: NSLocalizedString(Orders().TEXT_ORDERS_4, comment: "") )
            
        case 200: setTextView(order: NSLocalizedString(Orders().TEXT_ORDERS_5, comment: "") )
            
            makeAward(imageNamed: NSLocalizedString("US_2", comment: ""), spriteName: NSLocalizedString("US_2_Sprite", comment: ""), name: NSLocalizedString("US_2_SpriteName", comment: ""), int_y: NSLocalizedString("250", comment: ""))
        case 300: setTextView(order: NSLocalizedString(Orders().TEXT_ORDERS_6, comment: "") )
        case 400: setTextView(order: NSLocalizedString(Orders().TEXT_ORDERS_7, comment: "") )
        case 500: setTextView(order: NSLocalizedString(Orders().TEXT_ORDERS_8, comment: "") )
            
            makeAward(imageNamed: NSLocalizedString("US_3", comment: ""), spriteName: NSLocalizedString("US_3_Sprite", comment: ""), name: NSLocalizedString("US_3_SpriteName", comment: ""), int_y: NSLocalizedString("250", comment: ""))
        case 750: setTextView(order: NSLocalizedString(Orders().TEXT_ORDERS_9, comment: "") )
        case 1000: setTextView(order: NSLocalizedString(Orders().TEXT_ORDERS_10, comment: "") )
            
            makeAward(imageNamed: NSLocalizedString("US_4", comment: ""), spriteName: NSLocalizedString("US_4_Sprite", comment: ""), name: NSLocalizedString("US_4_SpriteName", comment: ""), int_y: NSLocalizedString("250", comment: ""))
        case 2000: setTextView(order: NSLocalizedString(Orders().TEXT_ORDERS_11, comment: "") )
            
            makeAward(imageNamed: NSLocalizedString("US_5", comment: ""), spriteName: NSLocalizedString("US_5_Sprite", comment: ""), name: NSLocalizedString("US_5_SpriteName", comment: ""), int_y: NSLocalizedString("250", comment: ""))
        default:
            break
        }
    }

    //imageNamed - RU_*, spriteName - RU_*_Sprite, name - RU_*_SpriteName, int_y - 230
    //imageNamed - US_*, spriteName - US_*_Sprite, name - US_*_SpriteName, int_y - 250
    
    func makeAward (imageNamed:String, spriteName: String, name:String, int_y:String){
        texture = SKTexture (imageNamed: imageNamed)
        let spriteName = SKSpriteNode (texture:texture)
        spriteName.anchorPoint = CGPoint(x: 0.5, y: 0.5) //задаем начальную точку.
        spriteName.size =  CGSize(width: AwardsSize().shirinaO, height: AwardsSize().visotaO)
        spriteName.position = CGPoint(x: 0, y: Int(-self.frame.size.height)/2+Int(int_y)!)
        spriteName.name = name// задаем имя.
        spriteName.scene?.scaleMode = .aspectFill
        spriteName.zPosition=0
        self.addChild(spriteName)//добавляем наш объект на нашу сцену.
    }
    
    
   
   
    func buttonPlaySprite (){
        texture = SKTexture(imageNamed: "buttonPlay")

        if NSLocale.current.identifier.contains("ru_RU") {

            texture = SKTexture(imageNamed: "buttonPlay_RU")
        }
        let buttonPlaySprite = SKSpriteNode(texture: texture)
        buttonPlaySprite.size =  CGSize(width: menuButtonSize().dlinaButton, height: menuButtonSize().visotaButton)
        buttonPlaySprite.anchorPoint = CGPoint(x: 0.5, y: 0.5) //задаем начальную точку.
        buttonPlaySprite.position = CGPoint(x: self.frame.midX, y: -self.frame.size.height/2+100)
        buttonPlaySprite.name = "buttonPlaySprite"// задаем имя.
        buttonPlaySprite.scene?.scaleMode = .aspectFill
        buttonPlaySprite.zPosition=0
        self.addChild(buttonPlaySprite)//добавляем наш объект на нашу сцену.
    }
    
    func makeLabelMenu(){
        
        LabelMenu = SKLabelNode(text: String(format:"%@", NSLocalizedString(TextMessages().TEXT_INFORMATION_ORDER, comment: "")))
        LabelMenu.position = CGPoint(x: 0, y: self.frame.size.height/2-150)
        LabelMenu.fontSize = 70
        LabelMenu.fontColor = UIColor.black
        LabelMenu.fontName="Capture it(RUS BY LYAJKA)"
        LabelMenu.name = "Label"
        LabelMenu.zPosition=0
        self.addChild(LabelMenu)
    }

   

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
            let touch:UITouch = touches.first!
            let positionInScene = touch.location(in: self)
            let node = self.atPoint(positionInScene)

         if (node.name == "buttonPlaySprite") {
             self.loadGameScene()
         }
    }

    func loadGameScene() {

        if (textView != nil) {textView.removeFromSuperview()}
        
        let scene = SKScene(fileNamed: "GameScene")
        scene?.scaleMode = .aspectFill
        view?.presentScene(scene)

    }
}
