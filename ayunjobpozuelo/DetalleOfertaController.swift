//
//  OfertasController.swift
//  ayunjobpozuelo
//
//  Created by avansis on 25/02/15.
//  Copyright (c) 2015 avansis. All rights reserved.
//
import UIKit

class DetalleOfertaController: UIViewController {

    var oferta:Oferta?
    
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var salario: UILabel!
    @IBOutlet weak var municipio: UILabel!
    @IBOutlet weak var texto: UILabel!
    @IBOutlet weak var fecha: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        oferta = ofertas[seleccionOferta]
        
        titulo.text = oferta?.titulo
        salario.text = oferta?.ofrece
        municipio.text = oferta?.localidad
        texto.text = oferta?.descripcion_oferta
        fecha.text = oferta?.fecha_publicacion_oferta
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

