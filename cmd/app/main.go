package main

import (
	"fmt"
	"net/http"
	"text/template"

	"github.com/go-chi/chi/middleware"
	"github.com/go-chi/chi/v5"
)

type data struct {
	Message string
}

func main() {
	router := chi.NewRouter()

	router.Use(middleware.Logger)
	router.Use(middleware.Recoverer)

	router.Get("/", home)

	fmt.Println("Started http server on port :8080")
	http.ListenAndServe(":8080", router)
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
