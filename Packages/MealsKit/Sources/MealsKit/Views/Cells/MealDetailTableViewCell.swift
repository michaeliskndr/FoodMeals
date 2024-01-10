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

protocol MealsDetailTableViewCellDelegate: AnyObject {
    func didTapImage(_ image: UIImage)
}

final class MealDetailTableViewCell: UITableViewCell {
        
    static var identifier: String { String.init(describing: Self.self) }
    
    weak var delegate: MealsDetailTableViewCellDelegate?
    
    lazy var mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var mealLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .darkGray
        return label
    }()
    
    lazy var areaLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    lazy var instructionDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .darkGray
        return label
    }()

    lazy var instructionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
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
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(mealLabel)
        stackView.addArrangedSubview(areaLabel)
        stackView.addArrangedSubview(instructionDescriptionLabel)
        stackView.addArrangedSubview(instructionLabel)
        
        stackView.setCustomSpacing(16, after: areaLabel)
        stackView.setCustomSpacing(8, after: instructionDescriptionLabel)
        
        mealImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(240)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(mealImageView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview()
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
        areaLabel.text = "\(meal.area) Food - \(meal.category)"
        instructionDescriptionLabel.text = "Instruction"
        instructionLabel.text = meal.instructions
    }
    
    func applyMock() {
        if #available(iOS 13.0, *) {
            mealImageView.image = .init(systemName: "star")
        }
        mealLabel.text = "Rendang"
        areaLabel.text = "from: Indonesia"
        instructionDescriptionLabel.text = "main course"
    }
}
