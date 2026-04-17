//
//  ECodable.swift
//  NNHost
//
//  Created by Leigod on 2022/3/11.
//

import Foundation

public protocol ECodable: Codable {
    mutating func didFinishMapping()
    func toDic() -> [String: Any]
}

extension ECodable {
    public mutating func didFinishMapping() {}
    public func toDic() -> [String: Any] {
        return [String: Any]()
    }
}

public protocol EnumCodable: RawRepresentable, Codable where RawValue: Codable {
    static var defaultCase: Self { get }
}

extension EnumCodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            let decoded = try container.decode(RawValue.self)
            self = Self(rawValue: decoded) ?? Self.defaultCase
        } catch {
            self = Self.defaultCase
        }
    }
}
