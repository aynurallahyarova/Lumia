//
//  TopicsController.swift
//  Lumora
//
//  Created by Aynur on 22.02.26.
//

import UIKit

class TopicsController: BaseController {
    let viewModel = TopicsViewModel()
    var coordinator: AppCoordinator?
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cv.register(TopicsCell.self, forCellWithReuseIdentifier: TopicsCell.identifier)
        
        cv.dataSource = self
        cv.delegate = self
        
        cv.backgroundColor = .white
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureViewModel() {
        viewModel.getTopics()
        viewModel.success = { [weak self] in
            self?.collectionView.reloadData()
        }
        viewModel.error = { error in
            print(error)
        }
    }
    
    override func configureUI() {
        navigationItem.title = "Topics"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
}
extension TopicsController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.topics.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicsCell.identifier, for: indexPath) as! TopicsCell
        
        let data = viewModel.topics[indexPath.row]
        
        cell.configure(data: data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        .init(width: view.frame.width - 32, height: 120)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let topic = viewModel.topics[indexPath.item]
        coordinator?.openTopicPhotos(topic: topic)
    }
}
