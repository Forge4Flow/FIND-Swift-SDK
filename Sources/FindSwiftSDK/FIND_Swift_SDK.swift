import Foundation
import Combine
import FCL
import Flow
import BigInt
import CryptoKit

public let find = FIND_Swift_SDK.shared

public class FIND_Swift_SDK {
    public static let shared = FIND_Swift_SDK()
    public var profile: FINDProfile?

    public init() {

    }

    public func checkFindProfile() async {
        if fcl.currentUser != nil {
            if fcl.currentUser!.loggedIn {
                let profile = await reverseLookupProfile(address: fcl.currentUser!.addr.hex)
                print(profile)
            }
        }
    }

    public func reverseLookupProfile(address: String) async -> String {
        do {
            let block = try await fcl.query {
                cadence {
                    FindScripts.reverseLookupProfile.rawValue
                }

                arguments {
                    [.address(Flow.Address(hex: address))]
                }
            }.decode(FINDProfile.self)
            await MainActor.run {
                self.profile = block
            }

            return ""
        } catch {
            print(error)
            return ""
        }
    }

    public func reverseLookupFIND(address: String) async -> String {
        do {
            let block = try await fcl.query {
                cadence {
                    FindScripts.reverseLookupFIND.rawValue
                }
            }.decode()
            await MainActor.run {
                print(block)
            }

            return ""
        } catch {
            print(error)
            return ""
        }
    }
}
