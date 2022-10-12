
(crafted-package-install-package 'xah-fly-keys)
(require 'xah-fly-keys)
(xah-fly-keys-set-layout "colemak")
(xah-fly-keys 1)
(global-set-key (kbd "<f4>") 'xah-fly-mode-toggle)
(provide 'init-xah-fly-keys)
