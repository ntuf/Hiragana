//
//  ViewController.swift
//  Hiragana
//
//  Created by hiroyuki tomiduka on 2019/09/27.
//  Copyright © 2019 ntuf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Input: UITextField!
    @IBOutlet weak var Output: UITextField!
    var alert: UIAlertController!
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        Input.becomeFirstResponder()
    }

    // MARK: @IBAction

    @IBAction func inputEditingChanged(_ sender: Any) {
  
        let kanaConverter = KanaConverter()
        kanaConverter.getKana(Input.text!) {hiragana in
            DispatchQueue.main.async {
                self.Output.text = hiragana
            }
        }
    }
    
    @IBAction func tapPaste(_ sender: Any) {
        
        let board = UIPasteboard.general
        if board.hasStrings{
            self.Input.text =
                board.value(forPasteboardType: "public.text") as? String
            // 貼り付けた語句を変換する
            inputEditingChanged(sender)
        }
        
    }
    
    @IBAction func tapCopy(_ sender: Any) {
        
        if Output.text != "" {
            let board = UIPasteboard.general
            board.setValue(self.Output.text!,
                           forPasteboardType: "public.text")
            alartMomentary(nil,"結果をコピーしました")
        }
        
    }
    
    private func alartMomentary(_ title: String?, _ message: String? ) {
        alert = UIAlertController(title: title,
                                message: message,
                                preferredStyle:UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3,
                execute: {
                    self.alert.dismiss(animated: true, completion: nil)
                }
            )
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 他をタッチすると、キーボードを閉じる
        self.view.endEditing(true)
    }
    
}

