//
//  ViewController.swift
//  HeartRate_DBTest01
//
//  Created by Roger Eduardo Vazquez Tuz on 10/14/19.
//  Copyright © 2019 Roger Eduardo Vazquez Tuz. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class ViewController: UIViewController {
    
    var db: Firestore!
    @IBOutlet weak var tbNom: UITextField!
    @IBOutlet weak var tbApellidos: UITextField!
    @IBOutlet weak var tbGender: UITextField!
    
    @IBOutlet weak var tbPeso: UITextField!
    @IBOutlet weak var tbAltura: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = FirestoreSettings()

        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
    }
    
    
    
    private func saveRecords(name: String, height: Int, gender: String, lastName: String, weight: Int) {
        var ref: DocumentReference? = nil
        ref = db.collection("pacientes").addDocument(data: ["apellido": lastName,
                                                            "estatura": height,
                                                            "genero": gender,
                                                            "nombre": name,
                                                            "peso": weight]) {
                                                                err in
                                                                if let err = err {
                                                                    print("Error al subir el documento: \(err)")
                                                                } else {
                                                                    print("Insertado con id: \(ref!.documentID)")
                                                                }
        }
        
    }
    
    private func displayRecords() {
        db.collection("pacientes").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error al obtener datos -> : \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
    @IBAction func displayBtn(_ sender: Any) {
        displayRecords()
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        
        let nom = tbNom.text!
        let height = Int(tbAltura.text!)!
        let gen  = tbGender.text!
        let surname = tbApellidos.text!
        let weight = Int(tbPeso.text!)! * 1000
        
       saveRecords(name: nom, height: height, gender: gen, lastName: surname, weight: weight)
    }
    
    

}

