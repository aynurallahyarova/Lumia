//
//  TopicsPhotoController.swift
//  Lumora
//
//  Created by Aynur on 22.03.26.
//

import UIKit

class TopicsPhotoController: BaseController {
    
    private lazy var collection: UICollectionView = {
        let layout = WaterfallLayout()
        layout.delegate = self
        layout.sectionInset = UIEdgeInsets(top: 4, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.identifier)
        return collection
        
    }()
    
    private let topic: Topic
    var coordinator: AppCoordinator?
    private lazy var viewModel = TopicsPhotoViewModel(useCase: TopicsPhotoManager())
    
    init(topic: Topic) {
        self.topic = topic
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func configureUI() {
        navigationItem.title = topic.title ?? "Topic"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = .white
    }
    override func configureViewModel() {
        viewModel.fetchPhotos(topicId: topic.slug ?? "")
        viewModel.success = { [weak self] in
            self?.collection.reloadData()
        }
        viewModel.error = { error in
            print(error)
        }
    }
    override func configureConstraints() {
        view.addSubview(collection)
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension TopicsPhotoController: CollectionConfiguration {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.identifier, for: indexPath) as! HomeCell
        cell.configure(with: viewModel.photos[indexPath.item])
        return cell
    }

}
extension TopicsPhotoController: WaterfallLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 8) / 2
        
        let photo = viewModel.photos[indexPath.item]
        
        let photoWidth = CGFloat(photo.urls?.width ?? 300)
        let photoHeight = CGFloat(photo.urls?.height ?? 300)
        
        let ratio = photoHeight / photoWidth
        let imageHeight = width * ratio
        
        let totalHeight = imageHeight + 50
        
        return CGSize(width: width, height: indexPath.item % 2 == 0 ? totalHeight : imageHeight)
    }
    
    func collectionViewLayout(for section: Int) -> WaterfallLayout.Layout {
        //        .waterfall(column: 2, distributionMethod: .balanced)
        .waterfall(column: 2, distributionMethod: .balanced)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = viewModel.photos[indexPath.item]
        coordinator?.openPhotoDetail(photo: photo)
    }
}
