//
//  File.swift
//  
//
//  Created by Michael Iskandar on 09/01/24.
//

import XCTest
import RxSwift
import RxTest
import ConnectionKit
import CommonKit
@testable import MealsKit

class MealsViewModelTests: XCTestCase {
    
    var viewModel: MealsViewModel!
    var mockMealService: MealService!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        
        // Create a mock meal service
        mockMealService = MockMealService()
        
        // Initialize the view model with the mock meal service
        viewModel = MealsViewModel()
        viewModel.mealService = mockMealService
        
        // Initialize the scheduler and dispose bag
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
    
    // Test the search method when meals are found
    func testSearchMealsSuccess() {
        // Arrange
        let query = "test"
        let meals = Meals.mock
        let successResponse = Result<Meals, Error>.success(meals)
        
        let mockMealService = MockMealService()
        viewModel.mealService = mockMealService
        
        mockMealService.searchMealsStub = { _ in
            return Observable.just(successResponse)
        }
        
        let observer = scheduler.createObserver(MealListState.self)
        
        // Act
        viewModel.search(query: query)
        viewModel.searchObservable
            .subscribe(onNext: { state in
                observer.onNext(state)
            })
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        // Assert
        let expectedStates: [Recorded<Event<MealListState>>] = [
            .next(0, .meal(items: meals.meals ?? []))
        ]
        
        XCTAssertEqual(observer.events, expectedStates)
    }
    
    // Test the search method when no meals are found
    func testSearchMealsEmpty() {
        // Arrange
        let query = "test"
        let emptyResponse = Result<Meals, Error>.success(Meals.emptyMock)
        
        let mockMealService = MockMealService()
        viewModel.mealService = mockMealService
        
        mockMealService.searchMealsStub = { _ in
            return Observable.just(emptyResponse)
        }
        
        let observer = scheduler.createObserver(MealListState.self)
        
        // Act
        viewModel.search(query: query)
        viewModel.searchObservable
            .subscribe(onNext: { state in
                observer.onNext(state)
            })
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        // Assert
        let expectedStates: [Recorded<Event<MealListState>>] = [
            .next(0, .empty)
        ]
        
        XCTAssertEqual(observer.events, expectedStates)
    }
    
    // Test the search method when an error occurs
    func testSearchMealsError() {
        // Arrange
        let query = "test"
        let errorMessage = "An error occurred"
        let errorResponse = Result<Meals, Error>.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage]))
        
        let mockMealService = MockMealService()
        viewModel.mealService = mockMealService
        
        mockMealService.searchMealsStub = { _ in
            return Observable.just(errorResponse)
        }
        
        let observer = scheduler.createObserver(MealListState.self)
        
        // Act
        viewModel.search(query: query)
        viewModel.searchObservable
            .subscribe(onNext: { state in
                observer.onNext(state)
            })
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        // Assert
        let expectedStates: [Recorded<Event<MealListState>>] = [
            .next(0, .error(error: errorMessage))
        ]
        
        XCTAssertEqual(observer.events, expectedStates)
    }
}

private extension Meals {
    static var emptyMock: Meals {
        Meals(meals: nil)
    }
    
    static var mock: Meals {
        Meals(meals: [
            Meal(id: "1", meal: "Udang", thumbnail: "Gambar", category: "Food", tags: nil, area: "Indonesia"),
            Meal(id: "2", meal: "Rendang", thumbnail: "Gambar", category: "Food", tags: nil, area: "Indonesia"),
        ])
    }
}

class MockMealService: MealService {
    var searchMealsStub: ((_ query: String) -> APIResponse<Meals>)?
    var getMealDetailStub: ((_ id: String) -> APIResponse<Meals>)?
    
    func searchMeals(q: String) -> APIResponse<Meals> {
        if let searchMealsStub = searchMealsStub {
            return searchMealsStub(q)
        } else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No stub for searchMealsStub"])
            return Observable.just(.failure(error))
        }
    }
    
    func getMealDetail(id: String) -> APIResponse<Meals> {
        if let getMealDetailStub = getMealDetailStub {
            return getMealDetailStub(id)
        } else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No stub for getMealStub"])
            return Observable.just(.failure(error))
        }
    }
}
