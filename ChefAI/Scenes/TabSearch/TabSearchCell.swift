//
//  SearchCell.swift
//  ChefAI
//
//  Created by Burak Özdemir on 18.04.2025.
//

import UIKit
import SnapKit
import Kingfisher

class TabSearchCell: UICollectionViewCell {
    static let identifier = "tabSearchCell"
    
    // MARK: - Properties
    
    private let containerView: UIView = {
        let view: UIView = .init()
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let searchMealImageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.image = .init()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let bottomView: UIView = {
        let view: UIView = .init()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        return view
    }()
    
    private let searchMealNameLabel: UILabel = {
        let label: UILabel = .init()
        label.text = ""
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .heavy)
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
    
    func configure(cell: Meal) {
        searchMealNameLabel.text = cell.mealName
        
        guard let urlString = cell.mealImageURL, let imageURL = URL(string: urlString) else { return }
        searchMealImageView.kf.setImage(with: imageURL)
    }
}

// MARK: - Privates

private extension TabSearchCell {
    func addViews() {
        addSubview(containerView)
        containerView.addSubviews(
            searchMealImageView,
            bottomView
        )
        bottomView.addSubview(searchMealNameLabel)
    }
    
    func configureConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        searchMealImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bottomView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        searchMealNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(bottomView)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
    }
}
