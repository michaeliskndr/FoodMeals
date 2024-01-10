////
////  File.swift
////  
////
////  Created by Michael Iskandar on 10/01/24.
////

import UIKit
import UtilityKit
import ConnectionKit
import CommonKit
import SnapKit
import DiffableDataSources
import RxSwift

class MealsDetailViewController: UIViewController {
    
    var viewModel: MealDetailRespondObservable?
    
    var id: String? {
        didSet {
            viewModel?.getMeal(id: id ?? "")
        }
    }
    
    enum SectionType: Hashable {
        case main
    }
    
    enum CellType: Hashable {
        case loading
        case item(item: Meal)
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(MealDetailTableViewCell.self, forCellReuseIdentifier: MealDetailTableViewCell.identifier)
        tableView.register(InitialEmptyTableViewCell.self, forCellReuseIdentifier: InitialEmptyTableViewCell.identifier)
        return tableView
    }()
    
    lazy var searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    lazy var dataSource: TableViewDiffableDataSource = TableViewDiffableDataSource<SectionType, CellType>(tableView: tableView) { [weak self] tableView, indexPath, cellType in
        guard let self = self else { return UITableViewCell() }
        return setupReusableCell(tableView, indexPath, cellType)
    }
    
    var items: [CellType] = [] {
        didSet {
            refreshSnapShot()
        }
    }
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupRx()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func setupRx() {
        /// observable
        viewModel?.mealObservable
            .observe(on: MainScheduler.instance)
            .subscribeOnNext(run: { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .meal(let item):
                    self.items = [.item(item: item)]
                    navigationItem.title = item.meal
                case .loading:
                    self.items = [.loading]
                case .error(let error):
                    self.items = [.loading]
                }
            }).disposed(by: disposeBag)
    }
}

extension MealsDetailViewController: UITableViewDelegate {
    private func setupReusableCell(_ tableView: UITableView, _ indexPath: IndexPath, _ cellType: CellType) -> UITableViewCell {
        switch cellType {
        case .loading:
            let cell = UITableViewCell()
            let spinner = UIActivityIndicatorView(style: .gray)
            cell.addSubview(spinner)
            spinner.snp.makeConstraints { make in
                make.centerX.centerY.equalToSuperview()
            }
            spinner.startAnimating()
            return cell
        case .item(let item):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MealDetailTableViewCell.identifier, for: indexPath) as? MealDetailTableViewCell
            else { return UITableViewCell() }
            cell.apply(meal: item)
            return cell
        }
    }
    
    private func refreshSnapShot() {
        var snapshot = DiffableDataSourceSnapshot<SectionType, CellType>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        dataSource.apply(snapshot)
    }
}
