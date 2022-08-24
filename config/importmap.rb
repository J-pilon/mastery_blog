# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "tinymce", to: "https://cdn.tiny.cloud/1/i0031jfesm49fw7oyohgdb8m84bsltuijvk57iim4t9kxi67/tinymce/5/tinymce.min.js"