(use-modules (guix packages)
             (guix build utils)
             (gnu packages base)
             (gnu packages guile)
             (gnu packages guile-xyz))

(packages->manifest (list guile-next guile-hoot guile-goblins))
