//
//  File.swift
//  
//
//  Created by Michael Iskandar on 09/01/24.
//

import UIKit
import UtilityKit
import ConnectionKit
import CommonKit
import SnapKit
import DiffableDataSources
import RxSwift

protocol MealsViewModelRespondObservable {
    func search(query: String)
    func goToMeal(from viewController: UIViewController, id: String)
    func presentImage(from viewController: UIViewController, image: UIImage)
    var searchObservable: Observable<MealListState> { get }
}

class MealsViewController: UIViewController {
    
    var viewModel: MealsViewModelRespondObservable?
    
    enum SectionType: Hashable {
        case main
    }
    
    enum CellType: Hashable {
        case empty
        case initial
        case item(item: Meal)
        case mock
        
        var item: Meal? {
            switch self {
            case .item(let item): return item
            default: return nil
            }
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(MealsTableViewCell.self, forCellReuseIdentifier: MealsTableViewCell.identifier)
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
        setupSearchController()
        setupRx()
    }
    
    private func setupView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        navigationItem.title = "Food Meals"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func setupRx() {
        /// responder
        searchController.searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard $0.count > 0 else {
                    self?.items = [.initial]
                    return
                }
                self?.viewModel?.search(query: $0)
            }).disposed(by: disposeBag)
        
        /// observable
        viewModel?.searchObservable
            .observe(on: MainScheduler.instance)
            .subscribeOnNext(run: { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .meal(let items):
                    let tempItem = items.compactMap { CellType.item(item: $0) }
                    self.items = tempItem
                case .initial:
                    self.items = [.initial]
                case .empty:
                    self.items = [.empty]
                case .error:
                    self.showFailedAlert()
                }
            }).disposed(by: disposeBag)
    }
}

extension MealsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath), let item = item.item else { return }
        viewModel?.goToMeal(from: self, id: item.id)
    }
}

extension MealsViewController: MealsTableViewCellDelegate {
    func didTapImage(_ image: UIImage) {
        viewModel?.presentImage(from: self, image: image)
    }
}

extension MealsViewController {
    private func setupReusableCell(_ tableView: UITableView, _ indexPath: IndexPath, _ cellType: CellType) -> UITableViewCell {
        switch cellType {
        case .mock:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MealsTableViewCell.identifier, for: indexPath) as? MealsTableViewCell
            else { return UITableViewCell() }
            cell.applyMock()
            return cell
        case .item(let item):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MealsTableViewCell.identifier, for: indexPath) as? MealsTableViewCell
            else { return UITableViewCell() }
            cell.apply(meal: item)
            cell.delegate = self
            return cell
        case .empty, . initial:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InitialEmptyTableViewCell.identifier, for: indexPath) as? InitialEmptyTableViewCell
            else { return UITableViewCell() }
            cell.apply(with: cellType)
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
