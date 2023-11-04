serve:
	echo http://localhost:25252
	go run main.go

open:
	chromium http://localhost:25252 &
