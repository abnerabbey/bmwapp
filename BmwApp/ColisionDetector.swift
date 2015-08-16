//
//  ColisionDetector.swift
//  Riderz
//
//  Created by Rodolfo Castillo on 15/08/15.
//  Copyright (c) 2015 Rodolfo Castillo. All rights reserved.
//

import Foundation

class ColisionDetector: NSObject {
    
    //    V es para representar el vector con mayor valor mientras v representa
    //    el vector actual representado
    
    func colHasOcurred(V: Vector, value: Double)->Bool{
        if V.getMagnitud() > value {
            return true
        } else {
            return false
        }
    }
    
    func isNewForceBigger(V: Vector, v: Vector)->Bool{
        if v.getMagnitud() > V.getMagnitud() {
            return true
        } else {
            return false
        }
    }
    
}