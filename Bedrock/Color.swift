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
    
    init(red: Double, green: Double, blue: Double, alpha: Double = 1) {
        redComponent = red
        greenComponent = green
        blueComponent = blue
        
        alphaComponent = alpha
    }
    
    init(red255: Double, green255: Double, blue255: Double, alpha255: Double = 255) {
        redComponent = red255 / 255.0
        greenComponent = green255 / 255.0
        blueComponent = blue255 / 255.0
        
        alphaComponent = alpha255 / 255.0
    }
    
    init?(hex: Int){
        
        guard hex <= 0xFFFFFF && hex >= 0 else { return nil}
        
        redComponent = Double((hex & 0xFF0000) >> 16) / 255.0
        greenComponent = Double((hex & 0x00FF00) >> 8) / 255.0
        blueComponent = Double(hex & 0x0000FF) / 255.0
        
        alphaComponent = 1
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
    
    func colors() -> (Double, Double, Double) {
        return (redComponent, greenComponent, blueComponent)
    }
    
    func colorsA() -> (Double, Double, Double, Double) {
        return (redComponent, greenComponent, blueComponent, alphaComponent)
    }
    
    func colors255() -> (Double, Double, Double) {
        return (redComponent * 255, greenComponent * 255, blueComponent * 255)
    }
    
    func colors255A() -> (Double, Double, Double, Double) {
        return (redComponent * 255, greenComponent * 255, blueComponent * 255, alphaComponent * 255)
    }
    
}
