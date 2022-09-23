package main

import "net/http"

func landing(rw http.ResponseWriter, req *http.Request) {
	html := `
<!DOCTYPE html>
<html>
<head>
<title>Page Title</title>
</head>
<body>

<h1>My First Heading</h1>
<p>My first paragraph</p>

</body>
</html>
`
	rw.Write([]byte(html))
	return

}

func main() {
	http.HandleFunc("/", landing)
	if err := http.ListenAndServe(":8000", nil); err != nil {
		panic(err)
	}
}
