//
//  File.swift
//  
//
//  Created by Michael Iskandar on 10/01/24.
//

import UIKit
import CommonKit
import Kingfisher
import SnapKit

final class MealDetailTableViewCell: UITableViewCell {
    
    static var identifier: String { String.init(describing: Self.self) }
    
    lazy var mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var mealLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    lazy var areaLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()

    lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        separatorInset = .zero
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        contentView.addSubview(mealImageView)
        contentView.addSubview(mealLabel)
        contentView.addSubview(areaLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(tagLabel)
        
        mealImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.height.width.equalTo(100)
        }
        
        mealLabel.snp.makeConstraints { make in
            make.top.equalTo(mealImageView)
            make.leading.equalTo(mealImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        areaLabel.snp.makeConstraints { make in
            make.top.equalTo(mealLabel.snp.bottom).offset(4)
            make.leading.equalTo(mealImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-16)
        }

        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(areaLabel.snp.bottom).offset(8)
            make.leading.equalTo(mealImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-16)
        }

        tagLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(4)
            make.leading.equalTo(mealImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    func apply(meal: Meal) {
        if let url = URL(string: meal.thumbnail) {
            mealImageView.kf.setImage(with: url)
        }
        mealLabel.text = meal.meal
        areaLabel.text = "from: \(meal.area)"
        categoryLabel.text = meal.category
        tagLabel.text = meal.tags
    }
    
    func applyMock() {
        if #available(iOS 13.0, *) {
            mealImageView.image = .init(systemName: "star")
        }
        mealLabel.text = "Rendang"
        areaLabel.text = "from: Indonesia"
        categoryLabel.text = "main course"
        tagLabel.text = "meat, rempah, juicy"
    }
}
