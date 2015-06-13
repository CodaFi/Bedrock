//
//  Color.swift
//  Bedrock
//
//  Created by Robert S Mozayeni on 6/12/15.
//  Copyright (c) 2015 Robert Mozayeni. All rights reserved.
//

struct Color {
    let redComponent: Double
    let greenComponent: Double
    let blueComponent: Double
    let alphaComponent: Double
    
    init (red: Double, green: Double, blue: Double, alpha: Double = 0) {
        redComponent = red
        greenComponent = green
        blueComponent = blue
        
        alphaComponent = alpha
    }
}
