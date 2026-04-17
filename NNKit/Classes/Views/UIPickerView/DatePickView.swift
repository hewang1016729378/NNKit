//
//  DatePickView.swift
//  NNHost
//
//  Created by tgw on 2022/1/13.
//

import UIKit
import BRPickerView

// 选择年月日
public class DatePickView: UIView {
    public var cancelBlock:(() -> Void)?
    public var affirmBlock:((_ timers: String) -> Void)?
    var timeStr: String = ""
    private lazy var cancelBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("取消".localized, for: .normal)
        button.setTitleColor(k_111111, for: .normal)
        button.titleLabel?.font = kFont16b
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(cancleBtnAction), for: .touchUpInside)
        return button
    }()
    private lazy var affirmBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("确认", for: .normal)
        button.setTitleColor(k_111111, for: .normal)
        button.titleLabel?.font = kFont16b
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(affirmBtnAction), for: .touchUpInside)
        return button
    }()
    lazy var containView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 300))

    lazy var datePickView: BRDatePickerView = {
        let pickV = BRDatePickerView()
        pickV.pickerMode = .YMD
        pickV.maxDate = Date.init()
        return pickV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupViews()
        self.datePickView.changeBlock = {[weak self] (selectDate,selectValue) in
            if (selectValue?.count ?? 0 >= 10) {
//                NSString *time = [selectValue substringToIndex:10];
                
                self?.timeStr = selectValue?.substring(to: 10) ?? ""
            }

        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews() {
        addSubview(containView)
        containView.addSubview(cancelBtn)
        containView.addSubview(affirmBtn)
        datePickView.addPicker(to: containView)
        cancelBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 70, height: 50))
            make.left.equalTo(self.snp.left).offset(16)
            make.top.equalTo(self.snp.top).offset(6)
        }
        affirmBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 70, height: 50))
            make.right.equalTo(self.snp.right).offset(-16)
            make.top.equalTo(self.snp.top).offset(6)
        }
        datePickView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self)
            make.top.equalTo(affirmBtn.snp.bottom).offset(-15)
        }

    }
    @objc func cancleBtnAction() {
        self.cancelBlock?()
    }
    @objc func affirmBtnAction() {
        if self.timeStr.isEmpty {
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"// 自定义时间格式
            let time = dateformatter.string(from: Date())
            let timeS = time.prefix(10)
            self.timeStr = String(timeS)
        }
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        self.timeStr = formatter.string(from: self.datePickView.date)
        self.affirmBlock?(self.timeStr)
    }
}
