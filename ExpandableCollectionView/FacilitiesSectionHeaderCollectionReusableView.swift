//
//  FacilitiesSectionHeaderCollectionReusableView.swift
//  ExpandableCollectionView
//
//  Created by Patrick Wiley on 26.11.20.
//

import UIKit

protocol FacilitiesSectionHeaderDelegate: class {
    func didPressButton(_ facilities: String, isExpanded: Bool)
}


class FacilitiesSectionHeaderCollectionReusableView: UICollectionReusableView {
   
    @IBOutlet weak var titleLabel: UILabel!

    weak var sectionHeaderDelegate: FacilitiesSectionHeaderDelegate?

    var collectionIsExpanded = false
    var facilitiesType = ""

    var categoryData: [String:Any]! {
        didSet {
            titleLabel.text = categoryData["title"] as? String
            facilitiesType = categoryData["title"] as! String
        }
    }

    @IBAction func moreButtonDidPressed(_ sender: Any) {
        collectionIsExpanded = !collectionIsExpanded
        sectionHeaderDelegate?.didPressButton(facilitiesType, isExpanded: collectionIsExpanded)
    }
}


