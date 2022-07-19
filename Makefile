## make elm build
elm-watch:
	(cd src && elm-live Main.elm --no-server -- --output=main.js)