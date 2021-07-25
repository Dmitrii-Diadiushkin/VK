//
//  CircleAvatarShadow.swift
//  VK
//
//  Created by Dmitrii Diadiushkin on 20.01.2021.
//

import UIKit

class CircleAvatarShadow: UIView {

    var avatarImage = UIImageView()
    @IBInspectable private var shadowColor: UIColor = .black{
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    @IBInspectable private var shadowOpacity: Float = 0.6 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    @IBInspectable private var shadowRadius: CGFloat = 5 {
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView(){
        
        avatarImage.frame = self.layer.bounds
        avatarImage.clipsToBounds = true
        avatarImage.layer.cornerRadius = avatarImage.frame.width / 2
        
        self.layer.cornerRadius = avatarImage.frame.width / 2
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = CGSize.zero
        self.addSubview(avatarImage)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        })
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.3, delay: 0.2, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }

}
