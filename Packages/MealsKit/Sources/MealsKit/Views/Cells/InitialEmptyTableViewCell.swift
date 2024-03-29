//
//  File.swift
//  
//
//  Created by Michael Iskandar on 09/01/24.
//

import UIKit
import SnapKit
import CommonKit

final class InitialEmptyTableViewCell: UITableViewCell {
    
    static var identifier: String { String.init(describing: Self.self) }
    
    lazy var illustrationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .darkGray
        return imageView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .darkGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        contentView.addSubview(illustrationImageView)
        contentView.addSubview(descriptionLabel)
        
        illustrationImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(illustrationImageView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
    }
    
    func apply(with type: MealsViewController.CellType) {
        switch type {
        case .empty:
            if #available(iOS 13.0, *) {
                illustrationImageView.image = .init(systemName: "multiply.circle.fill")
            }
            descriptionLabel.text = "Item not found"
        case .initial:
            if #available(iOS 13.0, *) {
                illustrationImageView.image = .init(systemName: "magnifyingglass.circle")
            }
            descriptionLabel.text = "Find your favourite food"
        default: break
        }
    }
}
