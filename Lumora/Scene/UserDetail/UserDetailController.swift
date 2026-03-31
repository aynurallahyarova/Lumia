//
//  UserDetailController.swift
//  Lumora
//
//  Created by Aynur on 28.03.26.
//

import UIKit

class UserDetailController: BaseController {
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width - 32) / 2
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(UserDetailPhotoCell.self, forCellWithReuseIdentifier: UserDetailPhotoCell.identifier)
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()
    
    private lazy var profileImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 40
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var blurView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .systemMaterialDark)
        let view = UIVisualEffectView(effect: blur)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bioLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 13, weight: .regular)
        lbl.textColor = .white
        lbl.numberOfLines = 2
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var locationLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12, weight: .regular)
        lbl.textColor = .lightGray
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var statsLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12, weight: .regular)
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    //MARK: segment
    private lazy var segment: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Photos", "Likes"])
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()

    private let viewModel: UserDetailViewModel
    var coordinator: AppCoordinator?
    
    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        view.addSubview(backgroundImage)
        view.addSubview(blurView)
        view.addSubview(profileImage)
        view.addSubview(nameLabel)
        view.addSubview(bioLabel)
        view.addSubview(locationLabel)
        view.addSubview(statsLabel)
        view.addSubview(segment)
        view.addSubview(collection)
    }
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            // background
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.heightAnchor.constraint(equalToConstant: 250),
            
            blurView.topAnchor.constraint(equalTo: backgroundImage.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor),
            
            // profile
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.centerYAnchor.constraint(equalTo: backgroundImage.bottomAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 80),
            profileImage.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 8),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bioLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            bioLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            locationLabel.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 4),
            locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            statsLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 6),
            statsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            segment.topAnchor.constraint(equalTo: statsLabel.bottomAnchor, constant: 12),
            segment.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segment.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            collection.topAnchor.constraint(equalTo: segment.bottomAnchor, constant: 12),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    override func configureViewModel() {
        viewModel.fetchAll()
        viewModel.success = { [weak self] in
            guard let self else { return }
            
            let userDetail = self.viewModel.userdetail

            self.backgroundImage.loadURL(data: userDetail?.profileImage?.medium ?? "")
            self.profileImage.loadURL(data: userDetail?.profileImage?.medium ?? "")
            
            self.nameLabel.text = userDetail?.name
            self.bioLabel.text = userDetail?.bio
            self.locationLabel.text = "📍 \(userDetail?.location ?? "")"
            
            self.statsLabel.text = "Photos: \(userDetail?.totalPhotos ?? 0)  Likes: \(userDetail?.totalLikes ?? 0)"
            
            self.collection.reloadData()
        }
        viewModel.error = { error in
            print(error)
        }
    }
    
    
    @objc private func segmentChanged() {
        //likes photos elave eliyersen
        viewModel.changeSegment(index: segment.selectedSegmentIndex)
    }

}
extension UserDetailController: CollectionConfiguration {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserDetailPhotoCell.identifier, for: indexPath) as! UserDetailPhotoCell
        cell.configure(photo: viewModel.photos[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = viewModel.photos[indexPath.item]
        coordinator?.openPhotoDetail(photo: photo)
    }
    
    
}
