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
		
		cv.register(UINib(nibName: CharDetailViewPhotoCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CharDetailViewPhotoCollectionViewCell.identifier)
		cv.register(CharDetailViewBasicInfoCollectionViewCell.self, forCellWithReuseIdentifier: CharDetailViewBasicInfoCollectionViewCell.identifier)
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




/*
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
	 /// computed viewModel property that needs a Character
	 private var viewModel: CharDetailViewViewModel {
		 CharDetailViewViewModel(star: star!)
	 }
	 
	 private var collectionView: UICollectionView?
	 
	 override func viewDidLoad() {
		 super.viewDidLoad()
		 
		 view.backgroundColor = .systemBackground
		 
		 let collectionView = setUpCollectionView()
		 self.collectionView = collectionView
		 view.addSubview(collectionView)
		 addConstraints()
		 // remove later
		 title = viewModel.title
		 navigationItem.largeTitleDisplayMode = .never
	 }
	 
	 /// collectionView will be setup in the viewModel
	 private func setUpCollectionView() -> UICollectionView {
		 let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
			 return self.viewModel.createCVSection(for: sectionIndex)
		 }
		 let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		 collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
		 collectionView.dataSource = self
		 collectionView.delegate = self
		 collectionView.translatesAutoresizingMaskIntoConstraints = false
		 
		 return collectionView
	 }
	 
	 private func addConstraints(){
		 guard let collectionView = collectionView else { return  }
		 let view = view.safeAreaLayoutGuide
		 NSLayoutConstraint.activate([
			 collectionView.topAnchor.constraint(equalTo: view.topAnchor),
			 collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			 collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			 collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		 ])
	 }

 }

 extension CharDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	 func numberOfSections(in collectionView: UICollectionView) -> Int {
		 return viewModel.detailViewSection.count
	 }
	 func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		 return 10
	 }
	 
	 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
		 print("cell")
		 cell.backgroundColor = indexPath.section % 2 == 0 ? .brown : .cyan
		 return cell
	 }
	 
	 
 }

 */
