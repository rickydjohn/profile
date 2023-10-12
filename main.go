package main

import (
	"log"
	"net/http"
)

var port string = "8000"

func landing(rw http.ResponseWriter, req *http.Request) {
	log.Println("received request from ", req.RemoteAddr)
	html := `
<!DOCTYPE html>
<html>
<head>
<title>Page Title</title>
</head>
<body>

<h1>My First Heading</h1>
<p>My first paragraph</p>
<p>My first paragraph</p>
<p>My first paragraph</p>

</body>
</html>
`
	rw.Write([]byte(html))
	return

}

func main() {
	http.HandleFunc("/", landing)
	log.Printf("starting service on %s port", port)
	if err := http.ListenAndServe("0.0.0.0:"+port, nil); err != nil {
		panic(err)
	}
}
