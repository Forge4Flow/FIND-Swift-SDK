# FindSwiftSDK

Swift SDK For Integrating with Find on Flow in iOS Apps

## Features

1. Look up FIND name and profile of currently logged in FCL user
2. Look up FIND name and profile of any other address

### TODO

1. Edit/Update Profile
2. Create Profile
3. Lease/Register .FIND name
4. FIND Marketplace integrations
5. More Documentation

## Getting Started

### Installing

This is a Swift Package, and can be installed via Xcode with the URL of this repository.

```Swift
.package(name: "FCL", url: "https://github.com/BoiseITGuru/FIND-Swift-SDK", from: "0.0.3")
```

Once installed in your Xcode project, the SDK will automatically be initilized on app load and can be imported to any file by adding `import FindSwiftSDK` to the top of the file. Using either `fcl.authenticate()` or `fcl.unauthenticate()` will automatically update the current users FIND Name & Profile.

### Examples

#### Looking up another users FIND Name by Flow Address

```Swift
let findName = find.reverseLookupFIND(address: '0x1234567890')
```

#### Looking up another users FIND Profile by Flow Address

```Swift
let findProfile = find.reverseLookupProfile(address: '0x1234567890')
```

#### Using the current users FIND Name & Profile

Upon login the current users FIND Name & Profile will loaded into the `find.profile` variable.

```Swift
public struct FINDProfile: Decodable, Hashable {
    public var findName: String
    public var name: String
    public var description: String
    public var tags: [String]
    public var avatar: String
    public var links: [String]
}
```

Since this is a @Published variable you can utlize directly inside SwiftUI as shown below.

```Swift
if find.profile?.avatar != nil {
    AsyncImage(url: URL(string: find.profile?.avatar ?? ""), scale: 2) { image in
        image
            .resizable()
            .clipShape(Circle())
            .aspectRatio(contentMode: .fill)
    } placeholder: {
        ProgressView()
            .progressViewStyle(.circular)
    }
        .frame(width: 80, height: 80)
} else {
    Image("defualtProfileImage")
        .resizable()
        .frame(width: 80, height: 80)
        .clipShape(Circle())
}
VStack(alignment: .leading) {
    Text(find.profile?.name ?? fclModel.address)
        .font(.title)
        .lineLimit(1)
    Text("Some other info probably")
        .font(.subheadline)
}
```
