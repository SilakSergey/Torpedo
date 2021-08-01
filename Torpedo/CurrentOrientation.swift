//
//  CurrentOrientation.swift
//  Torpedo
//
//  Created by Sergey Silak on 11.05.2021.
//

import Foundation
import UIKit

func CurrentOrientation() -> String {
    
    if (UIDevice.current.orientation.isPortrait){
        
        return Constants().PORTRAIT
        
    } else {
        
        return Constants().LANDSCAPE
    }
}

