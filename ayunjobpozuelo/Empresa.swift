//
//  Empresa.swift
//  ayunjobpozuelo
//
//  Created by avansis on 14/01/16.
//  Copyright (c) 2016 avansis. All rights reserved.
//

import Foundation

class Empresa: NSObject {
    
    var idEmpresas_colaboradoras: String
    
    var descripcion: String
    
    var nombre_empresa: String
    
    var URL_imagen_empresa: String

    init(idEmpresas_colaboradoras: String, descripcion: String, nombre_empresa: String, URL_imagen_empresa:String) {
            
            self.idEmpresas_colaboradoras=idEmpresas_colaboradoras
            self.descripcion=descripcion
            self.nombre_empresa=nombre_empresa
            self.URL_imagen_empresa=URL_imagen_empresa
            super.init()
    }
}