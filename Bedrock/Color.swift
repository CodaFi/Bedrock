//
//  Color.swift
//  Bedrock
//
//  Created by Robert S Mozayeni on 6/12/15.
//  Copyright (c) 2015 Robert Mozayeni. All rights reserved.
//

import Darwin

public struct Color {
    public let redComponent: Double
    public let greenComponent: Double
    public let blueComponent: Double
    public let alphaComponent: Double
    
    public init(red: Double, green: Double, blue: Double, alpha: Double = 1) {
        redComponent = red
        greenComponent = green
        blueComponent = blue
        
        alphaComponent = alpha
    }
    
    public init(red255: Double, green255: Double, blue255: Double, alpha255: Double = 255) {
        redComponent = red255 / 255.0
        greenComponent = green255 / 255.0
        blueComponent = blue255 / 255.0
        
        alphaComponent = alpha255 / 255.0
    }
    
    public init?(hex: Int){
        
        if hex <= 0xFFFFFF && hex >= 0 {
			redComponent = Double((hex & 0xFF0000) >> 16) / 255.0
			greenComponent = Double((hex & 0x00FF00) >> 8) / 255.0
			blueComponent = Double(hex & 0x0000FF) / 255.0
			
			alphaComponent = 1
			return
		}
		return nil
    }
    
    
    public init(hue: Double, saturation: Double, brightness: Double, alpha: Double) {
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
    
    public func colors() -> (Double, Double, Double) {
        return (redComponent, greenComponent, blueComponent)
    }
    
    public func colorsA() -> (Double, Double, Double, Double) {
        return (redComponent, greenComponent, blueComponent, alphaComponent)
    }
    
    public func colors255() -> (Double, Double, Double) {
        return (redComponent * 255, greenComponent * 255, blueComponent * 255)
    }
    
    public func colors255A() -> (Double, Double, Double, Double) {
        return (redComponent * 255, greenComponent * 255, blueComponent * 255, alphaComponent * 255)
    }
    
}
