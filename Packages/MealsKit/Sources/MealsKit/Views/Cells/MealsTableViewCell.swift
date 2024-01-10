//
//  File.swift
//  
//
//  Created by Michael Iskandar on 09/01/24.
//

import UIKit
import CommonKit
import Kingfisher
import SnapKit

protocol MealsTableViewCellDelegate: AnyObject {
    func didTapImage(_ image: UIImage)
}

final class MealsTableViewCell: UITableViewCell {
    
    static var identifier: String { String.init(describing: Self.self) }
    
    weak var delegate: MealsTableViewCellDelegate?
    
    lazy var mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var mealLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .darkGray
        return label
    }()
    
    lazy var areaLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        return label
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .darkGray
        return label
    }()

    lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .darkGray
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        mealImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapImage(_ sender: UITapGestureRecognizer) {
        guard let image = mealImageView.image else { return }
        delegate?.didTapImage(image)
    }
    
    func apply(meal: Meal) {
        if let url = URL(string: meal.thumbnail) {
            mealImageView.kf.setImage(with: url)
        }
        mealLabel.text = meal.meal
        areaLabel.text = "\(meal.area) Food"
        categoryLabel.text = meal.category
        tagLabel.text = meal.tags ?? "No Tags"
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
