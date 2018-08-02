//
//  ViewController.swift
//  Emoticons
//
//  Created by Menamobile on 17/4/13.
//
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let text = "[你好][(|)]【[[hello][<o)][:-#][[(k)][(D)]][sssd][aadf][:$]"
        let attributeStr = EmoticonsHelper.convertToCommonEmoticons(text: text, font: label.font, textColor: label.textColor)
        label.attributedText = attributeStr
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

