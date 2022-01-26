//
//  UVAlertView.swift
//  Christie-uv-light
//
//  Created by 刘燃 on 2021/4/25.
//

import UIKit

class UVAlertView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var alertContentView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var quitButton: UIButton!
    
    var leftClick: (() ->Void)?
    
    var rightClick: (() ->Void)?
    
    class func UVAlertView(_ title:String = "", subTitle: String = "",rightBtnTitle: String = "Quit") ->UVAlertView {
        let view = Bundle.main.loadNibNamed("UVAlertView", owner: nil, options: nil)?.last as! UVAlertView
        view.titleLabel.text = title
        view.subTitleLabel.text = subTitle
        view.frame = UIScreen.main.bounds
        view.sizeToFit()
        view.quitButton.setTitle(rightBtnTitle, for: .normal)
        return view
    }
    
    func show() {
        CURRENT_TOP_VC().view.addSubview(self)
        let basic = POPBasicAnimation.init(propertyNamed: kPOPViewBackgroundColor)
        basic?.fromValue = UIColor.black.withAlphaComponent(0.0)
        basic?.toValue = UIColor.black.withAlphaComponent(0.4)
        basic?.duration = 0.25
        self.pop_add(basic, forKey: "view.backgroundColor")
        
        let pop = POPSpringAnimation.init(propertyNamed: kPOPViewScaleXY)
        pop?.fromValue = CGSize(width: 0.3, height: 0.3)
        pop?.toValue = CGSize(width: 1, height: 1)
        pop?.springSpeed = 20
        pop?.springBounciness = 12
        alertContentView.pop_add(pop, forKey: "scale")
    }
    
    private func dissmiss() {
        removeFromSuperview()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        alertContentView.layer.cornerRadius = 10
        cancelButton.layer.cornerRadius = 5
        quitButton.layer.cornerRadius = 5
        alertContentView.clipsToBounds = true
        cancelButton.clipsToBounds = true
        quitButton.clipsToBounds = true
    }
    
    @IBAction func clickQuit(_ sender: Any) {
        dissmiss()
        rightClick?()
    }
    
    @IBAction func clickCancel(_ sender: Any) {
        dissmiss()
        leftClick?()
    }
}
