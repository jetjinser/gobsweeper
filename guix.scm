(package
  (name "gobsweeper")
  (version "0.0.1")
  (source (git-checkout (url (dirname (current-filename)))))
  (build-system gnu-build-system)
  (arguments
   '(#:make-flags '("GUILE_AUTO_COMPILE=0")))
  (native-inputs
   (list autoconf automake guile-syntax-highlight pkg-config texinfo))
  (inputs
   (list guile-next-next v8))
  (synopsis "WASM compiler for Guile Scheme")
  (description "Guile-hoot is an ahead-of-time WebAssembly compiler for GNU Guile.")
  (home-page "https://spritely.institute")
  (license (list license:asl2.0 license:lgpl3+)))
