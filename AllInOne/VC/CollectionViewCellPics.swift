//
//  CollectionViewCellPics.swift
//  AllInOne
//
//  Created by Apple on 11/13/18.
//  Copyright © 2018 mac08. All rights reserved.
//

import UIKit

class CollectionViewCellPics: UICollectionViewCell
{
    
    @IBOutlet weak var imageVIew1: UIImageView!
    @IBOutlet weak var tickImage: UIImageView!
    @IBOutlet weak var lbl_AssingImagesInfo: UILabel!
    deinit {
        imageVIew1 = nil
        tickImage = nil
    }
//    override func prepareForReuse() {
//        imageVIew1 = nil
//        tickImage = nil
//    }
    
    override func prepareForReuse()
    {
        self.imageVIew1.image = UIImage.init(named: "image.png")
        self.imageVIew1.setNeedsDisplay() // tried adding after some recommendations
        self.setNeedsDisplay()
        super.prepareForReuse()        // tried adding after some recommendations
    }
    
    
}
