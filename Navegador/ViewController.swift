//
//  ViewController.swift
//  Navegador
//
//  Created by usuario on 27/10/17.
//  Copyright © 2017 usuario. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var bAtras: UIButton!
    @IBOutlet weak var bAvanzar: UIButton!
    
    @IBOutlet weak var tfDir: UITextField!
    @IBOutlet weak var webV1: UIWebView!
    @IBOutlet weak var bCargar: UIButton!
    var paginaw = ""    
    var ref: DatabaseReference!
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        bCargar.isEnabled = true
        bAtras.isEnabled = true
        bAvanzar.isEnabled = true
        ref = Database.database().reference()
    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView){
        tfDir.text? = (webV1.request?.mainDocumentURL?.absoluteString)!
        let timestamp = String(NSDate.timeIntervalSinceReferenceDate*1000)
        print(timestamp)
        ref.child("historial").childByAutoId().setValue(tfDir.text)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cargar(_ sender: Any) {
        if  (tfDir.text?.characters.count)! > 0 {
            if tfDir.text != "" {
                if (tfDir.text?.characters.count)! > 7 {
                    let index1 = tfDir.text?.index((tfDir.text?.startIndex)!, offsetBy: 7)
                    
                    let substring1 = tfDir.text?.substring(to: index1!)
                    if substring1?.lowercased() != "http://" {
                        tfDir.text="http://"+tfDir.text!
                    }
                }
                else {
                    tfDir.text="http://"+tfDir.text!
                }
            }
            webV1.loadRequest(URLRequest(url: URL(string: tfDir.text!)!))
        }
    }
    
    @IBAction func atras(_ sender: Any) {
        if webV1.canGoBack{
            webV1.goBack()
        }
    }
    
    @IBAction func avanzar(_ sender: Any) {
        if webV1.canGoForward{
            webV1.goForward()
        }
    }
    
}

