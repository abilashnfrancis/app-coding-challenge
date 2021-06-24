//
//  GradientView.swift
//  FlickrCodingChallenge
//
//  Created by Abilash Francis on 24/6/21.
//

import UIKit

class GradientView: UIView {
    override open class var layerClass: AnyClass {
       return CAGradientLayer.classForCoder()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = [UIColor(white: 0, alpha: 0).cgColor , UIColor(white: 0, alpha: 0.45).cgColor]
    }
}
