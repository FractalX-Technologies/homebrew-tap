cask "fx-vault" do
  version "1.0.6"
  sha256 "d0f03bd50c09d6473487bbb2d627a5e30eb270de32e6ed9fa939ba0e0ebf6d03"

  url "https://github.com/FractalX-Technologies/fx-vault/releases/download/v#{version}/FXVault-#{version}.dmg"
  name "FX Vault"
  desc "Manage GitHub Actions secrets and variables from a local encrypted vault"
  homepage "https://github.com/FractalX-Technologies/fx-vault"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on formula: "gh"
  depends_on macos: :tahoe

  app "FX Vault.app"

  zap trash: [
    "~/Library/Application Support/FX Vault",
    "~/Library/Caches/io.fractalx.fxvault",
    "~/Library/Preferences/io.fractalx.fxvault.plist",
    "~/Library/Saved Application State/io.fractalx.fxvault.savedState",
  ]

  caveats <<~EOS
    `brew uninstall --zap --cask fx-vault` moves the local vault
    (~/Library/Application Support/FX Vault) to the Trash. It stays recoverable
    there until you empty the Trash, and values never synced to GitHub exist
    only in it. Export or sync anything you need first.
    zap does not remove the Touch ID keychain item. To erase the vault and that
    item, use Settings > Advanced > Reset Vault... in FX Vault before uninstalling.
  EOS
end
