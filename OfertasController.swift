//
//  OfertasController.swift
//  ayunjobpozuelo
//
//  Created by avansis on 25/02/15.
//  Copyright (c) 2015 avansis. All rights reserved.
//
import UIKit

let detalleOfertaSegueIdentifier = "detalleofertasegue"

var seleccionOferta = 0;

class OfertasController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var players: [Oferta] = ofertas
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("OfertaCell", forIndexPath: indexPath)
            as OfertaCell
        
        let player = players[indexPath.row] as Oferta
        cell.titulo.text = player.titulo
        cell.descripcion.text = player.descripcion_oferta
        cell.salario.text = player.ofrece
        cell.municipio.text = player.localidad
        cell.fecha.text = player.fecha_publicacion_oferta
        
        ImageLoader.sharedLoader.imageForUrl(player.URL_icono, completionHandler:{(image: UIImage?, url: String) in
           cell.imagen.image = image
        })
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        println(players[row])
        
        seleccionOferta = row
        
        let selectedProgram = ofertas[indexPath.row]
        
        // Create an instance of PlayerTableViewController and pass the variable
        let destinationVC = DetalleOfertaController()
        destinationVC.oferta = selectedProgram
        
        
        
        performSegueWithIdentifier("detalleofertasegue", sender: self)
        
    }
    
    
    
}

