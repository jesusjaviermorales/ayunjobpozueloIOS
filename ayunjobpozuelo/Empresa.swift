//
//  Empresa.swift
//  ayunjobpozuelo
//
//  Created by avansis on 14/01/16.
//  Copyright (c) 2016 avansis. All rights reserved.
//

import Foundation

class Empresa: NSObject, NSCoding {
    
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
    
    required init(coder decoder: NSCoder) {
        self.idEmpresas_colaboradoras = decoder.decodeObjectForKey("idEmpresas_colaboradoras") as String
        self.descripcion = decoder.decodeObjectForKey("descripcion") as String
        self.nombre_empresa = decoder.decodeObjectForKey("nombre_empresa") as String
        self.URL_imagen_empresa = decoder.decodeObjectForKey("URL_imagen_empresa") as String
    }
    
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.idEmpresas_colaboradoras, forKey: "idEmpresas_colaboradoras")
        coder.encodeObject(self.descripcion, forKey: "descripcion")
        coder.encodeObject(self.nombre_empresa, forKey: "nombre_empresa")
        coder.encodeObject(self.URL_imagen_empresa, forKey: "URL_imagen_empresa")
    }


    
    
    
}