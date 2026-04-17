//
//  CustomAlertView.swift
//  NNHost
//
//  Created by ly on 2022/1/11.
//

import UIKit

class CustomAlertView: UIView {
    lazy var imageView: UIImageView = {
        let tmp = UIImageView.init()
        tmp.isHidden = true
        return tmp
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        if EnableAlertViewDarkMode {
            label.textColor = UIColor.systemThemeTextColor()
        } else {
            label.textColor = .black
        }
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    lazy var subTitleLabel: UILabel = {
        let label = UILabel.init()
        if EnableAlertViewDarkMode {
            label.textColor = UIColor.systemThemeTextColor(darkColor: "#E0E0E0".color())
        } else {
            label.textColor = k_808080
       }
        label.font = .pingfang(14.0)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    lazy var leftBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle("取消".localized, for: .normal)
        btn.setTitleColor(k_B2B2B2, for: .normal)
        btn.titleLabel?.font = UIFont.pingfangBold(16)
        btn.backgroundColor = k_F9F9F9
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 6.0
        return btn
    }()
    lazy var rightBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle("确认".localized, for: .normal)
        btn.setTitleColor(NNKitConfirmTitleColor, for: .normal)
        btn.titleLabel?.font = UIFont.pingfangBold(16)
        btn.backgroundColor = NNKitConfirmBackColor
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 6.0
        return btn
    }()
    var style: CustomAlertViewController.Style? {
        didSet {
            switch style {
            case .confirmAndCancel:
                self.leftBtn.isHidden = false
                self.rightBtn.snp.makeConstraints { make in
                    make.left.equalTo(self.snp.centerX).offset(6.0)
                }
            case .confirm:
                self.leftBtn.isHidden = true
                self.rightBtn.snp.makeConstraints { make in
                    make.left.equalTo(self).offset(22.0)
                }
            case .none:
                print("")
            }
        }
    }
    var result: CustomAlertViewController.Result? {
        didSet {
            switch result {
            case .success:
                self.imageView.isHidden = false
                self.imageView.image = I$("success")
                titleLabel.snp.remakeConstraints { make in
                    make.top.equalTo(32.0)
                    make.centerX.equalToSuperview().offset(11.0)
                    make.left.greaterThanOrEqualTo(self).offset(35.0)
                }
            case .failure:
                self.imageView.isHidden = false
                self.imageView.image = I$("failure")
                titleLabel.snp.remakeConstraints { make in
                    make.top.equalTo(32.0)
                    make.centerX.equalToSuperview().offset(11.0)
                    make.left.greaterThanOrEqualTo(self).offset(35.0)
                }
            case .none:
                self.imageView.isHidden = true
                titleLabel.snp.remakeConstraints { make in
                    make.top.equalTo(self).offset(32.0)
                    make.centerX.equalTo(self)
                    make.left.equalTo(self).offset(24.0)
                    make.right.equalTo(self).offset(-24.0)
                }
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        if EnableAlertViewDarkMode {
            backgroundColor = UIColor.systemThemeBackgroudColor(darkColor: "#444444".color())
        } else {
            backgroundColor = .white
        }
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(leftBtn)
        addSubview(rightBtn)
        layer.masksToBounds = true
        layer.cornerRadius = 12.0
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(32.0)
            make.centerX.equalTo(self)
            make.left.equalTo(self).offset(24.0)
            make.right.equalTo(self).offset(-24.0)
        }
        imageView.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.right.equalTo(titleLabel.snp.left).offset(-4.0)
        }
        subTitleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(titleLabel.snp.bottom).offset(16.0)
            make.left.equalTo(self).offset(24.0)
            make.right.equalTo(self).offset(-24.0)
        }
        leftBtn.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(38.0)
            make.right.equalTo(self.snp.centerX).offset(-6.0)
            make.left.equalTo(self).offset(22.0)
            make.height.equalTo(46.0)
            make.bottom.equalTo(self).offset(-20.0)
        }
        rightBtn.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(38.0)
            make.left.equalTo(self.snp.centerX).offset(6.0)
            make.right.equalTo(self).offset(-22.0)
            make.height.equalTo(46.0)
            make.bottom.equalTo(self).offset(-20.0)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
