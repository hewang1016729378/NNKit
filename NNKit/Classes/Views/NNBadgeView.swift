//
//  NNBadgeView.swift
//  NNIM
//
//  Created by ly on 2023/8/2.
//  Copyright © 2023 NN. All rights reserved.
//

import Foundation
import RxSwift

/*
 设置约束，限制高。
 badgeView.snp.makeConstraints { make in
     make.top.equalToSuperview().offset(12.0)
     make.right.equalToSuperview().offset(-12.0)
     make.height.equalTo(16)
     make.width.greaterThanOrEqualTo(16)
 }
 */

public class NNBadgeView: UIView {
    var disposeBag = DisposeBag()
    /*
     * 传入消息数，大于99显示99+
     */
    public var badgeNum = 0 {
        didSet {
            updateUI()
        }
    }
    /*
     * 设置自定义字符串显示，比如...
     */
    public var badgeValue = "" {
        didSet {
            label.text = badgeValue
        }
    }
    // 汽泡背景色
    public var badgeBgColor = "FD6670".color() {
        didSet {
            backgroundColor = badgeBgColor
        }
    }
    public lazy var label: UILabel = {
        let tmp = UILabel()
        tmp.textColor = .white
        tmp.font = .pingFangSCRegular(12.0)
        tmp.textAlignment = .center
        return tmp
    }()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    func setupViews() {
        layer.masksToBounds = true
        addSubview(label)
        backgroundColor = badgeBgColor
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
            make.left.equalTo(self).offset(3.0)
            make.right.equalTo(self).offset(-3.0)
        }
    }
    private func updateUI() {
        if badgeNum > 99 {
            label.text = "99+"
        } else {
            label.text = "\(badgeNum)"
        }
    }
    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = height/2.0
    }
}
