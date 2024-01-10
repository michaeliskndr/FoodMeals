//
//  File.swift
//  
//
//  Created by Michael Iskandar on 10/01/24.
//

import UIKit
import CommonKit
import UtilityKit
import RxSwift
import ConnectionKit

public enum MealDetailState: Equatable {
    case error(error: String)
    case meal(item: Meal)
    case loading
}

class MealsDetailViewModel: MealDetailRespondObservable {
    
    @Inject var mealRouting: MealRouting
    @Inject var mealService: MealService
    
    @BehaviourWrapper
    var mealDetailState: MealDetailState = .loading
    var mealObservable: Observable<MealDetailState> {
        $mealDetailState
    }

    let disposeBag = DisposeBag()
    init() {}
}

extension MealsDetailViewModel {
    func getMeal(id: String) {
        mealService.getMealDetail(id: id)
            .subscribeOnNext { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let item):
                    guard let item = item.meals?.first else { return }
                    self.mealDetailState = .meal(item: item)
                case .failure(let error):
                    self.mealDetailState = .error(error: error.localizedDescription)
                }
            }.disposed(by: disposeBag)
    }
    
    func presentImage(from viewController: UIViewController, image: UIImage) {
        mealRouting.presentImage(from: viewController, with: image)
    }
}
