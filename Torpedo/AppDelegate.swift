//
//  AppDelegate.swift
//  Torpedo
//
//  Created by Sergey Silak on 10.05.2021.
//

import UIKit

@main



class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
    
        SoundPlayer.init()
        
        if(!UserDefaults.standard.bool(forKey: "beenLaunched")){
            makeBackgroundSoundSettings()
            makeSoundEffectsSettings()
            makeHardModeSettings()
            
            UserDefaults.standard.setValue(0, forKey: Constants().DESTROYED_KEY)
            UserDefaults.standard.set(true, forKey: "beenLaunched")
        }
        UserDefaults.standard.synchronize()
        // Предзагрузка Atlas - много памяти!
        //   preloadAssets()
        
     //   testing()
        
        return true
    }
    
    //предзагрузка анимации воды
    func preloadAssets(){
        DispatchQueue.main.async {
            Assets.sharedInstance.preloadAssets()
        }
    }

    func makeBackgroundSoundSettings() {
    if ((UserDefaults.standard.object(forKey:Constants().SOUNDBACKGROUND_KEY)) == nil){
        UserDefaults.standard.set("ON", forKey: Constants().SOUNDBACKGROUND_KEY)
    }
}
    
    func makeSoundEffectsSettings(){
        if ((UserDefaults.standard.object(forKey:Constants().SOUNDEFFECTS_KEY)) == nil){
            UserDefaults.standard.set("ON", forKey: Constants().SOUNDEFFECTS_KEY)
        }
    }
    
    func makeHardModeSettings() {
        if ((UserDefaults.standard.object(forKey:Constants().HARD_KEY)) == nil){
            UserDefaults.standard.set("OFF", forKey: Constants().HARD_KEY)
        }
    }
    
    
    func testing(){
        //49,199,499,999,1999 - награды
        //0,49,99,149,199,299,399,499,749,999,1999 - приказы
        UserDefaults.standard.setValue(499, forKey: Constants().DESTROYED_KEY)
        
        //test No launch
     //   UserDefaults.standard.set(false, forKey: "beenLaunched")
        UserDefaults.standard.synchronize()
    }
}

