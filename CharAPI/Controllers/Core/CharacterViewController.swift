//
//  CharacterViewController.swift
//  CharAPI
//
//  Created by may on 5/8/23.
//

import UIKit

class CharacterViewController: UIViewController {

	private let viewModel = CharacterViewViewModel()
	
	@IBOutlet var loadingIndicator: UIActivityIndicatorView!
	@IBOutlet var VCCollectionView: UICollectionView!
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemBackground
		title = "Characters"
		navigationController?.navigationBar.prefersLargeTitles = true
		
		setUpCollectionView()
		viewModel.fetchCharacterList()
		
    }
	
	private func setUpCollectionView(){
		VCCollectionView.dataSource = viewModel
		VCCollectionView.delegate = viewModel
		
		DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: { [weak self] in
			
			self?.loadingIndicator.stopAnimating()
			self?.VCCollectionView.isHidden = false
			
			UIView.animate(withDuration: 0.5) {
				self?.VCCollectionView.alpha = 1
			}
		})
	}
    

  

}

