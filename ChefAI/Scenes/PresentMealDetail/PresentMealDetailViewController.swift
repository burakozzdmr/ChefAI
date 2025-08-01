//
//  PresentMealDetailViewController.swift
//  ChefAI
//
//  Created by Burak Özdemir on 11.05.2025.
//

import UIKit
import SnapKit
import Kingfisher
import WebKit

protocol PresentMealDetailControllerProtocol: AnyObject {
    func fetchDetailData(mealDetailData: Meal)
}

class PresentMealDetailViewController: UIViewController {

    // MARK: - Properties
    
    private let detailScrollView: UIScrollView = {
        let scrollView: UIScrollView = .init()
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view: UIView = .init()
        return view
    }()
    
    private lazy var dismissButton: UIButton = {
        let button: UIButton = .init()
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 24, weight: .heavy)
        button.setImage(UIImage(systemName: "xmark", withConfiguration: symbolConfiguration), for: .normal)
        button.tintColor = .customButton
        button.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
        return button
    }()
    
    private let detailImageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.image = .init()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 24
        return imageView
    }()
    
    private let detailNameLabel: UILabel = {
        let label: UILabel = .init()
        label.text = ""
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .black)
        label.numberOfLines = 0
        return label
    }()
    
    private let categoryView: UIView = {
        let view: UIView = .init()
        view.backgroundColor = .darkGray
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let categoryNameLabel: UILabel = {
        let label: UILabel = .init()
        label.text = ""
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .heavy)
        return label
    }()
    
    private let areaView: UIView = {
        let view: UIView = .init()
        view.backgroundColor = .darkGray
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let detailAreaLabel: UILabel = {
        let label: UILabel = .init()
        label.text = ""
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .heavy)
        return label
    }()
    
    private lazy var favouriteButton: UIButton = {
        let button: UIButton = .init()
        let configuration = UIImage.SymbolConfiguration(pointSize: 24, weight: .heavy)
        let image = UIImage(systemName: "heart", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .customButton
        button.clipsToBounds = true
        button.layer.cornerRadius = 24
        button.addTarget(self, action: #selector(favouriteTapped), for: .touchUpInside)
        return button
    }()
    
    private let recipeLabel: UILabel = {
        let label: UILabel = .init()
        label.text = "Recipe"
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        return label
    }()
    
    private let detailVideoWebView: WKWebView = {
        let webView: WKWebView = .init()
        webView.clipsToBounds = true
        webView.layer.cornerRadius = 24
        return webView
    }()
    
    private let detailDescriptionLabel: UILabel = {
        let label: UILabel = .init()
        label.text = ""
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let viewModel: PresentMealDetailViewModel
    private let loadingView: LoadingView = .init()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favouriteButton.isSelected = viewModel.fetchFavouriteState()
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 24, weight: .heavy)
        let currentImage: UIImage = viewModel.fetchFavouriteState()
        ? .init(systemName: "heart.fill", withConfiguration: configuration)!
        : .init(systemName: "heart", withConfiguration: configuration)!
        
        favouriteButton.setImage(currentImage, for: .normal)
    }
    
    // MARK: - Inits
    
    init(viewModel: PresentMealDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.outputDelegate = self
    }
    
    required init ?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Objective-C Methods

@objc private extension PresentMealDetailViewController {
    func dismissTapped() {
        self.dismiss(animated: true)
    }
    
    func favouriteTapped() {
        favouriteButton.isSelected.toggle()

        if favouriteButton.isSelected {
            AlertManager.shared.presentAlert(
                with: "ChefAI",
                and: "Added to favourites.",
                buttons: [UIAlertAction(
                    title: "OK",
                    style: .default,
                    handler: { _ in
                        self.viewModel.addFavouriteMeals(with: self.favouriteButton.isSelected)
                    }
                )],
                from: self
            )
            let configuration = UIImage.SymbolConfiguration(pointSize: 24, weight: .heavy)
            let image = UIImage(systemName: "heart.fill", withConfiguration: configuration)
            favouriteButton.setImage(image, for: .normal)
        } else {
            viewModel.deleteFavouriteMeals(with: self.favouriteButton.isSelected)
            let configuration = UIImage.SymbolConfiguration(pointSize: 24, weight: .heavy)
            let image = UIImage(systemName: "heart", withConfiguration: configuration)
            favouriteButton.setImage(image, for: .normal)
        }
    }
}

// MARK: - Privates
    
private extension PresentMealDetailViewController {
    func addViews() {
        view.addSubview(detailScrollView)
        detailScrollView.addSubview(contentView)
        
        contentView.addSubviews(
            detailImageView,
            dismissButton,
            detailNameLabel,
            categoryView,
            areaView,
            favouriteButton,
            recipeLabel,
            detailVideoWebView,
            detailDescriptionLabel
        )
        
        categoryView.addSubview(categoryNameLabel)
        areaView.addSubview(detailAreaLabel)
    }
    
    func configureConstraints() {
        detailScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(detailScrollView)
        }
        
        detailImageView.snp.makeConstraints {
            $0.top.equalTo(dismissButton.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(240)
        }
        
        dismissButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(32)
        }
        
        detailNameLabel.snp.makeConstraints {
            $0.top.equalTo(detailImageView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        categoryView.snp.makeConstraints {
            $0.top.equalTo(detailNameLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(160)
            $0.height.equalTo(40)
        }
        
        categoryNameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        areaView.snp.makeConstraints {
            $0.top.equalTo(detailNameLabel.snp.bottom).offset(16)
            $0.leading.equalTo(categoryView.snp.trailing).offset(32)
            $0.width.equalTo(160)
            $0.height.equalTo(40)
        }
        
        favouriteButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(32)
            $0.width.height.equalTo(48)
        }
        
        detailAreaLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        recipeLabel.snp.makeConstraints {
            $0.top.equalTo(categoryView.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(16)
        }
        
        detailVideoWebView.snp.makeConstraints {
            $0.top.equalTo(recipeLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(240)
        }
        
        detailDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(detailVideoWebView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
    func configureUI() {
        addViews()
        configureConstraints()
        
        view.backgroundColor = .customBackgroundColor2
        detailScrollView.backgroundColor = .customBackgroundColor2
        contentView.backgroundColor = .customBackgroundColor2
        
        loadingView.isHidden = false
    }
}

// MARK: - MealDetailViewModelOutputProtocol

extension PresentMealDetailViewController: MealDetailControllerProtocol {
    func fetchDetailData(mealDetailData: Meal) {
        print("fetchDetailData is executed !")
        
        print("--------------- DETAIL MEAL DATA ---------------")
        print(mealDetailData)
        detailNameLabel.text = mealDetailData.mealName
        categoryNameLabel.text = mealDetailData.mealCategory
        detailAreaLabel.text = mealDetailData.mealArea
        detailDescriptionLabel.text = mealDetailData.mealDescription
        
        guard let urlString = mealDetailData.mealImageURL,
              let imageURL = URL(string: urlString),
              let videoURL = mealDetailData.mealYoutubeURL,
              let embeddedVideoURL = URL(string: EmbedFormatter.convertToEmbed(from: videoURL))
        else { return }
        
        detailImageView.kf.setImage(with: imageURL)
        
        DispatchQueue.main.async {
            self.loadingView.isHidden = true
        }
        
        let videoRequest: URLRequest = .init(url: embeddedVideoURL)
        detailVideoWebView.load(videoRequest)
    }
}

