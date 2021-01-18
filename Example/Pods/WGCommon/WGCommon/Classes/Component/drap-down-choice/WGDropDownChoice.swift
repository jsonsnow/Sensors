//
//  WGDropDownChoice.swift
//  WeAblum
//
//  Created by chen liang on 2020/7/9.
//  Copyright © 2020 WeAblum. All rights reserved.
//

import UIKit

open class WGDropDownChoice: UIView {
    
    public typealias WGclickHandler = () -> Void
    var title: String
    var font: Float = 11
    var color: UIColor = UIColor("526286")
    public var clickHandle: WGclickHandler?
    
    public init(title: String, font: Float, color: UIColor?, handle: WGclickHandler?) {
        self.title = title
        self.font = font
        self.clickHandle = handle
        if color != nil {
            self.color = color!
        }
        super.init(frame: .zero)
        configView()
        configTitle(title)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configView() -> Void {
        self.addSubview(self.titleBtn)
        self.addSubview(self.triangle)
        self.triangle.backgroundColor = UIColor("999999")
    }
    
    public func configTitle(_ title: String) -> Void {
        let ocTitle = title as NSString
        self.titleBtn.setTitle(title, for: .normal)
        let size = ocTitle.getUISize(UIFont.systemFont(ofSize: CGFloat(self.font)))
        self.titleBtn.frame = CGRect.init(x: 0, y: 0, width:size.width , height: size.height)
        self.triangle.frame = CGRect.init(x: size.width + 5, y: 3, width: 8, height: size.height);
        self.triangle.bottomTraingleView()
    }
    
    @objc func clickBtnAction() {
        self.clickHandle?()
    }
    
    lazy var titleBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitleColor(self.color, for: .normal)
        btn.setTitle(self.title, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(self.font))
        btn.addTarget(self, action: #selector(clickBtnAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var triangle: UIView = {
        let triangle = UIView.init()
        return triangle
    }()
}
