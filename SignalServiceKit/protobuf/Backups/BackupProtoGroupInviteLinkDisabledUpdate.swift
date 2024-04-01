//
// Copyright 2024 Signal Messenger, LLC
// SPDX-License-Identifier: AGPL-3.0-only
//

// Code generated by Wire protocol buffer compiler, do not edit.
// Source: BackupProto.BackupProtoGroupInviteLinkDisabledUpdate in Backup.proto
import Foundation
import Wire

public struct BackupProtoGroupInviteLinkDisabledUpdate {

    @ProtoDefaulted
    public var updaterAci: Foundation.Data?
    public var unknownFields: UnknownFields = .init()

    public init(configure: (inout Self) -> Swift.Void = { _ in }) {
        configure(&self)
    }

}

#if !WIRE_REMOVE_EQUATABLE
extension BackupProtoGroupInviteLinkDisabledUpdate : Equatable {
}
#endif

#if !WIRE_REMOVE_HASHABLE
extension BackupProtoGroupInviteLinkDisabledUpdate : Hashable {
}
#endif

extension BackupProtoGroupInviteLinkDisabledUpdate : Sendable {
}

extension BackupProtoGroupInviteLinkDisabledUpdate : ProtoDefaultedValue {

    public static var defaultedValue: BackupProtoGroupInviteLinkDisabledUpdate {
        BackupProtoGroupInviteLinkDisabledUpdate()
    }
}

extension BackupProtoGroupInviteLinkDisabledUpdate : ProtoMessage {

    public static func protoMessageTypeURL() -> String {
        return "type.googleapis.com/BackupProto.BackupProtoGroupInviteLinkDisabledUpdate"
    }

}

extension BackupProtoGroupInviteLinkDisabledUpdate : Proto3Codable {

    public init(from protoReader: ProtoReader) throws {
        var updaterAci: Foundation.Data? = nil

        let token = try protoReader.beginMessage()
        while let tag = try protoReader.nextTag(token: token) {
            switch tag {
            case 1: updaterAci = try protoReader.decode(Foundation.Data.self)
            default: try protoReader.readUnknownField(tag: tag)
            }
        }
        self.unknownFields = try protoReader.endMessage(token: token)

        self._updaterAci.wrappedValue = updaterAci
    }

    public func encode(to protoWriter: ProtoWriter) throws {
        try protoWriter.encode(tag: 1, value: self.updaterAci)
        try protoWriter.writeUnknownFields(unknownFields)
    }

}

#if !WIRE_REMOVE_CODABLE
extension BackupProtoGroupInviteLinkDisabledUpdate : Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StringLiteralCodingKeys.self)
        self._updaterAci.wrappedValue = try container.decodeIfPresent(stringEncoded: Foundation.Data.self, forKey: "updaterAci")
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: StringLiteralCodingKeys.self)

        try container.encodeIfPresent(stringEncoded: self.updaterAci, forKey: "updaterAci")
    }

}
#endif
