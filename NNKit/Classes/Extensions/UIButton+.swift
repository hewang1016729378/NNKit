//
//  UIButton+.swift
//  DeviceKit
//
//  Created by EyreFree on 2020/5/28.
//

#if os(iOS)
import UIKit

public class LayoutButton: UIButton {
    public enum Position {
        case top
        case bottom
        case left
        case right
    }

    private var position: Position?
    private var space: CGFloat = 0

    // 取消高亮
    public override var isHighlighted: Bool {
        set { }
        get { return false }
    }

    public convenience init(_ position: Position, at space: CGFloat = 0) {
        self.init(type: .custom)
        self.position = position
        self.space = space
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        if let position = position {
            switch position {
            case .top:
                let titleHeight = titleLabel?.bounds.height ?? 0
                let imageHeight = imageView?.bounds.height ?? 0
                let imageWidth = imageView?.bounds.width ?? 0
                let titleWidth = titleLabel?.bounds.width ?? 0
                titleEdgeInsets = UIEdgeInsets(top: (titleHeight + space) * 0.5,
                                               left: -imageWidth * 0.5,
                                               bottom: -space,
                                               right: imageWidth * 0.5)
                imageEdgeInsets = UIEdgeInsets(top: 0,
                                               left: titleWidth * 0.5,
                                               bottom: imageHeight + space,
                                               right: -titleWidth * 0.5)
            case .bottom:
                let titleHeight = titleLabel?.bounds.height ?? 0
                let imageHeight = imageView?.bounds.height ?? 0
                let imageWidth = imageView?.bounds.width ?? 0
                let titleWidth = titleLabel?.bounds.width ?? 0
                titleEdgeInsets = UIEdgeInsets(top: -(titleHeight + space) * 0.5,
                                               left: -imageWidth * 0.5,
                                               bottom: space,
                                               right: imageWidth * 0.5)
                imageEdgeInsets = UIEdgeInsets(top: imageHeight + space,
                                               left: titleWidth * 0.5,
                                               bottom: 0,
                                               right: -titleWidth * 0.5)

            case .left:
                titleEdgeInsets = UIEdgeInsets(top: 0, left: space, bottom: 0, right: 0)
                imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: space)
            case .right:
                let imageWidth = (imageView?.bounds.width ?? 0) + space
                let titleWidth = (titleLabel?.bounds.width ?? 0) + space
                titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: 0, right: imageWidth)
                imageEdgeInsets = UIEdgeInsets(top: 0, left: titleWidth, bottom: 0, right: -titleWidth)
            }
        }
    }
}


public extension UIButton {
    func setTitle(_ title: String?) {
        setTitle(title, for: UIControl.State.normal)
    }
    
    func setTitleColor(_ color: UIColor?) {
        setTitleColor(color, for: UIControl.State.normal)
    }
    
    func setTitleShadowColor(_ color: UIColor?) {
        setTitleShadowColor(color, for: UIControl.State.normal)
    }
    
    func setImage(_ image: UIImage?) {
        setImage(image, for: UIControl.State.normal)
    }
    
    func setSelectedImage(_ image: UIImage?) {
        setImage(image, for: UIControl.State.selected)
    }
    
    func setHighlightedImage(_ image: UIImage?) {
        setImage(image, for: UIControl.State.highlighted)
    }
    
    func setBackgroundImage(_ image: UIImage?) {
        setBackgroundImage(image, for: UIControl.State.normal)
    }
    
    @available(iOS 13.0, *)
    func setPreferredSymbolConfiguration(_ configuration: UIImage.SymbolConfiguration?) {
        setPreferredSymbolConfiguration(configuration, forImageIn: UIControl.State.normal)
    }
    
    @available(iOS 6.0, *)
    func setAttributedTitle(_ title: NSAttributedString?) {
        setAttributedTitle(title, for: UIControl.State.normal)
    }
    
    var title: String? {
        return title(for: UIControl.State.normal)
    }
    
    var titleColor: UIColor? {
        return titleColor(for: UIControl.State.normal)
    }
    
    var titleShadowColor: UIColor? {
        return titleShadowColor(for: UIControl.State.normal)
    }
    
    var image: UIImage? {
        return image(for: UIControl.State.normal)
    }
    
    var backgroundImage: UIImage? {
        return backgroundImage(for: UIControl.State.normal)
    }
    
    @available(iOS 13.0, *)
    var preferredSymbolConfigurationForImage: UIImage.SymbolConfiguration? {
        return preferredSymbolConfigurationForImage(in: UIControl.State.normal)
    }
    
    @available(iOS 6.0, *)
    var attributedTitle: NSAttributedString? {
        return attributedTitle(for: UIControl.State.normal)
    }
}


public extension UIButton {
    /// 逆时针方向🔄
    enum Position { case top, left, bottom, right }
    
    /// 重置图片image与标题title位置(默认间距为0)
    func adjustImageTitlePosition(_ position: Position, spacing: CGFloat = 0 ) {
        self.sizeToFit()
        
        let imageWidth = self.imageView?.image?.size.width
        let imageHeight = self.imageView?.image?.size.height
        
        let labelWidth = self.titleLabel?.frame.size.width
        let labelHeight = self.titleLabel?.frame.size.height
        
        switch position {
        case .top:
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight! - spacing / 2, left: 0, bottom: 0, right: -labelWidth!)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!, bottom: -imageHeight! - spacing / 2, right: 0)
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing / 2, bottom: 0, right: 0)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing * 1.5, bottom: 0, right: 0)
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight! - spacing / 2, right: -labelWidth!)
            titleEdgeInsets = UIEdgeInsets(top: -imageHeight! - spacing / 2, left: -imageWidth!, bottom: 0, right: 0)
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth! + spacing / 2, bottom: 0, right: -labelWidth! - spacing / 2)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth! - spacing / 2, bottom: 0, right: imageWidth! + spacing / 2)
        }
    }
}

#endif
