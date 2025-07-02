//
//  SearchBarView.swift
//  ChefAI
//
//  Created by Burak Özdemir on 18.04.2025.
//

import UIKit
import SnapKit

class SearchBarView: UIView {
    
    // MARK: - Properties
    
    private let searchLabel: UILabel = {
        let label: UILabel = .init()
        label.text = "What would you like to eat?"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 19, weight: .bold)
        return label
    }()
    
    private let searchImageView: UIImageView = {
        let imageView: UIImageView = .init()
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        imageView.image = UIImage(systemName: "magnifyingglass", withConfiguration: config)
        imageView.contentMode = .scaleToFill
        imageView.tintColor = .darkGray
        return imageView
    }()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureUI()
    }
    
    required init ?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Privates

private extension SearchBarView {
    func addViews() {
        addSubviews(
            searchLabel,
            searchImageView
        )
    }
    
    func configureConstraints() {
        searchLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(searchImageView.snp.trailing).offset(16)
        }
        
        searchImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(8)
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
        
        backgroundColor = .white
        layer.cornerRadius = 8
        clipsToBounds = true
    }
}

