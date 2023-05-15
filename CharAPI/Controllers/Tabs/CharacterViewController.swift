//
//  CharacterViewController.swift
//  CharAPI
//
//  Created by may on 5/8/23.
//

import UIKit

///  A controller with a collection view of characters
class CharacterViewController: UIViewController {

	/// where logic is placed, interaction between Model / Data
	private let viewModel = CharViewViewModel()
	/// when user taps a cell, controller saves the selected character / cell
	private var selectedCharacter: Character?
	
	/// UI in the contoller
	@IBOutlet var loadingIndicator: UIActivityIndicatorView!
	@IBOutlet var VCCollectionView: UICollectionView!
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemBackground
		title = "Characters"
		
		setUpCollectionView()
		viewModel.delegate = self
		viewModel.fetchCharacterList()
		
    }
	
	/// collectionView will be setup in the viewModel
	private func setUpCollectionView(){
		VCCollectionView.dataSource = viewModel
		VCCollectionView.delegate = viewModel
		// alpha is 0 at first and hidden before initial load
		VCCollectionView.alpha = 0
	}
	
	// brings data to other VC
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		switch segue.identifier {
			case "ShowCharDetailViewController":
				if let destinationVC = segue.destination as? CharDetailViewController,  selectedCharacter != nil {
					destinationVC.star = selectedCharacter
				}
			default:
				break
		}
	}

  

}

/// View Model's Delagate
///  when a viewmodel needs to update UI / Change VC, it needs to be done in Controller, thus we use a delegate
extension CharacterViewController: CharViewViewModelDelegate {
	func didLoadInitialCharacters() {
		//initial fetch of data
		VCCollectionView.reloadData()
		loadingIndicator.stopAnimating()
		VCCollectionView.isHidden = false
		UIView.animate(withDuration: 0.5) {
			self.VCCollectionView.alpha = 1
		}
		
	}
	
	func didTapCollectionViewCell(selected character: Character) {
		selectedCharacter = character
		performSegue(withIdentifier: "ShowCharDetailViewController", sender: self)
		
	}
}
