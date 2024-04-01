//
// Copyright 2024 Signal Messenger, LLC
// SPDX-License-Identifier: AGPL-3.0-only
//

// Code generated by Wire protocol buffer compiler, do not edit.
// Source: BackupProto.BackupProtoGroupJoinRequestApprovalUpdate in Backup.proto
import Foundation
import Wire

public struct BackupProtoGroupJoinRequestApprovalUpdate {

    public var requestorAci: Foundation.Data
    /**
     * The aci that approved or rejected the request.
     */
    @ProtoDefaulted
    public var updaterAci: Foundation.Data?
    public var wasApproved: Bool
    public var unknownFields: UnknownFields = .init()

    public init(
        requestorAci: Foundation.Data,
        wasApproved: Bool,
        configure: (inout Self) -> Swift.Void = { _ in }
    ) {
        self.requestorAci = requestorAci
        self.wasApproved = wasApproved
        configure(&self)
    }

}

#if !WIRE_REMOVE_EQUATABLE
extension BackupProtoGroupJoinRequestApprovalUpdate : Equatable {
}
#endif

#if !WIRE_REMOVE_HASHABLE
extension BackupProtoGroupJoinRequestApprovalUpdate : Hashable {
}
#endif

extension BackupProtoGroupJoinRequestApprovalUpdate : Sendable {
}

extension BackupProtoGroupJoinRequestApprovalUpdate : ProtoMessage {

    public static func protoMessageTypeURL() -> String {
        return "type.googleapis.com/BackupProto.BackupProtoGroupJoinRequestApprovalUpdate"
    }

}

extension BackupProtoGroupJoinRequestApprovalUpdate : Proto3Codable {

    public init(from protoReader: ProtoReader) throws {
        var requestorAci: Foundation.Data = .init()
        var updaterAci: Foundation.Data? = nil
        var wasApproved: Bool = false

        let token = try protoReader.beginMessage()
        while let tag = try protoReader.nextTag(token: token) {
            switch tag {
            case 1: requestorAci = try protoReader.decode(Foundation.Data.self)
            case 2: updaterAci = try protoReader.decode(Foundation.Data.self)
            case 3: wasApproved = try protoReader.decode(Bool.self)
            default: try protoReader.readUnknownField(tag: tag)
            }
        }
        self.unknownFields = try protoReader.endMessage(token: token)

        self.requestorAci = requestorAci
        self._updaterAci.wrappedValue = updaterAci
        self.wasApproved = wasApproved
    }

    public func encode(to protoWriter: ProtoWriter) throws {
        try protoWriter.encode(tag: 1, value: self.requestorAci)
        try protoWriter.encode(tag: 2, value: self.updaterAci)
        try protoWriter.encode(tag: 3, value: self.wasApproved)
        try protoWriter.writeUnknownFields(unknownFields)
    }

}

#if !WIRE_REMOVE_CODABLE
extension BackupProtoGroupJoinRequestApprovalUpdate : Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StringLiteralCodingKeys.self)
        self.requestorAci = try container.decode(stringEncoded: Foundation.Data.self, forKey: "requestorAci")
        self._updaterAci.wrappedValue = try container.decodeIfPresent(stringEncoded: Foundation.Data.self, forKey: "updaterAci")
        self.wasApproved = try container.decode(Bool.self, forKey: "wasApproved")
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: StringLiteralCodingKeys.self)
        let includeDefaults = encoder.protoDefaultValuesEncodingStrategy == .include

        if includeDefaults || !self.requestorAci.isEmpty {
            try container.encode(stringEncoded: self.requestorAci, forKey: "requestorAci")
        }
        try container.encodeIfPresent(stringEncoded: self.updaterAci, forKey: "updaterAci")
        if includeDefaults || self.wasApproved != false {
            try container.encode(self.wasApproved, forKey: "wasApproved")
        }
    }

}
#endif
