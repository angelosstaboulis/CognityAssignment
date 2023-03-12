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
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,TVSHowProtocol {
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
    var dbManager = DBManager()
    override func viewDidLoad() {
        super.viewDidLoad()
       

        // Do any additional setup after loading the view.
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initTableView()
    }

}
extension ViewController {
    func offLineUse(){
        self.view.makeToast("Please wait.........", duration: 1.5, position: .center, style: ToastStyle())
        let monitor = NWPathMonitor()
        monitor.start(queue: .main)
        monitor.pathUpdateHandler = { path in


            if path.status == .satisfied{
                self.viewModel.fetchTVShow()
                self.result.append(contentsOf: self.viewModel.delegate!.result)
            }
            else{
                for item in 0..<self.dbManager.fetchRecord().count{
                    self.result.append(TVModel(name: self.dbManager.fetchRecord()[item].name!, rating: self.dbManager.fetchRecord()[item].ratings!, thumbnail: self.dbManager.fetchRecord()[item].thumb!))
            
                }
           }
        }
    }
    func initTableView(){
        tableTVShow.delegate = self
        tableTVShow.dataSource = self
        self.navigationController?.navigationBar.topItem?.title = "TV Shows"
        viewModel.delegate = self
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
            self.dbManager.insertRecord(dbStruct: DBStruct(name: self.result[indexPath.row].name!, ratings: self.result[indexPath.row].rating!, thumb: self.result[indexPath.row].thumbnail!))
            cell.imgThumb.sd_setImage(with: URL(string: result[indexPath.row].thumbnail!))
            cell.lblName.text = result[indexPath.row].name
            cell.lblRatings.text = result[indexPath.row].rating
        }
       
        return cell
    }
}
