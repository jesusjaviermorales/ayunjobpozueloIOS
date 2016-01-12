//
//  Oferta.swift
//  ayunjobpozuelo
//
//  Created by avansis on 25/02/15.
//  Copyright (c) 2015 avansis. All rights reserved.
//


import UIKit

class Oferta: NSObject {
    
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
    
    init(ayuntamientos_id: String, categoriadeofertas_id_categoria: String, categoria_generica: String,
        descripcion: String, descripcion_oferta: String, fecha_publicacion_oferta: String,
        id: String, IdEmpresascolaboradoras: String, idEmpresas_colaboradoras: String,
        id_categoria: String, informacion_de_contacto: String, localidad: String,
        nombre_empresa: String, numero_referencia: String, ofrece: String,
        requisitos_minimos: String, titulo: String, URL_imagen_empresa: String,
        URL_icono: String, url_pdf_convocatoria: String, url_portal_web: String
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

        super.init()
    }
}