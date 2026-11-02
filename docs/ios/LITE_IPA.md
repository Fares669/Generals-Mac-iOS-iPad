# iOS Lite IPA (game data excluded)

This workflow builds an **unsigned iPhone/iPad IPA** containing the open-source engine, runtime libraries, MoltenVK, fonts and configuration. It **never** embeds or distributes the proprietary game data.

## Building

Go to **Actions → iOS Lite IPA**, choose the `feat/ios-lite-ipa` branch and run the workflow, or push an iOS-related change to this branch. After a successful run, download the `GeneralsXZH-lite-unsigned-ipa` artifact. The downloaded GitHub ZIP contains `GeneralsXZH-lite-unsigned.ipa`.

The IPA is **unsigned**. It cannot be installed directly on iOS until a sideloading tool (such as Sideloadly on Windows) or Xcode signs it using your Apple account or developer certificate. Re-sign nested libraries/frameworks as part of the operation. iOS app capabilities and installation lifespan depend on your signing method.

## Adding game files (bring your own legally owned copy)

The engine in lite mode looks for game files in the app's **Documents root**. Install the signed app first, then transfer the required Zero Hour game data to its shared Documents folder using Apple's file sharing (Apple Devices on Windows, Finder on macOS), or Files on iOS where accessible. Copy the game data folders/files directly into Documents, **not** inside an additional "GeneralsZH" parent directory. The exact contents depend on the game's legitimate installation.

At first launch, the lite app copies the bundled Liberation fonts into `Documents/fonts/` and a default `dxvk.conf` into Documents, without replacing existing user files. It also seeds default preferences in its app-support folder. The app will not run the game without the actual game data.

The full proprietary-data build path of the upstream project is unchanged.

## Limitations

- A successful CI build proves the IPA can be assembled, **not** that gameplay has been device-tested.
- Older devices and newer iOS versions require real-device testing, especially the Vulkan/MoltenVK and orientation paths.
- **Never commit or attach** commercial game data, CD keys or account credentials to this repository or its CI artifacts.
