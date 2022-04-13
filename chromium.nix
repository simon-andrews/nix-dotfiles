{
  programs.chromium = {
    enable = true;
    extensions =
      [
        # Utilities
        "nngceckbapebfimnlniiiahkandclblb" # BitWarden -- FOSS password manager
        "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader -- dark mode for any website
        "nkbihfbeogaeaoehlefnkodbefgpgknn" # MetaMask -- Ethereum wallet
        "dneaehbmnbhcippjikoajpoabadpodje" # Old Reddit Redirect -- always go to old.reddit.com

        # Shopping
        "ghnomdcacenbmilgjigehppbamfndblo" # The Camelizer -- shows Amazon price histories
        "fjifglfkcaipnmhngbigdebkoikioend" # ReviewMeta.com Review Analyzer -- reports suspicious Amazon reviews

        # Ad blocking
        "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock -- skips sponsored segments on YouTube
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin -- blocks advertisements

        # Privacy and security
        "lckanjgmijmafbedllaakclkaicjfmnk" # ClearURLs -- removes tracking/etc. cruft from URLs
        "ldpochfccmkkmhdbclfhpagapcfdljkj" # Decentraleyes -- serves CDN content locally
        "gcbommkclmclpchllfjekcdonpmejbdp" # HTTPS Everywhere -- automatic redirect to HTTPS sites
      ];
  };
}
