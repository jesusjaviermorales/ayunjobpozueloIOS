//
//  Alertas.swift
//  ayunjobpozuelo
//
//  Created by avansis on 19/01/16.
//  Copyright (c) 2016 avansis. All rights reserved.
//

import Foundation

class Alerta: NSObject {
    
    var id: String
    
    var usuario: String
    
    var alerta: String
    
    init(id: String, usuario: String, alerta: String) {
        self.id=id
        self.usuario=usuario
        self.alerta=alerta
        super.init()
    }
}