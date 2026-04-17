//
//  NNAgreementView.swift
//  BiLinApp
//
//  Created by ly on 2024/2/5.
//

import Foundation
import YYText

public class NNAgreementView: UIView {
    /// 高亮文字点击事件
    /// index返回左到右对应的坐标
    public var highlightTapEvent: ((_ index: Int) -> Void)?

    /// 默认灰色，字体文本颜色
    public var textColor: UIColor = "#8A8B8B".color() {
        didSet {
            protocolLabel.textColor = textColor
            // 设置新颜色，高亮颜色需要重新赋值
            updateHighLightText()
        }
    }
    /// 默认绿色，协议高亮文本颜色
    public var highLightColor: UIColor = "#03CB8E".color() {
        didSet {
            
        }
    }
    /// 需要高亮的文本
    public var highLightTexts = ["《服务协议》", "《隐私协议》"] {
        didSet {
            updateHighLightText()
        }
    }
    
    public var textFont = UIFont.pingfang(12.0) {
        didSet {
            protocolLabel.font = textFont
        }
    }
    
    lazy var checkboxBtn: UIButton = {
        let tmp = UIButton.init()
        tmp.setImage(UIImage.init(named: "agreenment_btn_unselect"), for: .normal)
        tmp.setImage(UIImage.init(named: "agreenment_btn_select"), for: .selected)
        tmp.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
        tmp.expandEventSize(CGSizeMake(35.0, 35.0))
        return tmp
    }()
    
    /// 协议文本
    private let protocolLabel: YYLabel = {
        let titl = YYLabel()
        titl.text = "开通前请确认《服务协议》与《隐私协议》".localized
        titl.numberOfLines = 2
        titl.textAlignment = .left
        let paraph = NSMutableParagraphStyle()
        // 将行间距设置为6
        paraph.lineSpacing = 6
        // 样式属性集合
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                          NSAttributedString.Key.paragraphStyle: paraph]
        titl.attributedText = NSAttributedString(string: titl.text!, attributes: attributes)
        titl.textAlignment = .center
        return titl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        stepUI()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func stepUI() {
        addSubviews([checkboxBtn, protocolLabel])
        checkboxBtn.snp.makeConstraints { make in
            make.left.equalTo(self).offset(0.0)
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize.init(width: 13.0, height: 13.0))
        }
        protocolLabel.snp.makeConstraints { make in
            make.left.equalTo(checkboxBtn.snp.right).offset(6.0)
            make.right.equalTo(self).offset(0.0)
            make.centerY.equalTo(checkboxBtn)
        }
    }
    
    func setup() {
        protocolLabel.textColor = textColor
        updateHighLightText()
    }
    
    /// 更新需要高亮的文本
    fileprivate func updateHighLightText() {
        let attrString = NSMutableAttributedString(string: protocolLabel.text ?? "")
        // 设置默认颜色
        let allRange: NSRange = (attrString.string as NSString).range(of: protocolLabel.text ?? "")
        attrString.addAttributes([NSAttributedString.Key.foregroundColor: textColor,
                                  NSAttributedString.Key.font: textFont
                                 ], range: allRange)
        // 设置高亮颜色和点击事件
        for index in 0..<highLightTexts.count {
            let highLightStr = highLightTexts[index]
            let range: NSRange = (attrString.string as NSString).range(of: highLightStr)
            attrString.addAttributes([NSAttributedString.Key.foregroundColor: highLightColor,
                                      NSAttributedString.Key.font: textFont
                                     ], range: range)
            // 添加点击事件
            attrString.yy_setTextHighlight(range, color:highLightColor, backgroundColor: .clear) { [weak self](containView, text, range, rect) in
                self?.highlightTapEvent?(index)
            }
        }
        protocolLabel.attributedText = attrString
    }
    
    @objc func click(_ btn: UIButton) {
        checkboxBtn.isSelected = !checkboxBtn.isSelected
    }
    
    /// 获取协议同意状态
    /// - Returns: true同意
    public func getAgreeStatus() -> Bool {
        return checkboxBtn.isSelected
    }
    
    /// 开启晃动动画效果
    public func startSharkAnimation() {
        AnimationTools.textSharkSpringAnimation(layer: checkboxBtn.layer)
        AnimationTools.textSharkSpringAnimation(layer: protocolLabel.layer)
    }
}
