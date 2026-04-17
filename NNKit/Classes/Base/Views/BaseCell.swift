//
//  BaseCell.swift
//  NNHost
//
//  Created by ly on 2022/1/20.
//

import UIKit

open class BaseCell: UITableViewCell {
    public lazy var leftTitleLabel: UILabel = {
        let tmp = UILabel.init()
        tmp.settingLabel(pingFangSCSize: 16.0, textColor: k_333333)
        return tmp
    }()
    public lazy var rightLabel: UILabel = {
        let tmp = UILabel.init()
        tmp.settingLabel(pingFangSCSize: 14.0, textColor: k_999999)
        tmp.textAlignment = .right
        return tmp
    }()
    public lazy var centerLabel: UILabel = {
        let tmp = UILabel.init()
        tmp.settingLabel(pingFangSCSize: 16.0, textColor: "#FC6670".color())
        tmp.textAlignment = .center
        tmp.isHidden = true
        return tmp
    }()
    public lazy var arrowIcon: UIImageView = {
        let tmp = UIImageView.init()
        tmp.image = UIImage.init(named: "ic_right_arrow")
        return tmp
    }()
    public lazy var rightSwitch: UISwitch = {
        let tmp = UISwitch.init()
        tmp.isHidden = true
        return tmp
    }()
    public lazy var centerBtnView: UIView = {
        let tmp = UIView.init()
        tmp.isHidden = true
        let img = UIImageView.init()
        img.image = UIImage.init(named: "room_join")
        tmp.addSubview(img)
        tmp.addSubview(centerImgLabel)
        img.snp.makeConstraints { make in
            make.left.equalTo(tmp).offset(0.0)
            make.centerY.equalTo(tmp)
        }
        centerImgLabel.snp.makeConstraints { make in
            make.left.equalTo(img.snp.right).offset(5.0)
            make.right.equalTo(tmp).offset(0.0)
            make.centerY.equalTo(tmp).offset(1.0)
       }
        return tmp
    }()
    public lazy var centerImgLabel: UILabel = {
        let tmp = UILabel.init()
        tmp.settingLabel(pingFangSCSize: 16.0, textColor: "#FF9B27".color())
        tmp.textAlignment = .center
        return tmp
    }()
    
    /*
     * 满足右侧头像显示，默认隐藏
     */
    public lazy var avatarImgView: UIImageView = {
        let tmp = UIImageView.init()
        tmp.isHidden = true
        tmp.layer.masksToBounds = true
        tmp.layer.cornerRadius = 12.0
        return tmp
    }()
    public lazy var inputTextField: UITextField = {
        let tmp = UITextField.init()
        tmp.clearsOnBeginEditing = true
        tmp.isHidden = true
        tmp.textAlignment = .right
        return tmp
    }()
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        setupViews()
    }
    private func setupViews() {
        contentView.addSubview(rightLabel)
        contentView.addSubview(leftTitleLabel)
        contentView.addSubview(inputTextField)
        contentView.addSubview(arrowIcon)
        contentView.addSubview(avatarImgView)
        contentView.addSubview(rightSwitch)
        contentView.addSubview(centerLabel)
        contentView.addSubview(centerBtnView)
        // 防止leftTitleLabel被rightLabel挤压导致leftTitleLabel不显示
        leftTitleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        leftTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(16.0)
            make.centerY.equalTo(contentView)
        }
        rightLabel.snp.makeConstraints { make in
            make.left.greaterThanOrEqualTo(leftTitleLabel.snp.right).offset(15)
            make.right.equalTo(arrowIcon.snp.left).offset(-6.0)
            make.centerY.equalTo(contentView)
        }
        arrowIcon.snp.makeConstraints { make in
            make.right.equalTo(contentView).offset(-16.0)
            make.centerY.equalTo(contentView)
            make.size.equalTo(CGSize.init(width: 24.0, height: 24.0))
        }
        rightSwitch.snp.makeConstraints { make in
            make.right.equalTo(contentView).offset(-16.0)
            make.centerY.equalTo(contentView)
        }
        avatarImgView.snp.makeConstraints { make in
            make.right.equalTo(rightLabel).offset(0.0)
            make.centerY.equalTo(contentView)
            make.size.equalTo(CGSize.init(width: 40.0, height: 40.0))
        }
        inputTextField.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-16.0)
            make.left.equalTo(contentView).offset(109.0)
        }
        centerLabel.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(contentView)
        }
        centerBtnView.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(contentView)
            make.height.equalTo(25.0)
        }
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
