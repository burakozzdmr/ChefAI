//
//  DailyMealCell.swift
//  ChefAI
//
//  Created by Burak Özdemir on 10.03.2025.
//

import UIKit
import Kingfisher
import SnapKit

class DailyMealCell: UICollectionViewCell {
    static let identifier = "dailyMealCell"
    
    // MARK: - Properties
    
    private let mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure(with cellContent: Meal) {
        guard let urlString = cellContent.mealImageURL else { return }
        guard let imageURL = URL(string: urlString) else { return }

        mealImageView.kf.setImage(with: imageURL)
    }
}

// MARK: - Privates

private extension DailyMealCell {
    func addViews() {
        addSubview(mealImageView)
    }
    
    func configureConstraints() {
        mealImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
    }
}
