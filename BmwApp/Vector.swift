//
//  Vector.swift
//  Riderz
//
//  Created by Rodolfo Castillo on 15/08/15.
//  Copyright (c) 2015 Rodolfo Castillo. All rights reserved.
//

import Foundation

class Vector: NSObject{
    var forces: [Double]!
   
    
    init(f: [Double]) {
        self.forces = f
        
    }
    
    func getMagnitud()->Double{
        return sqrt((forces[0]*forces[0])+(forces[1]*forces[1])+(forces[2]*forces[2]))
    }
    
}