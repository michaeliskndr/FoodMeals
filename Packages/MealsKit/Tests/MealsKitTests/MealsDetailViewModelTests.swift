//
//  File.swift
//  
//
//  Created by Michael Iskandar on 10/01/24.
//

import XCTest
import RxSwift
import RxTest
import ConnectionKit
import CommonKit
@testable import MealsKit

class MealsDetailViewModelTests: XCTestCase {
    
    var viewModel: MealsDetailViewModel!
    var mockMealService: MealService!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        // create mock meal service
        mockMealService = MockMealService()
        
        // initiate viewmodel to test
        viewModel = MealsDetailViewModel()
        viewModel.mealService = mockMealService
        
        // initiate scheduler
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        viewModel = nil
        mockMealService = nil
        scheduler = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func testGetMealSuccess() {
        // Arrange
        let id = "123"
        let meal = Meals.mock
        let successResponse = Result<Meals, Error>.success(meal)
        
        let mockMealService = MockMealService()
        viewModel.mealService = mockMealService
        
        mockMealService.getMealDetailStub = { _ in
            return Observable.just(successResponse)
        }
        
        let observer = scheduler.createObserver(MealDetailState.self)
        
        // act
        viewModel.getMeal(id: id)
        viewModel.mealObservable
            .subscribe(onNext: { state in
                observer.onNext(state)
            }).disposed(by: disposeBag)
        
        scheduler.start()
        
        guard let assertMeal = meal.meals?.first else { return }
        // assert
        XCTAssertEqual(observer.events, [
            .next(0, .meal(item: assertMeal))
        ])
    }
    
    func testGetMealError() {
        // arrange
        let id = "123"
        let errorMessage = "An error occurred"
        let errorResponse = Result<Meals, Error>.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage]))

        let mockMealService = MockMealService()
        viewModel.mealService = mockMealService
        
        mockMealService.getMealDetailStub = { _ in
            return Observable.just(errorResponse)
        }
        
        let observer = scheduler.createObserver(MealDetailState.self)
        
        // act
        viewModel.getMeal(id: id)
        viewModel.mealObservable
            .subscribe(onNext: { state in
                observer.onNext(state)
            }).disposed(by: disposeBag)
        
        scheduler.start()
        
        // assert
        XCTAssertEqual(observer.events, [
            .next(0, .error(error: errorMessage))
        ])
    }
}

private extension Meals {
    static var mock: Meals {
        Meals(meals: [
            Meal(id: "1", meal: "Udang", thumbnail: "Gambar", category: "Food", tags: nil, area: "Indonesia"),
        ])
    }
}
