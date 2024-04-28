//
//  ViewController.swift
//  TravelBookDeneme
//
//  Created by Özcan on 25.04.2024.
//

import UIKit


class HomePage: UIViewController {
    
    var tableView = UITableView()
    var travelListesi = [Travel]()
    var viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUIObjects()
        saveButon()
        listFonk()
    }
    
    func listFonk() {
        _ = viewModel.travelList.subscribe(onNext: { list in
            self.travelListesi = list
            self.tableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        viewModel.fetchFunc()
        NotificationCenter.default.addObserver(self, selector: #selector(fetch), name: NSNotification.Name("backTo"), object: nil)
    }
    
    @objc func fetch() {
        viewModel.fetchFunc()
    }
    
    private func setUpUIObjects() {
        
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(Cellim.self, forCellReuseIdentifier: "hucre")
    }
    
    func saveButon() {
        let rightSaveButon = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(passTo))
        self.navigationItem.rightBarButtonItem = rightSaveButon
    }
    
    @objc func passTo() {
        self.navigationController?.pushViewController(RegisterPage(), animated: true)
    }
    
    func passToDetail(travel:Travel) {
        self.navigationController?.pushViewController(DetailPage(gelcekNesne: travel), animated: true)
    }
}

extension HomePage : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let nesne = travelListesi[indexPath.row]
        
        let hucre = tableView.dequeueReusableCell(withIdentifier: "hucre", for: indexPath) as! Cellim
        
        hucre.label.text = nesne.nameOfPlace
        
        return hucre
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        passToDetail(travel: travelListesi[indexPath.row])
    }
}


