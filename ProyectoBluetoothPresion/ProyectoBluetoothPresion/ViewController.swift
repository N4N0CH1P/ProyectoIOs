//
//  ViewController.swift
//  ProyectoBluetoothPresion
//
//  Created by user161551 on 10/14/19.
//

import UIKit
import CoreBluetooth
let medidorPresion = CBUUID(string:"0x1810")
	
class ViewController: UIViewController {

    @IBOutlet var lblDispositivos: [UILabel]!
    var centralManager: CBCentralManager!
    var medidorPresionPeripheral: CBPeripheral!
    
    override func viewDidLoad() {
        centralManager = CBCentralManager(delegate: self, queue: nil)
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension ViewController: CBCentralManagerDelegate{
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state{
            
        case .unknown:
            print("device unknown")
        case .resetting:
            print("device resetting")
        case .unsupported:
            print("device unsupported")
        case .unauthorized:
            print("device unauthorized")
        case .poweredOff:
            print("device poweredOff")
        case .poweredOn:
            centralManager.scanForPeripherals(withServices: [medidorPresion])
            
        @unknown default:
            <#code#>
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        var aux = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))

        aux.center = CGPoint(x: 160, y: 684)
        aux.textAlignment =	NSTextAlignment.center
        aux.text = peripheral.name
        lblDispositivos.append(aux)
        medidorPresionPeripheral = peripheral
        central.stopScan()
        central.connect(medidorPresionPeripheral)
        
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        let alert = UIAlertController(title: "Conectado", message: "Se conecto el dispositivo: \(peripheral.name)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}

