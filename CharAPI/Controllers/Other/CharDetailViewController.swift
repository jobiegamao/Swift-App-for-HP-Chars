//
//  CharDetailViewController.swift
//  CharAPI
//
//  Created by may on 5/15/23.
//

import UIKit


/// A controller that shows a single character(star) information
class CharDetailViewController: UIViewController {

	/// star character of this detail view controller
	public var star: Character?
	private var viewModel: CharDetailViewViewModel!
	
	private lazy var collectionView: UICollectionView = {
		let cv = UICollectionView(frame: .zero, collectionViewLayout: self.viewModel.createCVLayout())
		
		cv.register(UINib(nibName: CharDetailViewPhotoCollectionViewCell.identifier, bundle: nil),
					forCellWithReuseIdentifier: CharDetailViewPhotoCollectionViewCell.identifier)
		cv.register(UINib(nibName: CharDetailViewBasicInfoCollectionViewCell.identifier, bundle: nil),
					forCellWithReuseIdentifier: CharDetailViewBasicInfoCollectionViewCell.identifier)
		
		cv.register(CharDetailViewRelationsCollectionViewCell.self, forCellWithReuseIdentifier: CharDetailViewRelationsCollectionViewCell.identifier)
		cv.register(CharDetailAdtnlInfoCollectionViewCell.self, forCellWithReuseIdentifier: CharDetailAdtnlInfoCollectionViewCell.identifier)
		cv.register(CharDetailListInfoCollectionViewCell.self, forCellWithReuseIdentifier: CharDetailListInfoCollectionViewCell.identifier)
		
		cv.translatesAutoresizingMaskIntoConstraints = false
		cv.dataSource = self.viewModel
		cv.delegate = self.viewModel
		return cv
	}()
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		viewModel = CharDetailViewViewModel(star: star!)
		
		view.backgroundColor = .systemBackground 
		view.addSubview(collectionView)
		addConstraints()
		
		
    }
	

	
	private func addConstraints(){
	
		let view = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: view.topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}

}
