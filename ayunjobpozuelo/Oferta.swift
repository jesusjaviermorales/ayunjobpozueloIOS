//
//  Oferta.swift
//  ayunjobpozuelo
//
//  Created by avansis on 25/02/15.
//  Copyright (c) 2015 avansis. All rights reserved.
//


import UIKit

class Oferta: NSObject, NSCoding {
    
    var ayuntamientos_id: String
  
    var categoriadeofertas_id_categoria: String
  
    var categoria_generica: String
   
    var descripcion: String
    
    var descripcion_oferta: String
   
    var fecha_publicacion_oferta: String
   
    var id: String
   
    var IdEmpresascolaboradoras: String
   
    var idEmpresas_colaboradoras: String
   
    var id_categoria: String
   
    var informacion_de_contacto: String
  
    var localidad: String
   
    var nombre_empresa: String
    
    var numero_referencia: String
   
    var ofrece: String
 
    var requisitos_minimos: String
  
    var titulo: String
 
    var URL_imagen_empresa: String
  
    var URL_icono: String
   
    var url_pdf_convocatoria: String
   
    var url_portal_web: String
    
    var url_detalle_oferta: String
    
    init(ayuntamientos_id: String, categoriadeofertas_id_categoria: String, categoria_generica: String,
        descripcion: String, descripcion_oferta: String, fecha_publicacion_oferta: String,
        id: String, IdEmpresascolaboradoras: String, idEmpresas_colaboradoras: String,
        id_categoria: String, informacion_de_contacto: String, localidad: String,
        nombre_empresa: String, numero_referencia: String, ofrece: String,
        requisitos_minimos: String, titulo: String, URL_imagen_empresa: String,
        URL_icono: String, url_pdf_convocatoria: String, url_portal_web: String,
        url_detalle_oferta: String
        ) {
       
         self.ayuntamientos_id=ayuntamientos_id
         self.categoriadeofertas_id_categoria=categoriadeofertas_id_categoria
         self.categoria_generica=categoria_generica
         self.descripcion=descripcion
         self.descripcion_oferta=descripcion_oferta
         self.fecha_publicacion_oferta=fecha_publicacion_oferta
         self.id=id
         self.IdEmpresascolaboradoras=IdEmpresascolaboradoras
         self.idEmpresas_colaboradoras=idEmpresas_colaboradoras
         self.id_categoria=id_categoria
         self.informacion_de_contacto=informacion_de_contacto
         self.localidad=localidad
         self.nombre_empresa=nombre_empresa
         self.numero_referencia=numero_referencia
         self.ofrece=ofrece
         self.requisitos_minimos=requisitos_minimos
         self.titulo=titulo
         self.URL_imagen_empresa=URL_imagen_empresa
         self.URL_icono=URL_icono
         self.url_pdf_convocatoria=url_pdf_convocatoria
         self.url_portal_web=url_portal_web
         self.url_detalle_oferta = url_detalle_oferta

        super.init()
    }
    
    
    required init(coder decoder: NSCoder) {
        
        self.ayuntamientos_id = decoder.decodeObjectForKey("ayuntamientos_id") as String
        self.categoriadeofertas_id_categoria = decoder.decodeObjectForKey("categoriadeofertas_id_categoria") as String
        self.categoria_generica = decoder.decodeObjectForKey("categoria_generica") as String
        self.descripcion = decoder.decodeObjectForKey("descripcion") as String
        self.descripcion_oferta = decoder.decodeObjectForKey("descripcion_oferta") as String
        self.fecha_publicacion_oferta=decoder.decodeObjectForKey("fecha_publicacion_oferta") as String
        self.id=decoder.decodeObjectForKey("id") as String
        self.idEmpresas_colaboradoras=decoder.decodeObjectForKey("idEmpresas_colaboradoras") as String
         self.IdEmpresascolaboradoras=decoder.decodeObjectForKey("IdEmpresascolaboradoras") as String
        self.id_categoria=decoder.decodeObjectForKey("id_categoria") as String
        self.informacion_de_contacto=decoder.decodeObjectForKey("informacion_de_contacto") as String
        self.localidad=decoder.decodeObjectForKey("localidad") as String
        self.nombre_empresa=decoder.decodeObjectForKey("nombre_empresa") as String
        self.numero_referencia=decoder.decodeObjectForKey("numero_referencia") as String
        self.ofrece=decoder.decodeObjectForKey("ofrece") as String
        self.requisitos_minimos=decoder.decodeObjectForKey("requisitos_minimos") as String
        self.titulo=decoder.decodeObjectForKey("titulo") as String
        self.URL_imagen_empresa=decoder.decodeObjectForKey("URL_imagen_empresa") as String
        self.URL_icono=decoder.decodeObjectForKey("URL_icono") as String
        self.url_pdf_convocatoria=decoder.decodeObjectForKey("url_pdf_convocatoria") as String
        self.url_portal_web=decoder.decodeObjectForKey("url_portal_web") as String
        self.url_detalle_oferta = decoder.decodeObjectForKey("url_detalle_oferta") as String

        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        
        coder.encodeObject(self.ayuntamientos_id, forKey: "ayuntamientos_id")
        coder.encodeObject(self.categoriadeofertas_id_categoria, forKey: "categoriadeofertas_id_categoria")
        coder.encodeObject(self.categoria_generica, forKey: "categoria_generica")
        coder.encodeObject(self.descripcion, forKey: "descripcion")
        coder.encodeObject(self.descripcion_oferta, forKey: "descripcion_oferta")
        coder.encodeObject(self.fecha_publicacion_oferta, forKey: "fecha_publicacion_oferta")
        coder.encodeObject(self.id, forKey: "id")
        coder.encodeObject(self.IdEmpresascolaboradoras, forKey: "IdEmpresascolaboradoras")
        coder.encodeObject(self.idEmpresas_colaboradoras, forKey: "idEmpresas_colaboradoras")
        coder.encodeObject(self.id_categoria, forKey: "id_categoria")
        coder.encodeObject(self.informacion_de_contacto, forKey: "informacion_de_contacto")
        coder.encodeObject(self.localidad, forKey: "localidad")
        coder.encodeObject(self.nombre_empresa, forKey: "nombre_empresa")
        coder.encodeObject(self.numero_referencia, forKey: "numero_referencia")
        coder.encodeObject(self.ofrece, forKey: "ofrece")
        coder.encodeObject(self.requisitos_minimos, forKey: "requisitos_minimos")
        coder.encodeObject(self.titulo, forKey: "titulo")
        coder.encodeObject(self.URL_imagen_empresa, forKey: "URL_imagen_empresa")
        coder.encodeObject(self.URL_icono, forKey: "URL_icono")
        coder.encodeObject(self.url_pdf_convocatoria, forKey: "url_pdf_convocatoria")
        coder.encodeObject(self.url_portal_web, forKey: "url_portal_web")
        coder.encodeObject(self.url_detalle_oferta, forKey: "url_detalle_oferta")
        
    }
    
    
}