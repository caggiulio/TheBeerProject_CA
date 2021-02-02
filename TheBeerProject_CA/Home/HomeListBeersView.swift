//
//  HomeListBeersView.swift
//  TheBeerProject_CA
//
//  Created by Nunzio Giulio Caggegi on 01/02/21.
//

import UIKit

extension HomeListBeersViewController {

    func configureUI() {
        self.title = "Beer Box"
        
        self.view.addSubview(beerTableView)
        beerTableView.backgroundColor = UIColor(named: "AppMainColor")
        
        beerTableView.register(BeerTableViewCell.self, forCellReuseIdentifier: "beerTableViewCell")
        
        beerTableView.delegate = self
        beerTableView.dataSource = self
        
        beerTableView.rowHeight = UITableView.automaticDimension
        beerTableView.estimatedRowHeight = 248
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.backgroundColor = UIColor(named: "AppMainColor")

            navigationItem.standardAppearance = appearance
            navigationItem.scrollEdgeAppearance = appearance
        } else {
            
        }
    }
    
    func setConstraints() {
        beerTableView.translatesAutoresizingMaskIntoConstraints = false
        beerTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        beerTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        beerTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        beerTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    func setHeaderViewPopular() {
        header = UIView.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: 230))
        let childViewController = HeaderSectionViewController()
        childViewController.headerDataProvider = self.headerDataProvider
        childViewController.delegate = self
        childViewController.view.frame = header!.frame
        addChild(childViewController)
        header!.addSubview(childViewController.view)
        didMove(toParent: self)
        
        beerTableView.reloadData()
    }
    
    func setSearchBar() {
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = search
        search.searchBar.delegate = self
        search.searchBar.barStyle = .default
        search.searchBar.barTintColor = UIColor.white
        search.searchBar.tintColor = UIColor.white
        search.searchBar.setTextColorAndTextFont(color: .white, font: UIFont.systemFont(ofSize: 12))
    }

}

extension HomeListBeersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeListBeersDataProvider?.beers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerTableViewCell") as! BeerTableViewCell
        if let beer = homeListBeersDataProvider?.beers?[indexPath.row] {
            cell.updateUI(beer: beer)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 248
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.fetchBeerByIndex(indexPath: indexPath)
        router?.routeToSomewhere()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = ((homeListBeersDataProvider?.beers?.count ?? 0) - 1)
        if((indexPath.row == lastElement)) && ((homeListBeersDataProvider?.beers?.count ?? 0) > 2) {
            let request = HomeListBeers.Something.Request(page: (interactor?.page ?? 0) + 1, beerName: interactor?.beerName, category: interactor?.category)
            interactor?.fetchListBeer(request: request)
        }
    }
}
