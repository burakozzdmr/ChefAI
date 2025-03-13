//
//  ListCell.swift
//  ChefAI
//
//  Created by Burak Özdemir on 13.03.2025.
//

import UIKit
import SnapKit
import Kingfisher

class ListCell: UICollectionViewCell {
    static let identifier = "listCell"
    
    // MARK: - Properties
    
    private let mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let mealNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .black)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init ?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure(with cellContent: Meal) {
        mealNameLabel.text = cellContent.mealName
        
        guard let urlString = cellContent.mealImageURL, let imageURL = URL(string: urlString) else { return }
        mealImageView.kf.setImage(with: imageURL)
    }
}

// MARK: - Privates

private extension ListCell {
    func addViews() {
        contentView.addSubview(mealImageView)
        contentView.addSubview(mealNameLabel)
    }
    
    func configureConstraints() {
        mealImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(128)
        }
        
        mealNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
    }
}
