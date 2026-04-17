//
//  TableViewFactory.swift
//  NNHost
//
//  Created by hewang on 2022/3/8.
//

import UIKit

public class TableViewFactory {
    public class func create(_ style: UITableView.Style = .plain, hasHeader: Bool = true) -> UITableView {
        let view = UITableView(frame: CGRect.zero, style: style)
        setupView(view)
        guard style == .grouped, hasHeader else {
            return view
        }
        // 去掉 .grouped样式 顶部和底部空白
        let inset = UIEdgeInsets(top: -35, left: 0, bottom: -20, right: 0)
        view.contentInset = inset
        return view
    }

    public class func new(_ style: UITableView.Style = .plain) -> UITableView {
        let view = UITableView(frame: CGRect.zero, style: style)
        setupView(view)
        // 去掉.grouped样式顶部空白
        if style == .grouped {
            view.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFLOAT_MIN))
        }
        return view
    }

    public class func setupView(_ view: UITableView) {
        view.backgroundColor = .white
        view.tableFooterView = UIView()
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.rowHeight = UITableView.automaticDimension
        view.estimatedSectionHeaderHeight = UITableView.automaticDimension
        view.estimatedSectionFooterHeight = UITableView.automaticDimension
        if #available(iOS 15.0, *) {
            view.sectionHeaderTopPadding = 0
        }
        if #available(iOS 11.0, *) {
            // 解决 tableView 执行 reload 抖动问题
            view.estimatedRowHeight = kScreenWidth
            view.contentInsetAdjustmentBehavior = .never
        }
    }
}
