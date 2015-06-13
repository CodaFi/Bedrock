//
//  Color.swift
//  Bedrock
//
//  Created by Robert S Mozayeni on 6/12/15.
//  Copyright (c) 2015 Robert Mozayeni. All rights reserved.
//

import Darwin

struct Color {
    let redComponent: Double
    let greenComponent: Double
    let blueComponent: Double
    let alphaComponent: Double
    
    init (red: Double, green: Double, blue: Double, alpha: Double = 1) {
        redComponent = red
        greenComponent = green
        blueComponent = blue
        
        alphaComponent = alpha
    }
    
    init(hue: Double, saturation: Double, brightness: Double, alpha: Double) {
        let r, g, b, f, p, q, t: Double
        
        let i = floor(hue * 6)
        f = hue * 6 - i
        p = brightness * (1 - saturation)
        q = brightness * (1 - f * saturation)
        t = brightness * (1 - (1 - f) * saturation)
        
        switch i % 6 {
        case 0:
            r = brightness
            g = t
            b = p
        case 1:
            r = q
            g = brightness
            b = p
        case 2:
            r = p
            g = brightness
            b = t
        case 3:
            r = p
            g = q
            b = brightness
        case 4:
            r = t
            g = p
            b = brightness
        case 5:
            r = brightness
            g = p
            b = q
        default:
            exit(1)
        }
        
        redComponent = r
        greenComponent = g
        blueComponent = b
        
        alphaComponent = alpha
        
    }
}
