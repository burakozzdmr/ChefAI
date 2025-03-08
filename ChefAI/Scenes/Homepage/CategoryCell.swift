//
//  CategoryCell.swift
//  ChefAI
//
//  Created by Burak Özdemir on 8.03.2025.
//

import UIKit
import SnapKit

// MARK: - CategoryCell

class CategoryCell: UICollectionViewCell {
    static let identifier = "categoryCell"
    
    // MARK: - Properties
    
     private let categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .customText
        return label
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
    
    func configure(with cell: String) {
        categoryTitleLabel.text = cell
    }
}

// MARK: - Privates

private extension CategoryCell {
    func addViews() {
        addSubview(categoryTitleLabel)
    }
    
    func configureConstraints() {
        categoryTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
    }
}
