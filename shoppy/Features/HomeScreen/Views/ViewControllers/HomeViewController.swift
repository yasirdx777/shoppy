//
//  HomeViewController.swift
//  shoppy
//
//  Created by YasirRomaya on 8/22/21.
//

import UIKit
import SnapKit

class HomeViewController: UITableViewController {
    
    private var homeViewModel : HomeViewModel?
    
    private var loadingIndicator:UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel = HomeViewModel()
        
        setTableViewConfiguration()
        setLoadingIndicator()
        setRefreshControl()
        setHomeViewData()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.tableView.bringSubviewToFront(loadingIndicator)
    }
    
    
    @objc private func refresh(sender:AnyObject){
        homeViewModel?.getHomeViewData()
    }
    
    private func setHomeViewData(){
        self.loadingIndicator.startAnimating()
        
        self.homeViewModel?.bindHomeViewModelToController = { [weak self] in
            guard let self = self else { return }
            
            let isRefreshing = self.tableView.refreshControl?.isRefreshing ?? true
            
            if (isRefreshing){
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.adjustAfterRefreshing()
                    self.tableView.reloadData()
                }
            }else{
                self.tableView.reloadData()
                self.loadingIndicator.stopAnimating()
            }
        }
    }
    
    func adjustAfterRefreshing(){
        self.tableView.refreshControl?.endRefreshing()
        let top =  self.tableView.adjustedContentInset.top + UIScreen.main.viewTopInset()
        let maxY = self.tableView.refreshControl?.frame.maxY ?? 0.0
        let y = maxY + top
        self.tableView.setContentOffset(CGPoint(x: 0, y: -y), animated:true)
    }
}


// MARK:- view configuration
extension HomeViewController {
    
    private func setTableViewConfiguration(){
        self.view.backgroundColor = Style.sharedInstance.getBackgroundColor()
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.separatorStyle = .none
        self.extendedLayoutIncludesOpaqueBars = true
        
        self.tableView.register(SliderTableViewCell.self, forCellReuseIdentifier: SliderTableViewCell.cellIdentifier)
        self.tableView.register(CategoriesTableViewCell.self, forCellReuseIdentifier: CategoriesTableViewCell.cellIdentifier)
        self.tableView.register(ProductsTableViewCell.self, forCellReuseIdentifier: ProductsTableViewCell.cellIdentifier)
        self.tableView.register(BestProductsTableViewCell.self, forCellReuseIdentifier: BestProductsTableViewCell.cellIdentifier)
        self.tableView.register(StoresTableViewCell.self, forCellReuseIdentifier: StoresTableViewCell.cellIdentifier)
    
    }
    
    private func setRefreshControl(){
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.tintColor = UIColor.lightGray
        self.tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
    }
    
    private func setLoadingIndicator(){
        if #available(iOS 13.0, *) {
            self.loadingIndicator = UIActivityIndicatorView(style: .large)
        } else {
            self.loadingIndicator = UIActivityIndicatorView(style: .gray)
        }
        
        self.tableView.addSubview(loadingIndicator)
        
        loadingIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-UIScreen.main.viewInset())
        }
    }
}

// MARK:- Table view delegates
extension HomeViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return homeViewModel?.sectionDataModels?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = homeViewModel?.sectionDataModels?[section]
        
        let tableViewHeaderView = TableViewHeaderView()
        tableViewHeaderView.headerTitle = section?.title
        return tableViewHeaderView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 36
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : section == 4 ? 80 : 24
        
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: SliderTableViewCell.cellIdentifier, for: indexPath) as! SliderTableViewCell
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesTableViewCell.cellIdentifier, for: indexPath) as! CategoriesTableViewCell
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductsTableViewCell.cellIdentifier, for: indexPath) as! ProductsTableViewCell
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: BestProductsTableViewCell.cellIdentifier, for: indexPath) as! BestProductsTableViewCell
            
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: StoresTableViewCell.cellIdentifier, for: indexPath) as! StoresTableViewCell
            
            return cell
        default:
            return UITableViewCell()
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableViewSize = abs(UIScreen.main.viewInset() - tableView.frame.height) + tableView.frame.width
        
        switch indexPath.section {
        case 0:
            return tableViewSize / 5
        case 1:
            return tableViewSize / 12
        case 2:
            return tableViewSize / 5
        case 3:
            return tableViewSize / 9
        case 4:
            return tableViewSize / 8
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let section = homeViewModel?.sectionDataModels?[indexPath.section]
        
        switch indexPath.section {
        case 0:
            let sliderTableViewCell = cell as! SliderTableViewCell
            sliderTableViewCell.sectionItemDataModels = sortSectionItems(section: section)
            
        case 1:
            let categoriesTableViewCell = cell as! CategoriesTableViewCell
            
            categoriesTableViewCell.sectionItemDataModels = sortSectionItems(section: section)
            
        case 2:
            let productsTableViewCell = cell as! ProductsTableViewCell
            
            productsTableViewCell.sectionItemDataModels = sortSectionItems(section: section)
            
        case 3:
            let bestProductsTableViewCell = cell as! BestProductsTableViewCell
            
            bestProductsTableViewCell.sectionItemDataModels = sortSectionItems(section: section)
            
        case 4:
            let storesTableViewCell = cell as! StoresTableViewCell
            
            storesTableViewCell.sectionItemDataModels = sortSectionItems(section: section)
            
        default:
            print("section not found")
        }

    }
    
}

extension HomeViewController {
    private func sortSectionItems(section: SectionDataModel?) -> [SectionItemDataModel]?{
        
        var sectionItems = section?.items?.allObjects as? [SectionItemDataModel]
        
        sectionItems?.sort(by: { $0.createdAt ?? Date() < $1.createdAt ?? Date() })
        
        return sectionItems
    }
}
