//
//  ViewController.swift
//  ExpandableCollectionView
//
//  Created by Patrick Wiley on 26.11.20.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var facilitiesCategoryData = [[String:Any]]()
    var outdoorFacilitiesIsExpanded = false
    var indoorFacilitiesIsExpanded = false

    override func viewDidLoad() {
        super.viewDidLoad()

        getIndoorOutdoorFacilitiesData()
    }

}

extension ViewController {

    // MARK: - Helper Methods

    func getIndoorOutdoorFacilitiesData() {

        let facilitiesData = FacilitiesCategoryLibrary.fetchFacilitiesCategory()
        var indoorFacilities = [FacilitiesCategory]()
        var outdoorFacilities = [FacilitiesCategory]()

        // distinguishing between indoor and outdoor data
        for facData in facilitiesData {

            if facData.type == "Indoor Facility" {
                indoorFacilities.append(facData)
            } else {
                outdoorFacilities.append(facData)
            }
        }

        facilitiesCategoryData = [
            ["title": "Indoor Facilities", "info": indoorFacilities],
            ["title": "Outdoor Facilities", "info": outdoorFacilities]
        ]
    }

}

extension ViewController: UICollectionViewDataSource {

    // MARK: - UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return facilitiesCategoryData.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if section == 0 {

            if indoorFacilitiesIsExpanded {
                let category = facilitiesCategoryData[section]
                let infoList = category["info"] as! [FacilitiesCategory]
                return infoList.count
            } else {
                return 3
            }

        } else {

            if outdoorFacilitiesIsExpanded {
                let category = facilitiesCategoryData[section]
                let infoList = category["info"] as! [FacilitiesCategory]
                return infoList.count
            } else {
                return 3
            }

        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryBoard.facilitiesCategoryCellIdentifier, for: indexPath) as! FacilitiesCell

        let category = facilitiesCategoryData[indexPath.section]
        let infoList = category["info"] as! [FacilitiesCategory]
        cell.facilitiesCategoryData = infoList[indexPath.item]

        return cell
    }

    // for section header view
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: StoryBoard.facilitiesSectionHeaderIdentifier, for: indexPath) as! FacilitiesSectionHeader

        let category = facilitiesCategoryData[indexPath.section]
        sectionHeaderView.categoryData = category
        sectionHeaderView.sectionHeaderDelegate = self

        return sectionHeaderView
    }

}

extension ViewController: FacilitiesSectionHeaderDelegate {

    func didPressButton(_ facilities: String, isExpanded: Bool) {

        if facilities == "Indoor Facilities" {
            indoorFacilitiesIsExpanded = isExpanded
        } else if facilities == "Outdoor Facilities" {
            outdoorFacilitiesIsExpanded = isExpanded
        }

        collectionView.reloadData()
    }

}
