## make elm build 
## One need to have the elm-live module in order to run this
elm-watch:
	(cd src && elm-live Main.elm --no-server -- --output=main.js)

## Make new sudoku_times_bulma_custom.css 
## This is done by making changes in the 
## /sudoku_times/style/bulma-0.9.4/bulma/sudoku_times_custom.scss
## file and then using the "make bulma-custom" command
bulma-custom:
	(cd style/bulma-0.9.4/bulma && sass --sourcemap=none sudoku_times_custom.scss:css/sudoku_times_bulma_custom.css)

## Working progress deployment script
deploy: ## Deploys whatever is on the production branch to production
	./deploy.sh