//
// Copyright 2024 Signal Messenger, LLC
// SPDX-License-Identifier: AGPL-3.0-only
//

// Code generated by Wire protocol buffer compiler, do not edit.
// Source: BackupProto.BackupProtoSimpleChatUpdate in Backup.proto
import Wire

public struct BackupProtoSimpleChatUpdate {

    @ProtoDefaulted
    public var type: BackupProtoSimpleChatUpdate.BackupProtoType?
    public var unknownFields: UnknownFields = .init()

    public init(configure: (inout Self) -> Swift.Void = { _ in }) {
        configure(&self)
    }

}

#if !WIRE_REMOVE_EQUATABLE
extension BackupProtoSimpleChatUpdate : Equatable {
}
#endif

#if !WIRE_REMOVE_HASHABLE
extension BackupProtoSimpleChatUpdate : Hashable {
}
#endif

extension BackupProtoSimpleChatUpdate : Sendable {
}

extension BackupProtoSimpleChatUpdate : ProtoDefaultedValue {

    public static var defaultedValue: BackupProtoSimpleChatUpdate {
        BackupProtoSimpleChatUpdate()
    }
}

extension BackupProtoSimpleChatUpdate : ProtoMessage {

    public static func protoMessageTypeURL() -> String {
        return "type.googleapis.com/BackupProto.BackupProtoSimpleChatUpdate"
    }

}

extension BackupProtoSimpleChatUpdate : Proto3Codable {

    public init(from protoReader: ProtoReader) throws {
        var type: BackupProtoSimpleChatUpdate.BackupProtoType? = nil

        let token = try protoReader.beginMessage()
        while let tag = try protoReader.nextTag(token: token) {
            switch tag {
            case 1: type = try protoReader.decode(BackupProtoSimpleChatUpdate.BackupProtoType.self)
            default: try protoReader.readUnknownField(tag: tag)
            }
        }
        self.unknownFields = try protoReader.endMessage(token: token)

        self._type.wrappedValue = try BackupProtoSimpleChatUpdate.BackupProtoType.defaultIfMissing(type)
    }

    public func encode(to protoWriter: ProtoWriter) throws {
        try protoWriter.encode(tag: 1, value: self.type)
        try protoWriter.writeUnknownFields(unknownFields)
    }

}

#if !WIRE_REMOVE_CODABLE
extension BackupProtoSimpleChatUpdate : Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StringLiteralCodingKeys.self)
        self._type.wrappedValue = try container.decodeIfPresent(BackupProtoSimpleChatUpdate.BackupProtoType.self, forKey: "type")
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: StringLiteralCodingKeys.self)

        try container.encodeIfPresent(self.type, forKey: "type")
    }

}
#endif

/**
 * Subtypes within BackupProtoSimpleChatUpdate
 */
extension BackupProtoSimpleChatUpdate {

    public enum BackupProtoType : Int32, CaseIterable, ProtoEnum, ProtoDefaultedValue {

        case UNKNOWN = 0
        case JOINED_SIGNAL = 1
        case IDENTITY_UPDATE = 2
        case IDENTITY_VERIFIED = 3
        /**
         * marking as unverified
         */
        case IDENTITY_DEFAULT = 4
        case CHANGE_NUMBER = 5
        case BOOST_REQUEST = 6
        case END_SESSION = 7
        case CHAT_SESSION_REFRESH = 8
        case BAD_DECRYPT = 9
        case PAYMENTS_ACTIVATED = 10
        case PAYMENT_ACTIVATION_REQUEST = 11

        public static var defaultedValue: BackupProtoSimpleChatUpdate.BackupProtoType {
            BackupProtoSimpleChatUpdate.BackupProtoType.UNKNOWN
        }
        public var description: String {
            switch self {
            case .UNKNOWN: return "UNKNOWN"
            case .JOINED_SIGNAL: return "JOINED_SIGNAL"
            case .IDENTITY_UPDATE: return "IDENTITY_UPDATE"
            case .IDENTITY_VERIFIED: return "IDENTITY_VERIFIED"
            case .IDENTITY_DEFAULT: return "IDENTITY_DEFAULT"
            case .CHANGE_NUMBER: return "CHANGE_NUMBER"
            case .BOOST_REQUEST: return "BOOST_REQUEST"
            case .END_SESSION: return "END_SESSION"
            case .CHAT_SESSION_REFRESH: return "CHAT_SESSION_REFRESH"
            case .BAD_DECRYPT: return "BAD_DECRYPT"
            case .PAYMENTS_ACTIVATED: return "PAYMENTS_ACTIVATED"
            case .PAYMENT_ACTIVATION_REQUEST: return "PAYMENT_ACTIVATION_REQUEST"
            }
        }

    }

}

extension BackupProtoSimpleChatUpdate.BackupProtoType : Sendable {
}
