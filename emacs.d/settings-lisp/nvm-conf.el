;; Set nvm version if it exists, for the time being this needs to be manually customized
;; This should give access to global cli tools such as mmcd (marmaid-cli)
(if (file-exists-p "/home/rene/.nvm/versions/node/v16.15.1/bin/node")
    (nvm-use "v16.15.1"))

(provide 'nvm-conf)
