//
//  Oferta.swift
//  ayunjobpozuelo
//
//  Created by avansis on 25/02/15.
//  Copyright (c) 2015 avansis. All rights reserved.
//


import UIKit

class Ayuntamiento: NSObject {
    
    var correo_electronico: String
   
    var descripcion: String?
   
    var id: String?
  
    var nombre: String?
 
    var permite_publicar_empresa: String?
   
    var telefono: String?
  
    var telefono_agencia_colocacion: String?
  
    var url_darse_de_alta_usuario: String?
   
    var url_imagen_escudo_ayuntamiento: String?
   
    var web: String
    
    init(correo_electronico: String, descripcion: String, id: String,
        nombre: String, permite_publicar_empresa: String, telefono: String,
        telefono_agencia_colocacion: String, url_darse_de_alta_usuario: String, url_imagen_escudo_ayuntamiento: String,
        web: String) {
       
         self.correo_electronico=correo_electronico
         self.descripcion=descripcion
         self.id=id
         self.nombre=nombre
         self.permite_publicar_empresa=permite_publicar_empresa
         self.telefono=telefono
         self.telefono_agencia_colocacion=telefono_agencia_colocacion
         self.url_darse_de_alta_usuario=url_darse_de_alta_usuario
         self.url_imagen_escudo_ayuntamiento=url_imagen_escudo_ayuntamiento
         self.web=web
        
        super.init()
    }
    
    override init() {
        
        self.correo_electronico=""
        self.descripcion=""
        self.id=""
        self.nombre=""
        self.permite_publicar_empresa=""
        self.telefono=""
        self.telefono_agencia_colocacion=""
        self.url_darse_de_alta_usuario=""
        self.url_imagen_escudo_ayuntamiento=""
        self.web=""

        
    }
    
    
}