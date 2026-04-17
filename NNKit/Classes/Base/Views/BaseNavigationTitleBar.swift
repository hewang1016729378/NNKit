//
//  BaseNavigationTitleBar.swift
//  NNAcc
//
//  Created by ly on 2021/12/4.
//

import Foundation
import RxSwift
import UIKit
import YYText

open class BaseNavigationTitleBar: UIView {
    public lazy var contentView: UIView = {
        let tmp = UIView()
        return tmp
    }()

    public lazy var leftBtn: NNBigButton = {
        let tmp = NNBigButton()
        tmp.setImage(I$("ic_back"), for: .normal)
        tmp.expandEventSize(CGSize(width: 50.0, height: 50.0))
        return tmp
    }()

    public lazy var titleLabel: YYLabel = {
        let tmp = YYLabel()
        tmp.font = kFont16b
        tmp.textAlignment = .center
        tmp.textColor = .black
        tmp.preferredMaxLayoutWidth = 300
        return tmp
    }()

    public lazy var titleImageView: UIImageView = {
        let tmp = UIImageView()
        tmp.isHidden = true
        return tmp
    }()

    public lazy var rightBtn: NNBigButton = {
        let tmp = NNBigButton()
        tmp.expandEventSize(CGSize(width: 30.0, height: 30.0))
        tmp.titleLabel?.font = UIFont.pingfang(14.0)
        // 防止rightBtn被titleLabel挤压
        tmp.setContentHuggingPriority(.required, for: .horizontal)
        return tmp
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    func setupViews() {
        addSubview(contentView)
        contentView.addSubview(leftBtn)
        contentView.addSubview(rightBtn)
        contentView.addSubview(titleLabel)
        contentView.addSubview(titleImageView)

        contentView.snp.makeConstraints { make in
            make.left.bottom.right.equalTo(self)
            make.top.equalTo(UIConstant.statusBarHeight())
        }

        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView)
            make.left.greaterThanOrEqualTo(leftBtn.snp.right).offset(10)
            make.right.lessThanOrEqualTo(rightBtn.snp.left).offset(-10)
            make.centerX.equalTo(self.contentView).priority(.low)
        }
        
        leftBtn.snp.makeConstraints { make in
            make.left.equalTo(self.contentView).offset(16.0)
            make.centerY.equalTo(self.titleLabel)
            make.width.height.equalTo(24)
        }

        titleImageView.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(self.contentView)
        }

        rightBtn.snp.makeConstraints { make in
            make.right.equalTo(self.contentView).offset(-16.0)
            make.centerY.equalTo(titleLabel)
//            make.width.lessThanOrEqualTo(30.0).priority(.high)
        }
        
        rightBtn.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
