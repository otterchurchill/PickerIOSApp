//
//  ViewController.swift
//  Picker3_Churchill
//
//  Created by user124420 on 2/4/17.
//  Copyright © 2017 user124420. All rights reserved.
//

import UIKit
import GameplayKit
import AVFoundation

extension Array {
    mutating func shuffle() {
        for i in 0 ..< (count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            swap(&self[i], &self[j])
        }
    }
}






let numbersDataSource =
    [["one","two", "three", "four","five","six","seven", "eight","nine","ten"],
     ["uno","dos", "thres","quatro","cinco","sies","siete","ocho","neuve","diez"],
     ["1","2","3","4", "5","6","7", "8","9","10"]]


class ViewController: UIViewController,  UIPickerViewDataSource, UIPickerViewDelegate {

    

    
    var oldBread = ""
    var oldMeat = ""
    var oldCheese = ""
    
    @IBOutlet weak var numberPicker: UIPickerView!
    let key =
        [["one","two", "three", "four","five","six","seven", "eight","nine","ten"],
        ["uno","dos", "thres","quatro","cinco","sies","siete","ocho","neuve","diez"],
        ["1","2","3","4", "5","6","7", "8","9","10"]]
    

    var numbersData = [["one","two", "three", "four","five","six","seven", "eight","nine","ten"],
         ["uno","dos", "thres","quatro","cinco","sies","siete","ocho","neuve","diez"],
         ["1","2","3","4", "5","6","7", "8","9","10"]]
    
    @IBOutlet weak var resultLabel: UILabel!
    
    
    @IBOutlet weak var emojilab: UILabel!
    
    
   
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return numbersData.count  }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numbersData[component].count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return numbersData[component][row]}
    
    func pickerView(_ pickerview: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        getnumber() }
    
   func getnumber() {
        
    
        
        let bread = numbersData[0][numberPicker.selectedRow(inComponent: 0)]
        
        let meat = numbersData[1][numberPicker.selectedRow(inComponent: 1)]
        let cheese = numbersData[2][numberPicker.selectedRow(inComponent: 2)]
        
        var utterance = AVSpeechUtterance(string: bread)
        //check for change function isolate text to speech
        if(oldBread != bread){
            //tts
            utterance = AVSpeechUtterance(string: bread)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
            
            
            let synthesizer = AVSpeechSynthesizer()
            synthesizer.speak(utterance)
            
        }
        if(oldMeat != meat){
            utterance = AVSpeechUtterance(string: meat)
            utterance.voice = AVSpeechSynthesisVoice(language: "es-MX")
    
            let synthesizer = AVSpeechSynthesizer()
            synthesizer.speak(utterance)
            var i = 0
            var emstr = "🐿"
         
            while(key[1][i] != meat){
                emstr += " 🐿 "
                i+=1 }
            
            emojilab.text = emstr
            
        }
        if(oldCheese != cheese){
                //tts
                utterance = AVSpeechUtterance(string: cheese)
                utterance.voice = AVSpeechSynthesisVoice(language:"en-GB" )
                
                
                let synthesizer = AVSpeechSynthesizer()
                synthesizer.speak(utterance)
            }
        
        
        // check if they are right
        let cheeseNum = Int(cheese)! - 1
        
        if ((key[0][cheeseNum] == bread) && (key[1][cheeseNum] == meat)) {
            resultLabel.text = "Great job!"
            }
        else{
            resultLabel.text = "Try again to match them." }
    
        oldBread = bread
        oldMeat = meat
        oldCheese = cheese
        //resultLabel.text = bread + ",old  " + oldBread + "fine" + meat + ", and " + cheese
    }

     override func viewDidLoad() {
        super.viewDidLoad()      // Do any additional setup after loading the view, typically from a nib.
        numberPicker.delegate = self
        numberPicker.dataSource = self
        numbersData[0] = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: numbersDataSource[0]) as! [String]
        numbersData[1] = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: numbersDataSource[1]) as! [String]
        numbersData[2] = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: numbersDataSource[2]) as! [String]
        numberPicker.reloadAllComponents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

