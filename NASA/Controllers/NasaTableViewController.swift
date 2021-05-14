//
//  NasaTableViewController.swift
//  NASA
//
//  Created by x.sargsyan on 2/11/20.
//  Copyright © 2020 SwiftAcademy. All rights reserved.
//

import UIKit

final class NasaTableViewController: UITableViewController {
    private var nasaApods: [Photo] = []
    private enum Keys: String { case NasaObject }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.loadIfNeeded()
    }
    
    
    // MARK: -  Private Methods -
    
    private func setup() {
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.loadItems), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
    }
    
    private func loadIfNeeded() {
        guard let nasaResponse = UserDefaults.standard.load(NasaResponse.self, Keys.NasaObject.rawValue) else { self.loadItems(); return }
        self.nasaApods = nasaResponse.photos
        
        self.tableView.reloadData()
    }
    
    @objc private func loadItems() {
        WebServiceManager().getNasaApodFromWeb { (nasas, error) in
            guard let nasas = nasas,
                error == nil else { print(error!); return }
            
            self.nasaApods = nasas
            UserDefaults.standard.save(NasaResponse(photos: self.nasaApods), Keys.NasaObject.rawValue)
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nasaApods.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NasaCell.self), for: indexPath) as! NasaCell
        let nasa = self.nasaApods[indexPath.row]
        
        cell.cellTitle.text = nasa.camera.fullName
        
        nasa.imgSrc.loadImage({ (image) in
            cell.cellImageView.image = image
        })
        
        return cell
    }
   
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else  { return }
        
        self.nasaApods.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nasa = self.nasaApods[indexPath.row]
        
        let detailsController = self.storyboard?.instantiateViewController(identifier: String(describing: DetailsController.self)) as! DetailsController
        detailsController.nasa = nasa
        
        self.navigationController?.pushViewController(detailsController, animated: true)
    }
}
