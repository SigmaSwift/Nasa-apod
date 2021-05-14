//
//  DetailsController.swift
//  NASA
//
//  Created by x.sargsyan on 2/12/20.
//  Copyright © 2020 SwiftAcademy. All rights reserved.
//

import UIKit

final class DetailsController: UIViewController {
    @IBOutlet private weak var detailsImageView: UIImageView!
    @IBOutlet private weak var detailsTitle: UILabel!
    var nasa: Photo?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    
    // MARK: - Private Methods -
    
    private func setup() {
        self.detailsTitle.text = self.nasa?.camera.fullName
        self.nasa?.imgSrc.loadImage({ (image) in
            self.detailsImageView.image = image
        })
    }
}
