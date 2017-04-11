//
//  AppTableTableViewController.swift
//  Desafio-TabbleView
//
//  Created by Andre Faruolo on 10/04/17.
//  Copyright © 2017 grupo5. All rights reserved.
//

import UIKit

class AppTableTableViewController: UITableViewController {
    
    var app1 = App(imagem: "WhatsApp", nome: "WhatsApp", categoria: "Social")
    var app2 = App(imagem:"Itau", nome:"Itau",  categoria:"Financas")
    var app3 = App(imagem: "Spotify", nome: "Spotify", categoria: "Musica")
    var app4 = App(imagem:"Facebook", nome:"Facebook",  categoria:"Social")
    
    
    var apps = [App]()
    var aux = [App]()
    
//    @IBAction func salvarMudancas (segue:UIStoryboardSegue) {
//
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.isEditing = false
        self.navigationItem.rightBarButtonItem = self.editButtonItem

        apps.append(app1)
        apps.append(app2)
        apps.append(app3)
        apps.append(app4)

        //Vetor Auxiliar
        for app in apps{
            aux.append(app)
            print(app.nome)
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    var categorias = [String]()
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        var achou: Bool = false
        for app in apps {
            achou = false
            for categoria in categorias {
                if(categoria == app.categoria){
                    achou = true
                }
            }
            if(achou == false){
                categorias.append(app.categoria)
            }
        }
        print(categorias.count)
        return categorias.count
    }

    
    var qtd: Int = 0
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        qtd = 0
            for app in apps {
                if(categorias[section] == app.categoria){
                    qtd += 1
                }
            }
        return qtd
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "app", for: indexPath)
        
        let cont = aux.count
        
        for i in 0..<cont {
            
            if(categorias[indexPath.section] == aux[i].categoria){
                
                cell.textLabel?.text = aux[i].nome
                cell.detailTextLabel?.text = aux[i].categoria
                cell.imageView?.image = UIImage(named: aux[i].imagem)
                aux.remove(at: i)
                print("i \(i)")
                print("Index Path \(indexPath)")
                return cell
            }
        }
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return categorias[section]
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.apps[sourceIndexPath.row]
        apps.remove(at: sourceIndexPath.row)
        apps.insert(movedObject, at: destinationIndexPath.row)
        NSLog("%@", "\(sourceIndexPath.row) => \(destinationIndexPath.row) \(apps)")
        // To check for correctness enable: self.tableView.reloadData()
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.apps.remove(at: indexPath.row)
            
            // Delete the row from the data source
            //tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()

            NSLog("%@", apps)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
