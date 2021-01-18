//
//  WGBasePopView.swift
//  WeAblum
//
//  Created by chen liang on 2020/7/10.
//  Copyright © 2020 WeAblum. All rights reserved.
//

import UIKit

let SINGLE_LINE_WIDTH = (1 / UIScreen.main.scale)
let SINGLE_LINE_ADJUST_OFFSET = (1 / UIScreen.main.scale / 2)
func one_pixel_line_value(with width: CGFloat = 1) -> CGFloat {
    if width/2 == 0 {
        return width
    }
    return width - SINGLE_LINE_ADJUST_OFFSET
}


@objc open class WGBasePopView: UIView {
    
    public var isTranslucent: Bool = true
    
    deinit {
        print("pop view dealloc")
    }
  
    @objc open func show(to view: UIView?) -> Void {
        var container = view
        if view == nil {
            let sharedSelector = NSSelectorFromString("sharedApplication")
            if UIApplication.responds(to: sharedSelector) {
                let shared = UIApplication.perform(sharedSelector)
                let res = shared?.takeUnretainedValue() as! UIApplication
                container = res.keyWindow
            }
        }
        self.frame = container!.bounds
        container?.addSubview(self)
        if isTranslucent {
            self.addSubview(translucentView)
        }
        self.addSubview(self.containerView)
    }

    
    @objc open func close() -> Void {
        self.removeFromSuperview()
    }

    func adjustContainerFrame() -> Void {
        if #available(iOS 11.0, *) {
            self.containerView.frame = self.containerView.frame.offsetBy(dx: 0, dy: -self.safeAreaInsets.bottom)
        } else {
            // Fallback on earlier versions
        }
    }
    
    @objc public lazy var translucentView: UIView = {
        let mask = UIView.init()
        mask.frame = self.bounds
        mask.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(close))
        mask.addGestureRecognizer(tap)
        return mask
    }()
    
    @objc public lazy var containerView: UIView = {
        let containerView = UIView.init()
        containerView.backgroundColor = UIColor.white
        return containerView
    }()
    
}

public class WGSheetPopView: WGBasePopView {
    public typealias WGSheetTitleArriteConfig = (_: String, _: Int) -> NSAttributedString?
    
    //MARK: props
    var titls: [String]!
    let itemSpace: Float = 0.5
    let itemHeight: Float = 50
    var titleConfig: WGSheetTitleArriteConfig?
    var clickHandle: ((_: Int) -> Void)?
    
   
    //MARK: init
    @objc public init(titles: [String], titleArributeConfig: WGSheetTitleArriteConfig?, clickHandle: @escaping (_ : Int) -> Void) {
        self.titls = titles
        self.titleConfig = titleArributeConfig
        self.clickHandle = clickHandle
        super.init(frame: .zero)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func show(to view: UIView?) {
        super.show(to: view)
        self.containerView.frame = frameByTitle(titls)
        self.adjustContainerFrame()
        configContents()
    }
    
    @objc func clickBtnAction(by send: UIButton) -> Void {
        let index = send.tag
        self.clickHandle?(index)
        self.close()
    }
    
    func configContents() -> Void {
        var preBtn: UIButton?
        for (index, value) in titls.enumerated() {
           let btn = UIButton.init(type: .custom)
            var y: Float = 0
            if preBtn != nil {
                y = Float(preBtn!.frame.maxY) + itemSpace
            }
            if index > 0 {
                let grayView = UIView.init()
                grayView.backgroundColor = UIColor("999999")
                grayView.frame = CGRect.init(x: 0, y: (preBtn?.frame.maxY ?? 0), width: (self.containerView.bounds.width), height: CGFloat(itemSpace))
                self.containerView.addSubview(grayView)
            }
            btn.frame = CGRect.init(x: 0, y: CGFloat(y), width: (self.containerView.bounds.width), height: CGFloat(itemHeight))
            let label = UILabel.init(frame: btn.frame)
            btn.backgroundColor = UIColor.white
            let arributeTitle = self.titleConfig?(value, index)
            if arributeTitle != nil {
                label.attributedText = arributeTitle
            } else {
                label.text = value
            }
            btn.tag = index
            btn.addTarget(self, action: #selector(clickBtnAction(by:)), for: .touchUpInside)
            label.numberOfLines = 0
            label.textAlignment = .center
            preBtn = btn
            self.containerView.addSubview(btn)
            self.containerView.addSubview(label)
        }
    }
    
    func frameByTitle(_ titles: [String]) -> CGRect {
        let height = Float(titles.count) * itemHeight + itemSpace * Float(titles.count - 1)
        return CGRect.init(x: 0, y: (self.superview!.bounds.height - CGFloat(height)), width: (self.superview!.bounds.width), height: CGFloat(height))
    }
}

public class WGAlertActionBtn: UIView {
    
    var actionTitle: String?
    var actionFont: Float = 17
//    init(hexString: "#2E2E2F")
    var actionColor: UIColor = UIColor("#2E2E2F")
    var hideRightLine = false
    var nextAction: WGAlertActionBtn?
    var action: (()-> Void)?
    
    @objc public init(title: String, font: Float = 17 ,color: UIColor? = UIColor("#2E2E2F"),hideRightLine: Bool = false, action: (()-> Void)?) {
        self.actionTitle = title
        self.actionFont = font
        if color != nil {
            self.actionColor = color!
        }
        self.action = action
        self.hideRightLine = hideRightLine
        super.init(frame: .zero)
        configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layoutView()
    }
    
    func configView() -> Void {
        addSubview(btn)
        addSubview(topLine)
        addSubview(rightLine)
        rightLine.isHidden = hideRightLine
        btn.setTitle(actionTitle, for: .normal)
        btn.setTitleColor(actionColor, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(actionFont), weight: .medium)
    }
    
    func layoutView() -> Void {
        btn.frame = self.bounds
        topLine.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: one_pixel_line_value())
        rightLine.frame = CGRect.init(x: self.bounds.width - 1, y: 0, width: one_pixel_line_value(), height: self.bounds.height)
    }
    
    @objc func clickBtnAction() {
        self.action?()
    }
    
    lazy var topLine: UIView = {
        let line = UIView.init()
        line.backgroundColor = UIColor("#EEEEEE")
        line.isHidden = false
        return line
    }()
    
    lazy var rightLine: UIView = {
        let line = UIView.init()
        line.backgroundColor = UIColor("#EEEEEE")
        line.isHidden = true
        return line
    }()
    
    lazy var btn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.addTarget(self, action: #selector(clickBtnAction), for: .touchUpInside)
        return btn
    }()
    
}

public class WGAlertPopView: WGBasePopView {
    
    var titleStr: String?
    var msgStr: String?
    var curAction: WGAlertActionBtn?
    var actions: [WGAlertActionBtn] = [WGAlertActionBtn]()
    let actionHeight: CGFloat = scaleX(48)
    
    @objc public init(title: String?, msg: String?) {
        self.titleStr = title
        self.msgStr = msg
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @discardableResult
    @objc public func addActionBtn(_ btn: WGAlertActionBtn) -> Self {
        actions.append(btn)
        self.containerView.addSubview(btn)
        let handle = btn.action
        btn.action = {[weak self] in
            self?.close()
            handle?()
        }
        return self
    }
    
    override public func show(to view: UIView?) {
        self.containerView.addSubview(title)
        self.containerView.addSubview(desc)
        let width: CGFloat = 320
        let height =  width / 1.54;
        self.containerView.frame = CGRect.init(x: (kSCREEN_WIDTH - width)/2, y: (kSCREEN_HEIGHT - height)/2, width: width, height: height)
        self.containerView.layer.cornerRadius = 6
        self.closeBtn.frame = CGRect.init(x: self.containerView.bounds.width - 32 , y: 8, width: 24, height: 24)
        self.containerView.addSubview(closeBtn)
        title.frame = CGRect.init(x: 24, y: 28, width: width - scaleX(24 * 2), height: 24)
        desc.mas_updateConstraints {
            $0?.left.mas_equalTo()(24)
            $0?.right.mas_equalTo()(-24)
            $0?.top.equalTo()(self.title.mas_bottom)?.offset()(20)
        }
        layoutActions()
        self.title.text = titleStr
        self.desc.text = msgStr
        super.show(to: view)
    }
    
    
    func layoutActions() -> Void {
        let width = self.containerView.bounds.width / CGFloat(self.actions.count)
        var pre: WGAlertActionBtn?
        self.actions.forEach { (action) in
            if pre != nil {
                action.frame = pre!.frame.offsetBy(dx: width, dy: 0)
            } else {
                action.frame = CGRect.init(x: 0, y: self.containerView.bounds.height - self.actionHeight, width: width, height: self.actionHeight)
            }
            pre = action
        }
    }
    
    lazy var title: UILabel = {
        let title = UILabel.factoryLabel(fonSize: 17, color: UIColor("#2E2E2F"))
        title.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        title.textAlignment = .center
        return title
    }()
    
    lazy var desc: UILabel = {
        let desc = UILabel.factoryLabel(fonSize: 17, color: UIColor("#6F7071"))
        desc.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        desc.textAlignment = .center
        return desc
    }()
    
    lazy var closeBtn: UIButton = {
        let closeBtn = UIButton.init(type: .custom)
        closeBtn.setBackgroundImage(BundleLoad.imageNamed("icon_popup_close"), for: .normal)
        closeBtn.addTarget(self, action: #selector(close), for: .touchUpInside)
        return closeBtn
    }()
}
