import Foundation
import Combine
import FCL
import Flow
import BigInt
import CryptoKit

public let find = FIND_Swift_SDK.shared

public class FIND_Swift_SDK: ObservableObject {
    public static let shared = FIND_Swift_SDK()
    @Published public var profile: FINDProfile?

    private var cancellables = Set<AnyCancellable>()

    public init() {
        fcl.$currentUser.sink { user in
            if user != nil {
                self.checkFindProfile()
            }
        }.store(in: &cancellables)
    }

    public func checkFindProfile() {
        Task.detached {
            print("Checking Profile")

            self.profile = await self.reverseLookupProfile(address: fcl.currentUser?.addr.hex ?? "")
        }
    }

    public func reverseLookupProfile(address: String) async -> FINDProfile? {
        do {
            let block = try await fcl.query {
                cadence {
                    FindScripts.reverseLookupProfile.rawValue
                }

                arguments {
                    [.address(Flow.Address(hex: address))]
                }
            }.decode(FINDProfile.self)

            return block
        } catch {
            print(error)
            return nil
        }
    }

    public func reverseLookupFIND(address: String) async -> String {
        do {
            let block = try await fcl.query {
                cadence {
                    FindScripts.reverseLookupFIND.rawValue
                }
            }.decode()

            return block as? String ?? ""
        } catch {
            print(error)
            return ""
        }
    }
}
