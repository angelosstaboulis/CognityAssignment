//
//  StartAssignmentViewController.swift
//  CognityAssignment
//
//  Created by Angelos Staboulis on 12/3/23.
//

import UIKit

class StartAssignmentViewController: UIViewController {
    var check:Bool=true
    var stopWidth = 900
    @IBOutlet weak var marquee: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        initialMarqueeLabel()

        // Do any additional setup after loading the view.
    }
    @objc func sliderAnimationTime() {
           // do what should happen when timer triggers an event
        UIView.animate(withDuration: TimeInterval(1.5), delay: 0, options: [.curveEaseOut], animations: {
               if self.check {
                   self.check = false
                   self.marquee.center.x -= self.view.bounds.width - CGFloat(self.stopWidth)
                   self.view.layoutIfNeeded()
               }else{
                   self.check = true
                   self.marquee.center.x += self.view.bounds.width - CGFloat(self.stopWidth)
                   self.view.layoutIfNeeded()
               }

           }, completion: nil)
       }
    @IBAction func btnStartAssignment(_ sender: Any) {
            let storyboard =  UIStoryboard(name: "Main", bundle: nil)
            let mainNavigation = storyboard.instantiateViewController(identifier: "MainNavigationViewController")
            mainNavigation.modalPresentationStyle = .fullScreen
            self.present(mainNavigation, animated: true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension StartAssignmentViewController {
    func initialMarqueeLabel(){
        marquee.center.x = view.center.x
        marquee.center.x -= view.bounds.width
        Timer.scheduledTimer(timeInterval: TimeInterval(1.5),
                                    target: self,
                                    selector: #selector(self.sliderAnimationTime),
                                    userInfo: nil,
                                    repeats: true)
    }
}
