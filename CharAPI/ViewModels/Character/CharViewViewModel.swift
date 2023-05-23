//
//  CharacterViewViewModel.swift
//  CharAPI
//
//  Created by may on 5/11/23.
//

import Foundation
import UIKit

protocol CharViewViewModelDelegate: AnyObject {
	func didLoadInitialCharacters()
	func didLoadMoreCharacters(for newElementsIndexPaths: [IndexPath])
	func didTapCollectionViewCell(selected character: Character)
	func didPullFooterForMoreData()
	func didFinishFooterLoad()
}

// to make the protocols optional
extension CharViewViewModelDelegate {
	// Collection View
	func didLoadInitialCharacters() {}
	func didLoadMoreCharacters(for newElementsIndexPaths: [IndexPath])  {}
	func didTapCollectionViewCell(selected character: Character) {}
	
	// footer
	func didPullFooterForMoreData() {}
	func didFinishFooterLoad() {}
}

class CharViewViewModel: NSObject {
	
	weak var delegate: CharViewViewModelDelegate?
	
	private var charactersList: [Character] = [] {
		didSet {
			// create a view model for each character
			// when a viewmodel is already created for that character name, it will not duplicate it
			for person in charactersList where !cellViewModel.contains(where: {$0.name == person.name} ){
				let viewModel = CharCollectionCellViewViewModel(
					name: person.name,
					alias_names: person.alias_names,
					species: person.species,
					blood_status: person.blood_status,
					imageURLString: person.image
				)
				
				cellViewModel.append(viewModel)
			}
			
		}
	}
	
	/// For cacheing collection view cell data
	private var cellViewModel: [CharCollectionCellViewViewModel] = []
	
	/// Current API Page Pagination Links
	private var APIPagination: LinksPagination? = nil
	
	/// Boolean val if there are more data page from the API Response
	public var shouldLoadMorePage: Bool {
		APIPagination?.next != nil
	}
	private var isCurrentlyLoading = false
	
	/// Initial fetch
	func fetchCharacterList() {
		Service.shared.fetchData(.listCharactersRequest, expecting: GetAllCharactersResponse.self) { [weak self] result in
			switch result {
				case .success(let ApiResponseModel):
					print(String(describing: ApiResponseModel).count)
					self?.charactersList = ApiResponseModel.data.map{ $0.attributes }
					self?.APIPagination = ApiResponseModel.links

					DispatchQueue.main.async {
						self?.delegate?.didLoadInitialCharacters()
					}
					
				case .failure(let error):
					print(error, "fetchCharacterList" )
			}
		}
	}
	
	/// Paginate fetch if theres more pages
	func fetchMoreCharacters(urlString: String){
		let request = Request(urlString: urlString)
		guard let request = request else { return }
		isCurrentlyLoading = true
		
		Service.shared.fetchData(request, expecting: GetAllCharactersResponse.self) {
			 [weak self] result in
			
			switch result {
				case .success(let ApiResponseModel):
					
					var adtnlCharacters = ApiResponseModel.data.compactMap { $0.attributes }
					
					// remove duplicates in charactersList and adtnlCharacters
					adtnlCharacters = adtnlCharacters.filter { character in
						guard let strongSelf = self else { return false }
						
						let isNew = !(strongSelf.charactersList.contains { $0.name == character.name })
						let isNotDuplicate = adtnlCharacters.filter { $0.name == character.name }.count == 1
						
						return isNew && isNotDuplicate
					}
	
					
					self?.charactersList.append(contentsOf: adtnlCharacters)
					self?.APIPagination = ApiResponseModel.links

					// update UI
					self?.delegate?.didFinishFooterLoad()
					
					// update Collection View in Controller
					let startIndex = (self?.charactersList.count ?? 0) - adtnlCharacters.count - 1
					let endIndex = (self?.charactersList.count ?? 0) - 1
					let indexForAdded: [IndexPath] = Array(startIndex..<endIndex).map { IndexPath(row: $0, section: 0)}
					
					self?.delegate?.didLoadMoreCharacters(for: indexForAdded)
					
					
					
					// stop the loading boolean
					self?.isCurrentlyLoading = false
					
					
					
				case .failure(let failure):
					print(failure)
			}
			
		}
		
		
	}
	
	
}

extension CharViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return cellViewModel.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharCollectionViewCell.reusableIdentifier, for: indexPath) as? CharCollectionViewCell else {
			return UICollectionViewCell()
		}
		
		let viewModel = cellViewModel[indexPath.row]
		cell.configureCell(viewModel: viewModel)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 180, height: 250)
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
		let character = charactersList[indexPath.row]
		delegate?.didTapCollectionViewCell(selected: character)
	}
	
	// MARK: - Collection View Footer
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		guard kind == UICollectionView.elementKindSectionFooter
		else {
			fatalError("Unsupported at viewForSupplementaryElementOfKind")
		}
		
		
		guard let footer = collectionView.dequeueReusableSupplementaryView(
			ofKind: kind,
			withReuseIdentifier: FooterLoadCollectionReusableView.identifier,
			for: indexPath
		) as? FooterLoadCollectionReusableView else {
			fatalError("Unsupported at viewForSupplementaryElementOfKind")
		}
		
		
		return footer
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
		guard shouldLoadMorePage else {
			return .zero
		}
		return CGSize(width: collectionView.frame.width, height: 100.0)
	}
	
	
}


// MARK: - ScrollView of CollectionView
extension CharViewViewModel: UIScrollViewDelegate {
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		guard shouldLoadMorePage,
			  !isCurrentlyLoading,
			  !cellViewModel.isEmpty,
			  let nextURLString = APIPagination?.next
		else { return }

		let offset = scrollView.contentOffset.y
		let contentHeight = scrollView.contentSize.height
		let scrollviewHeight = scrollView.frame.size.height

		// if reached the bottom / reached footer
		// delay by little so to avoid fetching even when still on top
		if offset >= contentHeight - scrollviewHeight + 10 {
			print("will fetch more characters")
			delegate?.didPullFooterForMoreData()
			fetchMoreCharacters(urlString: nextURLString)
		}
	}
	

	

}
