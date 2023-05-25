//
//  CharDetailViewViewModel.swift
//  CharAPI
//
//  Created by may on 5/15/23.
//

import Foundation
import UIKit

class CharDetailViewViewModel: NSObject {
	
	let star: Character
	
	var title: String {
		star.name.capitalized
	}
	
	/// Collection View Sections
	enum DetailViewSection {
		case photo(viewModel: CharDetailViewPhotoCVCellViewModel)
		case basic_info(viewModel: [CharDetailViewBasicInfoCVCellViewModel])
		case addtnl_info(viewModel: CharDetailViewAdtnlInfoCVCellViewModel)
		case list_info(viewModels: [CharDetailViewListInfoCVCellViewModel])
		case relationships(viewModels: [CharDetailViewRelationsCVCellViewModel])
	}
	private var detailViewSection: [DetailViewSection] = []
	

	
	// MARK: - Init
	init(star: Character) {
		self.star = star
		super.init()
		self.setupDetailViewSections()
	}
	
	// MARK: - Functions
	private func setupDetailViewSections() {
		// .photo + details
		configureData_PhotoSection()
		// .basic_info badges
		configureData_BasicInfoSection()
		// adtnl info -- 1 box
		configureData_AddtnlInfoSection()
		// list info badges
		configureData_ListInfoSection()
		// relationships
		configureData_RelationsSection()
	}
	
	private func configureData_PhotoSection(){
		let model: CharDetailViewPhotoCVCellViewModel = .init(
			image: star.image,
			name: star.name,
			alias_names: star.alias_names,
			titles: star.titles,
			born: star.born,
			died: star.died
		)
		
		detailViewSection = [
			.photo(viewModel: model)
		]
	}
	private func configureData_BasicInfoSection(){
		let basicInfoModels: [CharDetailViewBasicInfoCVCellViewModel] = [
			(title: "Birth", value: star.born,
			 imageString: "figure.and.child.holdinghands"),
			(title: "Death", value: star.died,
			 imageString: "cross.case.fill"),
			(title: "Species", value: star.species,
			 imageString: "pawprint.circle"),
			(title: "Status", value: star.blood_status,
			 imageString: "staroflife.circle"),
			(title: "House", value: star.house,
			 imageString: "house.fill"),
			(title: "Animagus", value: star.animagus,
			imageString: "pawprint"),
			(title: "Patronus", value: star.patronus,
			 imageString: "water.waves"),
			(title: "Boggart", value: star.boggart,
			 imageString: "waveform.path.ecg"),
			(title: "Marital Status", value: star.marital_status,
			 imageString: "person.line.dotted.person.fill"),
			(title: "Nationality", value: star.nationality,
			 imageString: "flag.and.flag.filled.crossed")
			
		].compactMap { attr in
			
			guard let value = attr.value else {
				return nil //skip if no value
			}
			return .init(
				title: attr.title,
				value: value,
				imageString: attr.imageString
			)
		}
			
		if !basicInfoModels.isEmpty {
			detailViewSection.append(.basic_info(viewModel: basicInfoModels))
		}
		
		
	}
	
	private func configureData_AddtnlInfoSection(){
		let model: CharDetailViewAdtnlInfoCVCellViewModel = .init(
			gender: star.gender,
			height: star.height,
			weight: star.weight,
			hair_color: star.hair_color,
			eye_color: star.eye_color,
			skin_color: star.skin_color,
			wiki: star.wiki
		)
		
		detailViewSection.append(.addtnl_info(viewModel: model))
	}
	
	private func configureData_ListInfoSection(){
		let models: [CharDetailViewListInfoCVCellViewModel] = [
			(title: "Jobs", array: star.jobs),
			(title: "Wands", array: star.wands)
		].compactMap { attr in
			guard let value = attr.array else {
				return nil //skip if no value
			}
			return .init(title: attr.title, array: value)
		}
		
		if !models.isEmpty {
			detailViewSection.append(.list_info(viewModels: models))
		}
		
	}
	
	private func configureData_RelationsSection(){
		let relations = (star.family_members ?? []) + (star.romances ?? [])
		var models: [CharDetailViewRelationsCVCellViewModel] = []
		
		if !relations.isEmpty {
			for person in relations {
				models.append(.init(person: person))
			}
			detailViewSection.append(.relationships(viewModels: models))
		}
	}
	
	
	
	
	// MARK: - Creating Collection View Layout
	func createCVLayout() -> UICollectionViewCompositionalLayout {
		let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
			return self.createCVSection(for: sectionIndex)
		}
		
		return layout
	}
	
	private func createCVSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
		switch detailViewSection[sectionIndex]{
			case .photo:
				return createCVSection_Photo()
			case .basic_info:
				return createCVSection_BasicInfo()
			case .addtnl_info:
				return createCVSection_AddtnlInfo()
			case .list_info:
				return createCVSection_ListInfo()
			case .relationships:
				return createCVSection_Relations()
		}
	}
	
	private func createCVSection_Photo() -> NSCollectionLayoutSection {
		
		// item
		let item_Photo = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .fractionalHeight(1)
		))
		
		item_Photo.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2, bottom: 10, trailing: 2)
		
		// group
		let group = NSCollectionLayoutGroup.vertical(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1),
				heightDimension: .fractionalHeight(0.5)
			),
			subitems: [item_Photo]
		)
		
		// section
		let section = NSCollectionLayoutSection(group: group)
		
		return section
	}
	private func createCVSection_BasicInfo() -> NSCollectionLayoutSection {
		// horizontal section
		// 2 columns
		
		// item
		// 1 item will have half the width of the Group
		// the height is proportion to the Group's row height
		let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(0.5),
			heightDimension: .fractionalHeight(1)
		))
		
		// padding
		item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2, bottom: 10, trailing: 2)
		
		// group
		// the group is like the canvas
		// the canvas/group will be horizontal, will take the width of the collectionView
		// each row will have an absolute size
		// subitems is the items in 1 row
		let group = NSCollectionLayoutGroup.horizontal(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1),
				heightDimension: .absolute(150)
			),
			subitems: [item, item]
		)
		
		// section
		let section = NSCollectionLayoutSection(group: group)
		
		return section
	}
	private func createCVSection_AddtnlInfo() -> NSCollectionLayoutSection {
		
		// item
		let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .fractionalHeight(1)
		))
		
		item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0)
		
		
		// group
		let group = NSCollectionLayoutGroup.vertical(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1),
				heightDimension: .fractionalHeight(0.4)
			),
			subitems: [item]
		)
		
		// section
		let section = NSCollectionLayoutSection(group: group)
		
		return section
	}
	private func createCVSection_ListInfo() -> NSCollectionLayoutSection {
		let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(0.5),
			heightDimension: .fractionalHeight(1)
		))
		
		// padding
		item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2, bottom: 10, trailing: 2)
		
		let group = NSCollectionLayoutGroup.horizontal(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1),
				heightDimension: .absolute(250)
			),
			subitems: [item, item]
		)
		
		// section
		let section = NSCollectionLayoutSection(group: group)
		
		return section
	}
	private func createCVSection_Relations() -> NSCollectionLayoutSection {
		// item
		let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .fractionalHeight(1)
		))
		
		item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 2, bottom: 10, trailing: 10)
		
		// group
		let group = NSCollectionLayoutGroup.horizontal(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(0.8),
				heightDimension: .absolute(200)
			),
			subitems: [item]
		)
		
 
		// section
		let section = NSCollectionLayoutSection(group: group)
		
		// make the section scrollable
		section.orthogonalScrollingBehavior = .groupPaging
		
		return section
	}
}


extension CharDetailViewViewModel: UICollectionViewDelegate, UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return detailViewSection.count
	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		let sectionType = detailViewSection[section]
		switch sectionType {
			case .photo:
				return 1
			case .basic_info(let cells):
				return cells.count
			case .relationships(let cells):
				return cells.count
			case .addtnl_info:
				return 1
			case .list_info(let cells):
				return cells.count
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let sectionType = detailViewSection[indexPath.section]
		switch sectionType {
			case .photo(let viewModel):
				guard let cell = collectionView.dequeueReusableCell(
					withReuseIdentifier: CharDetailViewPhotoCollectionViewCell.identifier,
					for: indexPath) as? CharDetailViewPhotoCollectionViewCell
				else { fatalError() }
				
				cell.configureCell(viewModel: viewModel)
				return cell
				
			case .basic_info(let viewModels):
				guard let cell = collectionView.dequeueReusableCell(
					withReuseIdentifier: CharDetailViewBasicInfoCollectionViewCell.identifier,
					for: indexPath) as? CharDetailViewBasicInfoCollectionViewCell
				else { fatalError() }
				
				cell.configureCell(viewModel: viewModels[indexPath.row])
				return cell
				
			case .relationships(let viewModels):
				guard let cell = collectionView.dequeueReusableCell(
					withReuseIdentifier: CharDetailViewRelationsCollectionViewCell.identifier,
					for: indexPath) as? CharDetailViewRelationsCollectionViewCell
				else { fatalError() }
				cell.backgroundColor = .yellow
				return cell
				
			case .addtnl_info(let viewModel):
				guard let cell = collectionView.dequeueReusableCell(
					withReuseIdentifier: CharDetailAdtnlInfoCollectionViewCell.identifier,
					for: indexPath) as? CharDetailAdtnlInfoCollectionViewCell
				else { fatalError() }
				cell.backgroundColor = .blue
				return cell
			case .list_info(let viewModels):
				guard let cell = collectionView.dequeueReusableCell(
					withReuseIdentifier: CharDetailListInfoCollectionViewCell.identifier,
					for: indexPath) as? CharDetailListInfoCollectionViewCell
				else { fatalError() }
				cell.backgroundColor = .blue
				return cell
		}
		
		
	
	}
	
	
}


