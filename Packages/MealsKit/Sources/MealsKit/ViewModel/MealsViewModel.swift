//
//  File.swift
//  
//
//  Created by Michael Iskandar on 09/01/24.
//

import UIKit
import CommonKit
import UtilityKit
import RxSwift
import ConnectionKit

public enum MealListState: Equatable {
    case error(error: String)
    case meal(items: [Meal])
    case empty
}

class MealsViewModel: MealsViewModelRespondObservable {
    
    @Inject var mealService: MealService
    @Inject var mealRouting: MealRouting
    
    @BehaviourWrapper
    var searchState: MealListState = .empty
    var searchObservable: Observable<MealListState> {
        $searchState
    }

    let disposeBag = DisposeBag()
    init() {}
}

extension MealsViewModel {
    func search(query: String) {
        mealService.searchMeals(q: query)
            .subscribeOnNext { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let item):
                    if let items = item.meals, items.count > 0 {
                        self.searchState = .meal(items: items)
                    } else {
                        self.searchState = .empty
                    }
                case .failure(let error):
                    self.searchState = .error(error: error.localizedDescription)
                }
            }.disposed(by: disposeBag)
    }

    func goToMeal(from viewController: UIViewController, id: String) {
        mealRouting.routeToMealDetail(from: viewController, with: id)
    }
}
