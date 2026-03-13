//
//  TopicsController.swift
//  Lumora
//
//  Created by Aynur on 22.02.26.
//

import UIKit

class TopicsController: BaseController {
    let viewModel = TopicsViewModel()
    
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
        viewModel.success = {
            self.collectionView.reloadData()
        }
        viewModel.error = { error in
            print(error)
          }
    }
    
    override func configureUI() {
        title = "Topics"
        
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
        
        CGSize(width: view.frame.width - 32, height: 120)
    }
}
