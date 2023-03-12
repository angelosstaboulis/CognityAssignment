//
//  DetailsViewController.swift
//  CognityAssignment
//
//  Created by Angelos Staboulis on 9/3/23.
//

import UIKit

class DetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TVDetailsCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TVDetailsCell
        cell.imgThumb.sd_setImage(with: URL(string: details.thumbnail!))
        cell.lblName.text = details.name
        cell.lblRatings.text = details.rating
        return cell
    }
    
    
    @IBOutlet weak var detailsTableView: UITableView!
    
    var details:TVModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        initialView()
        // Do any additional setup after loading the view.
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
extension DetailsViewController{
    func initialView(){
        self.navigationItem.title = details.name
        detailsTableView.dataSource = self
        detailsTableView.delegate = self
    }
}
