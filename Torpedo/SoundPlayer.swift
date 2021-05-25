import Foundation
import  AVFoundation

var sharedAudioPlayer: SoundPlayer!
var playSound: AVAudioPlayer!
var playLaunch: AVAudioPlayer!
var playExplosion: AVAudioPlayer!

class SoundPlayer {
    class func sharedAudio() -> SoundPlayer! {
        if sharedAudioPlayer == nil {
            sharedAudioPlayer = SoundPlayer()
        }
        return sharedAudioPlayer
    }

    init() {
        initAudioPlayers()
    }

    func initAudioPlayers() {
        
        soundBackgroundInit()
        soundlaunchInit()
        soundExplosionInit()
    }
    
    
    func soundBackgroundInit() {
        let url = Bundle.main.url(forResource: "backgroundSound", withExtension: "mp3")!

        do {
            playSound = try AVAudioPlayer(contentsOf: url)
            guard let playSound = playSound else { return }

            playSound.numberOfLoops = -1
            playSound.prepareToPlay()
            
        } catch let error as NSError {
            print(error.description)
        }
    }
    func soundlaunchInit() {
        let urlLaunch = Bundle.main.url(forResource: "launch", withExtension: "mp3")!

            do {
                playLaunch = try AVAudioPlayer(contentsOf: urlLaunch)
                guard playLaunch != nil else { return }

                
                playLaunch.numberOfLoops = 0
                playLaunch.prepareToPlay()
                
            } catch let error as NSError {
                print(error.description)
            }
    }
    func soundExplosionInit()  {
        let urlExplosion = Bundle.main.url(forResource: "explosion", withExtension: "mp3")!

            do {
                playExplosion = try AVAudioPlayer(contentsOf: urlExplosion)
                guard playExplosion != nil else { return }

                
                playExplosion.numberOfLoops = 0
                playExplosion.prepareToPlay()
                
            } catch let error as NSError {
                print(error.description)
                }
            }
    }
