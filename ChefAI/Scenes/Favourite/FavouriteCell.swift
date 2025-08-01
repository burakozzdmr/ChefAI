//
//  FavouriteCell.swift
//  ChefAI
//
//  Created by Burak Özdemir on 28.06.2025.
//

import UIKit
import SnapKit
import Kingfisher

class FavouriteCell: UICollectionViewCell {
    static let identifier = "favouriteCell"
    
    // MARK: - Properties
    
    private let containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.backgroundColor = .customBackgroundColor2
        return view
    }()
    
    private let mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .customBackgroundColor2
        return imageView
    }()
    
    private let mealNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .black)
        label.numberOfLines = 3
        label.textAlignment = .center
        return label
    }()
    
    private let bottomView: UIView = {
        let view: UIView = .init()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    
    func configure(with cellContent: Meal) {
        guard let urlString = cellContent.mealImageURL, let imageURL = URL(string: urlString) else { return }

        mealImageView.kf.setImage(with: imageURL)
        mealNameLabel.text = cellContent.mealName
    }
}

// MARK: - Privates

private extension FavouriteCell {
    func addViews() {
        contentView.addSubview(containerView)
        containerView.addSubviews(
            mealImageView,
            bottomView,
            mealNameLabel
        )
    }
    
    func configureConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        mealImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        mealNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(bottomView)
            $0.leading.trailing.equalToSuperview().inset(32)
        }
        
        bottomView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(48)
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
    }
}
