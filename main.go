package main

import (
	"fmt"
	"net/http"
	"text/template"
)

type data struct {
	Message string
}

func main() {
	http.HandleFunc("/", home)

	fmt.Println("Started http server on port :8080")
	http.ListenAndServe(":8080", nil)
}

func home(w http.ResponseWriter, r *http.Request) {
	data := data{
		Message: "Hello Everyone!",
	}
	tmpl := parseTemplate()
	err := tmpl.Execute(w, data)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
}

func parseTemplate() *template.Template {
	tmpl, err := template.ParseFiles("index.html")
	if err != nil {
		panic(err)
	}
	return tmpl
}
