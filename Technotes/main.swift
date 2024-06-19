// In order to enable the "Build Documentation" option in Xcode, at least one
// target definition is required to be present in the package manifest.
//
// Using an empty executable target to satisfy this condition also enables
// markdown rendering with the "Documentation Preview Assistant," making
// Xcode the best editor to write markdown tech notes.
//
// Note that these are quality of life improvements, since `xcrun docc` can be
// used without a Swift Package setup at all.
