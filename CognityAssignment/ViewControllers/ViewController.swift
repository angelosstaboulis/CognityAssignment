//
//  ViewController.swift
//  CognityAssignment
//
//  Created by Angelos Staboulis on 9/3/23.
//

import UIKit
import SDWebImage
import Toast
import Network
import Combine
import SwiftUI
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var result:[TVModel] = []{
        willSet{
            DispatchQueue.main.async {
                    self.tableTVShow.reloadData()
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return setupCell(indexPath: indexPath, tableView: tableView)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       gotoDetailsViewController(indexPath: indexPath)
    }
    @IBOutlet weak var tableTVShow: UITableView!
    var viewModel = TVShowViewModel()

    var helper = Helper()
    override func viewDidLoad() {
        super.viewDidLoad()
       

        // Do any additional setup after loading the view.
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillAppear(_ animated: Bool) {
        initTableView()
    }
  

}
extension ViewController {
    func offLineUse(){
        self.view.makeToast("Please wait.........", duration: 1.5, position: .center, style: ToastStyle())
        DispatchQueue.main.async { [self] in
            if self.helper.isOnline {
                Task.init{
                    self.result = await self.viewModel.fetchTVShows()
                        for item in 0..<self.result.count{
                            self.viewModel.insertRecord(dbStruct:DBStruct(id: item, name: self.result[item].name!, ratings: self.result[item].rating!, thumb: self.result[item].thumbnail!))
                            
                        }
                }
            }else{
                let shows = Array(viewModel.fetchRecords())
                debugPrint("shows=",shows.count,shows)
                for item in 0..<shows.count {
                    self.result.append(TVModel(name: shows[item].name, rating: shows[item].ratings, thumbnail: shows[item].thumb))
                }
                
            }
            
        }
        
    }
    func initTableView(){
        tableTVShow.delegate = self
        tableTVShow.dataSource = self
        self.navigationController?.navigationBar.topItem?.title = "TV Shows"
        offLineUse()
    }
}
extension ViewController{
    func gotoDetailsViewController(indexPath:IndexPath){
        let detailsRecord = result[indexPath.row]
        let details:DetailsViewController = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        details.details = detailsRecord
        self.navigationController?.pushViewController(details, animated: true)
    }
}
extension ViewController{
    func setupCell(indexPath:IndexPath,tableView:UITableView)->TVCell{
        let cell:TVCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TVCell
        if result.count > 0 {
           
            cell.imgThumb.sd_setImage(with: URL(string: result[indexPath.row].thumbnail!))
            cell.lblName.text = result[indexPath.row].name
            cell.lblRatings.text = result[indexPath.row].rating
        }
 
        return cell
    }
}
